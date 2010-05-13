From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Re: git log -M -- filename is not working?
Date: Thu, 13 May 2010 10:12:52 +0800
Message-ID: <AANLkTilES9d8rj5Zwfju7t3H7cjM7h9HWL8YprcxPc6t@mail.gmail.com>
References: <20100508044434.GC14998@coredump.intra.peff.net>
	 <20100508053025.GG14998@coredump.intra.peff.net>
	 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	 <19429.3589.823244.270582@winooski.ccs.neu.edu>
	 <20100512113855.GB23847@coredump.intra.peff.net>
	 <19434.39095.448649.313537@winooski.ccs.neu.edu>
	 <20100512124948.GA11761@coredump.intra.peff.net>
	 <19434.48308.815673.263230@winooski.ccs.neu.edu>
	 <AANLkTilje2dBHjd2aykMnAjWdf8k1vayJ_ez4IfMrl7_@mail.gmail.com>
	 <20100512164522.GA14710@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eli Barzilay <eli@barzilay.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 13 04:17:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCNzk-0000rb-Np
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 04:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab0EMCRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 22:17:46 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:48224 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0EMCRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 22:17:45 -0400
Received: by qyk1 with SMTP id 1so864380qyk.5
        for <git@vger.kernel.org>; Wed, 12 May 2010 19:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=a1yKk5p75Yf82pdcLgLExHZswJXzLrZKANqcjdFgwkQ=;
        b=n4HyeeI52FzIHxDkzYWqlDnKdJptAAKzSSiTJ7esFPh5FBDFhqlMktTnnVF6xD/nE9
         ckSAzBxGc1tg7nyo4D4tn8tTUkYx/QA2znfseTJimNYS78cVPRkKWPbWArnn6xqadtJ/
         DBhQjSdmbCZjGFk4KX2+j/aWbs2tMd6qYUMPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mMjf8ut6DEsUNMx8JZHhXZZ07tTIVE8iiBaGszZUhQThpEjAFpH88w8bMjHlsDix7M
         mlbDC9wt+L/emEdb60WN807tNK7lWyvzw6fB/VjUEyf8sBpCJZis5WGWij40OcB8e1bi
         kw0L2A0X6pj7yK49iPiqG04xMPxLvWA2c6Mn0=
Received: by 10.224.53.80 with SMTP id l16mr5518255qag.308.1273716773620; Wed, 
	12 May 2010 19:12:53 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Wed, 12 May 2010 19:12:52 -0700 (PDT)
In-Reply-To: <20100512164522.GA14710@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146975>

Hi Jeff,
On Thu, May 13, 2010 at 12:45 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 13, 2010 at 12:07:24AM +0800, Bo Yang wrote:
>>
>> Try this one, it only change a little on Jeff's patch, my simple tests
>> show it works. Apply it on 'next' branch.
>
> This is badly whitespace damaged. I fixed up some wrapping, but it seems
> that there was some tab/space interchanges, too. Can you repost?

Ah, sorry. I just copy the patch from my putty window, so it convert
all tabs into spaces...
And the following change this. Also, I have run a 'make test', seems
there is no problem for it. Happy try it!


diff --git a/builtin/log.c b/builtin/log.c
index 6208703..0142036 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -70,9 +70,10 @@ static void cmd_log_init(int argc, const char
**argv, const char *prefix,
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
-		rev->always_show_header = 0;
-		if (rev->diffopt.nr_paths != 1)
-			usage("git logs can only follow renames on one pathname at a time");
+		if (!rev->diffopt.nr_paths)
+			DIFF_OPT_CLR(&rev->diffopt, FOLLOW_RENAMES);
+		else
+			rev->always_show_header = 0;
 	}
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/diffcore.h b/diffcore.h
index 491bea0..9039a06 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -99,6 +99,10 @@ struct diff_queue_struct {
 		(q)->nr = (q)->alloc = 0; \
 		(q)->run = 0; \
 	} while(0);
