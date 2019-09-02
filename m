Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0951F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfIBTvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfIBTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF0CEB0E6;
        Mon,  2 Sep 2019 19:50:59 +0000 (UTC)
Date:   Mon, 2 Sep 2019 21:50:48 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Giuseppe =?UTF-8?B?Q3JpbsOy?= <giuscri@gmail.com>,
        SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190902215048.31a69442@naga>
In-Reply-To: <xmqq1rwyv6tq.fsf@gitster-ct.c.googlers.com>
References: <20190828145640.GC14432@sigill.intra.peff.net>
        <20190826191455.GA25695@sigill.intra.peff.net>
        <20190831131748.GA13001@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
        <20190902154732.GD18593@sigill.intra.peff.net>
        <xmqq1rwyv6tq.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 02 Sep 2019 12:25:37 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it still risks losing a case where some code path relies on the crud
> > cleanup for odd cases (mismatched delimiters, or interleaved delimiters,
> > or non-delimiter crud mixed in with delimiters).
> > ...
> > So I dunno. There is no patch to be discussed, and I am not volunteering
> > to write one.  So I think whoever chooses to do so has a lot of control
> > over what is proposed. :)  
> 
> Rather, they can propose what they want, but they have a lot of
> tough defending to do on their choice.  Lack of potential harm is
> much harder to prove than coming up with a single example that
> harms.
> 
> I'd rather leave the sleeping dog lie, if we need to encourage
> people to live in 21st century and step outside US-ASCII to do so,
> then do that instead.

As much as I would love to agree Windows is dragging us down here. I
don't think there is any other major (or even just not completely
obscure) platform that does not support UTF-8 in the terminal.

Thanks

Michal
