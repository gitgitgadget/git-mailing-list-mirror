Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC31520803
	for <e@80x24.org>; Sat,  6 May 2017 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdEFUuo (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 16:50:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54668 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdEFUum (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 16:50:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1A8FD207F8;
        Sat,  6 May 2017 20:50:42 +0000 (UTC)
Date:   Sat, 6 May 2017 20:50:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170506205041.GA26189@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I have no idea what Jonathan Tirado wrote; it was encrypted (but
 sent to a public list).

Samuel Lijin <sxlijin@gmail.com> wrote:
> Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:

Hi Samuel, check your Spam box (and move it to a normal inbox so
they can train it).  Gmail filters are known to trigger happy
and incorrectly flag messages.  It's been a problem on LKML,
too.

> - Brandon [RFC 01/14] through [RFC 14/14] convert dir.c to take an
> index parameter

Ironically, Brandon is a Google employee and Gmail seems to not
like his messages.  The only flag I see from SpamAssassin in
public-inbox is HEADER_FROM_DIFFERENT_DOMAINS which happens to
every message because it's relayed via kernel.org

Maybe Brandon can escalate this internally in Google...

(OTOH, I noticed a thread/mbox download bug in public-inbox,
https://public-inbox.org/git/xmqqmvaq702u.fsf@gitster.mtv.corp.google.com/t.mbox.gz
only shows two messages out of many.   Will need to fix that...)

> - Johanne's Coverity patch series

Likewise, but he also uses freemail domain (nothing wrong with
that, but it raises one flag on SA).  I noticed at least one
of his did trigger the RCVD_IN_SORBS_SPAM in SpamAssassin, but that's
a common problem with all freemail providers (including Gmail).


Anyways, I'm glad the SpamAssassin seems to be working well on
public-inbox and would be grateful to know if there's false
positives and missing messages.

One of the major reasons I started public-inbox was because I
lack faith in my ability to run my little list server (with
mlmmj or mailman) and be able to successfully relay to the big
providers.  Anyways, I'm glad it's helping readers of git@vger,
too :)
