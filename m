From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/4] Mention -r in usage summary
Date: Sun, 26 Feb 2006 06:11:24 +0100
Message-ID: <20060226051124.24860.29160.stgit@backpacker.hemma.treskal.com>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Feb 26 06:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDEBu-0000Op-Es
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBZFL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:11:27 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBZFL1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:11:27 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:10472 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751205AbWBZFL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 00:11:26 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060226051125.WRNS29994.mxfep02.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:25 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 71421272A
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:24 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16773>

I added the -r option to git-svnimport some time ago, but forgot to
update the usage summary in the documentation.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Documentation/git-svnimport.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index 5c543d5..b5c7721 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -10,10 +10,10 @@ git-svnimport - Import a SVN repository=20
 SYNOPSIS
 --------
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
-			[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
-			[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
-			[ -s start_chg ] [ -m ] [ -M regex ]
-			<SVN_repository_URL> [ <path> ]
+		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
+		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
+		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
+		<SVN_repository_URL> [ <path> ]
=20
=20
 DESCRIPTION
