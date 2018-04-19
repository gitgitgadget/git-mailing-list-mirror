Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240741F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeDSMEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:04:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:40741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbeDSMEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:04:06 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lf0M7-1edyjM392t-00qkQc; Thu, 19
 Apr 2018 14:03:55 +0200
Date:   Thu, 19 Apr 2018 14:03:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 05/15] sequencer: introduce the `merge` command
In-Reply-To: <nycvar.QRO.7.76.6.1804140248110.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1804191402060.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <8a5ae61f603df8d8cb19268e1b8470f0a4993445.1523362469.git.johannes.schindelin@gmx.de> <55216d0b-cb37-6514-7f80-91f4617c105d@talktalk.net>
 <85232331-97a0-7989-e095-854ed962c7a0@talktalk.net> <nycvar.QRO.7.76.6.1804140248110.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xjJi8yQXbLF0AL0qeGXKAU37HAOM/cjXI1zmyL1N4y/sFlxhyny
 KHDEWi67wZas8b9faPAre4kzDffZxWd3YT8IZDsGEY/nXb7dflviiQVS1e1xgfZ0VWlHcoV
 NMT5b6/TAWHxgyQp1GKH16yGXHul5hNLutc3TgsG0fwP73bIBjichjhv9B7NXAZp5g+V3cx
 i5OvjQhU9wjPeNssSUcWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r8tRbojXDYc=:+/LEovHlkuI0YETk4XACjv
 jX44Zoj0DnKFfTkV1kCR3fNmHlDMSYnL3/+Xq8EYyW3O8aN4+xu8EwxvCh0mU2d6ICUENzvf9
 ZaTV4+2DctjFx1j7AXjIEs+3/qOsdKldFE+dt3Y1jZlBSfq6mzL5g4f7y1b5jaVItQRFnXkHB
 e2E99Hq4r/aHKTys1rfHlyqc1+AXu+8EG+G49qDFkLcqeDXPLVUGnkKBaqGmcL1jXsCLcx4eb
 Le9otYwB7L8dSwUkWk73Wr7hYVgXbt4dte7TuZie83HqxCNCM+IBEk/ED56h1Bi00r403rpCD
 D/liUoZGi/yaHgPfX5POkjPuoBw35el/6u7HJ2ssLCy7/WA1crNx53q2UcbHnNVPBthd/RcB3
 2zNHKHsZ1dLNiBJdTC+vUbJCMKIjsxxgfo2+E2G//ErpA+1CB7BLxjfUzjH68UWAy3lgncetm
 BEU/HGhb/hIimJdjNlguaj+3xswW4imjJb8ivA0hdqwa1GoWvQrzyjvvVwsAMg5GS6lPVIMM7
 B4pZ83CeOtmXusZtjp5YHF8tsfc9F0O5LFLcZTE2z7pBAYYJzOJep7VvCgOY4bJx1EoYCyq3t
 P7SxhWtR49u37uydLIf8/agBtjomK5M24LC2CtB6ZhCwNKhYA4Mnp7SjtHoeNdB0x+PfDFNEh
 xMEQQmMUTdiiGSsnLJIhXB8bftG+Q5tfbjQFqZw/h4YMnbXfbWERXhx4LPGdRgS6/f+6fB5qU
 ciJpM3wF4s54Hur4Coa3uQ0LrD4lQ0EePVPsvff4ltbWCfrdsPiz7o7HByY71vYx8MLUy2dhK
 lO/4nOkEZewqi5HjxwlUBhWpkhF8fkP9PxC3WljzTLCax0qOjo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sat, 14 Apr 2018, Johannes Schindelin wrote:

> On Fri, 13 Apr 2018, Phillip Wood wrote:
> 
> > On 13/04/18 11:12, Phillip Wood wrote:
> > > @@ -3030,7 +3029,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> > >  			return error(_("unknown command %d"), item->command);
> > >  
> > >  		if (res < 0 && (item->command == TODO_LABEL ||
> > > -				item->command == TODO_RESET)) {
> > > +				item->command == TODO_RESET ||
> > > +				item->command == TODO_MERGE)) {
> > 
> > Unfortunately it's not as simple as that - we only want to reschedule if
> > merge_recursive() fails, not if run_git_commit() does.
> 
> Correct. How about introducing a flag `reschedule` that is passed to
> do_label(), do_reset() and do_merge()?
> 
> Seeing as do_reset() and do_merge() already have a replay_opts parameter,
> we could add a field `needs_rescheduling` and pass the replay_opts also to
> do_label().

Nevermind, we already use the trick in do_pick_commit() that -1 means:
reschedule, 0 means: success, and 1 means: merge conflicts (don't bother
rescheduling).

It just had slipped my mind; I use the same convention in do_merge() now.

Thank you so much for your review and suggestions. I *think* I
incorporated it all.

Ciao,
Dscho