+#define DIFF_QUEUE_MARK_RUN(q, r) \
+	do { \
+		(q)->run = (r); \
+	} while(0);

 extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
diff --git a/tree-diff.c b/tree-diff.c
index 1fb3e94..dd95f74 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"

 static char *malloc_base(const char *base, int baselen, const char
*path, int pathlen)
 {
@@ -322,78 +323,74 @@ int diff_tree(struct tree_desc *t1, struct
tree_desc *t2, const char *base, stru
 }

 /*
- * Does it look like the resulting diff might be due to a rename?
- *  - single entry
- *  - not a valid previous file
+ * Does it look like the resulting diff might be due to a rename? If we have
+ * any files that appeared, then maybe.
  */
 static inline int diff_might_be_rename(void)
 {
-	return diff_queued_diff.nr == 1 &&
-		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
+	int i;
+	for (i = 0; i < diff_queued_diff.nr; i++)
+		if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one))
+			return 1;
+	return 0;
 }

 static void try_to_follow_renames(struct tree_desc *t1, struct
tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
+	struct diff_queue_struct outq;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_filepair *choice;
-	const char *paths[1];
+	const char **new_paths;
+	int new_paths_num, new_paths_alloc;
 	int i;

-	/* Remove the file creation entry from the diff queue, and remember it */
-	choice = q->queue[0];
+	DIFF_QUEUE_CLEAR(&outq);
 	q->nr = 0;

 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
-	paths[0] = NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("unable to set up diff options to follow renames");
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
-	diff_tree_release_paths(&diff_opts);

-	/* Go through the new set of filepairing, and see if we find a more
interesting one */
+	new_paths_num = new_paths_alloc = opt->nr_paths;
+	new_paths = xmalloc(opt->nr_paths * sizeof(*new_paths));
+	for (i = 0; i < opt->nr_paths; i++)
+		new_paths[i] = opt->paths[i];
+
+	/* Go through the new set of filepairs, looking for renames. */
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];

-		/*
-		 * Found a source? Not only do we use that for the new
-		 * diff_queued_diff, we will also use that as the path in
-		 * the future!
-		 */
-		if ((p->status == 'R' || p->status == 'C') && !strcmp(p->two->path,
opt->paths[0])) {
-			/* Switch the file-pairs around */
-			q->queue[i] = choice;
-			choice = p;
-
-			/* Update the path we use from now on.. */
-			diff_tree_release_paths(opt);
-			opt->paths[0] = xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->paths, opt);
-			break;
-		}
-	}
+		/* XXX actually this is the slightly different wildcarding
+		 * pathspec. We really want to check just prefixes. But
+		 * I wonder if we can convince the diff machinery to just
+		 * be interested in these paths as destinations, but use
+		 * the whole tree as sources */
+		if (!match_pathspec(opt->paths, p->two->path,
+				   strlen(p->two->path), 0, NULL))
+			continue;

-	/*
-	 * Then, discard all the non-relevant file pairs...
-	 */
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		diff_free_filepair(p);
+		diff_q(&outq, p);
+
+		ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_alloc);
+		new_paths[new_paths_num++] = xstrdup(p->one->path);
 	}

-	/*
-	 * .. and re-instate the one we want (which might be either the
-	 * original one, or the rename/copy we found)
-	 */
-	q->queue[0] = choice;
-	q->nr = 1;
+	/* now finalize the new paths */
+	ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_alloc);
+	new_paths[new_paths_num] = NULL;
+	diff_tree_release_paths(opt);
+	diff_tree_setup_paths(new_paths, opt);
+
+	/* and restore our old queue */
+	free(q->queue);
+	*q = outq;
+	DIFF_QUEUE_MARK_RUN(q, 1);
 }

 int diff_tree_sha1(const unsigned char *old, const unsigned char
*new, const char *base, struct diff_options *opt)


Regards!
Bo
-- 
My blog: http://blog.morebits.org
