From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/7] branch: improve --verbose description
Date: Mon, 08 Nov 2010 19:03:58 +0100
Message-ID: <4CD83B8E.1060204@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW4h-0005k7-Tl
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab0KHSEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:04:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:45746 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0KHSEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:04:05 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id B96552F807B;
	Mon,  8 Nov 2010 19:04:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160958>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e388edc..807355a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -621,7 +621,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose,
+			"show hash and subject, give twice for upstream branch"),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
-- 
1.7.3
