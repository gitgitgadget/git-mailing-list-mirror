Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A796E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbcHXPtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:49:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:54420 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753440AbcHXPtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:49:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MF9WR-1bNWWg4711-00GIkq; Wed, 24 Aug 2016 17:48:42
 +0200
Date:   Wed, 24 Aug 2016 17:48:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: core.autocrlf, was Re: [git-for-windows] Re: [ANNOUNCE] Git for
 Windows 2.9.3
In-Reply-To: <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608241743460.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+pXt/jxahbVzPk/weVnG/2q2IjXRXefQ+qz9qwr7qamw8Ci1lm0
 kP6b7Gch1uQZV0RsajPvwPPqKxvr+zjtU5eb5Rm/yj48LkddrXRdmN/kq82sU1eGdeNHgb3
 CTx9yPijNSnA1eBQiwqy/84r9fn1Uq2ZD2vFVz8wuxwE0JoS/NT9MZqqFI5a11Q1v1wP0fZ
 QDNxhbu8wI6WHlFbwZewQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dNfwUUzpJ+g=:m7f04kmPzVlzBXQcFOF82A
 sofwW3b2gGMNJAnTWKFhhXsGrcHYFHDCW3uJ3j0vdQa+PwY+hOHIII9isPy3P4FwBjSsB0jSO
 4jKYDGTmU8lfUBubatpIzThNwhnLT8vPs1Ki1ubvAnNY13glP+UkXK/b0dzzuib5z36g5yBUI
 JVAzRIhbACVccczFfmd4sUyNmFss+rkBKXZeUIzwUVWvKZle6tc1PA+FEx0h2X0yDmq1qlGOO
 1O4HDbpay/Bmqf3445nTpGxvz76tf6ZDgkyfaUiVYe4tKzAQAKIhQnrWmdUsEWBfKm4P4yRfV
 3rb5KD8QUDLzRLLBf+01Pc7VYjZb0Ac46iaT9P249SuaVJ/IZMj7wF5YRsPG2VThwSqxm7rf4
 NqzVS7JCaMSGzketSVuT7oC8o4qGYrkGHy0HSJLEqTsfkxTvkCo89On7mdO5IWhBieA+zInfM
 mUTJ2c2e7rpCxDSEoewPVAJocQ4+HJ3d+p/Lycyab0SEFOeVOyuxHlSmva5u+o79TKG4K4It1
 8AEwD0wHjK39g7I0kqWEqZEtJ3dOlN2ZQTm/TkGLC1vQFusAVxT0Ef6V6pjNTUsY4XWzUjVMv
 VrbgTbUpYkv8tnWFOpHCKpWA1ZXbLDgr0xktUcIi8HO/Xa4JfWQ1dpyDssigMQhFyrZngtZKi
 b1OWEqHN133UCUGSz2o3oakzeLdHrA3bA915p7Z5lkvT5wjP6aLRyuJ0rOhjVpW9V4VkpqF4W
 vPc8xUvOEQqgfSMco1GoenBaoFkArYkE86i8rVBUi6sxNOT96OGyum/37WTnmxkCPVTsysCfO
 BkNMIsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The feature in question is also highly unlikely to be used as much by
> > non-Windows users as by Windows users due to the unfortunate choice of the
> > default setting for core.autocrlf.
> 
> My vague recollection from some years ago was that even among those
> who were active in msysGit development there were people who
> advocated for straight-thru and others who wanted core.autocrlf as
> the default, but I do not know the current state of the affairs.

I remember this very non-vaguely, for I was one of the people advocating
straight-through. I basically was shot down by people using Windows more
regularly than I did.

In any case, now is not the time to lament about this.

> In any case, in the ideal future, I would imagine that we would want
> to have "cat-file blob" to enable "--filters" by default; that would
> make cat-file and hash-objects a pair of symmetric operations.

I would advocate against that. It is not like the terms "hash-object" and
"cat-file" even *look* like they are opposites.

The main problem you face with making --filters the default is that it is
a possibly costly switch. Too costly in my opinion, just think of git-lfs.

> That certainly will not happen within 2.x timeframe, and the new
> "cat-file --filter" feature can appear in 2.11 at the earliest, but

s/--filter/--filters/

> I think by that time (or with a few more cycles) we may have a
> handful other improvements that are backward incompatible lined up
> to urge us to think about bumping the version number to 3.0.  I
> recall writing "Will keep in next to see if anybody screams" a few
> times already, and they are all good excuses to invite a version
> bump.
> 
> To prepare for that future, we would probably want to start updating
> in-tree scripts (including the tests) so that they call "cat-file
> --no-filter blob" whereever they currently say "cat-file blob" in or

s/--no-filter/--no-filters/

> soon after 2.11.  Of course, if some of them currently pipe
> "cat-file blob" output to munge it to produce what --filters would
> have done (I didn't check), we would want to rewrite them to use the
> new feature "cat-file --filter blob" when we do so.  In short, there

s/--filter/--filters/

> won't be any "cat-file blob" call that does not have either --filters
> or --no-filters, except the ones we write specifically to check the
> updated default behaviour when that happens.
> 
> Would that sound like a good longer-term plan?

Apart from my objecting against changing the default of cat-file, it sure
sounds like a good long-term plan ;-)

Ciao,
Dscho
