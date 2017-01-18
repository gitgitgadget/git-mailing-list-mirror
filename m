Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D401F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbdARNy2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 08:54:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:57193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbdARNy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 08:54:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1nbu-1cilya02BO-00tiwy; Wed, 18
 Jan 2017 14:54:10 +0100
Date:   Wed, 18 Jan 2017 14:54:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <xmqqbmv5fp22.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701181404590.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701161226090.3469@virtualbox> <xmqqbmv5fp22.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pi+RArdGPLEqUNFYYkGdKtL0a8abfkqxYbVT2h1iGO0XsVR4Hw7
 B1wN1Px14peOar0GBfy+MozYCAN3yr//AEXiq/K+MCVA4Z2qYASdinnsC+YSqwV3ndr3Gfi
 ox+UbA8N0iHTvDZmQzVLjiEbgibPxd6R1/qD7VijVkmu1wIxr9uOaOqDPzDKV+wZTE2Fele
 h81rck4R2q302DcrnKxag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z59nIiEHkgo=:14i0Ys2U8somI3NvvZaFIj
 T29Q+aFsRUfxQwliYSK2mYP1CEZBTRewjKMbJ/xPdo0paDv1lp6HeiAJvrvw7EActIHLM5yAE
 ph1C1QKmnsNaRXHqK9qzR6YwQeMlR9b5iDDXXlWHasbZJ21KnDtWi0//7zAAMXIja9lcfwnP5
 N0Whm1h36sY75Zm5KlGzUfhruJTyQRZWPvfh4XPAKIeysab8GecJaMplsOaowApGMCKY8anU6
 bn4/6C/rmsXA/GYGkPW0u4pOZ7qbWXzzt3raYpslyXa4410laNDF4M9InlYbUaA9F1yqHVdqN
 CDCIgSVS1tt/yYiiHLGJwp9pdeZmYLWni+wHb53w7V0jv5g1g+IvhpDAcZDaXtucomcAI2wnM
 qn9YPswBJhcDPL4wimN5vhbFg9CT24sNDs8mfBViJbRFNx3UN3yqKWocwkKCJ5YJ6ldsTJjM6
 DKPMeq+P2RjYotubHrlXvaac5z+ft7JJezrKZ1omRmfc17aDNJeKLDfYlTI8EuIEvd9WMSLce
 9x9WIHmhoDZvHJMMdpME6QDUlYUDU6+2ArHCIUSJLicv1A8L4zU1EjmNHZPoV1kA8qTagzIbK
 MltIDe1z1RACiLl4u8TLXXeqVjI20ydHhwbgyB3U6BGbkXCFNnP5/NDH5GCbVEEtOwJUF77qV
 flZ+oQp7YNVb22ZgOSwyfEMah+CYHgmfRcpIYVmPGk73VvPYgG+ss0TN7unfLluqQ04Vfg0X/
 O12gcfm90yDzGGLClx4sBMDfJhE363Pi8JZGnBDgSm5JbRazM1vbYyggrhpbb7X94EX5gGTwL
 UbMHJHt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 15 Jan 2017, Junio C Hamano wrote:
> >
> >> * js/prepare-sequencer-more (2017-01-09) 38 commits
> 
> > The only outstanding review comments I know about are your objection
> > to the name of the read_env_script() function (which I shot down as
> > bogus),
> 
> Not the "name", but the implementation not sharing the same code
> with "am" codepath even though they originate from the same shell
> function and serve the same purpose.

They do not originate from the same shell function at all. The scripted
git-am used a function called get_author_ident_from_commit to read the
author-script file. It also used "eval $(cat .../author-script)" to
evaluate the script later on.

And while git-rebase--interactive.sh's ". .../author-script" is very
similar to that latter invocation, I grant you that, the claim that those
codepaths originate from the same shell function is false.

Worse.

git-am.sh not only used a different method to read out the author-script,
and not only left no way for the user to modify that author-script, there
are many more differences in the exact code paths when comparing git-am.sh
to git-rebase--interactive.sh.

git-am.sh goes out of its way to not only apply the patch manually but
also to use the low-level `write-tree` and `commit-tree` commands. The
builtin am reproduces this as faithfully as possible (the author-script is
not actually evaluated, of course, but the builtin am knows that it has
to validate the author-script's contents for the first code path reading
the author-script anyway, so it reuses that function for the second code
path, knowing fully well the exact format of that file because it knows it
wrote it without any chance of the user messing it up).

