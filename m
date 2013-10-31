From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/16] revision: trivial style fixes
Date: Thu, 31 Oct 2013 03:25:43 -0600
Message-ID: <1383211547-9145-13-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocj-0008Ez-TF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab3JaJdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:00 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:51117 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:58 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so2777373oah.18
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/nWjtEVoNkOUuFRxBx3OT2e+yQzcYwY9hQfO/NPTu4=;
        b=gamstp07XetsaGGM2GAZV8AHttnBwoXAmG4kg+Hsbig+gThYZkkNsYWccb6pOr2d7Z
         RIBArBPU6wRyTfv0SdmRuuifSz3SKfDVF8oLzbEKf13eHe453gjlyfNkRwHEcISUOktM
         mrKb14a1zmmlNc2tM3uCjvb0IoY/whcaA1Sk+U6KOTfyG27xylSWzAJDA8Y1nsHPEvNO
         3O6suLtz4h/kEnR/N3D9cKPMrP3YQvMr9BxkMY9owLhz+a34ATlAsZTfvJBqB+b9gQZC
         vHSioOlyiwoKY8cMRr34jCBLZZSRBBop6VmcTakaDeyLWKQYoHXo5ZOpvcBaWYBPtuwZ
         +YTQ==
X-Received: by 10.182.80.196 with SMTP id t4mr1855592obx.1.1383211977674;
        Thu, 31 Oct 2013 02:32:57 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm4451056obg.13.2013.10.31.02.32.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237094>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 3fdea51..956040c 100644
--- a/revision.c
+++ b/revision.c
@@ -1519,7 +1519,7 @@ struct cmdline_pathspec {
 static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 {
 	while (*av) {
-		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = *(av++);
 	}
 }
@@ -1531,7 +1531,7 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 		int len = sb->len;
 		if (len && sb->buf[len - 1] == '\n')
 			sb->buf[--len] = '\0';
-		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
 }
@@ -2134,7 +2134,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 *	call init_pathspec() to set revs->prune_data here.
 		 * }
 		 */
-		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
+		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] = NULL;
 		parse_pathspec(&revs->prune_data, 0, 0,
 			       revs->prefix, prune_data.path);
@@ -2987,7 +2987,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (revs->max_count) {
 		c = get_revision_1(revs);
 		if (c) {
-			while (0 < revs->skip_count) {
+			while (revs->skip_count > 0) {
 				revs->skip_count--;
 				c = get_revision_1(revs);
 				if (!c)
@@ -3002,9 +3002,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (c)
 		c->object.flags |= SHOWN;
 
-	if (!revs->boundary) {
+	if (!revs->boundary)
 		return c;
-	}
 
 	if (!c) {
 		/*
@@ -3050,9 +3049,8 @@ struct commit *get_revision(struct rev_info *revs)
 
 	if (revs->reverse) {
 		reversed = NULL;
-		while ((c = get_revision_internal(revs))) {
+		while ((c = get_revision_internal(revs)))
 			commit_list_insert(c, &reversed);
-		}
 		revs->commits = reversed;
 		revs->reverse = 0;
 		revs->reverse_output_stage = 1;
-- 
1.8.4.2+fc1
