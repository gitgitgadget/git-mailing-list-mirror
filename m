From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 2/17] Fix the description of --utf8 and --keep to git-am.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844854119-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853669-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCO-0004lM-GG
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbVLHX2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLHX2N
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:13 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:9380 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932721AbVLHX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051208232804.VENK676.mxfep01.bredband.com@puritan.petwork>;
          Fri, 9 Dec 2005 00:28:04 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 302A7ADFEA;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853669-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13400>

The git-am script actually transform --utf8 and --keep to -u and -k when
sent to git-mailinfo.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-am.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c11386158dd597184fbc14df5f728bddd23b3d17
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 1ceed11..6645e82 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -28,7 +28,7 @@ OPTIONS
 	area to store extracted patches.
 
 --utf8, --keep::
-	Pass `--utf8` and `--keep` flags to `git-mailinfo` (see
+	Pass `-u` and `-k` flags to `git-mailinfo` (see
 	gitlink:git-mailinfo[1]).
 
 --binary::
-- 
0.99.9l
