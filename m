Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE30201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 04:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbdBQEFZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 23:05:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:56824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754684AbdBQEFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 23:05:25 -0500
Received: (qmail 20796 invoked by uid 109); 17 Feb 2017 04:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 04:05:25 +0000
Received: (qmail 29813 invoked by uid 111); 17 Feb 2017 04:05:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 23:05:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 23:05:22 -0500
Date:   Thu, 16 Feb 2017 23:05:22 -0500
From:   Jeff King <peff@peff.net>
To:     Luna Kid <lunakid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: `git show --oneline commit` does not do what's intuitively
 expected
Message-ID: <20170217040522.jugt4uuak74l3qjw@sigill.intra.peff.net>
References: <CA+-W3ctdRtLpziJ9TX2hqk7RagMyJpHsrfwj=rN7oXQ8EeUPnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+-W3ctdRtLpziJ9TX2hqk7RagMyJpHsrfwj=rN7oXQ8EeUPnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:51:36AM +0100, Luna Kid wrote:

> tl;dr; --> Please add --no-diff (or --msg-only) to git show. We'll
> love you for that. :)

I think it is already spelled "--no-patch", or "-s" for short.

> Please note that "show" is such a profoundly generic command verb,
> probably also used heavily in git, especially to show commits, that it
> comes to mind as second nature, without thinking, as the primary (or
> even as "the only") choice for showing various items in various ways
> -- which, in fact, it already properly does, indeed.

Right. That's what's it for. The DESCRIPTION section of the manpage
starts with:

       Shows one or more objects (blobs, trees, tags and commits).

       For commits it shows the log message and textual diff. It also
       presents the merge commit in a special format as produced by git
       diff-tree --cc.

       For tags, it shows[...etc...]

I guess that second paragraph could mention "--no-patch" explicitly to
disable it. It's documented in the COMMON DIFF OPTIONS section, but of
course there are quite a few options listed, so it's easy to miss.

-Peff
