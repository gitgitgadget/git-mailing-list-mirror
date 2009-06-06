From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 3/8] diff-delta.c: "delta.h" is not a required include
Date: Fri,  5 Jun 2009 19:47:06 -0500
Message-ID: <M3MzU6FlQXfVApDnN0vdEf4UcS0v8Dh-XOz1cA15MA7nN8wUHrIif6F7g1-JWcHSJSi5Z6_vOoA@cipher.nrlssc.navy.mil>
References: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 06 02:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCk4G-0001tD-IR
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 02:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbZFFArP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 20:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZFFArP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 20:47:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35759 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFFArO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 20:47:14 -0400
Received: by mail.nrlssc.navy.mil id n560lDva028380; Fri, 5 Jun 2009 19:47:13 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Jun 2009 00:47:13.0063 (UTC) FILETIME=[54BB5B70:01C9E640]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120852>

From: Brandon Casey <drafnel@gmail.com>

When compiling diff-delta.c with the SUNWspro C99 compiler, it complains

    "diff-delta.c", line 314: identifier redeclared: create_delta

There is nothing in "delta.h" that is required by diff-delta.c, so don't
include it.

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
