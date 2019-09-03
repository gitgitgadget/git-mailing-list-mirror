Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278151F461
	for <e@80x24.org>; Tue,  3 Sep 2019 13:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfICN0k (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 09:26:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:56079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbfICN0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 09:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567517190;
        bh=o8V0cplrGtKfZLcackdv/nvVznSo9N55Z2jRZEPzKRo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DkAfsIx9dFo2FCMcD6rprrrkxXKQVLu0NJZJHAdnydZK1GebS50cPwMBOtdort13T
         EGfxfwQwdMR8FhUvLIE+ymJF7dzX+LqbUcaTCMr5x0TnoxsAaqaifQsyGSltWG9uae
         iCm2rAD5kLDI9lyXHgFS4KzUzpg4/jdRrK/gqhmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlGk-1iitUr2suu-00dqRJ; Tue, 03
 Sep 2019 15:26:29 +0200
Date:   Tue, 3 Sep 2019 15:26:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Warren He <pickydaemon@gmail.com>
cc:     git@vger.kernel.org, Warren He <wh109@yahoo.com>
Subject: Re: [PATCH] rebase: introduce --update-branches option
In-Reply-To: <20190902234109.2922-2-wh109@yahoo.com>
Message-ID: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
References: <20190902234109.2922-1-wh109@yahoo.com> <20190902234109.2922-2-wh109@yahoo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MxJLK2wX1gOMQSphV25rgDgLc5FROmkOanYmNw7jhU2OMsFWg/2
 r3IOtQsOg/RhrqINWBTeuJ102ad2Z1Hhb6k4Ylm4WHfXbFN7iDqQH4jW5aS4ZIUe4HJ8umr
 St3fHajwNw1OXqFN51TNNQtp1bETfG3aqp6BuRe+c2vwOBxTKAG+ZfEvcRDUE1+7rcG+ug3
 zXIWQlMN3zaxBVqUuQgNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gsUqptFygjY=:COycJr1xRhDNYuoF2B+YJj
 ge3HwYDfbblNNN3u0udjkJwcb623xBwCQcAr+lyeoh+JzqGPVRTMwoB1VETNjHE2L3hYgRQSm
 yGk5Zws8vwJRWkqe4s9/LpaWFbsAD694iPyPM5IjVr36GOe9DWVFec5XQFVnrbXuvhPy9pB0x
 JsG3UrfLzUp1dxnMx6ZZproXUiQnBQEC+pXO81v4fmnkkFS/+sDcSt6/zcUm6GfQ+6XjHzJ1w
 IxzZ71e+bFsKSMxMQWho5UocFT7DlGg0booyPPvpWSGGl2F6TweO2V+jQa2NSN4p4kA0KhXSh
 WoTShIq7NUDRnaCBOQ1lT7xkzEVxRXkoNgxmyu+RoDGM0F58JGaUG9wVthDov+0masbzPzUf6
 fzLnEk3SORD/N0mFB40H64XSkKMZn/q/N7T5hkEHY7W58yt5lvPGvNVulEFRu9oG9AgM3WdXm
 BfuMXVni0AMOpl8/CEw2f08xz6QaoZT09jvfzLnCQSdP4uAgquMPCstjcKnbzkW+ad+Rjxjxo
 9CwOu3n1Rhhq9tBVmOzLN/ZyDtSG9KK4EaeeyxKwhzSR4/MlwdMhU4lU33d8M3M8fJvONnaat
 UUIox6raQYNPMIDfMT9q7G+1G1FXe63eixGPW/CqZTY7PgZimFRUFomnQITyRcigtPznrz9HL
 4mIQajErUksW3+yWQCmX2DoqiRh56qp8Gdh6NeMkrdA7EK9JkwEdcY+QEfAAKJGHczGCZ/4IV
 EuVRXEIMF3oaFXlGAx572RpDrjFCwUtUqWy+MyikEc7xrMIeAyIlxstc6baqPKIXzv0mKWXzU
 +Dgx3QDgv01hPYYJKNx0PHtdNqPXHrCYUGswfZzPKHUHb6NRafL1BZ6R/wJzNGfJazybABA1v
 MxTXZ3poWEfbiz0PO2kuxkPftkCMXVDTIsCqYWlXlklbDeI1ReZ3IZsrV3JcJtH+zVQRZsrfj
 lJV0SwRY/XDmdWQdvmfu8PVR7WPKyA4LoDUdOGrLqjRjpSjAdaa8Tf1VbTuzw0WntpicZPSnx
 XViVAlywXhST2M5gE6gRxmm0gHtK+Pdv1jTCgqVLwb2yx/EmXAONRF8UV5VxyW6eXkBldgTb3
 +HPQi3WekaTImL3WbJZQoyTgrMZ42/UsGAVT+zpVOZOR2ZZX84EWDqQZR78PcqyzI5zE3uLHZ
 zt2vb9klTrVTlsT0XgqT3miLKJb/CW0iwovaSjLAehBHrRLQ0en0VchQ9h9+/eEmgVG3vdpXl
 y4PbFphcGSVp8fpj0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Warren,

On Mon, 2 Sep 2019, Warren He wrote:

> Rebasing normally updates the current branch to the rewritten version.
> If any other branches point to commits rewritten along the way, those
> remain untouched. This commit adds an `--update-branches` option, which
> instructs the command to update any such branches that it encounters to
> point to the rewritten versions of those commits.

This is definitely a feature I longed for, myself. I worked around it by
using some complicated vim command (I think it was something like
`%s/^label (.*)/&^Mexec git update-ref refs/heads/\1 HEAD` or some such,
where the `^M` is actually typed via Ctrl+V Ctrl+M, and of course, this
does not take existing branches into account, but updates refs based on
the merge commits' onelines).

Once `--update-branches` is available, I will want to use it e.g. for my
work on the built-in `git add -i`, where I have to update 6
inter-dependent PRs in parallel.

A couple of suggestions below. (If you are like me, trying to address
all the suggestions while reading the code review, I would like to
suggest reading all the way through to the end first, it might save you
some work.)

> [...]
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c..cf87c53 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -447,6 +449,8 @@ int cmd_rebase__interactive(int argc, const char **a=
rgv, const char *prefix)
>  		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
>  			   REBASE_FORCE),
>  		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits"))=
,
> +		OPT_BOOL(0, "update-branches", &opts.update_branches,
> +			 N_("update branches that point to reapplied commits")),

Maybe `s/reapplied/rebased/`?

Also, seeing as the `cmd_rebase__interactive()` is only used by `git
rebase --preserve-merges`, which cannot make use of `--update-branches`
anyway, I would suggest to simply drop this hunk and only keep the next
one.

>  		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
>  			 N_("allow commits with empty messages")),
>  		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge co=
mmits")),
> @@ -1453,6 +1457,8 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>  		OPT_BOOL('k', "keep-empty", &options.keep_empty,
>  			 N_("preserve empty commits during rebase")),
> +		OPT_BOOL(0, "update-branches", &options.update_branches,
> +			 N_("update branches that point to reapplied commits")),
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
>  			    "squash!/fixup! under -i")),
> @@ -1710,6 +1716,9 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  	if (options.keep_empty)
>  		imply_interactive(&options, "--keep-empty");
>
> +	if (options.update_branches)
> +		imply_interactive(&options, "--update-branches");

