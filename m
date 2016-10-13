Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7391F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbcJMKkS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:40:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:58486 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbcJMKkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:40:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRSeC-1bRwVi1phw-00SgzR; Thu, 13 Oct 2016 12:40:06
 +0200
Date:   Thu, 13 Oct 2016 12:40:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Joshua N Pritikin <jpritikin@pobox.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: interactive rebase should better highlight the not-applying
 commit
In-Reply-To: <20161012170207.lapdv5h5aws4k4pw@droplet>
Message-ID: <alpine.DEB.2.20.1610131230370.197091@virtualbox>
References: <20161011190745.w2asu6eoromkrccu@droplet> <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com> <20161012132740.dvyofl36qtualxgk@droplet> <alpine.DEB.2.20.1610121815160.197091@virtualbox> <20161012170207.lapdv5h5aws4k4pw@droplet>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YLLiY71EFx8dCkuJcFlqq+KG8Rg/813D4uR3+Buz2cyHFYG1zma
 oSjOoL9gMJnG2hj31JX2Y7ZEBndyahgEVVtYAjLMc0ZgJ3xoVuyGRno4uiH4wi7qrfQmwPU
 VFNPxO2CnZ0OB07rq5fho/iSMric4gFi/F3Q8KLm6rqmuiNI2A9h/jsr6NbJkVBaJ5N78uB
 dFM8+Lukloa1V02xN0lVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wFSuRqvUOsw=:rpysufR1ZoEt3YVdRUzCm/
 qHrmZq4xQxlXetzO0xYe+rMmgTGk+jrfaMGs8krO8pCwL+/a4G07xdOH258Vaqh8q9BTkPrJV
 RyaQxi9m/bDW7p38TuxX2GrxUtTpPJr83vv0h/T5r/Ye14Ebj1WxXQN2VsVceyFgQRdHRr5qj
 aHc8RJppJ0Jekk9O7eFtw4It9I1gPCW9FIP6lNHMUWckNJURkB0hDMvC525GjcMwPHnByNKAL
 xTJLiZ+L2V54s+ZKyxcs83PpdmO2r/ZvCxKBf96e28TOlnC2QvboEpOnw//Z3O16U6TsOcgKN
 DDDGMowAjWtxPtGK6PMiOFnpb1j7oeofp41cjLKzS12JzPFy/GSCoueos+FDNydEOS6T07EqW
 9K/g3EODwYpIeeTV7U3uQQOMtJsBlYjny9kYIIIjjxkrr9WpXUjSpwqCJTjpWIqUFKgIYTgWI
 QHZYcJjUmCanss58jW//lrJplnTO7SQLAnV2PfP8dUz3OyqSMC83tWdL7KGNl6BJ9x5oD/JQA
 euqWNaxDBEwzMjyTcoohcrpQEcU9SlZSQqXXhvamvX2kPIFIQGPjRTroxAHnruIwYoR7OvqSU
 Dr40jqYFr5oapD856WObIsLfKonXmP6R/0GSknjNeVSSN8mrzTvyy5w1T46XkA0spGG93TGdK
 Fw/emp+Laa1hA8PLBI51mRPSmiJxvsUXqirkHOslmXZCP4p0jU22ZFmt4a5Ka0HXADASKkF53
 yDF9mBfJGsQaF9PSj4QZn3zw/5ICyedEYkWYW3l4VEagM7BzttA3FJwSbWABdW1CF6cYoYrPt
 xodp7ic
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joshua,

On Wed, 12 Oct 2016, Joshua N Pritikin wrote:

> On Wed, Oct 12, 2016 at 06:24:37PM +0200, Johannes Schindelin wrote:
> 
> > But maybe I read it all wrong and you do want to make this happen
> > yourself, and you simply want a little advice how to go about it?
> 
> Ugh, if you insist.

I don't. If you want that feature to see the light of day, you should
insist yourself ;-)

> > > On Tue, Oct 11, 2016 at 02:25:19PM -0700, Stefan Beller wrote:
> > > > On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > > > However IIUC currently rebase is completely rewritten/ported to C 
> > > > where it is easier to add color support as we do have some color 
> > > > support in there already.
> > > 
> > > Sounds great. Is there a beta release that I can try out?
> > 
> > There is no release as such, unless you count Git for Windows v2.10.0.
> 
> Nope, that doesn't count. ;-)

Sometimes honesty goes too far. You basically told me that what I work on
does not count. That does not exactly curry my favor.

> > But you can try the `interactive-rebase` branch of
> > https://github.com/dscho/git; please note, though, that my main aim
> > was to be as faithful as possible in the conversion (modulo speed, of
> > course).
> 
> Hm OK
> 
> > > Sometimes I do a rebase to fix some tiny thing 10-15 commits from HEAD.
> > > Maybe only 1 file is affected and there are no merge conflicts, but when
> > > rebase reapplies all the commits, the timestamps of lots of unmodified
> > > files change even though they are unmodified compared to before the
> > > rebase.
> > 
> > Well, they *were* modified, right?
> 
> Were they? Isn't that just an artefact of the implementation?

Yes, they were modified, as the todo script you saved for the interactive
rebase to perform told it to cherry-pick those changes. That is a worktree
operation, performing on files, not a repository operation working on
objects in Git's database.

> > A workaround would be to create a new worktree using the awesome `git
> > worktree` command, perform the rebase there (on an unnamed branch --
> > AKA "detached HEAD", no relation to Helloween), and then come back to
> > the original worktree and reset --hard to the new revision. That reset
> > would detect that there are actually no changes required to said
> > files.
> 
> What would be the problem with doing this by default? Or could it be a
> configuration option that can be enabled?

It could definitely be a new feature that is triggered by a new (opt-in)
configuration option.

It cannot be on by default, at least not in the short run, because those
cherry-picks can fail with merge conflicts and power users of the
interactive rebase expect those conflicts to show in the current worktree.

Ciao,
Johannes
