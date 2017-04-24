Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D380207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S977639AbdDXUhR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:37:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:39261 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S977631AbdDXUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:37:14 -0400
Received: (qmail 24712 invoked by uid 109); 24 Apr 2017 20:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 20:37:13 +0000
Received: (qmail 32500 invoked by uid 111); 24 Apr 2017 20:37:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 16:37:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 16:37:11 -0400
Date:   Mon, 24 Apr 2017 16:37:11 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
Message-ID: <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 08:22:36PM +0700, Duy Nguyen wrote:

> Off topic, is it possible to receive mail notifications from Travis
> when a fault is found in either 'pu', 'next' or 'master'? I know how
> to do it in Jenkins, but I'm not familiar with Travis and there's no
> obvious button from the web page..

I looked into this a bit for my personal builds. Notification config has
to go into the .travis.yml file[1].  So I think the best we could do is
send a notification email to some mailing list, and then let people
subscribe to that (or it could go to git@vger; I don't know how noisy it
would be).

-Peff

[1] I wanted to set up an email just to me for my personal fork, but I
    couldn't make it work. AFAICT there's no way to override upstream's
    config short of adding another commit, which would mean I'd have to
    base all my branches on a "fix up .travis.yml" commit.
