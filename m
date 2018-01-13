Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA621FAE2
	for <e@80x24.org>; Sat, 13 Jan 2018 07:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeAMH0c (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 02:26:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:42962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751225AbeAMH0b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 02:26:31 -0500
Received: (qmail 21486 invoked by uid 109); 13 Jan 2018 07:26:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 07:26:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5338 invoked by uid 111); 13 Jan 2018 07:27:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 02:27:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 02:26:29 -0500
Date:   Sat, 13 Jan 2018 02:26:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 0/7] Trace env variables in run_command()
Message-ID: <20180113072629.GC27251@sigill.intra.peff.net>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 01:49:42PM +0700, Nguyễn Thái Ngọc Duy wrote:

> v4:
> 
> - incorporates Jeff patches and moves them on top
> - removes strbuf release from print_trace_line
> - prints 'unset a b c' instead of 'unset a; unset b; unset c'
> - squashes v3 3/4 and 4/4 and Junio's patch into 6/7
> - adds tests
> - cwd is separated in 7/7

Thanks. Aside from the minor nit about argument parsing in
test-run-command, this looks good to me.

-Peff
