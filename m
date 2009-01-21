From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 20:09:24 +0200
Message-ID: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 19:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPhXf-000764-S0
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817AbZAUSJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZAUSJa
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:09:30 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:59858 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760054AbZAUSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:09:29 -0500
Received: by fk-out-0910.google.com with SMTP id f33so305889fkf.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HBE3GbzD3KpN5QApcXjKngl9hssUT7Ow62xUV21zMXs=;
        b=CXIwS2q5pCQnM41Oq7dADw0/qJLFWeWmAp/5jOsbnqFumLeEjeJMjXx762IlkDJeEu
         841tbBl2qi2r84Hj3lo1ccJpoOy8o/zHTEN1dl5thR5Av9beGhjqhuTgyVf02jU/m7+k
         z6SSMGsFN44Nr+gAU5P9JlXpOCxRZcS87IebQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SJkvN9j3McnmPaunWzAcAzytL3xsbrL6lUsuG1BLrpsj1nzTIErj/a+CnAVAJ9MnpH
         RnAqlU7QqagDbR1zcn2gunUXErHxBQHcCIPaaNKbcIgjnVGhKdYsULTTiOfceN5cwsTh
         +jkr5ycDITJ1d7HVOlYyDr0m+Eu+YErzjHdzA=
Received: by 10.181.149.7 with SMTP id b7mr2971220bko.210.1232561367585;
        Wed, 21 Jan 2009 10:09:27 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id c28sm8583574fka.26.2009.01.21.10.09.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 10:09:27 -0800 (PST)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106634>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 19f571a..3a9704c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -981,13 +981,11 @@ Telling git your name
 ---------------------
 
 Before creating any commits, you should introduce yourself to git.  The
-easiest way to do so is to make sure the following lines appear in a
-file named .gitconfig in your home directory:
+easiest way is to use the linkgit:git-config[1] command:
 
 ------------------------------------------------
-[user]
-	name = Your Name Comes Here
-	email = you@yourdomain.example.com
+$ git config user.name "Your Name Comes Here"
+$ git config user.email you@yourdomain.example.com
 ------------------------------------------------
 
 (See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
-- 
1.6.1