The builtin am also avoids spawning the low-level commands, opting instead
to call the functions in libgit.a directly. This is all done properly, and
as a consequence, the environment variables GIT_AUTHOR_* never become,
ahem, environment variables in the builtin am, but an "author" parameter
(which is a const char * pointing to a ready-to-use ident line) that gets
passed to the commit_tree() function.

Now, let's have a brief look at git-rebase--interactive.sh.

It was rightfully nicknamed "cherry-pick on drugs" in its early days,
because that is what it does: it calls `git cherry-pick` *most* of the
time.

So what does the (sequencer via being called from the) rebase--helper do?
Yep, exactly: it calls the internal do_pick() function that is the working
horse of the cherry-pick. And does that working horse call write_tree()
and commit_tree()? No, it does not. It *spawns a git-commit process*! And
the way to specify the author there is to pass the GIT_AUTHOR_*
environment variables.

Let's recapitulate.

Not only did the scripted am use a totally different code path to *read*
the author-script than rebase -i, the code path after that also differed
substantially from rebase -i to the point that very, very different Git
commands were called.

It also so happens that the proper way to convert those code paths into
builtin code uses very, very different functions from libgit.a that
require very, very different handling.

The builtin am never sets the environment variables GIT_AUTHOR_* but
instead constructs a complete ident line from it, and therefore *must*
validate the contents of author-script.

The sequencer *has to* set the GIT_AUTHOR_* environment variables because
it calls `git commit` in a different process *that already validates the
GIT_AUTHOR_* variables*.

Even worse (and this is not the first, or second, or third time I pointed
this out): if you mistook the identical file name, and identical content,
to mean that the different code paths *must* use a *single* function to
read the author-script (nevermind that the am code path reads it into a
structure that is specifically designed to support the "am" operation, and
nothing else), you would not only force the sequencer call to provide a
data structure it does not want, not only to validate the contents
unnecessarily, but it would have to lego the parsed contents *back into
almost the original shape as the original contents of the author-script*.
So it would have to add tons of code relative to the current version, for
no benefit at all, *increasing your maintenance burden for no good
reason*.

This repeated suggestion to reuse the code path to read the author-script
repeatedly ignores the fact that we have to do very, very different things
with the contents in those two code paths.

And if that was not enough: we are talking about code that is rock solid,
has been tested for almost a *year*, half of that year with a painful
cross-validation by running old and new rebase -i and comparing their
output. And this rock solid code is what you want to force me to change to
code that neither makes sense nor is tested well.

And I refuse to be forced to do that: we just proved collectively how good
a job we do when reviewing patches: we just flimsically introduced a
regression at the core of the operation of rebase -i. Not despite patch
review. Because of it.

In short: the objections against keeping the read_env_script() function
as-is (now fixed, of course) make no sense from several points of view:
logically, time-wise, and robustness.

> > and the rather real bug fix I sent out as a fixup! which you may want
> > to squash in (in the alternative, I can mailbomb v4 of the entire
> > sequencer-i patch series, that is your choice).
> 
> I'd rather see the "make elengant" thing redone in a more sensible
> way,

No, no, no, NO!

This is starting to become really, really annoying. The reasons you keep
repeating for rewriting this to use the same functions as builtin/am.c *do
not make sense*. Even when you repeat them a hundred times (I know, in the
US you have this really public example where somebody is really successful
repeating incorrect things over and over until some people start to
believe them, but this is not an example you should try to follow).

Just because you keep repeating that "am" and "rebase -i" both read
"author-script" files with the same syntax does not mean that it is
sensible to force them to use the same code path when the data needs to be
processed very differently afterwards!

And you can repeat another thousand times that it would make maintaining
the code easier, and it *still* would not make that statement less false.

The "am" command needs to validate the contents and process them into an
ident line.

The sequencer needs to pass the contents as environment variables to the
"git commit" command that validates the contents itself.

> I'll squash the fixup! thing in, and as I already said a few days ago, I
> do not think we'd want v4 (rather we'd want to go incremental).

Now, those are three statements that all make sense.

Thank you,
Johannes
