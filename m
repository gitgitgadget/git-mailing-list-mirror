Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D54B2095B
	for <e@80x24.org>; Fri, 17 Mar 2017 11:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbdCQLO5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 07:14:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:50230 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdCQLOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 07:14:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b4B-1cvkhF1Tqh-00CwW2; Fri, 17
 Mar 2017 12:07:50 +0100
Date:   Fri, 17 Mar 2017 12:07:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     ankostis <ankostis@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        The Keccak Team <keccak@noekeon.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
In-Reply-To: <CA+dhYEViN4-boZLN+5QJyE7RtX+q6a92p0C2O6TA53==BZfTrQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703171123350.3767@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org> <20170313174804.GH26789@aiede.mtv.corp.google.com> <CA+dhYEViN4-boZLN+5QJyE7RtX+q6a92p0C2O6TA53==BZfTrQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WlSSUvlsEZiKPjM4sp5tHWpPEFEfd0hskIvYlmZBcRVGJpXRey/
 mVOAMJ++0gPq8kwTj6ZkY1W0BOITdtbrMTwrXBZThnyehc5N6LaUovpb7HnUKh6qUw/HNgN
 yT8RgMTDJL9Dd3sgueeqi42iZftwtj2cT4n97+wYH39UKASXit3szOdSNjpV/jCmZkH1IxJ
 cuW2QbNhDdJDxCPR0nqqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rf1UcsLMy0E=:CwRIHjHgPsSS7JtL0vv45E
 39T9L0adM1IjUxI8WoJP12Tm76/APBAR3IbCXIuXUl3TCHg0YUNV6d01uNlaXsLWG6oF8n8Ie
 JQ7nSVAD5/JR6RbJZ6aBYXNeEfBRmDVsaDwq7mCUXr4VhfOtDCsmR33MSSylpk5lsdAYYCzKY
 oxPyRb+Az2Lk8EB0kv1xoY9x/nWmb3COg04zNGW7Erxx5r/hkrOwt4UMzgPCCq8Lb4nt8MeVw
 y26lKfb9OHh9YURhh4/CkdCc13UzyJHC9N1MGnZtLOXFTFQu86XTcmeSMnj3fyaZ5679x7SNX
 5o0Iz27Pxp1ZVReG1y9f/w6MyVymXT3X3M+2I/a28bxMsYZKeQzuxRAdv+l6mgzzSb2oeiAFW
 AHzmBfTx5Qnfil3aAaDNstc0V/WRp0qpj8Prc84dGyLvyPIv5u//p1pyXQOpvNOyx9gA0/c8E
 vBABHEas/YMcsaG+CLFJ9U17hQ0H34aFEXiymZAmFAZAxfX4hy9kUUvJgZ0IaHnaqLH1hz8Mg
 fTfhJNKSAiYFEEtMHg/h6K9Uemy8WPyoNndPD4X8ooyIARbJ3QZC8qf6Nx0aSsJtz3CLacikl
 V9yOyoM1wNXV4mhfY2DTX0Q1cfxNPcrq7bHj5YNfgl/lPUg0Lq0KUqnnUCN2silUzymlYMXQu
 QzMNBCaQKRNDtmt1ObORp4CvcsWvm5zjFIS+WrnvRycdRc60gnRdYieo/1HDeBOw2RUUx1edq
 ZsIg01cRHwCiisehO1QFreN1LD/MdcyVhferBlH5F7pPmjBVaZ5gS7qthVY1AOBPghrnOLBzW
 i9RDJRL6mAFIC/KV0av9DDB0yssPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kostis,

On Mon, 13 Mar 2017, ankostis wrote:

> On 13 March 2017 at 18:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > The Keccak Team wrote:
> >
> > > We have read your transition plan to move away from SHA-1 and
> > > noticed your intent to use SHA3-256 as the new hash function in the
> > > new Git repository format and protocol. Although this is a valid
> > > choice, we think that the new SHA-3 standard proposes alternatives
> > > that may also be interesting for your use cases.  As designers of
> > > the Keccak function family, we thought we could jump in the mail
> > > thread and present these alternatives.
> >
> > I indeed had some reservations about SHA3-256's performance.  The main
> > hash function we had in mind to compare against is blake2bp-256.  This
> > overview of other functions to compare against should end up being
> > very helpful.
> 
> What if some of us need this extra difficulty, and don't mind about the
> performance tax, because we need to refer to hashes 10 or 30 years from
> now, or even in the Post Quantum era?

If you need this extra difficulty, and if this extra difficulty would
imply a huge penalty for everybody else, it is safe to assume that that
extra difficulty would need to be an extra switch, off by default.

It simply shows that we put too much of a burden on SHA-1: we used it for
three separate purposes: to verify data integrity, to allow addressing
objects by their own content, and for signing entire commit histories
cryptographically (more as an afterthought, as I see it: the Linux project
provides the context where you never fetch from any untrusted source,
therefore cryptographically secure signatures are not quite as important
as the trust between maintainer and lieutenants).

We *will* have to separate those concerns, and maybe even switch to
different algorithms for the different concerns. There are much better
algorithms for validating data integrity, for example, including error
correction (which SHA-1 never wanted to do anyway).

In your case, I could imagine that you would simply require verifiable
cryptographic signatures (.asc files) to be committed together with the
documents; it would be much harder to find a collision where those
signatures still match (or a double collision where the forged document's
signature would collide with the non-forget document's signature, in
addition to the two documents colliding).

Another idea would be to use Jonathan Nieder's proposed transition plan
and simply extend it. That transition plan details how the objects would
be hashed with two algorithms locally and how to maintain a bidirectional
mapping between the two. You could simply piggyback on that code and
provide patches that allow for a third, configurable algorithm, and that
algorithm's hashes would simply be added to the commit objects and fsck
would then know to verify those, too. That would be an opt-in feature, of
course, so that only those who need the extra long term security have to
pay the price of a substantially slower hashing.

What we cannot do is to pick a super slow hash algorithm just to cater to
the use case where legal documents are managed, punishing everybody else
for using Git in the intended way: to manage source code.

Ciao,
Johannes
