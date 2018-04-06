Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E651F404
	for <e@80x24.org>; Fri,  6 Apr 2018 15:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeDFPLR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 11:11:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:45615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeDFPLO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 11:11:14 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBq8p-1fBN2x1AjX-00AmVN; Fri, 06
 Apr 2018 17:11:08 +0200
Date:   Fri, 6 Apr 2018 17:10:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 2/5] stash: convert apply to builtin
In-Reply-To: <20180405022810.15796-3-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061520060.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-3-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZpEmK09bjjcbAQbKm4Z2QMGzHywWia9OciQ9sovAaOCbKS/MApP
 NWGOusFIoZYmSJu5yBdZ7G2XwJIH9rWSCBFQ5ho2A4e0jiG1aZOkwaTOVIrFNpN1+QNaykR
 IXcXjjwvGtc2r8dxKQq3K+auoXWtkUft8pnlmZBAAu79gnXuR4bdRzHjRVI8TwGY13+b25V
 12YeudnMO9V4RHvtPm6TA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p328ReYL9b4=:/7oJjvnbWwh0kXhZ+u9So0
 TmUaBAVfPTHE9EQGUpmH3vfD4pfYF3BtUpSrbMg9hQkuGFslsV+340OMxBhvxVgrXSv6rkjbu
 Jd+ALj9hu4Jg70LPk6QOwZCXFupRIXCaIsOr24DARIpnpzmTxv3T/bbsSIiuEUs0P7OeZco6z
 nGrJHGle2L0+FiUgry8FSo7WetguXMD3b4tMbgRFF9xMLioqNvPE8hpModJrKtUq0Ph+79cRr
 1/L6Lx6l5IqAogqdV0B9pzhVZXA3HIeQw0Q1Y7LMBLT5etH6I0aTnDVPuksvCmxCoWX1lGsoz
 rij3kPqioOfppDP5wqGge9KUSf7ysRGQLNZNt16dyKbLnZ8B/JLMcHeQdbNWhktEm6zfT4aFm
 LSO+pyGfFC7WGKrzWOjpRyUKSDAjTbetgzm0+LwpDOXv1wki/6dWgWn2hB8ZAjs22TEKh4Odi
 hujLlB6fRfujJNuEeYfpWB6fghF15g/LE5/yHk/dttgnBYskqD+qkCnBSFCC340pWABsThhVe
 2WQyKj+ooKjavb1mez835iSg24qAQw/WHKWxd8j6rggeHPEwrehCI1ZXOsETgdm5VOL64sP6q
 gYioeMMlQdHwWS+cM5Qt+KsYUh4J6L/vxeE8JIVyYh17qO1gs6vt75aZPoO5Ob2PfYVVf7cZc
 ySblNqJ98cTab7kT7dZOQ+ojBcVmIIdjWnOynuwtJJ741Wg5tBkX12kzJxbrYC1uVw5Ih4f1r
 u0eOiY+4nwE0EJ1HqRX1FLffKREaKS+iL2z6KHF8EpA2rq0/rGsREIgetaK3KD2lu7TvqLac4
 J6KljrYE512wSufxEYwpomtBoV9iRidFGX6K8niv3Va+5XcaocKNLMGB3Tn9wCU/QJxBalp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> Add a bulitin helper for performing stash commands. Converting
> all at once proved hard to review, so starting with just apply
> let conversion get started without the other command being

s/let/lets the/ s/command/commands/

