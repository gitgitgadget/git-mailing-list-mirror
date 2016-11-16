Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44478203C1
	for <e@80x24.org>; Wed, 16 Nov 2016 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbcKPJup (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 04:50:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:62220 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932565AbcKPJum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 04:50:42 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjua-1cFmX22HD6-00QWGm; Wed, 16
 Nov 2016 10:50:33 +0100
Date:   Wed, 16 Nov 2016 10:50:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
In-Reply-To: <xmqqtwb9wywp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611161039590.3746@virtualbox>
References: <20161111201958.2175-1-dennis@kaarsemaker.net> <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com> <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com> <alpine.DEB.2.20.1611121106110.3746@virtualbox> <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
 <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com> <a3db4c55-550c-f2e8-83b8-46c2be86f7da@drmicha.warpmail.net> <xmqqtwb9wywp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RsPvwW207ilJvGMdVePVDBMaFZuvZ8hmWZ8AFH8+yzjBRfiI8ji
 hfe9RZwIwh+C2KGYb9smNpXOSutPPBS/OfXFwHrW3g5YAyVgp763vPQZr4l2XH4dWJWBLVG
 JxnAnSItUAJ5dYlbRrwbvEzAGbQCB6XWaX8MyZiKLV41eToGNmPGWtYrX2qDHBC56M1WyPD
 1akcG3J3l28m+p/I9h/hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GSUtTga9dbo=:3S56o0WtPaNk4cw/l8tai2
 V22I7HuoqFNDf5ycRUoa2qplh1loYy7L4QWqLdHmvlCRdjbtjz2oTZ1Je+i5hHIGpYM4WQ2hH
 yhJmUG+FAVMT/LDyIQK0aeS2YgJl4UusHI375Ofyfe6jnwChmYX2NKEL/+GjLcJl2XYOnbqeO
 A3AAmyS7eF4LO/9ocClVCcsGI6f4z0el/EgguVokkGAHQ2SG/ujZHov33FKxqXOwJ2IGaROGe
 Cih7eP33SgCHQdfIl9Yp7on0njTxXmMoMgtI7IME+3U6oXNS2d1hLYwHtZvz7eIuLTrJF5PRe
 J6lnDnGihWbhhCtDeANKpdVEkIGU5qoQhLW/yMHilRUFBasXQFzU3BCludNBdCw/pThf7W5Wf
 l6x+dsZ4qyP4ctfSW1Dr5g7T6OWRgSVFY2n4O3+ETH0Atxk4DbKoSnOORwv0hrFxB8nDnkmBS
 ByqcEC6wx7YvSUlz1gCqoBR46xubKXY/nM6t1Tbvyn+gsDEpZko0XJZcKUOfKOhNGsi1yOq1b
 Nsef0M1pTBeA2dqoA+JVYHPKI7h5XuTDdXFV3WM7oiy3ICtVa6A9Q1n/i/TB4U4TdAUVQ4qTk
 HWp+HoqsQupehwUbjmb92tn7OnzcdBgAA1J1cvLmIWPCpTnky2mLO7Z78B+Gmh+cF/Zgi8hNB
 fzSHy0/d1PKK+JCWwS93spKCOgnMxzj3BchsPZbeNSjfXaoFuhroimxF2JMwOblk8U+qTvgLE
 mjPkGyoOl6MMuXgRXlrW51cEmnB+Q4EZo2mswGrrEJmpMXvUo6LdvUP5S2w4YbtVlvBKjOfan
 Q9f4WJS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 14 Nov 2016, Junio C Hamano wrote:

> I _think_ the no-index mode was primarily for those who want to use
> our diff as a replacement for GNU and other diffs, and from that
> point of view, I'd favour not doing the "comparing symbolic link?
> We'll show the difference between the link contents, not target"
> under no-index mode myself.

If I read this correctly, then we are in agreement that the default for
--no-index should be as it is right now, i.e. comparing symlink targets as
opposed to --follow-links.

> That is a lot closer to the diff other people implemented, not ours.
> Hence the knee-jerk reaction I gave in
> 
> http://public-inbox.org/git/xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com

Let me quote the knee-jerk reaction:

> My knee-jerk reaction is:
>
>  * The --no-index mode should default to your --follow-symlinks
>    behaviour, without any option to turn it on or off.

But this is the exact opposite of what I find reasonable.

Ciao,
Johannes
