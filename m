Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6411FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 07:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdFJHfZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 03:35:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37511 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdFJHfY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 03:35:24 -0400
Received: (qmail 32756 invoked by uid 109); 10 Jun 2017 07:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 07:35:23 +0000
Received: (qmail 29395 invoked by uid 111); 10 Jun 2017 07:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 03:35:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 03:35:21 -0400
Date:   Sat, 10 Jun 2017 03:35:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
Message-ID: <20170610073521.ewjzvtpha3xgoe6z@sigill.intra.peff.net>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
 <20170609170357.GE21733@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170609170357.GE21733@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 10:03:57AM -0700, Jonathan Nieder wrote:

> Would putting a PULL_REQUEST_TEMPLATE and CONTRIBUTING in the
> top-level directory work?  If I'm reading
> https://help.github.com/articles/setting-guidelines-for-repository-contributors/#adding-a-contributing-file
> correctly then it seems to say the ".github/" prefix is optional.

Yes, that should work. The ".github" option is there if you don't want
the cruft at your top-level. I don't mind CONTRIBUTING, but
PULL_REQUEST_TEMPLATE is kind of gross. :)

> I also find the long source lines hard to read.  Can you say more
> about how broken lines render in the github.com web interface?  I
> would have expected github's markdown renderer to behave like others
> and cope with line wrapping.

GitHub-Flavored Markdown treats newlines as a line break in the rendered
output, unlike the original Markdown implementation. I don't like that
myself, but it was done in the early days after seeing how many people
accidentally butchered their formatting because they expected the output
to look more like what they typed.

-Peff
