From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] builtin/gc.c: add missing newline in message
Date: Sun, 19 Jun 2011 10:03:26 +0200
Message-ID: <m239j6tfht.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 10:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYCyu-0008WQ-TD
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 10:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab1FSIDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 04:03:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56441 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1FSID2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 04:03:28 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 8E27D1C021EF
	for <git@vger.kernel.org>; Sun, 19 Jun 2011 10:03:27 +0200 (CEST)
X-Auth-Info: BtkkvgbMbd/ZeuDL1N1Hi4xNiVP8U4Zwdki4TuOFVog=
Received: from linux.local (ppp-88-217-115-153.dynamic.mnet-online.de [88.217.115.153])
	by mail.mnet-online.de (Postfix) with ESMTPA id 725921C00206
	for <git@vger.kernel.org>; Sun, 19 Jun 2011 10:03:27 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 001E71E52E3; Sun, 19 Jun 2011 10:03:26 +0200 (CEST)
X-Yow: My Aunt MAUREEN was a military advisor to IKE & TINA TURNER!!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175998>

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 builtin/gc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ff5f73b..0498094 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -225,7 +225,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr,
 					_("Auto packing the repository for optimum performance. You may also\n"
 					"run \"git gc\" manually. See "
-					"\"git help gc\" for more information."));
+					"\"git help gc\" for more information.\n"));
 	} else
 		append_option(argv_repack,
 			      prune_expire && !strcmp(prune_expire, "now")
-- 
1.7.5.4


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
