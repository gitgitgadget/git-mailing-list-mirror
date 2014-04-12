From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH] checkout: Fix grammar in inline comment.
Date: Sun, 13 Apr 2014 07:41:27 +0900
Message-ID: <1397342487-46596-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 00:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ6cJ-0004fE-EG
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 00:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbaDLWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 18:41:38 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:65053 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLWli (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 18:41:38 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so6685282pde.15
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r1HzbYetisJSGxQDq/tOit5ghVPxvLQcXPbTaAAzSME=;
        b=hxBvq3wDJWqw/INn8Y4dE98i+cnqUQYUj7ts2cUwYp7BgbpKJCJ5oCkkmlj9wigkRF
         wrZ+s/FryhvuzfRo7+u6Z8/6EnFD8fBVwF2oTRoC11Vco0Tl6bmADym7nAR0poSkQh9R
         LnAqmMKJOp5Dh80hM1jA5VfZgTukhZvgKFJdHio+B6joTxdtC5XIpmAlf+86cAQA7ifs
         x3IzS32JhjnqG1V3Ugc9McUETau6yy6fJuIQUXiFYRzYru3cQyCwlcB80+2iBCI9DuOh
         MMvdfSDF/PQ/n3j6q3MD1TG96eSSLoHOX2VDKuqrfO3SJ/Nv1DLbLKxOzpHjGo+W+w6o
         YxtA==
X-Received: by 10.68.136.162 with SMTP id qb2mr35649019pbb.88.1397342497623;
        Sat, 12 Apr 2014 15:41:37 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id kl1sm24117508pbd.73.2014.04.12.15.41.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 15:41:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.259.gc5d75e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246199>

Inline comment had incorrect grammar. Fix grammatical mistakes and
reflect actual behavior of the function.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 builtin/checkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 63151e0..abe1161 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -888,8 +888,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *
 	 * case 3: git checkout <something> [--]
 	 *
-	 *   (a) If <something> is a commit, that is to
-	 *       switch to the branch or detach HEAD at it.  As a special case,
+	 *   (a) If <something> is a commit, switch to that branch or
+	 *       detach HEAD at that commit.  As a special case,
 	 *       if <something> is A...B (missing A or B means HEAD but you can
 	 *       omit at most one side), and if there is a unique merge base
 	 *       between A and B, A...B names that merge base.
-- 
1.9.0.259.gc5d75e8.dirty