> finished.
> 
> The helper is being implemented as a drop in replacement for
> stash so that when it is complete it can simply be renamed and
> the shell script deleted.
> 
> Delete the contents of the apply_stash shell function and replace
> it with a call to stash--helper apply until pop is also
> converted.
> 
> [...]
>
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> new file mode 100644
> index 0000000000..9d00a9547d
> --- /dev/null
> +++ b/builtin/stash--helper.c
> @@ -0,0 +1,431 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "parse-options.h"
> +#include "refs.h"
> +#include "lockfile.h"
> +#include "cache-tree.h"
> +#include "unpack-trees.h"
> +#include "merge-recursive.h"
> +#include "argv-array.h"
> +#include "run-command.h"
> +#include "dir.h"
> +#include "rerere.h"
> +
> +static const char * const git_stash_helper_usage[] = {

Note to other reviewers: while it would appear that our convention is
usually to cuddle the `*` with the identifier afterwards (i.e. `char
*const` instead of `char * const`), it would *also* appear that we somehow
prefer spaces on both sides when it comes to the _usage:

$ git grep 'usage\[' builtin/*.c | grep -c ' \* '
88

$ git grep 'usage\[' builtin/*.c | grep -c ' \*[^ ]'
18

So much to clean up and make more consistent... (not your problem, Joel)

> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_helper_apply_usage[] = {
> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char *ref_stash = "refs/stash";
> +static int quiet;
> +static struct strbuf stash_index_path = STRBUF_INIT;
> +
> +struct stash_info {
> +	struct object_id w_commit;
> +	struct object_id b_commit;
> +	struct object_id i_commit;
> +	struct object_id u_commit;
> +	struct object_id w_tree;
> +	struct object_id b_tree;
> +	struct object_id i_tree;
> +	struct object_id u_tree;
> +	struct strbuf revision;
> +	int is_stash_ref;
> +	int has_u;
> +};
> +
> +static int grab_oid(struct object_id *oid, const char *fmt, const char *rev)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret;
> +
> +	strbuf_addf(&buf, fmt, rev);
> +	ret = get_oid(buf.buf, oid);
> +	strbuf_release(&buf);
> +	return ret;
> +}

It could be even more reusable, by using

int get_oidf(struct object_id *oid, const char *fmt, ...)
{
	va_list ap;
	char *p;
	int ret;

	va_start(ap, fmt);
	p = xstrvfmt(fmt, ap);
	va_end(ap);
	ret = get_oid(p, oid);
	free(p);

	return ret;
}

Feel free to do this as a preparatory patch (it should probably live next
to get_oid()), otherwise there is always an opportunity for a
micro-project (or not so micro- one).

> +static void free_stash_info(struct stash_info *info)
> +{
> +	strbuf_release(&info->revision);
> +}
> +
> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
> +{
> +	struct strbuf symbolic = STRBUF_INIT;
> +	int ret;
> +	const char *revision;
> +	const char *commit = NULL;
> +	char *end_of_rev;
> +	char *expanded_ref;
> +	struct object_id discard;

I think elsewhere we prefer the name "dummy" for variables that are
assigned without really needing the values.

> +
> +	if (argc > 1) {
> +		int i;
> +		struct strbuf refs_msg = STRBUF_INIT;
> +		for (i = 0; i < argc; ++i)
> +			strbuf_addf(&refs_msg, " '%s'", argv[i]);
> +
> +		fprintf_ln(stderr, _("Too many revisions specified:%s"), refs_msg.buf);

Note to interested parties: while it may have been okay for a mere Unix
shell script to output such a message directly to stderr, in C, we need to
use `error()` and start the error message with lower-case. This should
*not* be done as part of the conversion to C, which is kind of bug-for-bug.

> +		strbuf_release(&refs_msg);
> +
> +		return -1;
> +	}
> +
> +	if (argc == 1)
> +		commit = argv[0];

It is probably a bit too magical to assign `commit = argv[0]` right
away... but it would work, as `argv` is guaranteed to be NULL-terminated.

> +
> +	strbuf_init(&info->revision, 0);
> +	if (commit == NULL) {

We usually use `!commit` instead of `commit == NULL`. It's just the style
we use, not a judgement.

> +		if (!ref_exists(ref_stash)) {
> +			free_stash_info(info);
> +			return error(_("No stash entries found."));

Technically, the shell version used `die`. We could use the same here,
too, but `error()` seems to be fine, too.

However, if you use `error()` here, you should use it also instead of the
`fprintf(stderr, ...);` above, for "Too many revisions specified".

Also: our convention is to start error messages lower-case because they
are prefixed with `error: `.

But in the interest of a faithful conversion to C, maybe we should start
by using `fprintf(stderr, ...)` first, and only convert to `error()` later
(because that will require changes to the test suite, too).

> +		}
> +
> +		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> +	} else {
> +		strbuf_addstr(&info->revision, commit);
> +	}
> +
> +	revision = info->revision.buf;
> +
> +	if (get_oid(revision, &info->w_commit)) {
> +		error(_("%s is not a valid reference"), revision);
> +		free_stash_info(info);
> +		return -1;
> +	}
> +
> +	if (grab_oid(&info->b_commit, "%s^1", revision) ||
> +		grab_oid(&info->w_tree, "%s:", revision) ||
> +		grab_oid(&info->b_tree, "%s^1:", revision) ||
> +		grab_oid(&info->i_tree, "%s^2:", revision)) {
> +
> +		error(_("'%s' is not a stash-like commit"), revision);
> +		free_stash_info(info);
> +		return -1;
> +	}

Fans of keeping Git commands in the form of Unix shell scripts, please
note that this is a deviation from the shell script, but in a good way:
before, if any of those revisions could not be parsed by `git rev-parse`,
the error would not have resulted in a fatal error. Instead, IS_STASH_LIKE
and IS_STASH_REF would have been unchanged, as would be w_commit,
b_commit, w_tree, b_tree and i_tree.

The error checking in C is much better for end users.

> +	info->has_u = !grab_oid(&info->u_tree, "%s^3:", revision);
> +
> +	end_of_rev = strchrnul(revision, '@');
> +	strbuf_add(&symbolic, revision, end_of_rev - revision);

This is a literal translation of the shell script's `"${REV%@*}"`, but I
wonder whether we can do better in C. After all,
`refs/stash@my-laptop@{1}` is possibly a valid stash, when I called `git
fetch laptop refs/stash:refs/stash@my-laptop` regularly.

Let's see.

Nope, we really don't have anything in our "API" to peel off reflog
suffixes... Another micro-project for the future. Nothing that needs to
hold up this patch series. (I am saying this mainly for the benefit of
other reviewers...)

> +
> +	ret = dwim_ref(symbolic.buf, symbolic.len, &discard, &expanded_ref);
> +	strbuf_release(&symbolic);
> +	switch (ret) {
> +	case 0: /* Not found, but valid ref */
> +		info->is_stash_ref = 0;
> +		break;
> +	case 1:
> +		info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
> +		break;
> +	default: /* Invalid or ambiguous */
> +		free_stash_info(info);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int reset_tree(struct object_id *i_tree, int update, int reset)
> +{
> +	struct unpack_trees_options opts;
> +	int nr_trees = 1;
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct tree *tree;
> +	struct lock_file lock_file = LOCK_INIT;
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
> +
> +	memset(&opts, 0, sizeof(opts));
> +
> +	tree = parse_tree_indirect(i_tree);
> +	if (parse_tree(tree))
> +		return -1;
> +
> +	init_tree_desc(t, tree->buffer, tree->size);
> +
> +	opts.head_idx = 1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.merge = 1;
> +	opts.reset = reset;
> +	opts.update = update;
> +	opts.fn = oneway_merge;
> +
> +	if (unpack_trees(nr_trees, t, &opts))
> +		return -1;
> +
> +	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +		return error(_("unable to write new index file"));
> +
> +	return 0;
> +}

Oh how I wish we had that as API:

$ git grep -W unpack_trees \*.c | grep init_tree_desc
archive.c-              init_tree_desc(&t, args->tree->buffer,
args->tree->size);
builtin/am.c-   init_tree_desc(&t[0], head->buffer, head->size);
builtin/am.c-   init_tree_desc(&t[1], remote->buffer, remote->size);
builtin/am.c-   init_tree_desc(&t[0], tree->buffer, tree->size);
builtin/checkout.c-     init_tree_desc(&tree_desc, tree->buffer, tree->size);
builtin/checkout.c-             init_tree_desc(&trees[0], tree->buffer, tree->size);
builtin/checkout.c-             init_tree_desc(&trees[1], tree->buffer, tree->size);
builtin/clone.c-        init_tree_desc(&t, tree->buffer, tree->size);
builtin/commit.c-       init_tree_desc(&t, tree->buffer, tree->size);
builtin/merge.c-                init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
builtin/read-tree.c-            init_tree_desc(t+i, tree->buffer, tree->size);
diff-lib.c-     init_tree_desc(&t, tree->buffer, tree->size);
merge-recursive.c-      init_tree_desc_from_tree(t+0, common);
merge-recursive.c-      init_tree_desc_from_tree(t+1, head);
merge-recursive.c-      init_tree_desc_from_tree(t+2, merge);
merge.c-                init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);

