From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix show-ref usage for --dereference.
Date: Wed, 20 Sep 2006 06:21:25 +0200
Message-ID: <20060920062125.25f99390.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 06:15:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPtUc-0001vr-JT
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 06:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWITEPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 00:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWITEPS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 00:15:18 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:18370 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751127AbWITEPR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 00:15:17 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 7987475B02;
	Wed, 20 Sep 2006 06:15:16 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27328>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-show-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 577d934..fab359b 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -3,7 +3,7 @@ #include "refs.h"
 #include "object.h"
 #include "tag.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--deref] [-s|--hash] [--tags] [--heads] [--] [pattern*]";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash] [--tags] [--heads] [--] [pattern*]";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
 	found_match = 0, verify = 0, quiet = 0, hash_only = 0;
-- 
1.4.2.1.g4251-dirty
