From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 3/17] Use uniform description for the '--' option.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844852030-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844854119-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVBP-0004R3-Qe
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVLHX2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLHX2M
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:12 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:8868 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932726AbVLHX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051208232804.VENL676.mxfep01.bredband.com@puritan.petwork>;
          Fri, 9 Dec 2005 00:28:04 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 3CC0BADFEB;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844854119-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13386>

All descriptions of the '--' option were the same except for that in
Documentation/git-merge-index.txt.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-merge-index.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

54160acf1b953d34c161b27aa2b320bbf61ac86e
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 6030642..fbc986a 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -20,7 +20,7 @@ files are passed as arguments 5, 6 and 7
 OPTIONS
 -------
 --::
-	Interpret all following arguments as filenames.
+	Do not interpret any more arguments as options.
 
 -a::
 	Run merge against all files in the index that need merging.
-- 
0.99.9l
