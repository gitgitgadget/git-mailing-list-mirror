From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] gitweb: Add ignore rule for GITWEB-BUILD-OPTIONS
Date: Sun, 2 May 2010 21:08:56 +1000
Message-ID: <y2wd2e97e801005020408w1e7407e0p1f7606eac101699b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 13:10:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8X4G-0000GN-Ie
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab0EBLJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:09:18 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:62770 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab0EBLJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:09:17 -0400
Received: by iwn12 with SMTP id 12so2065175iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Cbx1yskVhP0tDx9lK1vL1awaSB+YiptZ7oi+7QuGPZA=;
        b=DwHZ8SUDtv9BsSPW3E/U4azAJzf1jlawKHpyQCq/jLdmT4ExOOtid30l3G3qUFg1KB
         fGKK/4sqNk7YvZEgeeqkWu+F3R3FKdPWbxTDmCGrQN8xklnHqwdZzKeadjUGLiR0viEJ
         lrIFSyE1A68xr09KYckEJ+ZOJnFa67kfigm0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Wxur8hmvPmNb9V8g8FOSZgMmCQhYIQ2ekofvwXm+4sOragW2XSsCmEiV+WHi4RU2Pg
         22ImYywogqyb58mZiAOmjhgzk1c4tUCK/VJDaE4FcW7pLfcCaHMLYwoXFNeZ+5IRNU1P
         +By5YoDEtO0CowwTxqxDF7onf/iXPyiHphoOY=
Received: by 10.231.150.12 with SMTP id w12mr1413452ibv.37.1272798556112; Sun, 
	02 May 2010 04:09:16 -0700 (PDT)
Received: by 10.231.192.21 with HTTP; Sun, 2 May 2010 04:08:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146163>

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 561401b..b60699b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -157,6 +157,7 @@
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
 /gitweb/gitweb.min.*
+/gitweb/GITWEB-BUILD-OPTIONS
 /test-chmtime
 /test-ctype
 /test-date
-- 
1.7.1
