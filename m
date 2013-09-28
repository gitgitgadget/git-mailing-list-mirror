From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/10] revision: trivial style fixes
Date: Sat, 28 Sep 2013 16:51:45 -0500
Message-ID: <1380405106-29430-10-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2Wb-0002PV-Ad
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab3I1V6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:58:02 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33255 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3I1V57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:59 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so4187667obc.10
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3kfOnEC/lzvj89NvaFHg9eS8OPChCpRcVRbzSk625lo=;
        b=tx+eMmuBZyueaGqloh+QI1VF+UzXVU6x7T5EcFEj4FCFMNrui+ZbWaDKQAg9k9y5jU
         m2JEVZ4CDWPhkfeg/1+KQnXbG8uveacgZJyVhkQV9ZYL5PalfuMT70kJGvEZ6QVnLN1u
         09aainjbAlyJCCJczmLfwf9jTH4VIbnGeUY8Xc0xSi4VbPxEGX96tau9kokSZVfumthO
         KjtSK3CXxGu4Gn87Qlf0AHLlugMf86ANS5lHfNdwLf+BR6/fz/m/z8nOOhMgXq7rj3Lh
         GvRjLDn/nDNY9LRNYZgrfCvW5VRRI3VZSRVnWssTwaAmqLyy8O1RPmLiq6oIKyQyuok0
         6E/Q==
X-Received: by 10.60.52.81 with SMTP id r17mr12478659oeo.3.1380405478517;
        Sat, 28 Sep 2013 14:57:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm19413428obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235518>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 3ebd558..4049867 100644
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
-- 
1.8.4-fc
