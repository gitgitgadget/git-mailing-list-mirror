Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235B81FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 12:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbdBGMFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 07:05:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:62984 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753451AbdBGMFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 07:05:11 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcSWg-1cC9103WDO-00jsVJ; Tue, 07
 Feb 2017 13:04:52 +0100
Date:   Tue, 7 Feb 2017 13:04:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>,
        Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clonebundles
In-Reply-To: <xmqq4m070xua.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702071303370.3496@virtualbox>
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>        <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>        <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
 <xmqq4m070xua.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DzpSBKEvqU4DVftMkvsn6qzkfb+nS5YI4inADe4VLbpsO2/mewX
 /yf9mXiExO7yK44TTp8zUABgMoMndGneWpFZKBC80w+FiQ2s9NeZFHNiexyVsYCq9ZmYBRo
 8b1yOehs39/58uWd+qxMVCYGUEo7dEkaoipvWGzJLiVlk0mh/B5XjmlqPDZmxH0ZbQGxbz/
 1R9VyI1HScfmqohmHDAuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RhM75GKLje8=:wmo5kW/3JfiWGh3WHJM7d8
 FRBgvUfDbEaqvvW97FaaQYsZrN7ygWMVqusa5QhliyKNY3XhPdXjQN2MBm3W9Tuq5u1Zn+Gka
 CsJgGypfjoBUxVPmXi0Osx+DMZq86fypkExDrtvnT/8YZVOLxm7hHP4jU9sm94x4EPTPt02Sn
 jVtcaRvgptEyPxWrrE+E92vV+UGBzDgA1l9uoGnn2/xl3HadVl/8/VwiDYGlmE7yWp73b/l5G
 hVFFqc5AzMgsHT3NpgaVHO7F6xC/kGq6bh0klgDg9pFJud12Fp4DdCQ7qng2jmXd0/2EGr3H5
 Fsi+iEb5MOnMIAqBp1UekpyTaPVcedSV2lrsWhUvAyRzmJiHG20IhlybZlnakUtkZdfnr1D5f
 420crmvQp0rI0j0qtSd/ow7TsJnHDVCXafC/YwFBVNfOZvxkIgMvKMbpn87LhTKaEWqann4n0
 U/bYlPxU7q36y5iZigTYFFjstx/XlCOwSeCaJH/GmhYOVucYNv784s+JAvIeXldJVjwyEdtSZ
 mGP2DzxBi0bCIrIP4yDgBXf85trHEFTCdiLv5U1N+NIpLfns9YMmZzpIDS2MjYQ1dw1S29cOS
 42BskR/39KtVo0B1Ew/5l8IWaq8ieCSNxF7EqXAy7TIHN9t9f+tu3EN/9FWLJ3mcFy4P88sK9
 Padf/Rka+Gfat+iH0mbH90mR8Dt9RCVm4C2564vhfFwiAo0ITmAPh+ra3+87oMXZzZC8IcdZW
 2TS1v9IZDED0pMOI0XJ1Y2M9S06luruST8Vk5VOSXobmXq0sNxU5Jifz9IVrLhX6AiHxYAzd2
 6qnWrqC8Uq3koktEtvNUDoou6wur++aBhphpjINiY4Y2ZIQEAn+fEo4n3D6pbO3s0JFn/8JlG
 b29zlOPdTopX9uvteEALKl3n+sGucGMBOxKjkOnXEvyKjb/oey1MV9wESCopFO+aMZn1BNr7B
 gMWzYccpIhxmidPTuwC5JasAX9XXC2KUvzwsq08oitf2Qt+P3Es4YeS9pGvgJTNCc4RTGRXTA
 NNQvxHrCMJG0tClXcGfjW9I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Feb 2017, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > There is also Junio's work on Bundle v3 that was unfortunately
> > recently discarded.  Look for "jc/bundle" in:
> >
> > http://public-inbox.org/git/xmqq4m0cry60.fsf@gitster.mtv.corp.google.com/
> >
> > and previous "What's cooking in git.git" emails.
> 
> If people think it might be useful to have it around to experiment, I
> can resurrect and keep that in 'pu' (or rather 'jch'), as long as it
> does not overlap and conflict with other topics in flight.  Let me try
> that in today's integration cycle.

I would like to remind you of my suggestion to make this more publicly
visible and substantially easier to play with, by adding it as an
experimental feature (possibly guarded via an explicit opt-in config
setting).

Ciao,
Johannes
