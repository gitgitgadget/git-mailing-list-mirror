From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 16/56] merge-recursive: Make BUG message more legible by adding a newline
Date: Thu, 11 Aug 2011 23:19:49 -0600
Message-ID: <1313126429-17368-17-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBP-0004nj-Id
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1HLFVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:11 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1HLFVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:07 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ulWcnK4Muw7MhV/HUQOrQxngIFydOQehZUnPopTs4JU=;
        b=J9tt4yM9FJw68U/bYjxSNE8dJAG5xisIuByUD61lieGozmgbFqqIOfFY4hYKInm2IV
         2lIPD2SMWZ+AOoXekjuoEuBxpHUMN6h4iUcwkWNULTPfKARN9WKGBgO1HiwB0iOwNWai
         rD2jacGG/q7dHMZOLBj6UcdSnEooHYrz39EVE=
Received: by 10.42.169.198 with SMTP id c6mr539192icz.271.1313126467108;
        Thu, 11 Aug 2011 22:21:07 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.05
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179177>

Hopefully no one ever hits this error except when making large changes to
merge-recursive.c and debugging...

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index db9ba19..3fcd0a5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -230,7 +230,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s", ce_stage(ce),
+				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
 		die("Bug in merge-recursive.c");
-- 
1.7.6.100.gac5c1
