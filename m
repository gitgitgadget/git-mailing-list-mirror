Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373B11F9A9
	for <e@80x24.org>; Sun,  7 May 2017 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756612AbdEGWJ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:09:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45660 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756487AbdEGWJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:09:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 66CCE1F9A9;
        Sun,  7 May 2017 03:24:17 +0000 (UTC)
Date:   Sun, 7 May 2017 03:24:17 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170507032417.GA7838@dcvr>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
 <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
 <20170507010537.GA21703@starla>
 <xmqqfugh74mn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfugh74mn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> As it is a pain to access gmail inbox via imap (I was told that
> something called "offline imap" may alleviate the pain, but I
> haven't tried it yet),

offlineimap isn't bad; I've been using it since 2003-2004
and can say it's easier-to-setup and more reliable than
isync/mbsync, especially with not-so-great "IMAP" servers.

offlineimap also has specific examples in the docs for Gmail's
weird IMAP interface.  My main complaints about it are high memory
usage and slowness.

> I tend to use NNTP interface to either gmane
> or public-inbox almost exclusively, so like everybody else, it often
> takes a message hours before I see it due to this throttling.  I do
> not see the message I am responding to on public-inbox, and I am
> responding to the copy I got direct from you, for example.

Looks like vger is down, my mail server can't make connections
to it on port 25 at all.  Good thing we have a reply-to-all
convention here :)
