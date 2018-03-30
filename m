Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80BD1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeC3S6b (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:58:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:57733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752635AbeC3S6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:58:30 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2ckv-1ejUyT3TYj-00sJY9; Fri, 30
 Mar 2018 20:58:24 +0200
Date:   Fri, 30 Mar 2018 20:58:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Luciano Joublanc <ljoublanc@dinogroup.eu>, git@vger.kernel.org
Subject: Re: Bad refspec messes up bundle.
In-Reply-To: <xmqq370h4h4b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803302056570.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com> <xmqq370wvugk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet> <xmqq370h4h4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MFaQpuqDlupiBcZFlM3pCLA2cs2CvTppcKjvRBzFrYxnL+d4KHG
 ectk2VtrtsglkJvWaBAICKscgb4q3jD8is27+8VEYl6+0oRurrQwRjLEiDtE06ZmnOKvNJb
 EZ68xdMgUMaOhyOFGF/roQUGlo1iMpiwG9Tytk6NKOsua+/n9niGhVOC1qX6e+yd17qbMTP
 bhh99GRdrk3QigtdXN9Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fFFCxI4hIf0=:GVhmk89QCVUHxce69RuVqK
 gMJ71Y5q/qp3wny5laNIqWVX2/6A8sD5Z8F1u2770o7VCGrAdZFEOCn2xk/cthPUaIHtaKL0l
 DsERVBowRF5VbIZ0k4LuOK40ZoSNFhLpvMMH4/+WLZ4/FaIfWjYqgw+MKx1YFf0bwv3wku7sD
 n8rKVukJ+gt8rdz4N08hhZ62+fJ2Oc3kqolmZl/fzVv65tFPCSr5RuSum13aYIVcgkIknv+JR
 rLm3Bm8pyDwxHnoKVhtMH0tLZ3AAxmPpkER/sKaLrOiZp+8Fsi3DxNBJYTHvoIXEG17zHdMuu
 Hjj7fEZ0AGU74VKdEBF4LFqr7HAGEUbM6O+O9atZTPJ3LSvX8Ns5uvBa5GOu5i6jzz2LOPxGF
 H4iyLAy1e1tUTLGYrwtnYNCHBIE77jeUGK4jB6bLoLANvS+GKdChEM2BOq0z5VGlJCkdcmUkN
 bKXLJ81hPghTAndiv03mJoIwHSK4fAv36U8K3uzfl8ug+1GjGghgWRzRSx8C2yNb+AezMtuCk
 xgZLbOH3n2h03PYECf3MWoH2CCMYZWogW1I+Myq5RQLB0tXT+mzK7MX3p7sttudJF6g1MqTaX
 xbdyJt3oNxlvVTNB1IvrX76J9zejr4Ko74Rm9OBOc5yK8nRKv3eLqoFtMu8Cn3Ad7IIsSItyl
 lIJMm7hfd3LUGT11+ekWUyIoSI5RXw1ccCdY7oeqUYFe5ywrGpoZ6XQIZYVemgMLhLl15wCHN
 RL8wiOYugDoHXCC7wM/zSZVUllYAHqAFKwmYYzkt6uAxiLVEeLE4nrMJBBFbX7wUsZn97DoYv
 QJt8XBwBPUZ5dIkrQWDcYe5L0kJ99R+kqxCM9AH0Pzzb7qh3OTkSeBda9FfvqYwRHxMgbN+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Is this a bug? Should bundle allow providing multiple refspecs when
> > ...
> > I agree that it is a bug if a bundle file records a ref multiple
> > times.  Luciano, here are some pointers so you can fix it:
> >
> > - probably the best way to start would be to add a new test case to
> >   t/t5607-clone-bundle.sh. The script *should* be relatively easy to
> >   understand and imitate. The new test case would probably look somewhat
> >   like this:
> >
> > 	test_expect_failure 'bundles must not contain multiple refs' '
> 
> s/multiple/duplicate/.  It is not unusual for a bundle to record
> more than one ref; it is (1) useless and harmful to unsuspecting
> clients to record the same ref twice with the same value and (2)
> nonesnse to record the same ref twice with different value.

Of course! Thanks for pointing this out.

> Other than that, the outline seems to go in the right general
> direction.

Excellent.

Luciano, the ball is in your court now. If you get stuck with anything
(such as getting started with building Git), please let us know. We can
help.

Ciao,
Johannes
