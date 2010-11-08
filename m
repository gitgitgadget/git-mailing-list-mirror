From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/7] archive: improve --verbose description
Date: Mon, 08 Nov 2010 19:02:57 +0100
Message-ID: <4CD83B51.7000306@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW3i-00052K-0K
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab0KHSDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:03:04 -0500
Received: from india601.server4you.de ([85.25.151.105]:47816 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab0KHSDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:03:03 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id 343852F807B;
	Mon,  8 Nov 2010 19:03:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160957>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index 78a67f0..1944ed4 100644
--- a/archive.c
+++ b/archive.c
@@ -314,7 +314,7 @@ static int parse_archive_args(int argc, const char **argv,
 			"write the archive to this file"),
 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, "report archived files on stderr"),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
 		OPT__COMPR_HIDDEN('2', &compression_level, 2),
-- 
1.7.3