Looks like a lot of duplication to me. (Again, this is just a lament, and
a suggestion for a future project, not a micro-project, though).

> +
> +static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *w_commit_hex = oid_to_hex(w_commit);
> +
> +	/* Diff-tree would not be very hard to replace with a native function,
> +	 * however it should be done together with apply_cached.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
> +	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
> +
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}

As I stated before: I think this is good enough for the moment. We can
always spend time later to reduce these spawned processes and call
in-process functions instead. One teeny tiny step at a time.

> +static int apply_cached(struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/* Apply currently only reads either from stdin or a file, thus
> +	 * apply_all_patches would have to be updated to optionally take a buffer
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}
> +
> +static int reset_head(const char *prefix)
> +{
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +
> +	/* Reset is overall quite simple, however there is no current public API
> +	 * for resetting.
> +	 */
> +	argv_array_push(&args, "reset");
> +	return cmd_reset(args.argc, args.argv, prefix);
> +}
> +
> +static int diff_cached_index(struct strbuf *out, struct object_id *c_tree)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *c_tree_hex = oid_to_hex(c_tree);
> +
> +	/* diff-index is very similar to diff-tree above, and should be converted
> +	 * together with update_index
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);

We should probably note in the name of this function that we return a list
only of the added files.

> +	argv_array_push(&cp.args, c_tree_hex);
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int update_index(struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/* Update-index is very complicated and may need to have a public function
> +	 * exposed in order to remove this forking
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}
> +
> +static int restore_untracked(struct object_id *u_tree)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int res;
> +
> +	/*
> +	 * We need to run restore files from a given index, but without affecting
> +	 * the current index, so we use GIT_INDEX_FILE with run_command to fork
> +	 * processes that will not interfere.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "read-tree");
> +	argv_array_push(&cp.args, oid_to_hex(u_tree));
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path.buf);
> +	if (run_command(&cp)) {
> +		remove_path(stash_index_path.buf);
> +		return -1;
> +	}
> +
> +	child_process_init(&cp);
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path.buf);
> +
> +	res = run_command(&cp);
> +	remove_path(stash_index_path.buf);
> +	return res;
> +}
> +
> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
> +{
> +	struct merge_options o;
> +	struct object_id c_tree;
> +	struct object_id index_tree;
> +	const struct object_id *bases[1];
> +	int bases_count = 1;

It is always 1, maybe not waste a variable on it? ;-)

> +	struct commit *result;
> +	int ret;
> +	int has_index = index;
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
> +		return error(_("Cannot apply a stash in the middle of a merge"));
> +
> +	if (index) {
> +		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
> +			has_index = 0;
> +		} else {
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (diff_tree_binary(&out, &info->w_commit)) {
> +				strbuf_release(&out);
> +				return -1;
> +			}
> +
> +			ret = apply_cached(&out);
> +			strbuf_release(&out);
> +			if (ret)
> +				return -1;

A more faithful conversion would pipe the output of `git diff-tree
--binary` into `git apply --cached`, but I do not think it is worth
complicating things here.

> +
> +			discard_cache();
> +			read_cache();

$ git grep -A1 discard_cache | grep -c read_cache
10

I guess that's another idiom we use a lot. (Again, micro-project here.)

> +			if (write_cache_as_tree(&index_tree, 0, NULL))
> +				return -1;
> +
> +			reset_head(prefix);
> +		}
> +	}
> +
> +	if (info->has_u) {
> +		if (restore_untracked(&info->u_tree))
> +			return error(_("Could not restore untracked files from stash"));
> +	}
> +
> +	init_merge_options(&o);
> +
> +	o.branch1 = "Updated upstream";
> +	o.branch2 = "Stashed changes";
> +
> +	if (!oidcmp(&info->b_tree, &c_tree))
> +		o.branch1 = "Version stash was based on";
> +
> +	if (quiet)
> +		o.verbosity = 0;
> +
> +	if (o.verbosity >= 3)
> +		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
> +
> +	bases[0] = &info->b_tree;
> +
> +	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, bases_count, bases, &result);
> +	if (ret != 0) {
> +		rerere(0);
> +
> +		if (index)
> +			fprintf_ln(stderr, _("Index was not unstashed."));
> +
> +		return ret;
> +	}
> +
> +	if (has_index) {
> +		if (reset_tree(&index_tree, 0, 0))
> +			return -1;
> +	} else {
> +		struct strbuf out = STRBUF_INIT;
> +
> +		if (diff_cached_index(&out, &c_tree)) {
> +			strbuf_release(&out);
> +			return -1;
> +		}
> +
> +		if (reset_tree(&c_tree, 0, 1)) {
> +			strbuf_release(&out);
> +			return -1;
> +		}
> +
> +		ret = update_index(&out);
> +		strbuf_release(&out);
> +		if (ret)
> +			return -1;
> +
> +		discard_cache();
> +	}
> +
> +	if (!quiet) {
> +		struct argv_array args = ARGV_ARRAY_INIT;
> +		/* Status is quite simple and could be replaced with calls to wt_status
> +		 * in the future, but it adds complexities which may require more tests
> +		 */
> +		argv_array_push(&args, "status");
> +		cmd_status(args.argc, args.argv, prefix);
> +	}

