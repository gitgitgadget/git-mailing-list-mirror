Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4061F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbeLTTga (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:36:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:53215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730737AbeLTTga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:36:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1F72-1hORqH3sro-00tG5k; Thu, 20
 Dec 2018 20:36:14 +0100
Date:   Thu, 20 Dec 2018 20:35:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
In-Reply-To: <20181219155107.GD14802@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1812202034390.41@tvgsbejvaqbjf.bet>
References: <cover.1544048946.git.steadmon@google.com> <cover.1544729841.git.steadmon@google.com> <20181218173539.GA31070@sigill.intra.peff.net> <20181218210551.GG37614@google.com> <20181219155107.GD14802@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j+3iBKk3hGfE+SVw8t1t1MacfyszQ3tqlN3TIaH5G/MRBvGCGbJ
 PpEbZ7AFUBJD6FUEaKHuuw6yzZYOc1EQmCaO2lj/of7WVCNfud7fz08DZXVepYW4EkGxu12
 biG/eTZkdtqMtN4mo5ggV2CbLtGt3XD+7jyXrs6EDphrMJPpFHyR5jZfQcl8nnN2GDLUvby
 hmLmNGVstldt/7VmC7vVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5EVsHNzGy7U=:WZ0wTKM2gcNGW5/DQV2D2D
 NLjIImTSkmTCNJa0T/F6Zymcde/SaNt3+uGvyq+Wai2P5Z0nVBgqL0g2iOr1dKKZSECYnMMl8
 WVfyEoXe1q8uqim75Jx1yXIHQJX3NOopliK4F2fHwdfmeP8hxCOW3ssHfzdf0XwmUbf5rrXra
 n6CK5mmig9HuNCd2wRhHFrBZdFO3zupdzZm4Qp1GpPuMKxS0X8Nb5mHQYKQJAE4YDzEN/8kRN
 dkBpyTPFbe63i6Kk2s/Tfjh6ctJCdHW52nYqwlvfytKRuc3+FXGcfgtYnFnAu/a9bhWLD+euC
 X0OIfRsA06ST6qESlYu9JIhJY6RcuCHzc//jlAyH++6L+p+KF+ms09xpBuNbz0wWFn+1ghJqu
 e/6Qk+W3UTbtmygWbpkQQ2HLW/VJzu0lhuPnYFVAXbV7/OtoNHpKkyBj0J2HMKzdwSfAB60ZW
 2XvWF2qbsvQVS0TCpVHPUUbjpqnLrUewzReWKu7WFGSHsLjn09q0HXvjzlT7A6Gsvdwu9R/Y8
 l1YvBWAjOW0j14ggvYW4t9DuSoBhBlyKLy9po4/SC1qxr6JWYEM4p20HhkEAQlXQC1WwjBWW8
 Nhr9z3jnAIyFI9xmnOBa0nvDoi0Y/4NywBFCqNVIKxJTPtc5oeDB/UmeTNtCxT/kqtVokI0Xp
 GyfzAsWULzhZ1sZ6e4Q3QmPgY6xBH1ldkkXdQmETos7OSJIxKA2S94kcvMkq4VHg0oEGfThqY
 Nr8FzLihpYfZgJRDbg0cC0WeYqNqbYVzaRgr2TGYj47lbgeJ/ficvoitmKJjeX5gspnsJNLiA
 HLtZGEYSgCslyz6i2juLser1wqOlhNHfa35Dx8VYNWWGgB7ImDBlrW8rE67ejqsbbtcjQh3Bd
 G6/fEu1a3q/nq0NdK/pifjrx2/LNjZ+z16WWIIW8gupxS4SdOk3HRWSBB4PYdrOW4uB1ORw/q
 yQilZl2l7iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Wed, 19 Dec 2018, Jeff King wrote:

> On Tue, Dec 18, 2018 at 01:05:51PM -0800, Josh Steadmon wrote:
> 
> > On 2018.12.18 12:35, Jeff King wrote:
> > > On Thu, Dec 13, 2018 at 11:43:55AM -0800, Josh Steadmon wrote:
> > > 
> > > > Add a new fuzz test for the commit graph and fix a buffer read-overflow
> > > > that it discovered. Additionally, fix the Makefile instructions for
> > > > building fuzzers.
> > > > 
> > > > Changes since V3:
> > > >   * Improve portability of the new test functionality.
> > > 
> > > I thought there was some question about /dev/zero, which I think is
> > > in this version (I don't actually know whether there are portability
> > > issues or not, but somebody did mention it).
> > > 
> > > -Peff
> > 
> > I've only found one reference [1] (from 1999) of OS X Server not having
> > a /dev/zero. It appears to be present as of 2010 though [2].
> 
> Thanks for digging. That seems like enough to assume we should try it
> and see if any macOS people complain.
> 
> I do wonder if we'll run into problems on Windows, though.

As long as we're talking about Unix shell scripts, /dev/zero should be
fine, as we are essentially running in a variant of Cygwin.

If you try to pass /dev/zero as an argument to a Git command, that's an
entirely different thing: this most likely won't work.

Ciao,
Dscho
