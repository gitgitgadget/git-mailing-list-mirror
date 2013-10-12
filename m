From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/20] revision: trivial style fixes
Date: Sat, 12 Oct 2013 02:07:05 -0500
Message-ID: <1381561636-20717-10-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOY-0005ob-CI
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab3JLHNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:44 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48812 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:40 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so3486519obc.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KSX7913mSOHx1Xixp2bTAzB20MBLKEBHLi5oREu0boU=;
        b=kxZWVQ+pCpHoTaCpW6xNw0kzHwqIg1Y5E60e/Qwfi9kreiVoTsFfkhd+wmWf0JqGKM
         btPfUC75IWm/BWN8A0YTQ4GfGzj/MTgZdcHZXQL5C1P0pRq72JW7oRyfKQM+tG8mct4N
         vOJRj0mYd1RkPtOfjVQvRHeDgHWMgaOo5tx/w9FOhzru1yf+MckxkVnIRHivJowYHPML
         eaTfhfnaXKJoYLOpcOdIwbi2hOjAE0Q8mNka/LU9xZBdY2FD8IlnG5lAkr13E7f37iXp
         I/EpTbTxI3t6iKD7tSeaZWmW9cMUkMzTFCKcvLl6salG45dYSamcXksjOJN3hjskYyAa
         S43w==
X-Received: by 10.182.214.98 with SMTP id nz2mr13743012obc.37.1381562020137;
        Sat, 12 Oct 2013 00:13:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm28639839obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236019>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 0173e01..4049867 100644
--- a/revision.c
+++ b/revision.c
@@ -1503,7 +1503,7 @@ struct cmdline_pathspec {
 static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
 {
 	while (*av) {
-		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = *(av++);
 	}
 }
@@ -1515,7 +1515,7 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 		int len = sb->len;
 		if (len && sb->buf[len - 1] == '\n')
 			sb->buf[--len] = '\0';
-		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
 }
@@ -2118,7 +2118,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 *	call init_pathspec() to set revs->prune_data here.
 		 * }
 		 */
-		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
+		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] = NULL;
 		parse_pathspec(&revs->prune_data, 0, 0,
 			       revs->prefix, prune_data.path);
@@ -2971,7 +2971,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (revs->max_count) {
 		c = get_revision_1(revs);
 		if (c) {
-			while (0 < revs->skip_count) {
+			while (revs->skip_count > 0) {
 				revs->skip_count--;
 				c = get_revision_1(revs);
 				if (!c)
@@ -2986,9 +2986,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (c)
 		c->object.flags |= SHOWN;
 
-	if (!revs->boundary) {
+	if (!revs->boundary)
 		return c;
-	}
 
 	if (!c) {
 		/*
@@ -3034,9 +3033,8 @@ struct commit *get_revision(struct rev_info *revs)
 
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
1.8.4-fc
