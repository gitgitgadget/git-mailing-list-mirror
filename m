Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6621F576
	for <e@80x24.org>; Tue, 20 Feb 2018 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeBTLDX (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 06:03:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:50053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeBTLDW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 06:03:22 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LtJAR-1eeAYL1wXD-012mce; Tue, 20 Feb 2018 12:03:14 +0100
Date:   Tue, 20 Feb 2018 12:03:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
cc:     Git Users <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Is there any way to "interrupt" a rebase?
In-Reply-To: <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com> <20180219223653.GE6619@genre.crustytoothpaste.net> <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sFewdrrtEZq+hFrne4auuEaRDYi5U8BGULpxU4sFcwIV2SOPvqd
 ggJ53PsuJPS9dcC+B3dQUbWgJi+bNbiPY3esBmnFdASa3jnGPgFhX9+t2tan+x+QmHYefFI
 Z5B1A1sb5JrFw99Bpm2mgxd00vMztCyddLDZYoSKrW9ZkWL7DDzgaBf28BWRx5pjzaAhfVl
 z8KL0te72J8Pib2TxtqRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vnYzNVSnbNc=:1mhCHdVgJz1gZ6lebBTWvc
 YZF57zrZ4hCf1v47ZqZaqDGo9v6IwvMF5a4jciViqFUKNtKJvBVAtARcMFcu8Vmlokgp+qfjW
 o+OlNJn0q+db8g3sTQ+fqJjBEvM9W8eHNq9azmotmRGSwMpmy3MpMkRP5dpVEio5Fw8iMpUpP
 BiRPVLKd84Z4kJR0yDFmDyqUPM/lFGmUI5zrFahMW9kTsi5kIslzfb5fa5DO9ZFKElJdlQXEd
 oWYE95/XU1XNKDW1Eu2EhUc5dIkkJICdsMfGNDz+yBMywaiacfo0XSxMWzSPOXc5IAC7JEE7b
 u0DyQi4Vyh6PHHqy1mQx8L0zXaazqF8zCeClJk0sDCtSZyMnbUJOFH9SJt+2odrJ6yyHTal8r
 FOx1XTthuoZBr1YjBE4axkakQwfzs6RqCY8IyPxcXYgeLKhFvPGF/zH5Pd2ieU/YAUyt+FDXi
 8zS57tAIGAYI/dYS9913saUoXrIX+cK+RF7Wr9ZZxG5eZ7qo41+VYbQJOveVA+J+xaCES/P1S
 O+CkwS61+oNQPPE9hdNeJcAnUdt6v0pu2wAHAWDCU5QfP93cEwQ5oqQZP2lJ4tNXxjUCXj6HV
 HKMwZHOP38AEeNuboz/OK1FVLyP1px0g3BDbW3n1vsn5lg9a0kGMe+a15VGV9YXsS0HD5lVRn
 9gh5RzgF/G3/QY2UDlZNiB6JgKzOzA7RBfJk/7gM5k/MjRjWfRRaQmFFfQaM/SkhwpKQbrQkc
 84g8FNdtqbEdWLNide8QZcB8y8gDqES+4pBpjFw1Fbg0zWecVscQaepbGr65eMkj3coBR8h8e
 vAfszIcp8qNFJNKgFvKpkOZA3sTPRCH1A+vb679xsgjS5NS4Lk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hilco,

On Mon, 19 Feb 2018, Hilco Wijbenga wrote:

> On Mon, Feb 19, 2018 at 2:36 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Mon, Feb 19, 2018 at 11:35:25AM -0800, Hilco Wijbenga wrote:
> >> So a scenario like this:
> >>
> >> my-branch : X -> A -> B -> C -> D -> E -> F -> G
> >> base-branch : X -> Y
> >>
> >> git rebase --onto base-branch HEAD~7
> >> commit A --> conflicts
> >> ... lots of work ...
> >> commit B --> conflicts
> >> ... lots of work ...
> >> commit C (Git handles conflicts)
> >> commit D (no conflict)
> >> commit E --> conflicts
> >> ... er, that should have been fixed in commit C
> >>
> >> How do I keep all the work I did for commits A and B? I get the
> >> impression that rerere does not help here because I did not finish the
> >> rebase succesfully (and that makes perfect sense, of course). Is there
> >> a way at this point in the rebase to "go back" to commit C (so without
> >> "git rebase --abort")?
> >
> > What I do in this case is I unstage all the changes from the index, make
> > the change that should have gone into commit C, use git commit --fixup
> > (or --squash), and then restage the rest of the changes and continue
> > with the rebase.  I can then use git rebase -i --autosquash afterwards
> > to insert the commit into the right place.
> 
> Yes, that's essentially what I end up doing too. Obviously, in cases
> like this, Murphy likes to drop by so commit D will have made changes
> to the same files as commit C and you can't cleanly move the fix-up
> commit to commit C. :-( I had hoped there might be an easier/cleaner
> way to do it.

I am a heavy user of interactive rebase. Which is unsurprising, given that
I implemented the first version of it.

And I find myself in the same situation quite often (as of recent, more
often when doing complicated rebases involving non-linear commit
topologies, but I digress).

Being that familiar with the internals of the interactive rebase command
gives me the opportunity to do "clever" things.

My number one strategy is to mix interactive rebase with cherry-pick: I
`git reset --hard HEAD^` (which refers to the rewritten C), fix up the
commit as intended, then look at the latest interactive rebase command
listed in the output of `git status`, then determine the commit range of
commits I want to replay on top and then call `git cherry-pick <range>`
(in your case, that would be `git cherry-pick C..E`.

Admittedly, this strategy is a bit cumbersome because a lot of
book-keeping is performed by my working memory instead of Git.

When I am particularly tired and overworked (and therefore know that my
working memory is less useful than usual), I therefore resort to my
second-favorite strategy: U use the `done` file.

I literally copy parts of $GIT_DIR/rebase-merge/done to the beginning of
$GIT_DIR/rebase-merge/git-rebase-todo (the most convenient way to open the
latter is `git rebase --edit-todo`). In your case, those would be the
`pick` lines cherry-picking D and E. Then, as before, `git reset --hard
<commit>` (where I look up the `<commit>` using an aliased version of `git
log --graph --oneline --left-right --boundary`), amend the commit, and
then `git rebase --continue`.

It might be even possible to design a new subcommand for the interactive
rebase to facilitate a variation of this strategy (possibly even making
use of the fact that the interactive rebase accumulates mappings between
the original commits and the rewritten ones in
$GIT_DIR/rebase-merge/rewritten-list, intended for use in the post-rewrite
hook).

Ciao,
Johannes
