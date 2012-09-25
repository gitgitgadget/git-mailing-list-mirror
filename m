From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pathspec.c: Fix some sparse warnings
Date: Tue, 25 Sep 2012 18:15:41 +0100
Message-ID: <5061E6BD.2070109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: git@adamspiers.org
X-From: git-owner@vger.kernel.org Tue Sep 25 19:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGYnL-0002rM-BI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 19:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab2IYRT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 13:19:28 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:52103 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757247Ab2IYRT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 13:19:27 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id BC01C384081;
	Tue, 25 Sep 2012 18:19:25 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A1444384080;	Tue, 25 Sep 2012 18:19:25 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Tue, 25 Sep 2012 18:19:24 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206366>


Sparse issues a warning for all six external symbols defined in this
file. In order to suppress the warnings, we include the 'pathspec.h'
header file, which contains the relevant extern declarations for these
symbols.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Adam,

When you re-roll your 'as/check-ignore' branch could you please squash
this patch into commit a1080211 ("pathspec.c: move reusable code from
builtin/add.c", 20-09-2012).

Thanks!

ATB,
Ramsay Jones

 pathspec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pathspec.c b/pathspec.c
index 9525c7c..5dba000 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "pathspec.h"
 
 void validate_path(const char *prefix, const char *path)
 {
-- 
1.7.12
