Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1512022D
	for <e@80x24.org>; Sat,  5 Nov 2016 03:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbcKEDze (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 23:55:34 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47071 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbcKEDzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 23:55:33 -0400
Received: from [IPv6:2607:fb90:1cdc:1105:511b:8459:19af:755f] (unknown [IPv6:2607:fb90:1cdc:1105:511b:8459:19af:755f])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E346EA80C8;
        Sat,  5 Nov 2016 04:55:29 +0100 (CET)
User-Agent: K-9 Mail for Android
In-Reply-To: <20161105014817.vm4ush2wfbblzsc7@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com> <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net> <CA+P7+xpwUZscpgzLJYf5vkKKsT6SFkC3TrsyBJXJjGo9cF94nQ@mail.gmail.com> <20161105014817.vm4ush2wfbblzsc7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Regarding "git log" on "git series" metadata
From:   Josh Triplett <josh@joshtriplett.org>
Date:   Fri, 04 Nov 2016 21:55:23 -0600
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <A269CCA2-5F8C-4AF0-820E-2EA26FEF03D5@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 4, 2016 7:48:17 PM MDT, Jeff King <peff@peff.net> wrote:
>On Fri, Nov 04, 2016 at 04:34:34PM -0700, Jacob Keller wrote:
>
>> > You might also want fallback rules for storing gitrefs on "old"
>servers
>> > (e.g., backfilling gitrefs you need if the server didn't them in
>the
>> > initial fetch). But I guess storing any gitrefs on such a server is
>> > inherently dangerous, because the server might prune them at any
>time.
>> 
>> Is it possible currently for a protocol extension to result in "oh
>the
>> server doesn't support this so I'm going to stop pushing"?
>
>Yes, it would be easy for the client to abort if the server fails to
>advertise a particular extension.

And the reverse (old client, new server) should work as well? 

- Josh Triplett

