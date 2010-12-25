From: Zapped <zapped@mail.ru>
Subject: [PATCH 1/3] Fixes bug: git-diff: class methods are not detected in hunk headers for Pascal
Date: Sat, 25 Dec 2010 04:20:47 +0300
Message-ID: <1293240049-7744-1-git-send-email-zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 25 02:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWIou-0003mU-Or
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 02:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0LYBU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 20:20:56 -0500
Received: from smtp8.mail.ru ([94.100.176.53]:35486 "EHLO smtp8.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013Ab0LYBUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 20:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Date:Subject:To:From; bh=D9I+7PBUoaLacOf2QMgWF0e4NgiIB9v5/KLTEl+gszQ=;
	b=T88DGlB0/NKsauzyEQcIZEAr24jI3LsU7+KAQWjzMLhW7252qE1pei8B1Up3ljZZCEuvnzyPuNY4S8hEWfClf5kU7roMTAzHUZPxrFHuwldhF3Q4bf+au8nnjJxi7ol/;
Received: from [85.140.52.43] (port=41177 helo=localhost.localdomain)
	by smtp8.mail.ru with asmtp 
	id 1PWIoX-0001Kk-00
	for git@vger.kernel.org; Sat, 25 Dec 2010 04:20:53 +0300
X-Mailer: git-send-email 1.7.3.4.3.g3f811
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164166>

Signed-off-by: Zapped <zapped@mail.ru>
---
 userdiff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index f9e05b5..259a382 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -52,7 +52,7 @@ PATTERNS("objc",
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
 	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("pascal",
-	 "^((procedure|function|constructor|destructor|interface|"
+	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
 	 "\n"
 	 "^(.*=[ \t]*(class|record).*)$",
-- 
1.7.3.4.3.g3f811
