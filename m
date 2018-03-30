Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28BD1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeC3Mmw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:42:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:51763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbeC3Mmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:42:51 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLO9y-1f1LOs1aEM-000c8C; Fri, 30
 Mar 2018 14:42:40 +0200
Date:   Fri, 30 Mar 2018 14:42:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 4/9] t1300: remove unreasonable expectation from TODO
In-Reply-To: <20180329195218.GE2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301439000.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <5801f7529465b7dbdfbe3c105e2a8212c253ba0d.1522336130.git.johannes.schindelin@gmx.de> <20180329195218.GE2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q7K59rIRB3IVF27rA3llnWhMi3qkrny99hSAJdbbObQE3UibrIX
 cWlvzywzI2Bwi/KgKsBMWYqco/s71VoercKYeCIkTiXQFEKbxr/Dhf3AoNWWzEuLxXPvRIs
 /rNbd77sMJEaKzh+BwiXWGnJHBCMj8NixLIdfrTKsBd1k4goam7gZspkBNC6pDIqHzEclLS
 qR6WkEZ1h13JuMmTgV5cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EkM7UGH0bQs=:bAoyVXKcK6AS0s24KGhHov
 cfNheFOKXVjDmVfkSL/BG7EMtKWByJY/fR1ud9Klef3ZZDMQNNyX716ZeVpQ7ZuH9xhjeQBUl
 6+VZVXLAXEegnc8cjoDvtednxMX/NCLCcf1iSITL0BKyYRr1u9VsGzIiRMeE6OpiWOspYgSRd
 Aps13Wy/SKbJAXzLSulIH4UrQxCMIcfhemOLw8pO3cTt/gcCVi7N90lO868PEYdU+jJV0mMN2
 gY8bUXabczus+SoYL0ccXoYoflD0sCJcEGvONrnyjpF/vcP9kdDPJ7H5XtsTe8orKCMo5pIxN
 lYcac5lkiM8R3kyPvJcAOdt/gqEilmNmffOtNJKT/LO/4iFeqhi05jnv0FiFqSNvTiivhAifO
 dS2L1mOcrCL1Qg1JYe1UTKaVGhf+GTiTOqRx4KfjJt9+ks1yNm/tQLsn/zobiGIIeKoirW3FF
 3hGHsb8zghRD/4PoZ++DOxr0uXifPaxyiQ2iQ3L+/x+zYhFa9ObpLYG8KdaARmvSiyFX0JkcJ
 9QuRupDEouXHx2H4H/DLGnIKQZudcs7/Q5dnr9xHEHdqINAFymHg7wd1BtAFmRZtTZ1BmrbN8
 J2m2s+78+oTO/sL+IgqSrzlFm4l5awx65eMwbl4xzxfp6GwK/iDoNWCrEtmSbcsnJ9cyagIj9
 qP5+a3reKIBijvr8KSwne2txin8ozt3tVP1TA85DhEsOB/sZ1sDoWYqowi+46R+Ost9lIlhiw
 xcmxmrCubioUI+kfhcw+UHZmFspWoXu9cRh+xf6lIdSgeBA9yd8XD0hMrNc+W5ALzgOS+PfQE
 o+dFHu6K8F+X6d/HTF+LPEbRf375QHY3QQBVKhYz8i9fZSG4mmnggkTOHCkQ1pDJVaHTKXi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:18:50PM +0200, Johannes Schindelin wrote:
> 
> > In https://public-inbox.org/git/7vvc8alzat.fsf@alter.siamese.dyndns.org/
> > a reasonable patch was made quite a bit less so by changing a test case
> > demonstrating a bug to a test case that demonstrates that we ask for too
> > much: the test case 'unsetting the last key in a section removes header'
> > now expects a future bug fix to be able to determine whether a free-form
> > comment above a section header refers to said section or not.
> > 
> > Rather than shooting for the stars (and not even getting off the
> > ground), let's start shooting for something obtainable and be reasonably
> > confident that we *can* get it.
> 
> As I said before, I'm fine with turning this test into something more
> realistic.

Good.

Of course, I worked hard to come up with a patch series, i.e. I put in
some effort to placate anybody who would be offended by my accompanying
rant.

> An obvious question is whether we should preserve the original
> unrealistic parts by splitting it: the realistic parts into one
> expect_failure (that we'd switch to expect_success by the end of this
> series), and then an unrealistic one to serve as a documentation of the
> ideal, with a comment explaining why it's unrealistic.

As stated before, I think it would be a mistake to mark up this
unrealistic example with `test_expect_failure`. We do, after all, suggest
occasionally to grep for that when somebody asks what they could work on.
And you do not want to set somebody like that up for failure by pointing
them to such a "bug".

However, I did keep the example to demonstrate the expectation that
sections with surrounding comments are kept. That was very much intended.

And the reason I did not change the unrealistic example? So that it is
easier to review in our patch-based review process, where I try to avoid
hunks that might distract from the intent of the change.

Ciao,
Dscho
