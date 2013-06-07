From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Build fixes
Date: Fri,  7 Jun 2013 17:03:05 -0500
Message-ID: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:05:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4mN-00017e-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3FGWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:04:58 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52686 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FGWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:04:58 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so7331956obb.18
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QkaRziPeqKHjH7TCJY3f3vymt6/myyqETwMFflH9Tfc=;
        b=JBiIpZG7WbY/Vw6BsI6Vt3GsYnTbhgJXjqtgXeTznO2wq9/nylC7G3oGod9GQeqzII
         9UI9gwUk+4tsqDauK4iUkh2n4fM8o+GiHBHTcVxo3ZhZvogM63VAI336QQhY5boTHz3Z
         jJdhS5XjMGJ9GDHzSoHBXrxupowGYp8CK74Bvjp82b1PJqcfb/uzp/lMpxqZszWGdiJ3
         OEyHIdPlz0hJ8C0idrS6V/HhloFMOIfvRXZMpXOL0O4asZLjokIQ1C4wrLnoCD04DSjv
         uI000xDe0B6RVHEpo3g0Z7o7OC9JI7S20uDsPkXPwMzR0FNzzEOZjg+i20ofe06uYedO
         096w==
X-Received: by 10.60.38.197 with SMTP id i5mr482185oek.66.1370642697638;
        Fri, 07 Jun 2013 15:04:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d5sm966499oex.0.2013.06.07.15.04.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:04:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226745>

Felipe Contreras (2):
  build: generate test scripts
  build: do not install git-remote-testgit

 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.3.698.g079b096
