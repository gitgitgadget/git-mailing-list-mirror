Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3037F20970
	for <e@80x24.org>; Fri, 14 Apr 2017 21:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdDNVX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 17:23:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33823 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdDNVXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 17:23:55 -0400
Received: (qmail 11020 invoked by uid 109); 14 Apr 2017 21:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 21:23:55 +0000
Received: (qmail 5355 invoked by uid 111); 14 Apr 2017 21:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 17:24:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Apr 2017 17:23:52 -0400
Date:   Fri, 14 Apr 2017 17:23:52 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/2] http: few fixes for the proxy configuration
 handling
Message-ID: <20170414212352.aqhi3s7gwygf2fqn@sigill.intra.peff.net>
References: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 11:22:17PM +0300, Sergey Ryazanov wrote:

> this is few patches, which fixes regressions in the proxy handling.
> 
> Both patches are based on the maint branch.
> 
> Changes since v3:
>  - fix grammar (thanks to Jeff)
> 
> Changes since v2:
>  - fix grammar (thanks to Ævar)
>  - add new patch which fixes the silent ignoring of proxy missconfiguration
> 
> Sergey Ryazanov (2):
>   http: honor empty http.proxy option to bypass proxy
>   http: fix the silent ignoring of proxy misconfiguraion
> 
>  http.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

This whole series looks good to me.

-Peff
