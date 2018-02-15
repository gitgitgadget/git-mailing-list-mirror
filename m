Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8682C1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 01:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032356AbeBOBOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 20:14:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:53631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOBOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 20:14:16 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LikyX-1eE9ov1zht-00d2XX; Thu, 15 Feb 2018 02:14:12 +0100
Date:   Thu, 15 Feb 2018 02:14:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <CA+P7+xpg76nP8+KBrYWeYPcm8+0jS_MzL+B=LF6WPfBv44zrwA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802150209390.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com> <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com> <8760718imo.fsf@javad.com>
 <CA+P7+xpg76nP8+KBrYWeYPcm8+0jS_MzL+B=LF6WPfBv44zrwA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jyapwW1cokSeCRvf75CFOgaa7WvUeHvdliGxuPxDMsi0Iht75If
 +y0s+Bvpj21eoDapm76C9Tp6j61INsNmKaX5cU3VtUyMGOZcvWM/NAqZsHpDFLN3mfPUHWD
 V3iIvx5e80f8lLqi/4unOMLZYCyUu65DrltsrxI5MekjfZD4gNMGgTftjJdTBxuBrwO3RIC
 in8ZJu5mSw2MpJ1BzHDEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0J1/FqXvYPI=:jFAXbXxTcrQzoas478FXOm
 LKZ3n/NVd8uvbHxa+wvlPYnaFXRQt6RTfP7gr/Fs+mA+1LLJ3FnMtRXzQYsV0skO1US8ekRt5
 nN2ZN5S2PjhQ18WV1BIs+1a4eO28ndxrbgnO4NlKZ62uzexAMciJx1D7udFJjmWX3Gge8qL62
 7NS26WZMpqoRTne4rEsrzn62lrVNuxCL6Z0UWEQBogKSjQWnz0k7/x48uYiMvgh9xujwssqjy
 CKiClw2nZC0FpT9UMdHppalzuXCkIKi8Ds1wQwfB5OUGLUB7k2RX69eHjyNaouiZi1QZNA4YN
 NHPqI2WKOv7sVeMQI4fJRb0CqUqLfQBODuRGXTdX+nzEsxE7yLG5i7gls4i7yA//nazedNu+x
 D0UXGBZnSbSDGC3aTUlDVM74F/JJDaI6+8O+/nebffy4d5iOM33nvuWhHizoGaFCoTvjr66WO
 FPluDB4wpUIr/e+l42EwHbS3j/pcxkJTWaXZ1MecoXwCTA5qA42NpssQhYUjEBMaCezuliZri
 aPhVOXMDTI+LZhbYE4kjCXCIauI/VRs85i1K65ZhaYLU//i5FE0rjPXHRtoHx2Admkt3OsDsl
 s4XkJ0UhprRPSkVNhy50P3DrWSPfoSdfx1j2iswA1yFKD8mV3o2hMkT0q0sIjFbZY9+IOBfdw
 B7+vhcVw3MHJ5jx6pzecgoXPsOCnJ+Uu3VAU7PVOLISNGbHtgU2kILPDDudducuoVdGVcZol8
 YWr2sJRPndZrGj/T11mFVXTFj0tE3BWC31BKxXua1VqjCGL1SnF3XpV3A8RyH9Gr88odV1mHH
 7T6laxsWx8x4I2r/ZysmmNEJZ1snt9Hhmk7s8k37hJuUdjp4wc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Tue, 13 Feb 2018, Jacob Keller wrote:

> On Mon, Feb 12, 2018 at 11:15 PM, Sergey Organov <sorganov@gmail.com> wrote:
> >
> > Jacob Keller <jacob.keller@gmail.com> writes:
> >
> >> On Mon, Feb 12, 2018 at 12:39 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>>
> >>> On Mon, 12 Feb 2018, Sergey Organov wrote:
> >>>> > Have a look at https://github.com/git/git/pull/447, especially the
> >>>> > latest commit in there which is an early version of the deprecation I
> >>>> > intend to bring about.
> >>>>
> >>>> You shouldn't want a deprecation at all should you have re-used
> >>>> --preserve-merges in the first place, and I still don't see why you
> >>>> haven't.
> >>>
> >>> Keep repeating it, and it won't become truer.
> >>>
> >>> If you break formats, you break scripts. Git has *so* many users, there
> >>> are very likely some who script *every* part of it.
> >>>
> >>> We simply cannot do that.
> >>>
> >>> What we can is deprecate designs which we learned on the way were not only
> >>> incomplete from the get-go, but bad overall and hard (or impossible) to
> >>> fix. Like --preserve-merges.
> >>>
> >>> Or for that matter like the design you proposed, to use --first-parent for
> >>> --recreate-merges. Or to use --first-parent for some --recreate-merges,
> >>> surprising users in very bad ways when it is not used (or when it is
> >>> used). I get the impression that you still think it would be a good idea,
> >>> even if it should be obvious that it is not.
> >>
> >> If we consider the addition of new todo list elements as "user
> >> breaking", then yes this change would be user-script breaking.
> >
> > It _is_ user script breaking, provided such script exists. Has anybody
> > actually seen one? Not that it's wrong to be extra-cautious about it,
> > just curios. Note that to be actually affected, such a script must
> > invoke "git rebase -p" _command_ and then tweak its todo output to
> > produce outcome.
> >
> >> Since we did not originally spell out that todo-list items are subject
> >> to enhancement by addition of operations in the future, scripts are
> >> likely not designed to allow addition of new elements.
> >
> > Out of curiosity, are you going to spell it now, for the new todo
> > format?
> >
> >> Thus, adding recreate-merges, and deprecating preserve-merges, seems
> >> to me to be the correct action to take here.
> >
> > Yes, sure, provided there is actual breakage, or at least informed
> > suspicion there is one.
> >
> >> One could argue that users should have expected new todo list elements
> >> to be added in the future and thus design their scripts to cope with
> >> such a thing. If you can convincingly argue this, then I don't
> >> necessarily see it as a complete user breaking change to fix
> >> preserve-merges in order to allow it to handle re-ordering properly..
> >
> > I'd not argue this way myself. If there are out-of-git-tree non-human
> > users that accept and tweak todo _generated_ by current "git rebase -p"
> > _command_, I also vote for a new option.
> >
> 
> To be fair, I have not seen anything that actually reads the todo list
> and tweaks it in such a manner. The closest example is the git garden
> shears script, which simply replaces the todo list.
> 
> It's certainly *possible* that such a script would exist though,

We actually know of such scripts.

Remember how rewriting parts of rebase -i in C broke somebody's script
because the todo list was not re-read after a successful `exec`?

Guess three times why that script was broken? Precisely: it modified the
todo list!

To see the fix (and the explanation) in all its glory, just have a look at
54fd3243dae (rebase -i: reread the todo list if `exec` touched it,
2017-04-26).

And even if we did not know about any user. What does that mean? Does it
mean that there is no such user? Or does it not rather mean that our
imagination is rather limited, but we *still* should practice safe
software development and use the totally appropriate vehicle of
deprecating, rather than replacing, functionality?

Obviously, the latter option is what I favor, that's why I suggested it in
the first place.

Ciao,
Dscho
