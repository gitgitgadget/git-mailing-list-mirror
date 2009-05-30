From: David Aguilar <davvid@gmail.com>
Subject: Re: git-ls-files --added?
Date: Fri, 29 May 2009 23:02:34 -0700
Message-ID: <20090530060233.GA10033@gmail.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com> <m3fxeudhho.fsf@localhost.localdomain> <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com> <7vmy921i3j.fsf@alter.siamese.dyndns.org> <7vws85y9n7.fsf@alter.siamese.dyndns.org> <2cfc40320905251756t32e092fdqda769e21669f5d86@mail.gmail.com> <20090529212634.GA86167@gmail.com> <20090530070111.6117@nanako3.lavabit.com> <7v4ov38q5x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 08:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAHed-0008Om-EK
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 08:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZE3GCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 02:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZE3GCl
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 02:02:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:11110 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZE3GCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 02:02:40 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2200060wfd.4
        for <git@vger.kernel.org>; Fri, 29 May 2009 23:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K9vw9UB47Pe6EsYvqHOSX5HipLGC+oEA2RpWgt6wip0=;
        b=nnisdEtpRlYJcD+dVxcZC3Bi1xbEYzi0NZx/stktr6seDfw9/Y6F0vxoCkj1eT6BXO
         nL1MKg7rRBqWe9LxTOsFq7s7ftjvA78WAjOe4V9QoFewHVh2PdzX92MEx7NjeOinUbSs
         vPIiMfEreSkWfl7cwhSMFsF9dcN5jMs3cC9i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EGv+UUKh52mvweeXEkqYevSpfAMGiq5jxa2yLyjQ6ENgQCrBTCNiDRE2Z/AcTVdrHH
         dz6yv6Krqhm2ttmXHG6ORjKwsPceT68hmHZmikiEeg+RGpXM+pLmh/qeL/YV1aVjhRZX
         Cjb4G3nkvs/IHbEzaMzCnyIMAo+peDqgmzh4s=
Received: by 10.143.5.21 with SMTP id h21mr1061782wfi.293.1243663360353;
        Fri, 29 May 2009 23:02:40 -0700 (PDT)
Received: from gmail.com (cpe-76-87-90-126.socal.res.rr.com [76.87.90.126])
        by mx.google.com with ESMTPS id 32sm1386320wfc.14.2009.05.29.23.02.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 23:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4ov38q5x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120337>

On Fri, May 29, 2009 at 04:06:50PM -0700, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > ..., but I think the patch in the thread quoted by Junio (http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=99134) does exactly that.
> 
> I do not know if it matches what David wants, but I can tell you that that
> patch is certainly ancient.
> 
> Here is a minimal update to make it apply cleanly on top of today's
> 'master'.

Thanks Nanako + Junio!

There's good stuff to build upon here so I'll take a deeper look
into it.  Getting this as plumbing will help a lot of future git
scripters.

>         XsssY PATH1 -> PATH2
> 
>     format, where X is the diff status between HEAD and the index, sss is the
>     rename/copy score of the change (if X is rename or copy --- otherwise
>     it is blank), Y is the diff status between the index and the worktree.  
>     PATH1 is the path in the HEAD, and " -> PATH2" part is shown only when
>     PATH1 corresponds to a different path in the index/worktree.

Can/should shortstatus handle comparing against arbitrary revs,
so we can parse the same info against HEAD~ to see a fake
status as if we're amending a commit?  That'd be pretty useful.


> If you apply this patch with "git apply" (no --index) and then
> 
>         $ git mv COPYING RENAMING
> 
> then you would see:
> 
>         $ ./git-shortstatus
>         M     Makefile
>         R100  COPYING -> RENAMING
>             M builtin-commit.c
>             M builtin-revert.c
>             M builtin.h
>             M git.c
>             M wt-status.c
>             M wt-status.h        

Very nice.

I'll look into your suggestions below when I have some more
time and welcome others to help out as well.


