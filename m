Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89131F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393528AbfJYLsg (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 07:48:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:34119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390097AbfJYLsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 07:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572004110;
        bh=s5RDiYo4128tbQJ4InWOJXf6JPzXhEMkwgXSsfdO15k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZHXulou9hA7hgKNC9nsXelyo1owSJWi0pup7bz1muSvH4MJSfqs5W3RUPM+nlRUqt
         TCxND+gmxMq1M3j8gkHG+hOXiTR+7Nn4j3Iw0/tNsIB3PtDuQ5Uk+Yumu0l+GadgSH
         x2iesL0Qvf/bJfqgWdic6fjfkzzBFNs910fy1XCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1iOnYg48CV-00221W; Fri, 25
 Oct 2019 13:48:30 +0200
Date:   Fri, 25 Oct 2019 13:48:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during
 a rebase
In-Reply-To: <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910251341550.46@tvgsbejvaqbjf.bet>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com> <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com> <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l+uOQZC6sexLSeI1B32rgDVzwk2jTnHWmsc9XXPnftddtJthbOr
 aOFu+vDNyhIyWoxkiiuM2amzFpnzhYg8hyOqmB4+Myzn66WoY+7d5b5fNk8DlQFYKY3z4G5
 lN8sv2gqnxRGEorKf11Y9kj5kdACNUsQaya9Ug8vNARTsC1WzE7+Fjb1oPS2scLIgV+ttin
 VUKRhg4r/thREf2DF+HKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyXWKL+VQ78=:ktvD+dMxZPntlh3jBLbV0h
 z8ODC5iWvkXcHW5g62RAaGkfgq7WgNL6EaMiksYV+6mIsNuavPkTmY9T2be1xdJSY8ElbOXI6
 qv9HJqB9gDnocQGZxdYW1UqlKdn9II0O+vZwLdR4m8OhbRdTmOCVHAGOf3gJroKxeBy+f213a
 1tR6VbwN5EMAxW+F1/gA5q6RTgHYH9kNO6g8s7iY+Z5NmcOXGPYX2iQ6ddJo3TuBkRkZA+Dlc
 Ze+WfFtzKyxr2Vf53jHlt4GpGOaXuwUR8oyWm0MAOq0nrxfW2rpJNAAjdKrCxR/tp6AgIh9rW
 n9JvmcK1VKVkP+94fD1tZJmrWiXZ6VFBqiTkojhbR0vXvP6Iu4iShtaUpkntHc3D4wzQdpYX9
 ojulrxORwNYSIcL7xfVfkXn4YDOd7lXIhZXfBg5crOhBYjxZU+3tLvn3HRYA0fQnpXHBBy5Xq
 8Tiu2XwBC5ojJTVpsJWzJUfvx9Nsn+4+Q1cIfqZ/kC6zGNoqE945mH8PtyBUj3yrXOQVbJTjN
 XmHL38L7qaBgxfmH9tXEFMA1dw7psN3Cxtsvjoo0Sn6gY1IRSwlcdVXEB2sYhAHjamBA4Sj/g
 l0AcoqvPb9K58gcyXiM3kM2TFAUQ7MVvK3RQPeHxiWhPMg+4MDbd5PUi+UeFVggPk/if5w1ZN
 8SxXPpybiCfttxCyORmjnzOEv+94XYp4j8sVd9pSWQpAkwdN+8d2pb56MWQ+RL4mC3LP6EBgP
 EU923NRjTr9r+4a1bOivRGJFMR68tIlESbavz/peSf6BxSmdeoxNoBzbdi7eqhCeh/jUfBG25
 +q4IiWP3UnYiqkvSd9nhppxTZ4osA+R6bOazVt9VTRKI6ICWur+D9FVUCQ07ar4aD0RaP27At
 YDGyLU0OgmDXS4Md4WbGd5OUfj+8SxMGFPzrut4w2t5A/QPNtadpOZDD0EZX0KsHTi9yfPwJg
 I0qqBkVEvlaoyKI7cRrSuEQGGTRPcY7rWdKjcyTc7xu5L29RNmtnOjPIepiSOU4u5vBWdOTHc
 woynT7YFGqDxkR0h333y70Da+iUDSx/wLRZbmTxbb6tidPzUHno7Hd/WKhOzRv2lzY4w5nbmP
 0jp1cP37oaC/Bhut/PUrxz6cxRFfVRWJ++4CjqIU8UVsmuv+7kr89ZEEOald/KCpmrEpwKEpX
 1c5xxi8i7EvNaCn5WcNiI1T5TbFTdY/Dxh8s0vI8RDqaX6EMUnxqOjd10ozVq4kHC8TZrZuG+
 TRvdchyNJqAKOYpHzYehSq1cyo5w4zav46K0ML/dyb0Iu9QmrmqkJj7TgApg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 24 Oct 2019, Phillip Wood wrote:

> On 23/10/2019 00:30, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
> > `git commit` learned to suggest to run `git cherry-pick --skip` when
> > trying to cherry-pick an empty patch.
> >
> > However, it was overlooked that there are more conditions than just a
> > `git cherry-pick` when this advice is printed (which originally
> > suggested the neutral `git reset`): the same can happen during a rebas=
e.
> >
> > Let's suggest the correct command, even during a rebase.
> >
> > While at it, we adjust more places in `builtin/commit.c` that
> > incorrectly assumed that the presence of a `CHERRY_PICK_HEAD` meant th=
at
> > surely this must be a `cherry-pick` in progress.
> >
> > Note: we take pains to handle the situation when a user runs a `git
> > cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
> > line in an interactive rebase). On the other hand, it is not possible =
to
> > run a rebase during a cherry-pick, meaning: if both `rebase-merge/` an=
d
> > `sequencer/` exist, we still want to advise to use `git cherry-pick
> > --skip`.
>
> Thanks for working on this. It's unfortunate that rebase does not remove
> CHERRY_PICK_HEAD for empty commits as it does if the commit is not
> empty.

Oh, so that's what it is that bites me all the time? I frequently run
interactive rebases and sometimes mess up authorship (taking authorship
of patches that I did not, in fact, author). I guess what happens is
that I `git commit` in the middle of a rebase that was interrupted by
merge conflicts.

So I would actually like to see the _exact opposite_ of what you want to
see: I want to keep `CHERRY_PICK_HEAD` even in the non-empty case.

> I think this is because 'rebase --continue' will skip an empty commit
> so the user _has_ to run 'git commit' manually to keep it. If it had
> been designed so that 'rebase --continue' kept the empty commit and
> 'rebase --skip' skipped it then we would not have this problem but
> it's a bit late to worry about that now.

True.

> I don't this patch can distinguish between an empty cherry-pick
> performed by the user while a rebase is in progress and an empty pick
> performed by rebase as both create CHERRY_PICK_HEAD while
> .git/rebase-merge exists. It seems to assume that CHERRY_PICK_HEAD was
> created by rebase and prints advise based on that which may or may not
> be the correct. I think we could distinguish the two by checking if
> CHERRY_PICK_HEAD matches .git/rebase-merge/stopped-sha or REBASE_HEAD.

I guess we could, but then, I would rather worry about that in the next
cycle. In this cycle, I would rather fix the common case, which is that
a `git rebase -i` fails and tells me to `git cherry-pick --skip` instead
of `git rebase --skip`.

And even if I performed a `git cherry-pick` during a `git rebase` and
the result would be an empty commit, I'd rather be told to `git rebase
=2D-skip` to continue...

But if you feel strongly that this should be fixed differently, I'll
gladly leave it to you ;-)

Ciao,
Dscho

>
> Best Wishes
>
>
> Phillip
>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/commit.c       | 33 ++++++++++++++++++++++++---------
> >  t/t3403-rebase-skip.sh |  9 +++++++++
> >  2 files changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index e588bc6ad3..2beae13620 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -59,6 +59,9 @@ N_("The previous cherry-pick is now empty, possibly =
due to conflict resolution.\
> >  "    git commit --allow-empty\n"
> >  "\n");
> >
> > +static const char empty_rebase_advice[] =3D
> > +N_("Otherwise, please use 'git rebase --skip'\n");
> > +
> >  static const char empty_cherry_pick_advice_single[] =3D
> >  N_("Otherwise, please use 'git cherry-pick --skip'\n");
> >
> > @@ -122,7 +125,7 @@ static enum commit_msg_cleanup_mode cleanup_mode;
> >  static const char *cleanup_arg;
> >
> >  static enum commit_whence whence;
> > -static int sequencer_in_use;
> > +static int sequencer_in_use, rebase_in_progress;
> >  static int use_editor =3D 1, include_status =3D 1;
> >  static int have_option_m;
> >  static struct strbuf message =3D STRBUF_INIT;
> > @@ -183,6 +186,8 @@ static void determine_whence(struct wt_status *s)
> >  		whence =3D FROM_CHERRY_PICK;
> >  		if (file_exists(git_path_seq_dir()))
> >  			sequencer_in_use =3D 1;
> > +		if (file_exists(git_path_rebase_merge_dir()))
> > +			rebase_in_progress =3D 1;
> >  	}
> >  	else
> >  		whence =3D FROM_COMMIT;
> > @@ -453,8 +458,11 @@ static const char *prepare_index(int argc, const =
char **argv, const char *prefix
> >  	if (whence !=3D FROM_COMMIT) {
> >  		if (whence =3D=3D FROM_MERGE)
> >  			die(_("cannot do a partial commit during a merge."));
> > -		else if (whence =3D=3D FROM_CHERRY_PICK)
> > +		else if (whence =3D=3D FROM_CHERRY_PICK) {
> > +			if (rebase_in_progress && !sequencer_in_use)
> > +				die(_("cannot do a partial commit during a rebase."));
> >  			die(_("cannot do a partial commit during a cherry-pick."));
> > +		}
> >  	}
> >
> >  	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> > @@ -950,10 +958,12 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
> >  			fputs(_(empty_amend_advice), stderr);
> >  		else if (whence =3D=3D FROM_CHERRY_PICK) {
> >  			fputs(_(empty_cherry_pick_advice), stderr);
> > -			if (!sequencer_in_use)
> > -				fputs(_(empty_cherry_pick_advice_single), stderr);
> > -			else
> > +			if (sequencer_in_use)
> >  				fputs(_(empty_cherry_pick_advice_multi), stderr);
> > +			else if (rebase_in_progress)
> > +				fputs(_(empty_rebase_advice), stderr);
> > +			else
> > +				fputs(_(empty_cherry_pick_advice_single), stderr);
> >  		}
> >  		return 0;
> >  	}
> > @@ -1156,8 +1166,11 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
> >  	if (amend && whence !=3D FROM_COMMIT) {
> >  		if (whence =3D=3D FROM_MERGE)
> >  			die(_("You are in the middle of a merge -- cannot amend."));
> > -		else if (whence =3D=3D FROM_CHERRY_PICK)
> > +		else if (whence =3D=3D FROM_CHERRY_PICK) {
> > +			if (rebase_in_progress && !sequencer_in_use)
> > +				die(_("You are in the middle of a rebase -- cannot amend."));
> >  			die(_("You are in the middle of a cherry-pick -- cannot amend."));
> > +		}
> >  	}
> >  	if (fixup_message && squash_message)
> >  		die(_("Options --squash and --fixup cannot be used together"));
> > @@ -1628,9 +1641,11 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
> >  			reduce_heads_replace(&parents);
> >  	} else {
> >  		if (!reflog_msg)
> > -			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
> > -					? "commit (cherry-pick)"
> > -					: "commit";
> > +			reflog_msg =3D (whence !=3D FROM_CHERRY_PICK)
> > +					? "commit"
> > +					: rebase_in_progress && !sequencer_in_use
> > +					? "commit (rebase)"
> > +					: "commit (cherry-pick)";
> >  		commit_list_insert(current_head, &parents);
> >  	}
> >
> > diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> > index 1f5122b632..77b03ac49f 100755
> > --- a/t/t3403-rebase-skip.sh
> > +++ b/t/t3403-rebase-skip.sh
> > @@ -76,4 +76,13 @@ test_expect_success 'moved back to branch correctly=
' '
> >
> >  test_debug 'gitk --all & sleep 1'
> >
> > +test_expect_success 'correct advice upon empty commit' '
> > +	git checkout -b rebase-skip &&
> > +	test_commit a1 &&
> > +	test_tick &&
> > +	git commit --amend -m amended --no-edit &&
> > +	test_must_fail git rebase -m --onto a1 HEAD^ 2>err &&
> > +	test_i18ngrep "git rebase --skip" err
> > +'
> > +
> >  test_done
> >
>
>