It should not really imply `--interactive`, but `--rebase-merges`.
Imagine for example this call:

	git rebase --update-branches @{u}

This would not even be interactive (even if it uses the interactive
rebase backend to execute), but it would have to rebase the merge
commits. So I think we need something like this instead:

	if (options.update_branches && !options.rebase_merges) {
		if (options.type =3D=3D REBASE_UNSPECIFIED)
			options.type =3D REBASE_INTERACTIVE;
		else if (options.type !=3D REBASE_INTERACTIVE)
			die(_("%s requires an interactive rebase"),
			    "--update-branches");
		options.rebase_merges =3D 1;
	}

I don't think we can use `imply_interactive()` here because that would
also allow `--update-branches` to be combined with `--preserve-merges`
(which does not work, and as the latter is deprecated, I would advise
against trying to make it work, either).

> +
>  	if (gpg_sign) {
>  		free(options.gpg_sign_opt);
>  		options.gpg_sign_opt =3D xstrfmt("-S%s", gpg_sign);
> [...]
> diff --git a/sequencer.c b/sequencer.c
> index 34ebf8e..c6749ff 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4901,6 +4901,69 @@ void todo_list_add_exec_commands(struct todo_list=
 *todo_list,
>  	todo_list->alloc =3D alloc;
>  }
>
> +/*
> + * Add commands to update branch refs after the todo list would pick a =
commit
> + * that a branch ref points to.
> + */
> +static void todo_list_add_branch_updates(struct todo_list *todo_list,
> +				       const char *head_name)
> +{
> +	struct strbuf *buf =3D &todo_list->buf;
> +	int i, nr =3D 0, alloc =3D 0;
> +	struct todo_item *items =3D NULL;
> +
> +	load_ref_decorations(NULL, 0);

This loads also tags, correct? I am fairly certain that we don't want to
update tags here, but maybe the check for `DECORATION_REF_LOCAL` later
on already ensures that?

> +
> +	for (i =3D 0; i < todo_list->nr; i++) {
> +		const struct todo_item *item =3D &todo_list->items[i];
> +		enum todo_command command =3D item->command;
> +		const struct name_decoration *decoration;
> +
> +		ALLOC_GROW(items, nr + 1, alloc);
> +		items[nr++] =3D todo_list->items[i];
> +
> +		switch (command) {
> +		case TODO_PICK:
> +		case TODO_MERGE:
> +			break;
> +		default:
> +			continue;
> +		}

I think this misses the `edit` and `reword` commands. How about using
`is_pick_or_similar()` instead?

Of course, there is one slight problem with that: you would _also_ have
to call `is_fixup()` and delay the addition of the corresponding branch
updates (you don't want to apply multiple `fixup` commits and possibly
point a local branch to an already fixed-up commit).

> +
> +		decoration =3D get_name_decoration(&item->commit->object);
> +		for (; decoration; decoration =3D decoration->next) {
> +			size_t base_offset, pretty_name_len;
> +			const char *pretty_name;
> +
> +			if (decoration->type !=3D DECORATION_REF_LOCAL)
> +				continue;
> +			if (!strcmp(decoration->name, head_name))
> +				// Rebase itself will update the current branch for us.

Please use C-style /* ... */ comments, Git insists on not using
C++-style // comments.

> +				continue;

My instant reaction was: just compare `&item->commit->object.oid` to
`head_hash`, but your code is careful to take care of the scenario where
multiple local branches point to the pre-rebase `HEAD`. Good. Maybe you
want to test for that in the regression test, too?

However, you have two `if` conditions that both guard the same
operation: `continue`. How about combining the combinations? It's like
saying: under these circumstances, we skip adding a command.

> +
> +			base_offset =3D buf->len;
> +			pretty_name =3D prettify_refname(decoration->name);
> +			pretty_name_len =3D strlen(pretty_name);
> +			strbuf_addstr(buf, "exec git branch -f ");
> +			strbuf_addstr(buf, pretty_name);
> +			strbuf_addch(buf, '\n');
> +
> +			ALLOC_GROW(items, nr + 1, alloc);
> +			items[nr++] =3D (struct todo_item) {
> +				.command =3D TODO_EXEC,
> +				.offset_in_buf =3D base_offset,
> +				.arg_offset =3D base_offset + strlen("exec "),
> +				.arg_len =3D strlen("git branch -f ") + pretty_name_len,
> +			};

Wow. This is the first time I see anybody trying to use this kind of
assignment: `<item> =3D (struct <name>) { ... }`. I don't really know that
we can expect all C compilers that are currently used to compile Git to
handle this kind of construct. So I'd rather be a little bit more
verbose and safe:

			memset(items[nr], 0, sizeof(items[nr]));
			items[nr].command =3D TODO_EXEC;
			[...]
			nr++;

Taking another step back, I think we should actually be super lazy here
(it's not performance-critical code, so we can save us some time
verifying correctness, at the cost of a little slower execution):

			size_t len =3D buf->len;
			strbuf_addf(buf, "exec git branch -f %s\n",
				    prettify_refname(decoration->name));
			parse_insn_line(r, items[nr], buf.buf,
					buf.buf + len, buf.buf + buf.len);

Come to think of it, I wonder whether you could simply use a full
`struct todo_list` instead of maintaining the `items` manually, and then
use `append_new_todo()`.

At the end, you would simply call

	SWAP(new_list.items, todo_list->items);
	SWAP(new_list.nr, todo_list->nr);
	SWAP(new_list.alloc, todo_list->alloc);
	todo_list_release(&new_list);

Now, let's talk about this command: `git branch -f <name>`. I _think_ it
is the right command to use (instead of `git update-ref`, for example),
yet I have a couple doubts about that:

- with `git update-ref <name> HEAD <old-commit>`, we could safe-guard
  against ref updates while the rebase is running. This is _not_
  possible with `git branch -f`... We would overwrite the branch, even
  if another Git process had updated it in the meantime, e.g. in a
  manually-inserted `exec` call.

- we definitely want to try our best to handle the case where the branch
  in question is currently checked out in a separate worktree. This is a
  use case that bit me in the past (with my complicated vim method of
  emulating `--update-branches`).

- If we use `git branch`, we _have_ to use the short branch name.
  However, `prettify_refname()` does not guarantee that, I don't think:
  it strips `refs/heads/` or `refs/tags/` or `refs/remotes/` _if found_.
  So I would feel a lot more comfortable with

  	if (!skip_prefix(decoration->name, "refs/heads/", &name))
		continue;

	[...]

	strbuf_addf(buf, "exec git branch -f %s\n", name);

- I actually do not know off-hand what the reflog message for the branch
  updates would be! Would it be prefixed by `rebase -i`? I think we
  should make sure that the code uses an informative reflog message, and
  definitely verify that behavior in the regression test.

- An `exec git branch -f <name>` will update that branch _immediately_.
  Even if the user runs into a road-block with the current rebase and
  decides to abandon it via `git rebase --abort`. A subsequent attempt
  at rebasing would _no longer be able_ to pick up on the local
  branches, as they would not have been rolled back.

This last point is worth dwelling on for a moment. The interactive
rebase goes out of its way to first switch to an unnamed branch, and
only update the current branch at the very end, when the rebase
succeeded. If the rebase does not succeed, i.e. if it is aborted or
quit, the current branch will not be updated. The interactive rebase is
therefore sort of "transactional": either it succeeds in its entirety,
or all changes are rolled back.

However, the way this patch is implemented, it would break that design,
because the local branches would not be updated at the very end, but
already while the transaction is still being processed, so to say.

Spontaneously, I can think of a few ways to address this:

1. Add a new todo command, or an option for the `label` command (`label
   --branch <name>`) where it would remember to update those refs upon
   successful completion, much like the file
   `<GIT-DIR>/rebase-merge/refs-to-delete` accumulates the
   `refs/rewritten/<label>` refs to delete at the end of the interactive
   rebase, and teach `todo_list_add_branch_updates()` to use it.

2. Maybe even better would be to add a `label <branch-name>` (if there
   is no such command already) instead of the `exec git branch -f`
   lines, and then add a slur of `exec git branch -f` lines at the end
   of the todo list that pick up those labels and run them through
   `update-ref` to update them. That way, if the user aborts the
   interactive rebase somewhere in the middle, the refs would not have
   been updated yet.

3. Another method would combine the approaches 1. & 2.: add an option to
   the `label` command, say, `--update-branch=3D<name>`, which would appen=
d
   the following line to `<GIT-DIR>/rebase-merge/branches-to-update`:

   	update <name> <old-hash>

   And then a single line would be appended to the end of the todo
   list:

   	exec git update-ref --stdin <"<GIT-DIR>/rebase-merge/branches-to-updat=
e"

   This would have the advantage of making things a bit more explicit,
   but it would break expectations when a user would add the
   `--update-branch=3D<name>` option manually and forgot to make sure that
   that `update-ref` line was appended to the end.

Of course, with all of those methods, you would still have to make sure
that the todo command would be inserted _after_ `fixup`/`squash` chains.

However, now that I think of it, the `fixup`/`squash` thing is actually
a pretty tricky thing to deal with in this context. Imagine this commit
graph (newest commit first):

	*   Merge branch 'fix-names'
	| \
	|  * fixup! Implement the `names` command
	|  * Document the `names` feature
	|  * Implement the `names` command
	* / Fiddle with the README.md
	o

The `fixup!` will be re-ordered before `todo_list_add_branch_updates()`
is called, yet we do not want to update the `fix-names` branch to point
to the fixed-up commit, but still to the tip of the branch!

This consideration brings me to my favorite idea so far:

4. If we were to extend the `label` command by the `--update-branch`
   option, it would be nice if we could reuse the actual branch name as
   label name. However, at this stage we no longer have access to the
   `label_oid()` function, as the todo list was generated a long time
   ago. And we would not be able to guarantee that the branch name was
   not already used as a label.

   So why not implement this feature as part of
   `make_script_with_merges()`?

   That way, we could have an initial run through the commits to see
   whether they are decorated with any local branch, and if they are,
   make sure that they get the label(s) they want.

   (The only tricky situation with that would be that you could have a
   local branch `refs/heads/<40-digit-hex>` that clashes with a `reset
   <40-digit-hex>`, which situation can arise under
   `no-rebase-cousins`.)

   The current design actually refuses to have multiple labels per OID,
   but that could be fixed easily, as there is nothing preventing us
   from declaring the `state.commit2label` to allow multiple values for
   the same key. We would simply have to record together with a label
   our wish to update a local branch under that name, e.g. by adding a
   field `unsigned update_branch:1;` to `struct label_entry`, and then
   adding the appropriate `label` commands.

   This method would also have the advantage of adding the `label`
   commands in the right location even in the `fixup!` case I
   illustrated above: the `label` command would be added before the
   `fixup` command gets reordered.

   And it would probably make more sense to _not_ require that `exec git
   update-ref [...]` line at the end of the todo list, but to perform
   the updates transparently similarly to how the `refs/rewritten/` refs
   are removed at the end of an interactive rebase.

> +		}
> +	}
> +
> +	FREE_AND_NULL(todo_list->items);
> +	todo_list->items =3D items;
> +	todo_list->nr =3D nr;
> +	todo_list->alloc =3D alloc;
> +}
> +
>  static void todo_list_to_strbuf(struct repository *r, struct todo_list =
*todo_list,
>  				struct strbuf *buf, int num, unsigned flags)
>  {
> [...]
> diff --git a/t/t3431-rebase-update-branches.sh b/t/t3431-rebase-update-b=
ranches.sh
> new file mode 100755
> index 0000000..221c25d
> --- /dev/null
> +++ b/t/t3431-rebase-update-branches.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description=3D'git rebase -i --update-branches

How about dropping that `-i`? I think this option should also work
without an explicit `--interactive`.

> +
> +This test runs git rebase, moving branch refs that point to commits
> +that are reapplied.
> +
> +Initial setup:
> +
> + A - B          (master)
> +  |\
> +  |  C          (linear-early)
> +  |    \
> +  |      D      (linear-late)
> +  |\
> +  |  E          (feat-e)
> +   \   \
> +     F  |       (feat-f)
> +       \|
> +         G      (interim)
> +           \
> +             H  (my-dev)
> +'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup linear' '
> +	test_commit A &&
> +	test_commit B &&
> +	git checkout -b linear-early A &&
> +	test_commit C &&
> +	git checkout -b linear-late &&
> +	test_commit D
> +'
> +
> +test_expect_success 'smoketest linear' '
> +	git rebase --update-branches master
> +'
> +
> +test_expect_success 'check linear' '
> +	git rev-parse linear-early:B.t

I'd like to suggest this command instead:

	test_cmp_rev linear-early C

The `C` tag was created automatically by `test_commit C`, and the
`test_cmp_rev` command has the advantage of helping diagnose regressions
much better than `git rev-parse` would.

> +'
> +
> +test_expect_success 'setup merge' '
> +	git checkout -b feat-e A &&
> +	test_commit E &&
> +	git checkout -b feat-f A &&
> +	test_commit F &&
> +	git checkout -b interim &&
> +	test_merge G feat-e &&
> +	git checkout -b my-dev &&
> +	test_commit H
> +'
> +
> +test_expect_success 'smoketest merge' '
> +	git rebase -r --update-branches master

Let's try to make this work without `-r`, too.

> +'
> +
> +test_expect_success 'check merge' '
> +	git rev-parse feat-e:B.t &&
> +	git rev-parse feat-f:B.t &&
> +	git rev-parse interim:B.t

Likewise, I would love to see `test_cmp_rev` calls here.

Thank you for working on this feature, this is exciting!

Ciao,
Johannes

> +'
> +
> +test_done
> --
> 2.7.4
>
>
