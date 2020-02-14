Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526EDC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8A02187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgBNGXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:23:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:43174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725818AbgBNGXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:23:37 -0500
Received: (qmail 19166 invoked by uid 109); 14 Feb 2020 06:23:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:23:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19256 invoked by uid 111); 14 Feb 2020 06:32:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:32:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:23:35 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Git representative on AsciiDoc Working Group
Message-ID: <20200214062335.GB605125@coredump.intra.peff.net>
References: <20200212002129.GB6464@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212002129.GB6464@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 12:21:29AM +0000, brian m. carlson wrote:

> I've had folks from OpenDevise reach out to me and let me know that they're
> launching a standardization initiative for AsciiDoc under the Eclipe
> Foundation's open standardization process.  The goal is to standardize the
> language, ensure compatibility across implementations, and provide a reference
> implementation, with input from implementers, users, and others.
> 
> They'd like to extend an invitation for the Git project to send a
> representative, since we're a significant user of AsciiDoc.  I'm sending out
> this email to see what the project thinks and if anyone would be interested in
> fulfulling that role.

It certainly would be nice for somebody with Git's interests in mind to
keep an eye on the proceedings, just to make sure nothing too disruptive
is decided on.

But I don't know that we have a particular wishlist of things we'd
_like_ to see. The lack of semantic markup in asciidoc (e.g., being able
to mark a command-line parameter as such, rather than just a literal) is
sometimes a pain, but I think that's also what makes the source
documents so readable and generally non-painful to write.

As far as choosing a representative from the project, I'd probably
nominate you. ;)

-Peff
