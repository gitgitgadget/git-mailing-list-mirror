Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F56207F8
	for <e@80x24.org>; Sat,  6 May 2017 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbdEFVmZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 17:42:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60158 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdEFVmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 17:42:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0BD9B207F8;
        Sat,  6 May 2017 21:42:24 +0000 (UTC)
Date:   Sat, 6 May 2017 21:42:23 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170506214223.GA28534@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
 <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Thanks a lot for public-inbox, my only problem with it is that it
> doesn't cover every single mailing list I'm on, just git :)

Yes, I'm hoping more folks can start running their own
instances.  I notice you're on p5p where I started to
occasionally lurk a few years back.  Is that something you'd be
interesting in mirroring? :)

Some lists I'm involved in tend to be centralized
(reply-to-list, not reply-to-all); so UI changes will be needed
in public-inbox...

> Are you or someone else maintaining some ancillary scripts for it? I
> probably need to fix my patch workflow but my usual mode is browsing
> in GMail & then manually 'git am'-ing some file I find with git-log
> commands.

Not really.  I started out ssoma(*) just for archival/mirroring,
but it's mostly forgotten at this point.  I would rather people
build on existing protocols like NNTP.

> I have one to git am a patch from a msgid, thought I should write
> something to handle a series in some DWIM fashion (e.g. apply the
> latest continuous sequence of patches matching --author) but figured
> that someone's probably wrote this already & I don't need to hack it
> up myself...

I've been meaning to wire up the web search to allow downloading
an entire mbox worth of search results.  But it could be a bit
expensive for some queries and there needs to be a limit.  The
current limit for web display is too small; so maybe 1000
messages per-mbox at a time to avoid DoS-ing the server.

(*) some-sort-of-mail archiver: git clone git://80x24.org/ssoma
