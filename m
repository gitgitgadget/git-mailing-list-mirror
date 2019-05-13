Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909F51F461
	for <e@80x24.org>; Mon, 13 May 2019 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEMUxE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 16:53:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726179AbfEMUxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 16:53:04 -0400
Received: (qmail 26903 invoked by uid 109); 13 May 2019 20:53:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 May 2019 20:53:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6388 invoked by uid 111); 13 May 2019 20:53:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 May 2019 16:53:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 May 2019 16:53:01 -0400
Date:   Mon, 13 May 2019 16:53:01 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: git --help not actually showing the git(1) help page..
Message-ID: <20190513205301.GA22745@sigill.intra.peff.net>
References: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 09:47:27PM +0100, Philip Oakley wrote:

> Is there a cli way, especially on Git for Windows bash, to get the html man
> page of git(1)? I have it on my system, so can go via another page but..
> 
> All the `git <cmd> --help` appear to work, but I can't determine the correct
> invocation for bringing up the stupid content tracker's page in the browser.
> Previously I'd have expected either `git --help` or `git git --help` to work
> (can't remember which). The former only produces the short form -h help in
> the bash window, the latter says 'git' isn't a command.

Try "git help git".

It might be worth mentioning it in the paragraph at the end of "git
help".

-Peff
