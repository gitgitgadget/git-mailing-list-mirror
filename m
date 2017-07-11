Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5F3202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 05:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbdGKFBt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 01:01:49 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33770 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbdGKFBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 01:01:48 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dUnIe-00015L-Mr; Tue, 11 Jul 2017 14:01:28 +0900
Date:   Tue, 11 Jul 2017 14:01:28 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-15?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170711050128.zi63rjltzolfm4ag@glandium.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 10:57:57AM -0400, Ben Peart wrote:
> Correct.  MSVC also supports designated initializers but does not fully
> support C99.

Precision: *recent versions* of MSVC support designated initializer.
2013 introduced them, but there were bugs until 2015, see e.g.
https://stackoverflow.com/questions/24090739/possible-compiler-bug-in-msvc12-vs2013-with-designated-initializer

Mike
