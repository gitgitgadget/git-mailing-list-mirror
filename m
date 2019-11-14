Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7861F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKNXD7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 18:03:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:42941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfKNXD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 18:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573772627;
        bh=glc9K3RDn5hvi329KbFSSwip3OSBACamhWqr92BdRmE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ifb0FzrpOlSlZxtHI+Y8jokq2UQChP3ot90rkpT4fY92V1IgporZMiup/6Kh2+Ezk
         YjEGaIYYVRYezXWhDFx3FyN9q7RnhwmgXySS2/4MxBnLjDNHQlwzIRF2cAapt30wcL
         ldIdceFy3SN13MJ2XkHpV9gLns7AWm2j7i+mQS6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1iVO9S3SZk-0005B0; Fri, 15
 Nov 2019 00:03:46 +0100
Date:   Fri, 15 Nov 2019 00:03:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Should we auto-close PRs on git/git?
In-Reply-To: <20191114074117.GB17186@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fGzlZQa390c12FH6V4sB6IK1PENM1ml8+9DhgNax5F+q7RuALWj
 TovQoFUfIMwOimKqjC26TjXic1Vs4m7r+o9Shf6VntbqFfbhl6iWqoYQGC+F3U89ZYRtiD/
 0GxSl2Gkp6onjDe0gg7hccjsU9fmSRVitfHZekGqysB03InmHB7h+kZ/yCh5zKO9d52YChc
 N3YUbuHJF2WgxsLtf8ycA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uHBU0ZlZN+g=:v4V4COImdS/pqMiup58YHy
 XVBW2/PqGlAgXkdnJ2gTT2KTVYded+mLG/zH4cn5Sios0Jryk87oP45fTXzvf4HH07IWpi7N5
 5znbSaryPvIEDfjEuvrc9HooHTE+kNgDeyUpsspmuW8opFIVX+daJXmIKUL3VsKUKsFfmYd9p
 q/CvVgy6HqV5SWU6YO3ATo664jcj5Lr/Niz8okCV/Nl68aLRjKWJTItnbxx2WFYv9zkpHq0Ns
 zLKppxTEGTzv0dNvuqQbcFUp1+6Bl2LJQUWZ5fq+tMQI2M95NP8JHkSxh7hNURqhV+fhShG5H
 96CKnt+Ka6J0C/iwgEnJagU0wvce72rup/SisPJqeYSmh+Star1ha5Q36dg3th0U/uMYfzCCx
 8Y8u9kTCaAFeVe9RL673nK20kLZnqlWJb7w9v43NBCA+VXVTwOJxHtQxszj34KX9P7W2Md6iV
 kt/szCwHgjRqYXCbcV0ATZNUbIDmIn1Ns5uiGFdUlR4hzOM+5VHSH29ISODPDMA5l7rlNS+E0
 mBkoNNAs0OYU57L5rvaqFRJ06Kb8LlN04QntOG4sx2MJR0WvWT1EVixosGIvAaNxdWsmiyaXN
 FJnRIJCSIDQp8VRKnFYddR3fZxcmKfKzD7dszutqTyUoauQQmVLzTx/3kFzVkKXPyDNtGXuFL
 2znonQW7CsI8i5RdSP0c04HTfYLSKxAr7ulyi7WOwSyKizFzBfrN1tXWAvwBnGe5rZvZ8Uy6j
 bAxphqh+mzyQ9gr9Ka5v0nov6MR1J0qnGidwuykrAENiwGqxKSWCpH5B7LNXs92wO3o/DNseY
 sHDmB5rJ1UNTrrpdrOo1ymtIO7/WY4KMZ/xGOXMUzbidGtxlNDKwPJtoqJ4hXCGoRs7oKe0dC
 Tuqgi5SWXlglUN4Me/C9jDejWcD6XiFfnek/2tl6cuRdrE/MoTh5K098QQK9cWh0VFLbX9hoZ
 P8VkJ0f5EDZDr6JDmSnliJzpfSVdRLiPaPzp9HGH1St4hflxo8KP2CWdMTEBdKsYQBDvE2W3I
 bOz0uTE+9oUOso7pT2kGdI+a1Q4Y/DOqzoAZYxFv3n1kyUlvjUtB72CBgiY6JoGuP7qcR2uFo
 ge7Xn9oSyy90UHDDJD5fu4eJuPrYthvIujdCqAu2pOtrpLAQOW5vIebDkVS3GjeYzTq91ZaQl
 j8FQdrZjbI0M7QL5586AF+6BFWU7CCXBor+KrdpvaLsPcDVehgPHQf52W1Ck87zWRN8eaKJnj
 FcSkOigmu7QRVhJBwrC4BRy7qnf+Q0YxzQ4wioadYvi+iv6Huc78TAlUsFiQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 14 Nov 2019, Jeff King wrote:

> On Wed, Nov 13, 2019 at 01:04:35PM +0100, Johannes Schindelin wrote:
>
> > > We talked a while ago about having GitGitGadget operate on git/git,
> > > rather than on a separate mirror. That would automatically help at l=
east
> > > one class of PR-opener: people who want their patches to reach the l=
ist
> > > but didn't realize they should be using gitgitgadget/git.
> > >
> > > I don't remember what the technical blockers are for getting that se=
t
> > > up, but it seems like a strictly nicer outcome than auto-closing the=
ir
> > > PR.
> >
> > Okay, here are a couple of technical challenges, off the top of my hea=
d:
> > [...]
> > Not an easy, nor a small project, I am afraid.
>
> Yow. That's a lot more involved than I was hoping for.
>
> Thanks for writing it up. Some of the points raised were interesting. I
> do think we'd want git/git (the repository) to remain read-only if
> possible.

I guess you're right.

We should probably try to restrict the permissions as much as possible,
not only deny write access to the repository.

For example, one thing GitGitGadget does is to add these "Checks" to the
commits of the PRs which contain links to the corresponding commits in
gitster/git (if any). Those can actually not be removed, there is not
even any API for that. So it would probably make sense to avoid that in
git/git.

This would mean that the git/git part of GitGitGadget does not install
those commit mappings. I guess that's okay, they _are_ kinda hard to
use.

> If GitHub's permissions model is a limiting factor here, let me know
> and I can try to bring it to the attention of the right people.

I actually don't think that my use case fits any sane permission model
;-) After all, I want the GitHub App to _span_ repositories (even orgs),
and that's not really the idea of Apps.

After sleeping over it, I don't actually think that it is such a bad
idea to add a second GitHub App with a more limited permission set.

Ciao,
Dscho
