Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477E4207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 10:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1429624AbdDYKkz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 06:40:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39695 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1177063AbdDYKkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 06:40:53 -0400
Received: (qmail 11843 invoked by uid 109); 25 Apr 2017 10:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 10:40:52 +0000
Received: (qmail 11772 invoked by uid 111); 25 Apr 2017 10:41:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 06:41:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 06:40:50 -0400
Date:   Tue, 25 Apr 2017 06:40:50 -0400
From:   Jeff King <peff@peff.net>
To:     Timo Schmid <tschmid@ernw.de>
Cc:     git@vger.kernel.org
Subject: Re: Git Shell Security Issues
Message-ID: <20170425104050.qcivu5edpzo37t7m@sigill.intra.peff.net>
References: <5a5b33d8-f36f-bf94-6473-a9c2a980f65d@ernw.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a5b33d8-f36f-bf94-6473-a9c2a980f65d@ernw.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 12:29:22PM +0200, Timo Schmid wrote:

> I've found a security issue in the git-shell command, which allows authenticated
> attackers to read files, partially write files and in some configurations to execute
> shell commands in the context of the remote user.

Yikes.

> Should I report the details here or is there a security mailing list which I haven't
> found yet?

git-security@googlegroups.com

-Peff