> It is very much welcomed if somebody wants to build on top of this.  A few
> obvious things, aside from bikeshedding to drop the score value (which I
> just did as a sanity check measure and for nothing else --- I won't feel
> hurt if we lost that field from the output) and such are:
> 
>  * We can also rewrite wt_status_print_untracked() using the collected
>    data by making the collector pay attention to untracked files quite
>    easily;
> 
>  * I did not bouther touching wt_status_print_initial() but I think it
>    should be straightforward to produce its output from the collected
>    data, as the collector already knows how to handle the initial commit.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Makefile         |    1 +
>  builtin-commit.c |   45 +++++++++++-
>  builtin-revert.c |    1 +
>  builtin.h        |    1 +
>  git.c            |    1 +
>  wt-status.c      |  214 ++++++++++++++++++++++++++++++++++++++++++-----------
>  wt-status.h      |    9 ++
>  7 files changed, 226 insertions(+), 46 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index eaae45d..fd497d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -359,6 +359,7 @@ BUILT_INS += git-init$X
>  BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-peek-remote$X
>  BUILT_INS += git-repo-config$X
> +BUILT_INS += git-shortstatus$X
>  BUILT_INS += git-show$X
>  BUILT_INS += git-stage$X
>  BUILT_INS += git-status$X
> diff --git a/builtin-commit.c b/builtin-commit.c
> index baaa75c..463356b 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -14,6 +14,7 @@
>  #include "diffcore.h"
>  #include "commit.h"
>  #include "revision.h"
> +#include "string-list.h"
>  #include "wt-status.h"
>  #include "run-command.h"
>  #include "refs.h"
> @@ -21,7 +22,6 @@
>  #include "strbuf.h"
>  #include "utf8.h"
>  #include "parse-options.h"
> -#include "string-list.h"
>  #include "rerere.h"
>  #include "unpack-trees.h"
>  
> @@ -817,6 +817,49 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	return argc;
>  }
>  
> +int cmd_shortstatus(int argc, const char **argv, const char *prefix)
> +{
> +	struct wt_status s;
> +	int i;
> +
> +	read_cache();
> +	refresh_cache(REFRESH_QUIET);
> +	wt_status_prepare(&s);
> +	wt_status_collect_changes(&s);
> +	for (i = 0; i < s.change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		struct string_list_item *it;
> +		char pfx[1 + 3 + 1 + 1];
> +
> +		it = &(s.change.items[i]);
> +		d = it->util;
> +		switch (d->index_status) {
> +		case DIFF_STATUS_COPIED:
> +		case DIFF_STATUS_RENAMED:
> +			sprintf(pfx, "%c%3d",
> +				d->index_status,
> +				(int)(d->index_score * 100 / MAX_SCORE));
> +			break;
> +		case 0:
> +			memcpy(pfx, "    ", 4);
> +			break;
> +		default:
> +			sprintf(pfx, "%c   ", d->index_status);
> +			break;
> +		}
> +		if (!d->worktree_status)
> +			pfx[4] = ' ';
> +		else
> +			pfx[4] = d->worktree_status;
> +		pfx[5] = '\0';
> +		printf("%s ", pfx);
> +		if (d->head_path)
> +			printf("%s -> ", d->head_path);
> +		printf("%s\n", it->string);
> +	}
> +	return 0;
> +}
> +
>  int cmd_status(int argc, const char **argv, const char *prefix)
>  {
>  	const char *index_file;
> diff --git a/builtin-revert.c b/builtin-revert.c
> index 3f2614e..10f1655 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -3,6 +3,7 @@
>  #include "object.h"
>  #include "commit.h"
>  #include "tag.h"
> +#include "string-list.h"
>  #include "wt-status.h"
>  #include "run-command.h"
>  #include "exec_cmd.h"
> diff --git a/builtin.h b/builtin.h
> index 425ff8e..23e9eb6 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -95,6 +95,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
>  extern int cmd_show(int argc, const char **argv, const char *prefix);
>  extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
>  extern int cmd_status(int argc, const char **argv, const char *prefix);
> +extern int cmd_shortstatus(int argc, const char **argv, const char *prefix);
>  extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
>  extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_tag(int argc, const char **argv, const char *prefix);
> diff --git a/git.c b/git.c
> index 5a00726..68c223e 100644
> --- a/git.c
> +++ b/git.c
> @@ -348,6 +348,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "rm", cmd_rm, RUN_SETUP },
>  		{ "send-pack", cmd_send_pack, RUN_SETUP },
>  		{ "shortlog", cmd_shortlog, USE_PAGER },
> +		{ "shortstatus", cmd_shortstatus, RUN_SETUP | NEED_WORK_TREE },
>  		{ "show-branch", cmd_show_branch, RUN_SETUP },
>  		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
>  		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
> diff --git a/wt-status.c b/wt-status.c
> index 1b6df45..89be28e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "string-list.h"
>  #include "wt-status.h"
>  #include "color.h"
>  #include "object.h"
> @@ -56,6 +57,7 @@ void wt_status_prepare(struct wt_status *s)
>  	s->reference = "HEAD";
>  	s->fp = stdout;
>  	s->index_file = get_index_file();
> +	s->change.strdup_strings = 1;
>  }
>  
>  static void wt_status_print_cached_header(struct wt_status *s)
> @@ -98,18 +100,22 @@ static void wt_status_print_trailer(struct wt_status *s)
>  
>  #define quote_path quote_path_relative
>  
> -static void wt_status_print_filepair(struct wt_status *s,
> -				     int t, struct diff_filepair *p)
> +static void wt_status_print_change_data(struct wt_status *s,
> +					int t,
> +					int status,
> +					char *one_name,
> +					char *two_name,
> +					int score)
>  {
>  	const char *c = color(t);
>  	const char *one, *two;
>  	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
>  
> -	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
> -	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
> +	one = quote_path(one_name, -1, &onebuf, s->prefix);
> +	two = quote_path(two_name, -1, &twobuf, s->prefix);
>  
>  	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
> -	switch (p->status) {
> +	switch (status) {
>  	case DIFF_STATUS_ADDED:
>  		color_fprintf(s->fp, c, "new file:   %s", one);
>  		break;
> @@ -135,64 +141,88 @@ static void wt_status_print_filepair(struct wt_status *s,
>  		color_fprintf(s->fp, c, "unmerged:   %s", one);
>  		break;
>  	default:
> -		die("bug: unhandled diff status %c", p->status);
> +		die("bug: unhandled diff status %c", status);
>  	}
>  	fprintf(s->fp, "\n");
>  	strbuf_release(&onebuf);
>  	strbuf_release(&twobuf);
>  }
>  
> -static void wt_status_print_updated_cb(struct diff_queue_struct *q,
> -		struct diff_options *options,
> -		void *data)
> +static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
> +					 struct diff_options *options,
> +					 void *data)
>  {
>  	struct wt_status *s = data;
> -	int shown_header = 0;
>  	int i;
> +
> +	if (!q->nr)
> +		return;
> +	s->workdir_dirty = 1;
>  	for (i = 0; i < q->nr; i++) {
> -		if (q->queue[i]->status == 'U')
> -			continue;
> -		if (!shown_header) {
> -			wt_status_print_cached_header(s);
> -			s->commitable = 1;
> -			shown_header = 1;
> -		}
> -		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
> +		struct diff_filepair *p;
> +		struct string_list_item *it;
> +		struct wt_status_change_data *d;
> +
> +		p = q->queue[i];
> +
> +		d = xcalloc(1, sizeof(*d));
> +		d->worktree_status = p->status;
> +		it = string_list_insert(p->one->path, &s->change);
> +		it->util = d;
>  	}
> -	if (shown_header)
> -		wt_status_print_trailer(s);
>  }
>  
> -static void wt_status_print_changed_cb(struct diff_queue_struct *q,
> -                        struct diff_options *options,
> -                        void *data)
> +static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
> +					 struct diff_options *options,
> +					 void *data)
>  {
>  	struct wt_status *s = data;
>  	int i;
> -	if (q->nr) {
> -		int has_deleted = 0;
> -		s->workdir_dirty = 1;
> -		for (i = 0; i < q->nr; i++)
> -			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
> -				has_deleted = 1;
> -				break;
> -			}
> -		wt_status_print_dirty_header(s, has_deleted);
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p;
> +		struct string_list_item *it;
> +		struct wt_status_change_data *d;
> +
> +		p = q->queue[i];
> +		it = string_list_insert(p->two->path, &s->change);
> +		d = it->util;
> +		if (!d) {
> +			d = xcalloc(1, sizeof(*d));
> +			it->util = d;
> +		}
> +		d->index_status = p->status;
> +		switch (p->status) {
> +		case DIFF_STATUS_COPIED:
> +		case DIFF_STATUS_RENAMED:
> +			d->head_path = xstrdup(p->one->path);
> +			d->index_score = p->score;
> +			break;
> +		}
>  	}
> -	for (i = 0; i < q->nr; i++)
> -		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
> -	if (q->nr)
> -		wt_status_print_trailer(s);
>  }
>  
> -static void wt_status_print_updated(struct wt_status *s)
> +static void wt_status_collect_changes_worktree(struct wt_status *s)
> +{
> +	struct rev_info rev;
> +
> +	init_revisions(&rev, NULL);
> +	setup_revisions(0, NULL, &rev, NULL);
> +	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = wt_status_collect_changed_cb;
> +	rev.diffopt.format_callback_data = s;
> +	run_diff_files(&rev, 0);
> +}
> +
> +static void wt_status_collect_changes_index(struct wt_status *s)
>  {
>  	struct rev_info rev;
> +
>  	init_revisions(&rev, NULL);
>  	setup_revisions(0, NULL, &rev,
>  		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> -	rev.diffopt.format_callback = wt_status_print_updated_cb;
> +	rev.diffopt.format_callback = wt_status_collect_updated_cb;
>  	rev.diffopt.format_callback_data = s;
>  	rev.diffopt.detect_rename = 1;
>  	rev.diffopt.rename_limit = 200;
> @@ -200,15 +230,107 @@ static void wt_status_print_updated(struct wt_status *s)
>  	run_diff_index(&rev, 1);
>  }
>  
> +static void wt_status_collect_changes_initial(struct wt_status *s)
> +{
> +	int i;
> +
> +	for (i = 0; i < active_nr; i++) {
> +		struct string_list_item *it;
> +		struct wt_status_change_data *d;
> +
> +		it = string_list_insert(active_cache[i]->name, &s->change);
> +		d = it->util;
> +		if (!d) {
> +			d = xcalloc(1, sizeof(*d));
> +			it->util = d;
> +		}
> +		d->index_status = DIFF_STATUS_ADDED;
> +	}
> +}
> +
> +void wt_status_collect_changes(struct wt_status *s)
> +{
> +	wt_status_collect_changes_worktree(s);
> +
> +	if (s->is_initial)
> +		wt_status_collect_changes_initial(s);
> +	else
> +		wt_status_collect_changes_index(s);
> +}
> +
> +static void wt_status_print_updated(struct wt_status *s)
> +{
> +	int shown_header = 0;
> +	int i;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		struct string_list_item *it;
> +		it = &(s->change.items[i]);
> +		d = it->util;
> +		if (!d->index_status)
> +			continue;
> +		if (!shown_header) {
> +			wt_status_print_cached_header(s);
> +			s->commitable = 1;
> +			shown_header = 1;
> +		}
> +		wt_status_print_change_data(s, WT_STATUS_UPDATED,
> +					    d->index_status,
> +					    d->head_path ? d->head_path : it->string,
> +					    it->string,
> +					    d->index_score);
> +	}
> +	if (shown_header)
> +		wt_status_print_trailer(s);
> +}
> +
> +/*
> + * -1 : has delete
> + *  0 : no change
> + *  1 : some change but no delete
> + */
> +static int wt_status_check_worktree_changes(struct wt_status *s)
> +{
> +	int i;
> +	int changes = 0;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		d = s->change.items[i].util;
> +		if (!d->worktree_status)
> +			continue;
> +		changes = 1;
> +		if (d->worktree_status == DIFF_STATUS_DELETED)
> +			return -1;
> +	}
> +	return changes;
> +}
> +
>  static void wt_status_print_changed(struct wt_status *s)
>  {
> -	struct rev_info rev;
> -	init_revisions(&rev, "");
> -	setup_revisions(0, NULL, &rev, NULL);
> -	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> -	rev.diffopt.format_callback = wt_status_print_changed_cb;
> -	rev.diffopt.format_callback_data = s;
> -	run_diff_files(&rev, 0);
> +	int i;
> +	int worktree_changes = wt_status_check_worktree_changes(s);
> +
> +	if (!worktree_changes)
> +		return;
> +
> +	wt_status_print_dirty_header(s, worktree_changes < 0);
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		struct string_list_item *it;
> +		it = &(s->change.items[i]);
> +		d = it->util;
> +		if (!d->worktree_status)
> +			continue;
> +		wt_status_print_change_data(s, WT_STATUS_CHANGED,
> +					    d->worktree_status,
> +					    it->string,
> +					    it->string,
> +					    0);
> +	}
> +	wt_status_print_trailer(s);
>  }
>  
>  static void wt_status_print_submodule_summary(struct wt_status *s)
> @@ -337,6 +459,8 @@ void wt_status_print(struct wt_status *s)
>  			wt_status_print_tracking(s);
>  	}
>  
> +	wt_status_collect_changes(s);
> +
>  	if (s->is_initial) {
>  		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
>  		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
> diff --git a/wt-status.h b/wt-status.h
> index 78add09..00508c3 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -18,6 +18,13 @@ enum untracked_status_type {
>  };
>  extern enum untracked_status_type show_untracked_files;
>  
> +struct wt_status_change_data {
> +	int worktree_status;
> +	int index_status;
> +	int index_score;
> +	char *head_path;
> +};
> +
>  struct wt_status {
>  	int is_initial;
>  	char *branch;
> @@ -33,6 +40,7 @@ struct wt_status {
>  	const char *index_file;
>  	FILE *fp;
>  	const char *prefix;
> +	struct string_list change;
>  };
>  
>  int git_status_config(const char *var, const char *value, void *cb);
> @@ -40,5 +48,6 @@ extern int wt_status_use_color;
>  extern int wt_status_relative_paths;
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
> +void wt_status_collect_changes(struct wt_status *s);
>  
>  #endif /* STATUS_H */

-- 
		David
