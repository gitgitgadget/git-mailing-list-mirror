Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BDC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF60020732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G6Y9C7t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIPSnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:43:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:41121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbgIPSn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600281797;
        bh=t60puDZbEFU9sgf2HuZISqvJM7TBh5G8SZ9O0Ol3fCQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G6Y9C7t61U8MT5jJyGOecmDWoxy7oshnDFZ9NnS+bMX2UGUXEt/R/9YdY2l+ZIUdI
         Wwr2bX4TMCeVzLXYxasICW8kgRdjrr6X6V4cIkc7dRSZuozBtpZ5p8kyq4UVB+CKN8
         eCrsG+d3fSVMNmu4MgxtTp6aIcY2CTe+wNuISuQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1k8tc80shR-00PhuQ; Wed, 16
 Sep 2020 20:43:17 +0200
Date:   Wed, 16 Sep 2020 20:43:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <5be2fca8-2dbd-115e-b3bb-5783daeba4a3@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2009162040420.56@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net> <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com> <20200903060041.GH4035286@google.com> <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email> <nycvar.QRO.7.76.6.2009060933480.56@tvgsbejvaqbjf.bet>
 <5be2fca8-2dbd-115e-b3bb-5783daeba4a3@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9sYkaMvsU3C6ZqNlKaZnJ1pvA9yM2otp+sTeLle2ALcwzq3dLs1
 otun9T8a/Ya6bGODn1rtGR3we4rN4PGXsaNf7qSIHVK0/Ot/35L8XETihY3iVnPhCkX1Qze
 9e42sGEvlPu/TvO3YGnInJs7bKIu84/gAd73zUQsEwIHGTrgDelrwWyjiOmu6qzbMSFj0/L
 2aO4mrQv4/M8YF7Djhymw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wbf2w5/4jrE=:zD9CN/ngqFc1kvqj7cUTcv
 l3NT/eZOGJaAXJxX+qaC9LYKwkWrhRQAnws23gJ3aa0bPEjEp+a2GYG2+Oh7jdY0lWHy2XPqx
 rvbqrjZRGlbV26CBB1sZfZaX7kCZvQSpNJwl8MeNYXVF2t/qXA04WtWodPtexXlutElfklGmH
 SIgmF9T98uAWDOj4caA4mmsGKByELPHhVQXtyIE1UMaAwxkdDx2GZo/V4C4MHsc8LBwEEQOnK
 refEvqBGauozzk8J1zLhs6YcVijhffOpEMGdvmhQHJRsqXAoNZ41asOtcYmbaEczCn5cctOry
 UNxE/CfJFjGsZqvszJizOZZlP4DBIm/Z+HMzvypTFUpXCU+7ILbSY3vDKCT+KMdzmJtm5J0Ar
 JhP/mvnCvKj7Pxa9h1NADxhMMM0SY/pQQ5urLPYEIc5DJesQ4VhZIPnMNO/oBLMCgKtWF1Khg
 R+WOa8IIVIuPHeF4CEUPPqrvx/B3hRvJNJpoVu1IZUL8wbyZim+YtvRYY+QytQRm4X0KN3KZy
 ylw+8hI85E8VdGtPqg7J05uQ5YZjABYVDaIZ0RFdjEYtP4G+/WPsMq3PvHEHLypFPwkzR3Xws
 8N2XFoWZ/M/pTQYNUTTUKCj98QJNXgMpnk47CUYVBjTUwl4jiWhR+8vwxVGx7PB2wRtjg9GXd
 FpxWV9oztUoBEcDc5Lbjh8exCpLog/7jN4Iw5IClXlFlOYxmjoFVv6Nx5iaoqw0UW8UkZWNTL
 sYoPCExW3X7l+YWzxJOpf1gkr0a2wKB8n3REZYwpUikha7wIi82BYpgpZ7s08ZIVVTJqwD3pw
 +4N+9PP4WyopU4t7yVVSW7IzArucR5ADk80vIpkrYDsH+/67rsSGapqIHo4FfYT5AeFMI0Bet
 zLW2kK2sC7Hpx7GyQlaGr8+Hvn90YC8+qzCQ/amRD4L7Yq2WPzLPxlLD68XtSv19TvW5ZNrUW
 DMBZx3v4Yn51oE6wXhQQ22FGfTh0rODMuIS1ULkWnANwdml90yvoOuAMWtj2+alaN75W0270L
 D1CLUy3zmHf8wBCkXiiMZYQpe/wBcR0yB3WbFrKlnHsci7pfR1rOSipYfNmJ8dFl6akoBMQtI
 EJV6OfpJzi/pXgULB1y0qhut1MPKI8xnssmdoD2EWuXQuLAvKvzuxHQGyBnxRUTbWvv4LQdni
 45S0LceKgeNVK50dW5dS4nxlePlbDG9LqOP3kJgIC2rm7IFHlLjDslkWNJF04OUaq4rQNSZAv
 mAG6ZWEmCKF7P6UwTEjcCy+cZcnC0MN4lXTUe8g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Wed, 16 Sep 2020, Philip Oakley wrote:

> On 07/09/2020 19:49, Johannes Schindelin wrote:
> >
> > On Fri, 4 Sep 2020, Philip Oakley wrote:
> >
> >> On 03/09/2020 07:00, Jonathan Nieder wrote:
> >>> Christian Couder wrote:
> >>>
> >>>> I would appreciate help to find project ideas though. Are there sti=
ll
> >>>> scripts that are worth converting to C (excluding git-bisect.sh and
> >>>> git-submodule.sh that are still worked on)? Are there worthy
> >>>> refactorings or improvements that we could propose as projects?
> >>> I think setting up something like snowpatch[*] to run CI on patches
> >>> that have hit the mailing list but not yet hit "seen" might be a goo=
d
> >>> project for an interested applicant (and I'd be interested in
> >>> co-mentoring if we find a taker).
> >>>
> >>> Some other topics that could be interesting:
> >>> - better support for handling people's name changing
> >>> - making signing features such as signed push easier to use (for
> >>>   example by allowing signing with SSH keys to simplify PKI) and mor=
e
> >>>   useful (for example by standardizing a way to publish signed push
> >>>   logs in Git)
> >>> - protocol: sharing notes and branch descriptions
> >>> - formats: on-disk reverse idx
> >>> - obliterate
> >>> - cache server to take advantage of multiple promisors+packfile URIs
> >>>
> >>> Jonathan
> >>>
> >>> [*] https://github.com/ruscur/snowpatch
> >> A suggestion with high value for the Windows community
> >> - mechanism to map file names between the index and the local FS, sho=
uld
> >> a repos file/path name already be taken, or invalid. [1]
> > This suggestion keeps coming up, but I cannot help but highly doubt th=
at
> > it will prove useful in practice: if your source code contains a file
> > called `aux.c`, chances are that your build system lists this file
> > specifically, and it won't do at all to "magically" rename it to, say,
> > `aux_.c` during checkout.
>
> I'd disagree with that line of reasoning in the sense that if someone is
> on Windows wanting to 'view' a repo that was developed on Linux, with
> colons in pathnames, and filenames like aux.c we shouldn't be
> deliberately de-include them just because of those file/pathname
> 'accidents.

If someone wanted to just have a look, they usually make use of the web
interface of a Git hosting service and look at the file there.

Even if somebody insists on cloning the entire history, they can easily
look at the file via `git show origin/HEAD:<path>`.

The most likely users who really need those files to be checked out are
the ones who need to build the project, and that's simply not possible
with "magically" renamed files.

Ciao,
Dscho
