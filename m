From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] branch: fix funny-sounding error message
Date: Fri,  1 May 2015 21:12:40 -0600
Message-ID: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 05:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNrU-0002DU-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 05:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbbEBDMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 23:12:48 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35835 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbEBDMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 23:12:47 -0400
Received: by iejt8 with SMTP id t8so100446071iej.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=11nAjlP9wL4M4K/fT/+pCQnD6MnTaFNC2bUXdkPmA60=;
        b=TMV7lZOvWKs4rY9B7zLZwWzQ/+wHt5Lsti6TRu5Qw423v53TKYalAxPG5xb2o3YPon
         +1UO2+pYDkbkUa6Mp5jEZdKD+R6SXzz8PInM4KaFTYruNPHL4NElwLYfzASXEtI598WY
         JNtEqsY1WMBLbUd/D8j6aypIAnLj7xkPOJLAtrYjzhZXNf9HhaAE7rpP47Y4+tr7YpOU
         P7ShcPhbWjoS166yP0FtPvk4jVRTup+NC3hZNlHP8stkzZHqEcXVcHf6KNEU5nTxwnC3
         IUSCMVQA8mm4/kCaaSDtObU8j4tpVS79adbDYBFCqQhOg3fZK3/A4sD9WRxp7dEHWktH
         veRw==
X-Received: by 10.107.9.67 with SMTP id j64mr8199605ioi.39.1430536365965;
        Fri, 01 May 2015 20:12:45 -0700 (PDT)
Received: from localhost.localdomain (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id 37sm4814107ioj.0.2015.05.01.20.12.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 May 2015 20:12:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268214>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1d15037..c0b4bae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -972,7 +972,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-				die(_("could not set upstream of HEAD to %s when "
+				die(_("could not set upstream of HEAD to %s because "
 				      "it does not point to any branch."),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
-- 
2.3.7
