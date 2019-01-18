Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9951F453
	for <e@80x24.org>; Fri, 18 Jan 2019 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfAROQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 09:16:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:33607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAROQL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 09:16:11 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3ARX-1h3G2m3M2B-00swNk; Fri, 18
 Jan 2019 15:16:04 +0100
Date:   Fri, 18 Jan 2019 15:15:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
In-Reply-To: <xmqqwonkclpx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181443350.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com> <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com> <xmqqwonkclpx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FmKfBvZ8PYeep/UikZOFEDetTRvNn0cmC1UVXNqA3+YaTgBpojs
 bGmNhE0lHXM75tpP/upsjqk/hv7dXzTpJJbR1DQD3Z6vS+74gCP4tilfOO2T62ASZ2xijAB
 HvtYbL6hAS9ewitNh/1kFidj8TxXpSRlvKkgKq0oFIzcagaXmJZ6Lmqlw9gLD1Cf7iDWCV6
 /QfJ6xuo1HnvhAR4tpMdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sClpW/64VKU=:tcBYIHemfL7b6YbOi/0m4Z
 J+YnfQ+ExVckO7Gee4HEIxWf8F3CNVwiIw4dwPXXE3qARgv3paM6CpkPtyg9J5Pf7JB1jTkXc
 JJW9W/3Wyuu/ubyq4CkklJj/PaqO0nVUS6lZ+YSgBqbYolWCe2RDT3YAN7BMhowqu37DO9yBs
 XxlcjfFu/wyTad0ILoUAklmEdahAFiyC7uGafZ/C3PXw6Q53DbS2Vss81F6O0xxNqfJvcTeWP
 6ZNp97feEWtBJS1/o84UsKJwCaZFlKyEyJeBG8sb7kZ2dS3+Ngs3QRICFITKa61F1h8WNhJU8
 ltbhFO95D685xlIgGvHQJl204aqL+7my2LuXdj1PHSDi+Obz37XqJABpITBpr/oWeo8du/+eb
 VcppBBCF+i+flJExVncB8R3UVAqEZFl3vybcGdpxr0+40pyGFupKvIeDtYxIloX/Ncm6qaO1V
 VCVK3OyN/R58OFdqdTJKoeppQKEUQdqreoEyKL2uwLO0Ux+ImuB3xcUY+1109pI587bFjYck6
 nTilFJppxWUwx54DD27oTsTLXbAIrBXJpQgLfFO7oWSHQ5hQ+wvkpfY2gpvTZsefkCWQ5tSUI
 4fONr5/ee1NwcwkxsdnhwijOiGM/mXpOJRsArkRvbiYvLUizxxH+3JlJ6VUNr5ynuzq/kW94J
 k7iSJBnFToMAcuF400dm3VL1Q3CuiqnB3Qba2leu6xXi/TFGON7RfjBmuKDShvyQrgO4oIQCl
 e3jHf+BaFUvjCyl1gei+WZDvHfLXBJP1j0aQkaZNBMNjnz5H1W6Y2bjGeaZRM2HksyNfNiw4s
 ChEgabyGaC3JlonRtmK+iLjYrqH31KkIjBHLZhUOl09lHDcLdygX3Q+dL/nlkQB0XIaWiemKC
 bFLUFY+pBa5kUwedQYvV+1HK0+PDx8wg7+rwv755r6i6NNCo6Fb06sDFYz/VY5fHPk5apyH+U
 HIazZ65b5+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +static int write_basic_state(struct rebase_options *opts)
