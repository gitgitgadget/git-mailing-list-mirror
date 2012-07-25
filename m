From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/3] Incremental updates for da/difftool-updates
Date: Tue, 24 Jul 2012 20:14:21 -0700
Message-ID: <1343186064-49350-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sts4C-0002WG-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab2GYDOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:14:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64048 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab2GYDO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:14:29 -0400
Received: by pbbrp8 with SMTP id rp8so653821pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V+CPsk3xDPSSfusLJaG1/Ul97PFRsS8bUoEmEZhzPfI=;
        b=PX47JXvO5lOvoMETtdmCtDd9Lp0p2FOlzxNOSq6LkWEb4yWiPYDLm4p6GZP1hMTBTt
         fXwjZOFkw0yePZ6bTNoDEFyFWEz9TjdYX0nnBVb+oprAgsvKvXcowT5FwgoIddadrM84
         17kI7nxjUqtFvC+pZmm7yZkL+j2eqXbct7Ok5g6WIoVuGXj4W1Sm4J7yyR6yjBQ5ONr8
         sGXRDzDdZVhfzXZzsQHqdUHlkntZE9t2Jr+eoyZlm+TUDXA7ZbVPBORxE8E6f6ZS3DZe
         cyioxsOAat8ajUN10NW87N+LssxvNpKcccWNDATFRFiwu1VJW1pxT67KKMFM9zowbrzz
         qZag==
Received: by 10.68.222.163 with SMTP id qn3mr49498559pbc.135.1343186069131;
        Tue, 24 Jul 2012 20:14:29 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ms9sm13401672pbb.43.2012.07.24.20.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:14:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202102>

These are incremental updates on top of da/difftool-updates,
which is currently in next.

David Aguilar (3):
  difftool: Handle finding mergetools/ in a path with spaces
  difftool: Check all return codes from compare()
  difftool: Disable --symlinks on cygwin

 git-difftool.perl | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

-- 
1.7.12.rc0.15.g8157c39
