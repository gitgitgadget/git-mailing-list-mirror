Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78EC207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1172146AbdDXOIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:08:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:62198 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1170861AbdDXOIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 10:08:42 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8di-1cctWJ3AcQ-00Px59; Mon, 24
 Apr 2017 16:08:33 +0200
Date:   Mon, 24 Apr 2017 16:08:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <CAP8UFD3QJ5irxNZqn__CqXPgi+uY4vhZ2HyrNu9RhScbRU0LOA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704241604030.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox> <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
 <alpine.DEB.2.20.1704221319580.3480@virtualbox> <CAP8UFD3QJ5irxNZqn__CqXPgi+uY4vhZ2HyrNu9RhScbRU0LOA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NPID236GWJXJOgb+oK36/+lte2BuwYu6cJ3qWNOOBPSMEtxHSYU
 lf6mnAEVTdvhUpP0pY1M9VEKYR0G+mskHhQr1J6/INkmezAzjuwfKkCBE8YQLQMRCRF5QWp
 Rrvr8E1DTX4GEEzziYWWKbbJoJsh6zoOkT/vzIOLFmfnIxB/zBOCav4W/xxCZfrGiYjENNJ
 xbvUj0D2j1II5Gajjl3LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eKqc03m+nHE=:8kt35Unt6ZImabywxREQi+
 sNhGQxAZSJRpdqXR0U7r7vxeZ6y5e9YODvzr0jQZ8/7aoDyHzyGMKoQtsqQK9Hq/JI0rHP7qK
 KjgRr8hT+KFhKMIKRZXr1iTkgRPWeb1SXOiOGxmR3JoseMGNbE7hxPosl/eW1ynRXG4v1pMi5
 KJr2ZC2O7LylvjBHH3iH5mKuLd9ivFySxqYB488oK+fwciyHZJnDaPLhMn6BJIShvBo0HqUq4
 /N9brTzhJ7LilewnVtsbjMGwIHFEbqVPWK06G2PubDB+mf7P2dQqTcEMsK8PolByS8RLa/B9C
 byTTkTq08boCI7IQqm3Xcoh6/nynyOX7ucB//7/kLHxNpgWArPJXZyx74+gfI2uppdJXl2y3h
 wcLRxroU+O4zx0XlUi2ImT/L6TEHI//qNvlsuqP7FZJJkmYHtNSbnvcaouJuIZ4RrwdPpC4R9
 dhS/xBpVaxejaal8KmRAeqM2MrttJWWUYroRiZ8q48mQULvHVgRuMeYG8AgRUBWQZX9spdhBe
 Qe6wwtD4xNHILxlZ8skL+kuWxLR7BE/ryMBM/NcAYdoWLZt5UhT9wcOVNQjIWc1qx7WHaQSvb
 SJlplcgm2cjD5nhmlZ4TefUChs/dapmtsmaCPzXtrIAORbV8CL4zQ03quWNZc8+mea8hIRzT/
 XBCFE/PEZdQjIPIAzYizhJVIDDR39wfD9mCej0xZePKdVk+I6MFFkPwZoNgLQ+nxwCcwwTNtG
 W0nn3DsQrIA4vmVDY0uDGu+sMVPJ8fp+O3QSKPM8AYPv9KGRvJwwV0Q7pyEWm9eearhOXoqba
 XywWB1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Sat, 22 Apr 2017, Christian Couder wrote:

> On Sat, Apr 22, 2017 at 1:48 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> First bisect should ask you to test merge bases only if there are
> >> "good" commits that are not ancestors of the "bad" commit.
> >
> > Please note that this is a stateless job. The only "state" I have is
> > the branch name.
> >
> > So when something goes wrong, I have *no* indicator what is a known
> > good state.
> 
> Maybe we could consider the last release a known good state?

You mean the latest release. I would expect that we won't have a last
release in a long time...

Using the latest release as a 'known good' would not improve on using the
strategy I chose, as the latest release is at most up-to-date with
maint/master. In the case of `pu`, for example, it is much better to test
`next` and use it as a known good state if it passes.

If we had a Pull Request centric workflow with one integration branch (as
opposed to four), it would be relatively easy, as `master` would always be
expected to serve as a "known good" state, and it would be the policy that
the build has to pass before Pull Requests would be accepted.

But we don't, and that's that.

Ciao,
Johannes
