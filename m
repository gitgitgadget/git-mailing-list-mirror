Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E2F1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 13:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeCTN6R (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 09:58:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:52431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753098AbeCTN6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 09:58:16 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB2G8-1eqcnW20LU-009wgN; Tue, 20
 Mar 2018 14:58:11 +0100
Date:   Tue, 20 Mar 2018 14:57:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: abort on invalid strftime formats
In-Reply-To: <xmqqy3iouf4b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803201444440.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <66189602d022dd1911b5f5d98594506b80bb81ff.1521478106.git.johannes.schindelin@gmx.de> <xmqqy3iouf4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YRgc6blDh3kdi7A6KngLFmE2HKv386qf2vla6r3TOsbxEEZsImz
 tvomSpKaWA/Bd8qHhy5gIT3gNqZRxy9wTDV2YrdJXxainaXISeXAA3fkQRpJByurgDXyEPh
 5v/FcAg351Yx/1GaSfTlt349HP1qGKXUeZWybh5qSYPM5/y3+GrWk+Mdj/UriTyYOYxblB2
 CnMWG+7WD0e0qqNtpCkYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qt2FgnsJ2Ao=:IYkwi1bhiE1MSysBHq0Cz0
 fxaHjNBZyD7B0QBnltWgUFGgYnSsTIYQhwnkZtKyYVXdyr/xp4djmBCRFaFh7FX8CWuXrXD0L
 UZwSKLGkSXm/1Rofg86X22i6x14RnuQd7FO9Hj5ePMtFAJIkE67TB1My2zPN6EKepNC1RPOCQ
 4nsKS48mM3EzyeFzHSGdD/WjzjZcaPjhQkuBnjZfwe/AWdAtRLTtd5WI811LHJDnJMewpAXtu
 2lfbaujRJhxcyL0vyWO4frp6S6pkoGIwyzokJoiqxrEfBpqoFRkC/j0tazMRfQ1xDQWVRQBnZ
 1wAaDaJncZWK+EWf8Y1CRLCMtY/zV7zBcSlVkEI7jNDPCq/Pfuv7VXkCRRpVc2w5L6G6huEJ4
 uibX7HwL/YfJjCfvksjTfs3ANYIitqeOjteX54ePjhxW/09gMobtift/iC/bkkrhD5GyxtYdV
 ViFR/EhoZ//vT844d56zx4mM8dOfzdZC1Ovy49YeYKIHM/Xv2+EffeINzXRLiS0Q01aEgVHw6
 Hu7Js8IvKNrrfrhRcECwe5vw77QdvnLMMW9IpOjp6OiNQJB1uKjuIoCqyncguvOkdKDr0TQwN
 zn7okzQUEi01mTDsb+hKiDyVienItsaZQzkYeeTZTH+43iXYVLmli0PTLavEyxN7+bBjLrT4k
 68cJLSDDodMqPLAYgK7GxNzxAnV9vEGV/TNGwH4R1cw3NC8rnPDn4RPboNpPlbyKSQMYUIKPv
 iJAqxnuz1A7nt1Rrl6mPgta103e8USn7Umu/WZvvPXKyW/uSkdBNxWJ7tNvihm5z2afzNkaIX
 ZKhCje7ZfSNclkMtNi4ljbqKLQGjiuL8hWE0N+T7eCxDvX4kJI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 19 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > On Windows, strftime() does not silently ignore invalid formats, but
> > warns about them and then returns 0 and sets errno to EINVAL.
> >
> > Unfortunately, Git does not expect such a behavior, as it disagrees
> > with strftime()'s semantics on Linux. As a consequence, Git
> > misinterprets the return value 0 as "I need more space" and grows the
> > buffer. As the larger buffer does not fix the format, the buffer grows
> > and grows and grows until we are out of memory and abort.
> 
> Yuck, it is bad that the callers assume 0 is always "need more space",
> as "If a conversion specification does not correspond to any of the
> above, the behavior is undefined." is what we get from POSIX.

Yeah, well, our own rules state that we are sometimes stricter than POSIX
when it is pragmatic. This is one of those cases, methinks.

> > So let's just bite the bullet and override strftime() for MINGW and
> > abort on an invalid format string. While this does not provide the
> > best user experience, it is the best we can do.
> 
> As long as we allow arbitrary end-user input passed to strftime(), this
> is probably a step in the right direction.  
> 
> As to the future direction, I however wonder if we can return an error
> from here and make the caller cooperate a bit more.  Of course,
> implementation of strftime() that silently ignore invalid formats would
> not be able to return correct errors like an updated mingw_strftime()
> that does not die but communicates error to its caller would, though.

And I would not know what the caller should do in that case, quite
honestly... Would strftime() somehow tell us *which* placeholder it took
offense with? And would we "quote" that?

> My "git grep" is hitting only one caller of strftime(), which is
> strbuf_addftime(), which already does some magic to the format
> string, so such a future enhancement may not be _so_ bad.

Right, except that I do not think I could get the exact error condition
necessary to know *how* to munge the format further, not unless I invest a
serious amount of work in it ;-)

> Will apply, thanks.  I do not think there is no reason to cook this
> in 'next', and would assume this can instead go directly to 'master'
> to be part of v2.17-rc1 and onward, right?

Thanks. Given that this patch has been in Git for Windows for quite a
while without problems, I think it is safe to get it directly into
`master`. FWIW this late in the -rc phase, I would be very reluctant to
send anything I deem unworthy of `master` anyway.

Ciao,
Dscho
