From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 17/56] merge-recursive: Correct a comment
Date: Thu, 11 Aug 2011 23:19:50 -0600
Message-ID: <1313126429-17368-18-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDt-00066y-3U
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab1HLFXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:23:09 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab1HLFVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:09 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LN4EFDKKkCHvufKmI8Qa00njEEoZW2nWpTa7b6NhnZ0=;
        b=fy+7DVQ/glWyRZR3EoAaopOR7/08Wv+gKRrROH7kbBqDwJ4js2VBKn4+TU4L5Tcwn6
         oF5QxS9Tpg6/x3cnVghc6aaEqlDrw/pEsXeWV2Hkcjnb8PjrW29nJ4mWmnurOtk2Q4B7
         DeD4J/hdxaC10VcM534iam85HWRRPkkHj0/EI=
Received: by 10.231.83.135 with SMTP id f7mr1042108ibl.90.1313126468969;
        Thu, 11 Aug 2011 22:21:08 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.07
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179218>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3fcd0a5..3d464d9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1439,7 +1439,7 @@ static int process_df_entry(struct merge_options *o,
 		handle_delete_modify(o, path, new_path,
 				     a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
-		/* directory -> (directory, file) */
+		/* directory -> (directory, file) or <nothing> -> (directory, file) */
 		const char *add_branch;
 		const char *other_branch;
 		unsigned mode;
-- 
1.7.6.100.gac5c1
