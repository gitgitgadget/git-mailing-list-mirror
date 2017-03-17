Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6529A20951
	for <e@80x24.org>; Fri, 17 Mar 2017 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbdCQNoE (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 09:44:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbdCQNoD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 09:44:03 -0400
Received: (qmail 31242 invoked by uid 109); 17 Mar 2017 13:42:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 13:42:32 +0000
Received: (qmail 3027 invoked by uid 111); 17 Mar 2017 13:42:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 09:42:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 09:42:29 -0400
Date:   Fri, 17 Mar 2017 09:42:29 -0400
From:   Jeff King <peff@peff.net>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH v6 1/3] path.c: add xdg_cache_home
Message-ID: <20170317134229.qlrz4fqotirb5len@sigill.intra.peff.net>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
 <20170317123634.10863-1-lehmacdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317123634.10863-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 08:36:32AM -0400, Devin Lehmacher wrote:

> We already have xdg_config_home to format paths relative to
> XDG_CONFIG_HOME. Let's provide a similar function xdg_cache_home to do
> the same for paths relative to XDG_CACHE_HOME.
> 
> Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>

Looks obviously correct. The whole series looks good to me.

-Peff
