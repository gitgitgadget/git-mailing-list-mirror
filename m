From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/8] diff-delta.c: "diff.h" is not a required include
Date: Fri,  5 Jun 2009 18:36:11 -0500
Message-ID: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixq-0002dR-N1
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZFEXge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbZFEXgc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51656 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZFEXga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:30 -0400
Received: by mail.nrlssc.navy.mil id n55NaS85019256; Fri, 5 Jun 2009 18:36:28 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:27.0942 (UTC) FILETIME=[72714C60:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120840>

From: Brandon Casey <drafnel@gmail.com>

This file (diff.h) provides declarations for some functions that are
implemented in diff-delta.c.  The SUNWspro C99 compiler complains about
it.  There is nothing defined in "diff.h" that is required by diff-delta.c,
so don't #include it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 diff-delta.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index a4e28df..a9969f0 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -12,7 +12,6 @@
  */
 
 #include "git-compat-util.h"
-#include "delta.h"
 
 /* maximum hash entry list for the same hash bucket */
 #define HASH_LIMIT 64
-- 
1.6.3.1.24.g152f4
