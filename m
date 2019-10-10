Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D12A1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfJJL7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:59:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:45325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfJJL7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570708727;
        bh=98iL7+bxsGJIVAQyv/n13D6/fn7AZcKfD1ERmszPMeo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gDRQ0lPL4O8HDbgDusciFyTsmO8UC3e3RDmpXG6A4bN4t36P5533qATSU0FLvUil4
         io7HshMpu4u2KeLgDZWnKDHHs109xs3SC/9OaykNAEvb/3o5qJw0OfShK5q1IRIio3
         ypJGoQgQQfB/gfhQ3HY6OcAmdhG7SW1AsYM8+X7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1hyNoK3rnm-00ti9H; Thu, 10
 Oct 2019 13:58:47 +0200
Date:   Thu, 10 Oct 2019 13:58:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] xdiffi: fix typos and touch up comments
In-Reply-To: <20191009203847.GB7007@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910101358020.46@tvgsbejvaqbjf.bet>
References: <pull.380.git.gitgitgadget@gmail.com> <cb677310cecd52e853055e93a75b365a1d133968.1570559270.git.gitgitgadget@gmail.com> <20191009203847.GB7007@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QNbpK+FY5lWLrLgM2PTVhhLXwR4FvjXA/M6zB69aPzrOwixZZUh
 QHioYtxSYKGQYKeRTzfIpPNXrrA/R9xSfDYq7aiRh4mT8xAec8pqa6vPIApBOJHJLIAWTIj
 eqXrDArouNf8qhRgXOwAR+RXeqwhceYQn5s5V5Ifa8gL6IBFCoqEVLfiZar3yVl9U6fe0BD
 7cjIW+G4j9bKo1R06lFrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/zJ7GzlooZw=:bB7xgSRv9OD/loSeVwiX0C
 ykNQI4QCvIr6qQUd9PFL6tC2W/NCj85QNosVbU4Mq27dvj/NA5GI+WsTgOY04FanuokZmXtOY
 bAJ+dlKkmpUS3fj1WfMqzIldE/Dco2l6Pf2kCXMMrVuoqS8b6R/pn3fpeNFgBGsmG6K9JIjPX
 7faaFmuUD5/EVeDbWDKzcoxTDm6c2ItVeY01+UGT/uhbOz/U2Ozi6jJ2hripHg3BNiF+2kRHt
 UpHuAT9SlKppHV63PrCmxEYp7wZJnfB3DzJ/piSEBnYaOpRP2PLI6pRyPa5JcaDFyyLCVsodx
 oFfmHA8SXu8JTL0+GvmXr0lDUFOdL1gMSgjQNwPfDfrEWf69uqXU82RVLnO8LO30SM7vdfde/
 s1+h12hbWajSW3RbdjF9VosGEPTuZxqXogu2z1erO4KkygwXqFnei1t+2v4BLD0MauhdohgRN
 OFB7T0ppZoZ16Q70YhuUfwIJbB9nOcOSdzbDZSPsSamEohivIRxUKL1v9FkUctNO8enS8kdxN
 8douQCIZz1PUZuY0+FxzjI/THRQVP220/eltmoe9Y8rLD+3Hko+siYqOtSOR6dXZpvxyV2Qfi
 NEsUjKq9BQKf4kk6N/c/caFmjaFJ4ZcrLDOJKoOpd0V+WhS5n0A26oxCrBG7UUqZxnlXMGEBO
 uSsD4TXGTucI6TDdHr+ekQgVp4CqCt9YdtnVpQHSmKZGe7yYIwgUgrk4YsnSIylVJ3bbkroGO
 JpD71HzlLsqzJYziowUQ+s6Sy7roptY5dnBRa3SjAvwv8BbWaYtAO/ytmszZYD9WaXEhJ4yh0
 eyfMYtElSgn2suKxmmVptB2Wfs18dHdangYv9oqOaOqwfmne6K1/b1cn+nMW7cdsqNuFSNwQg
 dA4ZUup9+Bn1hYqKpP1n4Q4TATe7NlapCQ7kL3f1L+Y3elTRsAV2I9kMN58i/tXjNQgKAHCtQ
 HtMabHAzcjPzy7En9AC9ycATLXzHb4P1ZCyw5L0JHOywkH0WG2mtn1IcM0WH+gFIaHX48tuBD
 zXXMThSnoJF85d+4COWW+z+rWt6Vsay4poXKXBZYg7ZjXM3eVaf3jWbX79vWZJrjX2PM/PSzf
 HjXmcI6J8Np2jH7s+2QQLaaH56GSMj2P2Or54xtoRxq3b8qg01AUAYtBPTTkfIrnp3S4Jgo7A
 Pt5OKbG6vS+OuMgHpLK1vlFilTax3exrBL6ELUDkomJ/lEoA6OlgpjCLLCK2l1qL7AAEMOpUf
 vVyak4I/PTO6IFAjDP+4yrwzXaDMMvI315mS+01jNP6HX9mLD4X1VzF//NTo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 9 Oct 2019, Jeff King wrote:

> On Tue, Oct 08, 2019 at 11:27:52AM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Inspired by the thoroughly stale https://github.com/git/git/pull/159,
> > this patch fixes a couple of typos, rewraps and clarifies some comment=
s.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  xdiff/xdiffi.c | 99 ++++++++++++++++++++++++++++---------------------=
-
> >  1 file changed, 55 insertions(+), 44 deletions(-)
>
> I scanned through these with diff-highlight, and they all look good to
> me!

Thank you!
Dscho

P.S.: Darn, now I really have to find time to check out
diff-highlight...
