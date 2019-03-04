Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741AD20248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCDMi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:38:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:35185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfCDMi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:38:29 -0500
Received: from [10.49.208.72] ([95.208.59.9]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1hMO9I26Vi-00oFPm; Mon, 04
 Mar 2019 13:38:14 +0100
Date:   Mon, 4 Mar 2019 13:38:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <8e4b7966-7a3e-a081-bfc1-9e60303b8eab@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1903041210410.45@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet> <20190303171951.GD23811@sigill.intra.peff.net>
 <8e4b7966-7a3e-a081-bfc1-9e60303b8eab@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pIV+GFd0bJNwkmApr2F8NrqAGun82Tg18VR63BTD3EZWB5IqiIR
 9QwQlDdqXqFbBIwrkf6I1JxzTCqJKWMFBdcN7T6GmwFyClq88N9+EHU+y/z4Ggcw2Piiifb
 pBF9dS6zw3NqLFaXmOi7g58lC52rXv3yYkv88Oq5zE5D7uEfPZ9UtuXG4s1DGjOC0PINha4
 kQQgSvztl4xFcIb0fnpbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBJ0cr9a968=:EMCt+/CKs/+2j+1pTksns9
 qfLxN1UUgjzqzTYvdKODuP666InhWi07RqinJYJmzExpc5ld8d/6+m+co9ON/qMlehbhbrb7i
 eJbIayxCAcuLTiWVZ00UQio47wLorwPAY1zc2KipWJblC/7TMHG9PenlMhdGjFc90acXDIEbs
 J/wTGA6XOT3sxqrbDayFI3zBDeeIV2B43Q+zS2SfAKDZc2vhESduI3a5clj2fdbAcmUaCOviW
 l+bpLfSiQ+fuiRfObbXZfsAUaXY343pYO3ZAD5pmeavfo3/Kcy3eI907eyXzg9q7CMD9e6asx
 NUbU2XSXLmnPvSBaAZHo49VyXzvoO26AOnqIP7ZCe85DNiVIpRzw+ddN5Ue2eXFimWh+t/a8v
 wUQuOL+VGObRFVurko+vJfls69FLFgubd2teyCEmhQNKtjXNi0jf326RiQwNw9zLhoXzZTmms
 ly3hBFN8xhkcstvyKxW2zStdoyyqZG0ouBAQmwObN8glJOTVXC41QdGLf+VsyleDjmznOOa4Q
 paghZUridTQCzqYribr4xW9zlqSoXnonGPI1hsXY+5iPsS3C8OmdtqNVcXFczIFvAjecpMX1b
 f/gtXgQB+FAX4baI+bbgjqD3NdjIclhhfuRvfhwiw2OKuy9sg9Q1iiN9rWKx2jvHCTyluZ3PR
 KqqJFdi5CwNOzJVv21aZrp+iZuOtKcNQblnksXOfvRWH6Y7YWpF6dYe/jo6Rjaqcat+o1Ewm4
 gK5CAMaG67tW8NF/qIV3fwL+6GdqNUI6HhWqCxVS/TTeIfOP18BP/+sRP4cpfZZbFoBWsn+fO
 sZXH6LnxeBxbOOPiwdfzXNgMXK1FfiklRklpMMNkASsyCV225wie6HT9XpDcy85Z7OklXd13Z
 MSuvKMe/rN/xCtsMBzVAzdXr+st2zeXWXww1ZUSlw2W2s01lR+J3eQ5cBjqAD+rRjItzhSLK3
 WTCh59my32Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Sun, 3 Mar 2019, Ramsay Jones wrote:

> On 03/03/2019 17:19, Jeff King wrote:
> > On Sat, Mar 02, 2019 at 09:05:24PM +0100, Johannes Schindelin wrote:
> > 
> >>> That seems reasonable (regardless of whether it is in a script or in the
> >>> Makefile). Another option is to use -maxdepth, but that involves
> >>> guessing how deep people might actually put header files.
> >>
> >> It would also fail to work when somebody clones an unrelated repository
> >> that contains header files in the top-level directory into the Git
> >> worktree. I know somebody like that: me.
> > 
> > Good point.
> 
> [Sorry for the late reply - I have been AWOL this weekend and
> I am only just catching up with email! :-D ]

You should never feel the need to apologize for spending a weekend away
from the keyboard (AKA "having a life").

> So, tl;dr: soon, I will be submitting a patch to remove the
> 'hdr-check' target completely, for now anyway.

You mentioned later that you might be the only person using that target,
and if that were so, I would agree.

However, I started looking into adding `hdr-check` to the Azure Pipeline
we have (which would make a *ton* of sense, if you ask me), along with the
`sparse` thing we talked about.

So I am a bit opposed to removing that target.

> > By the way, "make hdr-check" already fails for me on master, as I do
> > not have libgcrypt installed, and it unconditionally checks
> > sha256/gcrypt.h.
> 
> Yep, for me too. There is a similar problem if you build with
> NO_CURL and don't have the 'curl/curl.h' header file, etc ...

I think all it needs to do is to pass `$(ALL_CFLAGS)` to gcc (although we
might need to add something like `#if defined(SHA256_GCRYPT) ... #endif`
guards to `sha256/gcrypt.h` to make it work in Peff's case).

But given that this target really is meant to catch all kinds of errors,
I'd be in favor of declaring that target requiring things like libgcrypt's
header files to be installed. We can easily make that happen in our CI
builds.

> The first version of the 'hdr-check' target re-introduced a static list
> of header files, but I didn't think people would appreciate having to
> maintain the list manually, so I gave up on that!
> 
> The next version was essentially the same patch that started this thread
> from Johannes (ie. the 'git ls-files' patch), given that the 'tags'
> targets had found it necessary. However, when I did some 'informal'
> timing tests (ie 5x 'time make ...' and average), this did not make any
> noticeable difference for me (_even_ on cygwin!). ;-)

My complaint is not about the speed in a regular clone, but about *my*
special clone, where I have some 50+ worktrees (that I really like to keep
in the same directory, thankyouverymuch, I ignore them via
`.git/info/exclude`, and I really like to have them all tucked away neatly
under the `/usr/src/git/` directory) and also some 30+ cloned repositories
in `3rdparty/` for random testing (including a bare clone of the Linux
kernel, of course also ignored via `.git/info/exclude`).

In that scenario, my version of `find` takes ages, only to finally even
throw a segmentation fault (!).

> So, I already have a 'hdr-check-fixup' branch (I think I have
> already mentioned it), in which the first commit looks like:
> 
>   diff --git a/Makefile b/Makefile
>   index c5240942f2..3401d1b9fb 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -2735,9 +2735,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>    .PHONY: sparse $(SP_OBJ)
>    sparse: $(SP_OBJ)
>    
>   +HC_HDRS := $(wildcard *.h negotiator/*.h block-sha1/*.h ppc/*.h ewah/*.h \
>   +       sha1dc/*.h refs/*.h vcs-svn/*.h)

But of course that would also share at least to a lesser extend the
shortcomings of a static list.

I still like the `ls-files` method the best.

>    GEN_HDRS := command-list.h unicode-width.h
>   -EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
>   -CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
>   +CHK_HDRS = $(filter-out $(GEN_HDRS),$(HC_HDRS))
>    HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
>    
>    $(HCO): %.hco: %.h FORCE
>   
> 
> ... which drops the use of LIB_H entirely.
> 
> Now, I have timed this and, for me, it no faster ... (I suspect
> that it would be faster for Johannes, but it would still cause
> a problem if you have 'top-level header files from some other
> repo ...').
> 
> So, if we really need to solve the problem, allowing for some
> unrelated headers in your worktree, then we can only use a
> static list, or a 'git ls-files' approach.

Or we can use `ls-files`, and fall back to your wildcard idea if
`ls-files` fails for some reason (typically because `.git/` is missing,
e.g. in case of an unpacked source .tar).

> Anyway, for now, since I seem to be the only person using this
> target, I think we should just remove it while I think again.
> (I can put it in my config.mak, so there will be no loss for me).

As I said above, I would rather keep it, with the `ls-files` and `:=`
fixup.

If others *really* feel strongly about lazy-evaluating `LIB_H`, then I
would *additionally* use Peff's sub-make hack. But only if others feel
strongly about it, because I, for one, certainly don't.

Ciao,
Dscho