> > +{
> > +	write_file(state_dir_path("head-name", opts), "%s",
> > +		   opts->head_name ? opts->head_name : "detached HEAD");
> > +	write_file(state_dir_path("onto", opts), "%s",
> > +		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
> > +	write_file(state_dir_path("orig-head", opts), "%s",
> > +		   oid_to_hex(&opts->orig_head));
> > +	write_file(state_dir_path("quiet", opts), "%s",
> > +		   opts->flags & REBASE_NO_QUIET ? "" : "t");
> > +	if (opts->flags & REBASE_VERBOSE)
> > +		write_file(state_dir_path("verbose", opts), "%s", "");
> > +	if (opts->strategy)
> > +		write_file(state_dir_path("strategy", opts), "%s",
> > +			   opts->strategy);
> > +	if (opts->strategy_opts)
> > +		write_file(state_dir_path("strategy_opts", opts), "%s",
> > +			   opts->strategy_opts);
> > +	if (opts->allow_rerere_autoupdate >= 0)
> > +		write_file(state_dir_path("allow_rerere_autoupdate", opts),
> > +			   "-%s-rerere-autoupdate",
> > +			   opts->allow_rerere_autoupdate ? "" : "-no");
> 
> Inside rebase, allow-rerere-autoupdate can be -1 (unspecified), 0
> (declined) or 1 (requested), and this code is being consistent with
> that convention.
> 
> The "--[no-]rerere-autoupdate" option that is parsed via
> OPT_RERERE_AUTOUPDATE (used in builtin/rebase--interactive.c among
> other built-in commands) on the other hand is tertially that uses 0
> (unspecified), 1 (requested) and 2 (declined).  This might be a
> ticking timebomb to confuse us in the future that may be worth
> fixing but probably outside this series.

Good point. We use -1 for unspecified in so many places, I think
OPT_RERERE_AUTOUPDATE needs to be fixed. But yes, I'll leave this as
#leftoverbits here.

> > @@ -459,6 +490,30 @@ static int reset_head(struct object_id *oid, const char *action,
> >  	return ret;
> >  }
> >  
> > +static int move_to_original_branch(struct rebase_options *opts)
> > +{
> > +	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> > +	int ret;
> > +
> > +	if (!opts->head_name)
> > +		return 0; /* nothing to move back to */
> > +
> > +	if (!opts->onto)
> > +		BUG("move_to_original_branch without onto");
> 
> This check is absent in the scripted version, but from the message
> we generate here, it is clear that the caller must not call this
> when there is no "onto" commit.  Good.
> 
> > +	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
> > +		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> > +	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
> > +		    opts->head_name);
> > +	ret = reset_head(NULL, "checkout", opts->head_name,
> > +			 RESET_HEAD_REFS_ONLY,
> > +			 orig_head_reflog.buf, head_reflog.buf);
> 
> The *action given to reset_head() here is "checkout".  Makes me
> wonder about two things:
> 
>  - The only real use of the parameter in the callee is to prepare
>    the error and advice messages from the unpack_trees machinery,
>    but because we are using it in REFS_ONLY mode, it does not
>    matter.  In fact it might even be misleading; perhaps pass NULL
>    or something, so that a mistaken update to reset_head() later
>    that lets REFS_ONLY request to go to unpack_trees machinery will
>    catch it as a bug?
> 
>  - Another topic in flight wants to make sure that the post-checkout
>    hook gets called when the RESET_HEAD_RUN_POST_CHECKOUT_HOOK flag
>    is given by the caller, and IIRC, the use of the flag is strongly
>    correlated to *action being "checkout".  Do we want to pass
>    REFS_ONLY and RUN_POST_CHECKOUT_HOOK flag for this call, or do we
>    rather keep it silent?  As the original scripted version did not
>    use "checkout" here and never triggered post-checkout hook, I am
>    inclined to say that we should not pass that other bit.  That
>    then leads me to suspect that we do not want *action to be
>    "checkout" here.

The only thing for which that the `action` is used, though, is the call to
`setup_unpack_trees_porcelain()`, which does not accept a `NULL`. I guess
I could replace it by the empty string. Will do that.

> 
> > +	strbuf_release(&orig_head_reflog);
> > +	strbuf_release(&head_reflog);
> > +	return ret;
> > +}
> 
> Unlike the scripted version, this does not die() upon failure, so
> the caller needs to be careful about the returned status.

Indeed. That function is only called from `run_am()`, and returns the
status in every instance. The caller of `run_am()`,
`run_specific_rebase()` also handles it correctly.

> 
> > @@ -466,6 +521,129 @@ N_("Resolve all conflicts manually, mark them as resolved with\n"
> >  "To abort and get back to the state before \"git rebase\", run "
> >  "\"git rebase --abort\".");
> >  
> > +static int run_am(struct rebase_options *opts)
> > +{
> > +	struct child_process am = CHILD_PROCESS_INIT;
> > +	struct child_process format_patch = CHILD_PROCESS_INIT;
> > +	struct strbuf revisions = STRBUF_INIT;
> > +	int status;
> > +	char *rebased_patches;
> > +
> > +	am.git_cmd = 1;
> > +	argv_array_push(&am.args, "am");
> > +
> > +	if (opts->action && !strcmp("continue", opts->action)) {
> > +		argv_array_push(&am.args, "--resolved");
> > +		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> > +		if (opts->gpg_sign_opt)
> > +			argv_array_push(&am.args, opts->gpg_sign_opt);
> > +		status = run_command(&am);
> > +		if (status)
> > +			return status;
> > +
> > +		discard_cache();
> > +		return move_to_original_branch(opts);
> 
> It is curious why discard_cache() is placed exacly here, as if we
> want to preserve the contents of the in-core index when
> run_command() failed.  But I do not think we care about the in-core
> index as the only thing that happen after "return status" is to
> return the control to run_specific_rebase(), let it jump to
> finished_rebase label to clean things up and rturn control to
> cmd_rebase() and exit based on the status value.
> 
> It's not like move_to_original_branch() wants to call read_cache()
> and get the result from the "am" that run_command() executed,
> either.
> 
> Puzzled.  Care to explain a bit more in the in-code comment?

I think that this call is just a left-over from a previous version that
did not have the REFS_ONLY flag to pass to `move_to_original_branch()`
(and it caused havoc before that flag was passed). Let me double-check
whether the `discard_cache()` even makes sense any longer.

*clicketyclick* indeed that is the case. Will remove all three
`discard_cache()` calls.

> 
> > +	}
> > +	if (opts->action && !strcmp("skip", opts->action)) {
> > +		argv_array_push(&am.args, "--skip");
> > +		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> > +		status = run_command(&am);
> > +		if (status)
> > +			return status;
> > +
> > +		discard_cache();
> > +		return move_to_original_branch(opts);
> 
> Ditto.
> 
> > +	}
> > +	if (opts->action && !strcmp("show-current-patch", opts->action)) {
> > +		argv_array_push(&am.args, "--show-current-patch");
> > +		return run_command(&am);
> > +	}
> 
> Up to this point, it is a faithful conversion of the first case/esac
> statement.  Good.
> 
> > +	strbuf_addf(&revisions, "%s...%s",
> > +		    oid_to_hex(opts->root ?
> > +			       /* this is now equivalent to ! -z "$upstream" */
> 
> Does "this" refer to the "opts->root being true" check?
> 
> Because you are flipping the polarity of the test from scripted
> version, shouldn't the comment be updated to "-z $upstream"?

It did flip the polarity, you are right, this comment is incorrect. It is
even more incorrect, though, as it talks about a shell construct that is
no longer applicable. Will fix.

> 
> > +			       &opts->onto->object.oid :
> > +			       &opts->upstream->object.oid),
> > +		    oid_to_hex(&opts->orig_head));
> 
> > +	rebased_patches = xstrdup(git_path("rebased-patches"));
> > +	format_patch.out = open(rebased_patches,
> > +				O_WRONLY | O_CREAT | O_TRUNC, 0666);
> 
> Unlike scripted version, we do not remove a (possibly) existing file.
> We give CREAT in case there is no existing one, and TRUNC in case
> there is an existing one.  Makes sense.  A more faithful translation
> would have unlink(2)ed a (possibly) existing one, and then because
> we can afford to, passed O_EXCL to avoid stomping on somebody else
> racing with us, but I do not think it is worth it.

Okay.

> > +	if (format_patch.out < 0) {
> > +		status = error_errno(_("could not write '%s'"),
> > +				     rebased_patches);
> 
> s/write '%s'/open '%s' for writing/?  I dunno.

Yep, of course! Will fix.

> > +		free(rebased_patches);
> > +		argv_array_clear(&am.args);
> > +		return status;
> > +	}
> > +
> > +	format_patch.git_cmd = 1;
> > +	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
> > +			 "--full-index", "--cherry-pick", "--right-only",
> > +			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> > +			 "--no-cover-letter", "--pretty=mboxrd", NULL);
> > +	if (opts->git_format_patch_opt.len)
> > +		argv_array_split(&format_patch.args,
> > +				 opts->git_format_patch_opt.buf);
> > +	argv_array_push(&format_patch.args, revisions.buf);
> > +	if (opts->restrict_revision)
> > +		argv_array_pushf(&format_patch.args, "^%s",
> > +				 oid_to_hex(&opts->restrict_revision->object.oid));
> 
> It is kinda surprising to see that we have learned quite a lot of
> fringe "configurations" we need to explicitly override like this.
> 
> Looks like a quite faithful conversion, anyway.
> 
> > +	status = run_command(&format_patch);
> > +	if (status) {
> > +		unlink(rebased_patches);
> > +		free(rebased_patches);
> > +		argv_array_clear(&am.args);
> > +
> > +		reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
> > +			   "HEAD", NULL);
> 
> This one may need to trigger post-checkout hook.  The scripted
> version does two different things depending on the value of
> $head_name, but we can just use the same code without conditional?

Yes, because `opts->head_name` is `NULL` in one case, and not `NULL` in
the other, and the `reset_head()` function performs the desired operation
in each case.

> > +		error(_("\ngit encountered an error while preparing the "
> > +			"patches to replay\n"
> > +			"these revisions:\n"
> > +			"\n    %s\n\n"
> > +			"As a result, git cannot rebase them."),
> > +		      opts->revisions);
> > +
> > +		strbuf_release(&revisions);
> > +		return status;
> > +	}
> > +	strbuf_release(&revisions);
> > +
> > +	am.in = open(rebased_patches, O_RDONLY);
> > +	if (am.in < 0) {
> > +		status = error_errno(_("could not read '%s'"),
> > +				     rebased_patches);
> 
> s/write '%s'/open '%s' for reading/?  I dunno.

Yep, will fix.

> 
> > +		free(rebased_patches);
> > +		argv_array_clear(&am.args);
> > +		return status;
> > +	}
> > +
> > +	argv_array_pushv(&am.args, opts->git_am_opts.argv);
> > +	argv_array_push(&am.args, "--rebasing");
> > +	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> > +	argv_array_push(&am.args, "--patch-format=mboxrd");
> > +	if (opts->allow_rerere_autoupdate > 0)
> > +		argv_array_push(&am.args, "--rerere-autoupdate");
> > +	else if (opts->allow_rerere_autoupdate == 0)
> > +		argv_array_push(&am.args, "--no-rerere-autoupdate");
> > +	if (opts->gpg_sign_opt)
> > +		argv_array_push(&am.args, opts->gpg_sign_opt);
> > +	status = run_command(&am);
> > +	unlink(rebased_patches);
> > +	free(rebased_patches);
> > +
> > +	if (!status) {
> > +		discard_cache();
> > +		return move_to_original_branch(opts);
> > +	}
> > +
> > +	if (is_directory(opts->state_dir))
> > +		write_basic_state(opts);
> > +
> > +	return status;
> > +}
> > +
> >  static int run_specific_rebase(struct rebase_options *opts)
> >  {
> >  	const char *argv[] = { NULL, NULL };
> > @@ -546,6 +724,11 @@ static int run_specific_rebase(struct rebase_options *opts)
> >  		goto finished_rebase;
> >  	}
> >  
> > +	if (opts->type == REBASE_AM) {
> > +		status = run_am(opts);
> > +		goto finished_rebase;
> > +	}
> > +
> >  	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
> >  	add_var(&script_snippet, "state_dir", opts->state_dir);
> 
> 
> Overall, this was quite a pleasant read and a well constructed
> series.  Other than two minor points (i.e. interaction with the
> 'post-checkout hook' topic, and discard_cache() before calling
> move_to_original_branch) I did not quite understand, looks good to
> me.
> 
> When merged to 'pu', I seem to be getting failure from t3425.5, .8
> and .11, by the way.  I haven't dug into the actual breakages any
> further than that.

Sorry for the trouble, and for my silence (I was heads-down into the Azure
Pipelines support).

I did not see any breakage in `pu` lately, hopefully things resolved
themselves?

Ciao,
Dscho
