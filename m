Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB6C2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 06:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdBXGL0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 01:11:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:33188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdBXGLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 01:11:25 -0500
Received: (qmail 21358 invoked by uid 109); 24 Feb 2017 06:10:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 06:10:48 +0000
Received: (qmail 5065 invoked by uid 111); 24 Feb 2017 06:10:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 01:10:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 01:10:46 -0500
Date:   Fri, 24 Feb 2017 01:10:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
Message-ID: <20170224061045.bejaswcrc4youwsv@sigill.intra.peff.net>
References: <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
 <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
 <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
 <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
 <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
 <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net>
 <xmqqh93k5ijb.fsf@gitster.mtv.corp.google.com>
 <20170224042227.2rjgf4zbiadxbrtz@sigill.intra.peff.net>
 <xmqqd1e85ddy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1e85ddy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 10:08:57PM -0800, Junio C Hamano wrote:

> Anyway, here is an updated one (the part of the patch to t/ is not
> shown as it is unchanged).
> 
> -- >8 --
> Subject: [PATCH] config: use git_config_parse_key() in git_config_parse_parameter()

Looks good. Nice and simple.

-Peff
