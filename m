From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pathspec.c: Fix some sparse warnings
Date: Sun, 28 Oct 2012 21:09:19 +0000
Message-ID: <508D9EFF.3040900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@adamspiers.org, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:12:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSa9S-0008Gf-05
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab2J1VL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:11:56 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:36324 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755796Ab2J1VLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:11:55 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 438EE18C510;
	Sun, 28 Oct 2012 21:11:54 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 9B51218C455;	Sun, 28 Oct 2012 21:11:52 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Sun, 28 Oct 2012 21:11:51 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208567>


Sparse issues a warning for all six external symbols defined in this
file. In order to suppress the warnings, we include the 'pathspec.h'
header file, which contains the relevant extern declarations for these
symbols.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

I asked Adam to squash this patch into his 'as/check-ignore' branch
when he next re-rolled the branch. However, it appears that you
resubmitted that branch instead ... :-D

I don't know if this branch is ready to progress to next yet, but
could somebody (yourself, Adam or Jeff?) please squash this into
commit 1a88ae42 ("pathspec.c: move reusable code from builtin/add.c")
before it hits next.

Thanks!

ATB,
Ramsay Jones

 pathspec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pathspec.c b/pathspec.c
index a9c5b5b..efdabe4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "pathspec.h"
 
 void validate_path(const char *prefix, const char *path)
 {
-- 
1.8.0
