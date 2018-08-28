Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5631F404
	for <e@80x24.org>; Tue, 28 Aug 2018 12:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH1Qlu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:41:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:58519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qlu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:41:50 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPUFR-1fymBM47nt-004lsC; Tue, 28
 Aug 2018 14:50:10 +0200
Date:   Tue, 28 Aug 2018 14:50:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Gregory Oschwald <oschwald@gmail.com>, git@vger.kernel.org
Subject: Re: $GIT_DIR is no longer set when pre-commit hooks are called
In-Reply-To: <20180827233706.GA11663@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808281442190.73@tvgsbejvaqbjf.bet>
References: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com> <20180826004150.GA31168@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808271824270.73@tvgsbejvaqbjf.bet> <20180827233706.GA11663@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MmJluucAH0fG/adEGMN1Kvq3ub66jq0IyL02yi04YCMa84j1Bc6
 MwP8tpNjxeQp10gDv8TfxNWK8vLn1iD5aDAtbECKSTmPy5mPn+2D3h/W1nQLfY9f3S3nZGv
 q//15g3VrU9psokTzgMb2yfsBGSO7YoRleNx8eyCcsovv8uvLFrQxREgKBAkxlm7iVOaHuY
 DwQ3epmVh6zu7+DqOD8DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+K8CcSjMueo=:TBFVmQwCjCxec4dOOECPO3
 H/8KMK1cKMgB89eFh4Rwl6OBK06+PX3aVsiYNKbIA6fuwHqmdZ30sSIj5AdZX+edalcoek5zD
 rdofH9hpbNsSCkU7EftzCwrQgN+1X0ktfbwCaqcSvKOLjjcTvvC9Il07qJr8afeIKPRBcgZUE
 PAgEZ638gvxer5ckRuRLJEC7lryIzp5SQ6r1eTG8vWIw8Sbf6oibZ2YNQ1t9UoWb5htXgQ2pZ
 8u0rNm+vrtLpoIdSMtDDz7jGb/IYKFFxElQWFupdEeJ2U/+zLES+Snvq8cMWY3BAf2M/2QxfU
 GjjRrUOteNsP0ZDGhyinDXmrKA4Q4fUA2sVtmXjwQ2CCBUWkQBy2bqvBloDHH2t/Jclo6Jp0L
 kmsuZMy5d2Zg1WFU5V7h++Xq+lu4z7dXyPUJazz8SUcuRguQNW6rKGrSnraevpxEkL/egAdV7
 VN6f3P1nmEiJcRD2tBI2ebMc0jIaoxocvceOdWvCkJgNMrbjxGF3Oe8s5pyh5nuACTmdWU+Na
 gkjINk/oghuAg/x3qTL5TAYIGyvOJdKNsiQG4VO5TjmRkIBZB2mRwZJW91sp1Ne3BN5af7QLv
 PyPJeB7wJw5044Gci/4tDmyIXfcYD/5ZekiSoYR+ZGHK4dGk5nPjEv2Q7DvVgyx2S6KgoL9co
 5cMAUrbkd1+F639rdlGPfFqdZxw5/XdLzmXxKDIYy/Yhms81Hk9xG2Ub3f6VnCYX81UVie1rV
 OmoUNjimWqTJpClU9Nz5ir4gm3pAXPVWYWxUrmr1QUO0kMX9TRAVqmltg51XGa+QwhydMxPcV
 3VmvURr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 27 Aug 2018, Jeff King wrote:

> On Mon, Aug 27, 2018 at 06:25:26PM +0200, Johannes Schindelin wrote:
> 
> > On Sat, 25 Aug 2018, Jeff King wrote:
> > 
> > > On Wed, Aug 22, 2018 at 04:16:00PM -0700, Gregory Oschwald wrote:
> > > 
> > > diff --git a/builtin/commit.c b/builtin/commit.c
> > > index 3bfeabc463..3670024a25 100644
> > > --- a/builtin/commit.c
> > > +++ b/builtin/commit.c
> > > @@ -1440,6 +1440,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
> > >  	int ret;
> > >  
> > >  	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
> > > +	argv_array_pushf(&hook_env, "GIT_DIR=%s", get_git_dir());
> > 
> > We did something similar in sequencer.c, and it required setting
> > `GIT_WORK_TREE`, too, to avoid problems in worktrees. Do you need the same
> > here, too?
> 
> Hmm, good point. Maybe. If we're just trying to restore the original
> behavior (i.e., fix a regression), then this would behave as the
> original.
> 
> I'm not at all opposed to going beyond that and actually fixing more
> cases. But I am a little nervous of introducing a new regression, given
> the subtlety around some of our startup code.

I concur about the subtlety around the startup code. Quite a bit of that
mess is now a bit easier to grok, thanks to my work to discover the
GIT_DIR gently, but there are still monsters lurking in that code.

Having said that, I don't think that we can get away with setting GIT_DIR
without GIT_WORK_TREE here. That would *definitely* introduce a bug, as
far as I can tell.

> My current understanding is:
> 
>   - If we're setting GIT_DIR, it's probably always save to set

With s/save/safe/, I agree.

>     GIT_WORK_TREE (or GIT_IMPLICIT_WORK_TREE=0 if there isn't a
>     worktree). I.e., there is no case I know that would be broken by
>     this.
> 
>   - Passing GIT_DIR to any sub-process operating in the context of our
>     repo (i.e., excluding cases where we're clearing local_repo_env) can
>     break a script that expects to do:
> 
>       cd /another/repo
>       git ...
> 
>     and operate in /another/repo. But such a script is already broken at
>     least in some cases, because running the initial command as:
> 
>       git --git-dir=/some/repo
> 
>     will mean that GIT_DIR is set.

Since this mailing list often indulges in tangent fest, I'll allow myself
this one: `git --git-dir=...` should probably handle the case where
GIT_DIR/GIT_WORK_TREE were set differently when the command was started,
and if so, unset them.

>     already broken, though it may be small consolation to somebody whose
>     hook happened to work most of the time, because they do not pass in
>     GIT_DIR.

I seem to remember two reports about such funny way to do things. So they
exist, I agree.

>   - Any command that uses setup_work_tree() (which includes things with
>     NEED_WORK_TREE in git.c) would have always been setting GIT_DIR up
>     through v2.17.x. So any hooks they run would have seen it
>     consistently, and therefore are exempt from being regressed in the
>     case above.
> 
> So I _think_ it would be safe to:
> 
>   1. Set GIT_DIR again anytime we call setup_work_tree(), because that's
>      what has always happened.
> 
>   2. Start setting GIT_WORK_TREE at the same time. This didn't happen
>      before, but it can't break anybody, and might help.

With s/might help/will help in some edge cases/, I agree.

> That makes the rules for when GIT_DIR is set confusing, but at least it
> shouldn't regress. A more consistent rule of "hooks always see GIT_DIR"
> (or even "any sub-process always sees...") is easier to explain, but
> might break people in practice.

Indeed.

> I notice also that sequencer.c sets an absolute path, since 09d7b6c6fa
> (sequencer: pass absolute GIT_DIR to exec commands, 2017-10-31). That
> does seem friendlier, though I wonder if could break any scripts. I
> cannot think of a case, unless the intermediate paths were no accessible
> to the uid running the process (but then, how would Git have generated
> the absolute path in the first place?).

Please note that (IIRC) this commit just reinstated the handling in
git-sh-setup, which always set GIT_DIR to an absolute path. Scripts used
in conjunction with `git rebase -i` would therefore have had to expect
this.

Ciao,
Dscho
