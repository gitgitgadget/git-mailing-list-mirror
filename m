Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD5A1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeGDJZX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 05:25:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:34891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbeGDJZV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 05:25:21 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBFBB-1fR3mL1bdd-00AJ30; Wed, 04
 Jul 2018 11:25:16 +0200
Date:   Wed, 4 Jul 2018 11:25:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: as/safecrlf-quiet-fix, was Re: What's cooking in git.git (Jun
 2018, #07; Thu, 28)
In-Reply-To: <xmqqd0w4ryi1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807041124330.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807031344080.75@tvgsbejvaqbjf.bet> <xmqqd0w4ryi1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8vgftBmKl33YKcjmKhwmG+oB25U++BKgPgbgmbCAGzEqowvKNLY
 G/SEOaOcVFb+zrUMQVUlEVi4GIVep3eeoO83RLUaQYie+gRWikiWTnL0TlzffaowLSsDXXJ
 zzpRgfAa48IjaAJnn0j7V3ogoxzu9kcPsNdV0hUDMWyT2wRIhPjyuxCW3oshuhmNhp4IVM1
 lL6CTgh7+5/soUGy2El+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yTtjdGGgSrE=:pdL6XVLHpjn6rjE/V3e/eu
 hzynZNc54f+9mb1XfMjR6ZGs1M6Ql4pV4pMrzsyk6p/mnxVKVCqF0JphlrTkqPwtmKWeUtbk4
 KDwJ7dJnHJbNIjkO8KctsoHM/o+nwwj3mdRQipMSLCKWZr5V4KEUZM7R1m1QG4WOSzwr6MDMu
 ZhqotxlalpXR4FxxYkshDAeedpLK9GAQuBrsIGMVzDOfOJzjUz+UOUTUujyuC0yAgsgXDZti7
 Puzjw3tTLPdjfKDd6eMEV0EV8mT500x+qMB9XBNdPCKuuBV9S92B73Hbu5zFyfK4JHUtfbcL6
 ErcNLyZ7Km0OznGZ3UVeXoc+gMH1SnaO2DvhpBLhUd7pDkpM/mg6yI8FBHDdla36TwTwD9w+G
 9u7dZNaGGmeJJdIxlmxaOWb5GODJ9AFwGoilEGByoeMSkeNXjyMaQNnw/bi/4+igK8UrK0vB4
 Q0LeJkr7sRlDw6pkYBHzyaukkIXthpB/C9Wf4pT4TAr+YDw8rJ66Nta5LjFTmV/E3zWNM4Ys5
 jnYse9bc8grM11e7ZCTO/LxoD2yLSFZLcUrLlgyoAzU+/G695M9fTnqrwUf0PoXAS0UrjR1dY
 p4Muppjq6sfbOMY6bfYBzE3U2BUd6XB7Gm/kVbQOajvqhNG+fQjJ+z9SazdYt8D6gtuZnaVqH
 2bMwdKGQop8/quz6eH9Cz3rojA6ncsNLKFQ7ZS1ZJECINXvM+sQJGMJUhI2TUQD9TnOZfWwI+
 aS33AhsPT2saOQdVnJWWqHsQqZHU/Qkm/kAszqCDGyvdKj2aqk8MRvzhS93zMDLUoYtPjOnyk
 1geDMWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 28 Jun 2018, Junio C Hamano wrote:
> >
> >> * as/safecrlf-quiet-fix (2018-06-11) 1 commit
> >>   (merged to 'next' on 2018-06-13 at b163674843)
> >>  + config.c: fix regression for core.safecrlf false
> >> 
> >>  Fix for 2.17-era regression around `core.safecrlf`.
> >
> > Is this `maint` material?
> 
> Possibly.  Why do you ask?

This is my feeble attempt at helping you triage. My question was more like
a suggestion.

Ciao,
Dscho
