From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 08/11] Document git rev-parse --is-inside-git-dir
Date: Sat, 16 Jun 2007 21:03:44 +0200
Message-ID: <11820206351723-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU4-0007JN-IV
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbXFPS60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbXFPS60
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbXFPS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101911ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rC1knQ1uNAED9+qs6F61QhvJwbLKCoYKcbOHzh2MHsXa/yKpnJofA5gJyJWTHX1guHuZ0hApJTgusy2YANf3ffOclKUS9HBp4yFtO4qZfijEyr0jgambO+jnvNfss3Ilg/qJ23pUGfAmwCZM9GwHU2dFowr9Vke9oR8c/zvwj/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AWM1xZ7joftU+M8PVlu5QWX1acb2kfZSLkKYvGZaJcCuTAZ4qlacE+LrsQqrDdFxpG7i+S0WUoTDtqtqaGKYHtkxyE3cRAkmLFNeziWIS9A4shNqiscu72uDupfmqwqL+j/4B9gTB4TFuoyMwCMC3cOxUkESutbmVXsRpk6YBYc=
Received: by 10.82.152.16 with SMTP id z16mr8172780bud.1182020294327;
        Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875776nfh.2007.06.16.11.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3tMR004254;
	Sat, 16 Jun 2007 21:03:55 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3tO6004253;
	Sat, 16 Jun 2007 21:03:55 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50302>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-rev-parse.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e1cb4ef..87771b8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -89,6 +89,10 @@ OPTIONS
 --git-dir::
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
 
+--is-inside-git-dir::
+	Return "true" if we are in the git directory, otherwise "false".
+	Some commands require to be run in a working directory.
+
 --short, --short=number::
 	Instead of outputting the full SHA1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
-- 
1.5.2
