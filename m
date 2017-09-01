Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81961F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 19:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbdIATQc (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 15:16:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:55952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbdIATQb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 15:16:31 -0400
Received: from virtualbox ([37.201.193.79]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1d9XH91YPm-00qV0X; Fri, 01
 Sep 2017 21:16:29 +0200
Date:   Fri, 1 Sep 2017 21:16:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
In-Reply-To: <CAHGBnuO0dviVr0zD+KqANc6Ju8-cZh2KLbLz6NH3h+jprRzbaw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1709012116060.4132@virtualbox>
References: <oo62vr$pvq$1@blaine.gmane.org> <alpine.DEB.2.21.1.1708302223510.7424@virtualbox> <CAHGBnuO0dviVr0zD+KqANc6Ju8-cZh2KLbLz6NH3h+jprRzbaw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xfBnOfEyizf17aUcfJiO2lubvDTN0eCUC0xMyQUWqySPcZTiqV5
 yhk6B5eCLIIrbrbc8oJS8t8V4nfaAoWcsotgZC8U/O2RjSSAyf3/HBCCKZASMwLRkHKMNCs
 Au60mEEkEvBsxIzOATb4Smo0rHlrqiY25BAjwMVf3mdUVvrZYLFY+a1yT8OwxCzjjEQCLO1
 3KKbj7d3hMy+QtaKjS7YA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/lLqOw0UBJw=:/vuAcOTHMB7KX4IyIACblE
 zVWPxGv8bG0RjeVakCx5WTiV1YxlIUxdNvzQheunq+26LA5GNorMwT0X8mg9RI/I3B6vTfmOc
 bMqvtiYz/xTl2dz+x0AYMZlUTjBJFR4cxGGNBE215LHzddvtW1Jm/atAd0yXmLicGPh+aqmiS
 ehGilUJDX20u8MHfbZg4UJv1CWzNAOXsoZurvGmTMErRX/Vdir8frOAWMqCVWickRjZ2qtjYP
 2IWnmJKaO+FFBxinowdyFscOGwLRWkqWeuuNO77HEr/R7bGy6qYm1H32Sb61/BXOzFkD8hs53
 hy+lKNQ7VzChbdhkHJ6WLf4I7a1Em2StjA9Xf9RYPF50MZqNiOlGjOWi0Lx00ZZbBEk1dnqAx
 Khs1fEGTVBfcC3yEOGIf1ExYuKbOYBKrds2aOxIHfCReYdOrIa/3bjKhE8wgncj0yWYvH67Jb
 uxiQJB4upTpbKvM0X3gnCyzuGA0RkjFqQXKZD0TmxuUjMlDc9wsK1oN5787YDPfpeKNzhgsHI
 qcFQPlbleqIy8Y71b27Mg7i/X740xBAeeppUJjbgP/doIgWihEJOoZRs0r95kDW56siwgaH3f
 H7oyptebDDMkcMvI624khUdCBXHncF6LIq6dmKdX1/OcrcATrMF4pttAloV0K/Gww72VIHcKo
 foCa8O4xU/zscuOEyvGlwCjRgR3JZ2XWBW7YC+x0/AW/wIM3glh42vP6UKGMUDaBx67Y3qSE/
 qLW7QByjdv1F3U+pqddtE//8cIaSWm333m8VavrBF7No4zjKqVyn+nppy2/EJId0e/GZurlZz
 ketdsEkt2ZjQDm6JrfXQY7lU81+udZ2hvftoJqlnLFx5hEXPvktNQjFtBh5do3ByVjvaQZk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Wed, 30 Aug 2017, Sebastian Schuberth wrote:

> On Wed, Aug 30, 2017 at 10:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > Please see 'exchange two commits with -p' in t3404. This is a known
> 
> Thank for pointing out the test.
> 
> > breakage, and due to the fact that -p and -i are fundamentally
> > incompatible with one another (even if -p's implementation was based on
> > -i's). I never had in mind for -p to be allowed together with -i, and was
> > against allowing it because of the design.
> 
> In any case, I wouldn't have expected *that* kind of side effect for
> such a simple case (that does not involve any merge commits).
> 
> If these options are fundamentally incompatible as you say, would you
> agree that it makes sense to disallow their usage together (instead of
> just documenting that you should know what you're doing)?

As I said already, I agreed with you before you said it, but I was
overruled.

Ciao,
Johannes
