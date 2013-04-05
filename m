From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATH 0/4] remoe-hg: switch to SHA-1 ids
Date: Fri,  5 Apr 2013 05:36:15 -0600
Message-ID: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFX-0002u6-Q8
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab3DELhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:17 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:36623 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab3DELhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:16 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so3908619oag.12
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=3NQjl+rqeIBdjwwGRC1clIEYavqxkCgb6E/0ioJXT0w=;
        b=0zcbd/Ugen1GLqfKfwvg1zI+9pL/Vflpfi5cmpTGCdYPS4045tt8G7u5z/RdPuU9/q
         J9MKfyuTDep8T6VNbStrWX7ZKCZ87NMx8Pifnv+XogQVh+nYctYr5JDVFxeXAckTnPib
         +fbYcR1wE+0plufZJ5nxhCet5jNgFfhquexGXU9GhxI6yAXzJbt+JwAHkMGGifBvWpCC
         7M5hVAWxTpPrIuRJPgE7/8ZXOCVdYvCSTIJ9xLdhMDB44tte1VkMOHCgpc1Y2apzB2jC
         3cJFe4m1wBGE8L8xOyFf+cPe3Yb8KuruMTzJ0linBmyHtOgPd4HMzVFJtqWNUmWsdCZI
         Sifg==
X-Received: by 10.60.133.4 with SMTP id oy4mr7935010oeb.56.1365161835857;
        Fri, 05 Apr 2013 04:37:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm11457789obc.10.2013.04.05.04.37.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 04:37:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220172>

Hi,

As some people suggested this is necessary for some use-cases, because revision
id numbers can change and point to different revisions.

Seems to work fine, but I wouldn't merge it just yet.

Felipe Contreras (4):
  remote-hg: shuffle some code
  remote-hg: improve node traversing
  remote-hg: add version checks to the marks
  remote-hg: switch from revisions to SHA-1 noteids

 contrib/remote-helpers/git-remote-hg | 77 ++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 29 deletions(-)

-- 
1.8.2