This is a change in behavior. The shell script calls `git status` always,
and only *suppresses* the output if `--quiet` was passed. I guess the
difference in behavior really boils down only to refreshing the index.
Maybe we can do that here, too? Something like

	if (quiet) {
		if (refresh_cache(REFRESH_QUIET))
			warning("could not refresh index");
	} else {
		...

> +
> +	return 0;
> +}
> +
> +static int apply_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int index = 0;
> +	struct stash_info info;
> +	int ret;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_BOOL(0, "index", &index,
> +			N_("attempt to recreate the index")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_helper_apply_usage, 0);
> +
> +	if (get_stash_info(&info, argc, argv))
> +		return -1;
> +
> +	ret = do_apply_stash(prefix, &info, index);

This is the only caller of that function. But I guess that `pop` also
needs to call it, so I guess it makes sense to keep `do_apply_stash()`
separate.

> +	free_stash_info(&info);
> +	return ret;
> +}
> +
> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int result = 0;
> +	pid_t pid = getpid();
> +	const char *index_file;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);

Please keep spaces around the pipe symbol.

> +	index_file = get_index_file();
> +	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file, (uintmax_t)pid);
> +
> +	if (argc < 1)
> +		usage_with_options(git_stash_helper_usage, options);
> +	else if (!strcmp(argv[0], "apply"))
> +		result = apply_stash(argc, argv, prefix);
> +	else {
> +		error(_("unknown subcommand: %s"), argv[0]);
> +		usage_with_options(git_stash_helper_usage, options);
> +		result = 1;
> +	}
> +
> +	return result;
> +}
> diff --git a/git-stash.sh b/git-stash.sh
> index 94793c1a91..0b5d1f3743 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -566,76 +566,11 @@ assert_stash_ref() {
>  }
>  
>  apply_stash () {
> -
> -	assert_stash_like "$@"
> -
> -	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
> -
> -	# current index state
> -	c_tree=$(git write-tree) ||
> -		die "$(gettext "Cannot apply a stash in the middle of a merge")"
> -
> -	unstashed_index_tree=
> -	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
> -			test "$c_tree" != "$i_tree"
> -	then
> -		git diff-tree --binary $s^2^..$s^2 | git apply --cached
> -		test $? -ne 0 &&
> -			die "$(gettext "Conflicts in index. Try without --index.")"
> -		unstashed_index_tree=$(git write-tree) ||
> -			die "$(gettext "Could not save index tree")"
> -		git reset
> -	fi
> -
> -	if test -n "$u_tree"
> -	then
> -		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
> -		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
> -		rm -f "$TMPindex" ||
> -		die "$(gettext "Could not restore untracked files from stash entry")"
> -	fi
> -
> -	eval "
> -		GITHEAD_$w_tree='Stashed changes' &&
> -		GITHEAD_$c_tree='Updated upstream' &&
> -		GITHEAD_$b_tree='Version stash was based on' &&
> -		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
> -	"
> -
> -	if test -n "$GIT_QUIET"
> -	then
> -		GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
> -	fi
> -	if git merge-recursive $b_tree -- $c_tree $w_tree
> -	then
> -		# No conflict
> -		if test -n "$unstashed_index_tree"
> -		then
> -			git read-tree "$unstashed_index_tree"
> -		else
> -			a="$TMP-added" &&
> -			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
> -			git read-tree --reset $c_tree &&
> -			git update-index --add --stdin <"$a" ||
> -				die "$(gettext "Cannot unstage modified files")"
> -			rm -f "$a"
> -		fi
> -		squelch=
> -		if test -n "$GIT_QUIET"
> -		then
> -			squelch='>/dev/null 2>&1'
> -		fi
> -		(cd "$START_DIR" && eval "git status $squelch") || :
> -	else
> -		# Merge conflict; keep the exit status from merge-recursive
> -		status=$?
> -		git rerere
> -		if test -n "$INDEX_OPTION"
> -		then
> -			gettextln "Index was not unstashed." >&2
> -		fi
> -		exit $status
> -	fi
> +	cd "$START_DIR"
> +	git stash--helper apply "$@"
> +	res=$?
> +	cd_to_toplevel

Is it important to cd to top-level when we are exiting anyway? I guess it
is, because we are not exiting right away, necessarily: both pop_stash()
and apply_to_branch() call this function. But then, both callers only call
drop_stash() afterwards (which does not perform worktree operations)...

> +	return $res
>  }
>  
>  pop_stash() {
> diff --git a/git.c b/git.c
> index ceaa58ef40..6ffe6364ac 100644
> --- a/git.c
> +++ b/git.c
> @@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
>  	{ "show-branch", cmd_show_branch, RUN_SETUP },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
> -- 
> 2.16.3

This patch (apart from the minor suggestions I had) looks very good to me
already. Thank you so much!

Ciao,
Dscho
