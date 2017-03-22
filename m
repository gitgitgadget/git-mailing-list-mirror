Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E20020323
	for <e@80x24.org>; Wed, 22 Mar 2017 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbdCVOcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 10:32:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:52815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934312AbdCVOcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 10:32:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYtId-1cdLCi2x2R-00Vj9i; Wed, 22
 Mar 2017 15:32:35 +0100
Date:   Wed, 22 Mar 2017 15:32:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
In-Reply-To: <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703221530040.3767@virtualbox>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com> <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com> <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com> <alpine.DEB.2.20.1703212105030.3767@virtualbox>
 <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iResz/tptX2ebnDo6Wozk6uIIWWpUZME6ZNVL0Qut8az6elHQo3
 v5NewJx6ForuAEWAfb6oIZ2LsLnErTR9Avvgd5UzI4B9C/hj/STW0hwMmF50H+yUhI1OcwY
 WpePgG/Log/Unt0WoQzLjfQ0PwHdmbmH8Tu46//ZDZtXNU4FYBO7IFtMlUzuom647ka0W+p
 oSPXqcVrRDlUQVCqDtuCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M2NYkJnL/hA=:WiYiDRKXGqFOJx1EPvCvU5
 m85znQFW8QxeWpjUAgBAXLmTOo6xP5Go11X0R2VAd29OO4ncQicGJRFCR03wJL2GDGRzWhY0t
 xIHZqeMFmYj9kL7y6sS523a3378h0PYAKNcxmO0934HFxz96d5pvkH6pIejVqbivkIUlNcrOw
 oUuZ2H0QNdPn0lkDRkTBS/gUNV7fwRTon/PLxJqj20YkdImhlqm+s6JESyqf9YwPRts3DklxW
 qx94FGAaUlguMP9nYCA5/8GZC72RmWNOgdMMOK5sQ9OyWL641Z3ow/BYayAqukOUwjJgfMZZa
 qPLAX0whTvHaHTtJgt84jwCVKNtplLpt3HWlASHz252yC6r91wAQNyEkyD3RJ2dO6z/uv0B3H
 ifWRgb82ozioKti+IIxIUAsxM9GPUmrpQNYggzqfQ1S8CAg2arNkr4cMNLNcROluqkTEe5IZs
 cabSgaxH7JOT8BzGvAbszIQv8OOVfROytoO79w1EfNh9R0N6qrWAkugwK2xZOpuUTK5nx6JmT
 EW/5rzdGV8UujTiqhiCOvsrR6Zom2K1/GzFK/VLsmfsDeq2HGSXo/TPysHN9SR6jLPHyAt+pg
 QumOafW5PBAIAqw+zASNj32o1Le3xBjZDL6yRO87AX1kVBoSEgWnHA1S/NszXpbKeKgAthWXp
 hy5VA+n5HyFd5S5S8fxeMpgJl511NE+m12bS9TWnK5PYuj+GX2oLO2BsjMTGOWaqctUktABW1
 8pUA4+rwNYcz2eVMUlnktmB2vbecJxpqdixC3SXQs5mTb2lnIs9OqnrysCN+hZKnmRTwGmTDg
 VlgQm9eHkLcAgxeCPyLeKEAPRA06A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 21 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 17 Mar 2017, Lars Schneider wrote:
> >
> >> > On 17 Mar 2017, at 11:18, Lars Schneider <larsxschneider@gmail.com>
> >> > wrote:
> >> > 
> >> > Would it make sense/have value to add a job to our TravisCI build
> >> > [1] that compiles Git in a few variations with some high profile
> >> > switches such as USE_SHA1DC? Running all the tests for these
> >> > variations would probably take to long but just compiling would be
> >> > less than 2min per variation.
> >> 
> >> ... or just run individual tests instead of the entire test suite for
> >> these variations (e.g. only t0013 for the USE_SHA1DC variation).
> >
> > The best solution may be to open a PR with .travis.yml patched to
> > enable this flag. And then report back to he mailing list because the
> > gentle people here are not that used to paying attention to Continuous
> > Testing :-D
> 
> Actually, the best solution may be to do nothing ;-)  With the current
> incarnation parked in 'pu' (or I may have already merged it to 'next'),
> without any explicit VARIANT_SHA1 request to $(MAKE), we default to use
> the DC_SHA1 variant.
> 
> Those who are paying attention to Travis would have noticed this by now,
> I thought ;-).

I pay attention mainly to breakages, and that is already a lot to pay
attention to. Thanks.

As to the default of seriously slowing down all SHA-1 computations: since
you made that the default, at compile time, with no way to turn on the
faster computation, this will have a major, negative impact. Are you
really, really sure you want to do that?

I thought that it was obvious that we would have at least a runtime option
to lessen the load.

Surprised,
Johannes
