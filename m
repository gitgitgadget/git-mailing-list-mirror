Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6E620C13
	for <e@80x24.org>; Thu, 30 Nov 2017 21:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdK3VQ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 16:16:56 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33902 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbdK3VQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 16:16:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3C27220C11;
        Thu, 30 Nov 2017 21:16:52 +0000 (UTC)
Date:   Thu, 30 Nov 2017 21:16:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
Message-ID: <20171130211652.GA26607@starla>
References: <20171129153436.24471-1-avarab@gmail.com>
 <20171129195430.10069-1-avarab@gmail.com>
 <20171130021137.GG15098@aiede.mtv.corp.google.com>
 <87fu8wumy6.fsf@evledraar.booking.com>
 <20171130205952.GB20640@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130205952.GB20640@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Yeah, people really do use Git.pm as an external API.

Yikes :<

> If we want to prevent this, then we should not be installing it in the
> public perl module path.  Or we should at least add a note to the
> manpages we ship :) to recommend not using it.

I think a note in manpages is fine; maybe a load-time warning
to non-git.git users.  We shouldn't be breaking other peoples'
code when they upgrade, though.
