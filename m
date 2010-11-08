From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/7] verify-tag: document --verbose
Date: Mon, 08 Nov 2010 19:04:51 +0100
Message-ID: <4CD83BC3.6000606@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW5Y-0006Et-Op
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab0KHSE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:04:56 -0500
Received: from india601.server4you.de ([85.25.151.105]:45747 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0KHSE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:04:56 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id E81732F807B;
	Mon,  8 Nov 2010 19:04:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160960>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-verify-tag.txt |    4 ++++
 builtin/verify-tag.c             |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index dada212..7112197 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -15,6 +15,10 @@ Validates the gpg signature created by 'git tag'.
 
 OPTIONS
 -------
+-v::
+--verbose::
+	Print the contents of the tag object before validating it.
+
 <tag>...::
 	SHA1 identifiers of git tag objects.
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 6784846..8136dba 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -93,7 +93,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	const struct option verify_tag_options[] = {
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, "print tag contents"),
 		OPT_END()
 	};
 
-- 
1.7.3
