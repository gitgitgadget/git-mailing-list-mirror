Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21571F404
	for <e@80x24.org>; Tue, 27 Feb 2018 16:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeB0QV1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 11:21:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:43697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751943AbeB0QVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 11:21:24 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpbJm-1eCRIW2GxS-00fT4B; Tue, 27
 Feb 2018 17:21:18 +0100
Date:   Tue, 27 Feb 2018 17:21:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tXilKFHUm8c614okpqsh/VdLVz8MP+p9oDDn4qbtQyWy2JA/Dd7
 KpdLGu6YoyGQUXMis9HX5m/G5f7GvL3OkMVc/poK9VIu5i4ZCeE0h7F52qirs5HbAjNFJ/L
 HpOOwzGcApBjgT8teP8Zk/laC+mXLY0lmQstdac3j9A1ncqfMpy8mTwMJpXGD5yGevJoRxC
 b3EEDypBoSExrHfWiXLcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jzsmGnEZlj8=:+IbpQR++dlVdfleBu6QY33
 Qn1P86ZWz/TseexNB3CDopoJt1J8wYrr1UH4SCrKN2I588Xh2HSWBuYeAU/yYbCVkEoBps/N9
 WuZcf3divslxD3J2Ba0/UPJfL8ISFcmtxv7BfNLxkboRDX7fZX9T3vauEwRfCLdywQfeIZtYZ
 HNZ/q0bOcTf7pvOPEOzeUJO/1WGzJ3PY8G2ohhihBc1ovhE+4qPnSxUwlE6S0t8WQgHnHh1Se
 G5LxmoBllD2rX/rIQnxrTBoVdqtdh/BdgY376Zjy7sXLu+DVtBXMCT/+bDTivnaKVCN9aAeNO
 VFPoc3m+d1A8Qbbn2SOih6kDpD4UqCtj8oau6FyrEcG2hQWedyfyVyywupRE1EA35zmrJmgZN
 S2XC2HV7tfavLisVEA3m890Cn1sxvTvDI6IbUCHlqTE0jN5GqL+AHjoPirFWCxhOLPaIA99hf
 9fbfdUVH1K0ijfDDYBvNfCI3Nx51MvCOnVeXAnqjuuD9dB60nmJld0LIxMScQsQCEaLIAgMmL
 b1V2V5Vfexfl/h43OgfRZ3SBYZMiowUxay+vGT+fZ+ImkC8RV5SGvprXiS6LCTul3UilSa1hl
 ErKPk5PCvrbI2LAsDuX9nHt+j14w69uY0VRBgaQJb8so9EWBp2t4WlX0Q3uh8+AVSchOd/xmn
 zTeQbMXsrQX0jcqn+8+8lLVGcpU24LyPAIe727M0HHZMGd2FJnHuW8HYY52fDgrLRi+Yp3onA
 PC/Uqc/br5TWDt2LnxMIuw5PinTs8fTohLFd8Me8LE8M+30jEOkbbRswJ0wT3aq9sIpiPsyvO
 Jx32TrNDP9kEo8oJwqfiJPiK6KFJj1z3PwwyG/8IjWe5ktSAYyWpeHcPUEio+ANuXP3Bnuq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Mon, 26 Feb 2018, Jacob Keller wrote:

> On Mon, Feb 26, 2018 at 4:07 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 20 Feb 2018, Igor Djordjevic wrote:
> >
> >> I`m really interested in this topic, which seems to (try to) address the
> >> only "bad feeling" I had with rebasing merges - being afraid of silently
> >> losing amendments by actually trying to "replay" the merge (where
> >> additional and possibly important context is missing), instead of really
> >> "rebasing" it (somehow).
> >
> > If those amendments are what you are worried about, why not address them
> > specifically?
> >
> > In other words, rather than performing the equivalent of
> >
> >         git show <merge>^! | git apply
> >
> > (which would of course completely ignore if the rewritten <merge>^2
> > dropped a patch, amended a patch, or even added a new patch), what you
> > really want is to figure out what changes the user made when merging, and
> > what merge strategy was used to begin with.
> >
> > To see what I mean, look at the output of `git show 0fd90daba8`: it shows
> > how conflicts were resolved. By necessity, this is more complicated than a
> > simple diff: it is *not* as simple as taking a diff between two revisions
> > and applying that diff to a third revision. There were (at least) three
> > revisions involved in the original merge commit, and recreating that merge
> > commit faithfully means to represent the essence of the merge commit
> > faithfully enough to be able to replay it on a new set of at least three
> > revisions.  That can be simplified to two-way diffs only in very, very
> > special circumstances, and in all other cases this simplification will
> > simply fall on its nose.
> >
> > If the proposed solution was to extend `git apply` to process combined
> > diffs, I would agree that we're on to something. That is not the proposed
> > solution, though.
> >
> > In short: while I am sympathetic to the desire to keep things simple,
> > the idea to somehow side-step replaying the original merge seems to be
> > *prone* to be flawed. Any system that cannot accommodate
> > dropped/changed/added commits on either side of a merge is likely to be
> > too limited to be useful.
> >
> 
> 
> The reason Sergey's solution works is because he cherry picks the
> merge using each parent first, and then merges the result of those. So
> each branch of the merge gets one, and then you merge the result of
> those cherry-picks. This preservers amendments and changes properly,
> and should result in a good solution.

I saw your patch trying to add a minimal example, and I really want to run
away screaming.

Do you have any way to describe the idea in a simple, 3-5 lines long
paragraph?

So far, I just know that it is some sort of confusing criss-cross
cherry-picking and merging and stuff, but nothing in those steps shouts
out to me what the *idea* is.

If it would be something like "recreate the old merge, with merge
conflicts and all, then generate the diff to the actual tree of the merge
commit, then apply that to the newly-generated merge", I would understand.

I would still suspect that -s ours would be a hard nut for that method,
but I would understand that idea.

Thanks,
Dscho
