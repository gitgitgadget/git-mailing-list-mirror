Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5C21F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406179AbfFKUhr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 11 Jun 2019 16:37:47 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:37376 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391937AbfFKUhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 16:37:47 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 6FC2E200407;
        Tue, 11 Jun 2019 22:37:40 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, timcharper@gmail.com
Subject: Re: Inclusion of translated git manpages into the packaging systems
Date:   Tue, 11 Jun 2019 22:37:39 +0200
Message-ID: <7802960.VzbTMjdsy5@cayenne>
In-Reply-To: <xmqqmuipmett.fsf@gitster-ct.c.googlers.com>
References: <1979608.xhrAu3A07H@cayenne> <1835964.yutTd2aTbA@cayenne> <xmqqmuipmett.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 10 June 2019 21:15:58 CEST Junio C Hamano wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> 
> > I can provide an archive comprising the precompiled manpages so that 
packagers 
> > don't need to mess up with po4a.
> 
> That's an interesting thing to hear---if this effort eventually
> relieves me from having to supply preformatted manpages and HTML
> docs (after all, en/C is just one more locale from your point of
> view, right?), that would be an excellent news for me ;-)

I wasn't expecting this one ;-D In fact, the translation project is different 
in two points:

 * Not all the sources have been copied; only sources for some manpages
 * the en version is the source for translation. It's not compiled (why 
bother? it's already done in the main repo).

> 
> The last-mile packagers that are directly facing end-users would be
> happy to have a place (or two) that they can pull the pre-built docs
> for these locales from, and they would not particularly care where
> exactly those places are, I think.

BTW, who is using the preformatted docs? If it's useful to anybody to have 
access to the compound of en + translated docs, such repo can be set up.

Please note that Johannes clearly stated that git-for-windows cannot afford 
more weight, so English only manpages are still required.




