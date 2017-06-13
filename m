Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7622D20282
	for <e@80x24.org>; Tue, 13 Jun 2017 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdFMJEa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 05:04:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:38905 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdFMJEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 05:04:30 -0400
Received: (qmail 20078 invoked by uid 109); 13 Jun 2017 09:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 09:04:29 +0000
Received: (qmail 21823 invoked by uid 111); 13 Jun 2017 09:04:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 05:04:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 05:04:27 -0400
Date:   Tue, 13 Jun 2017 05:04:27 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        jrnieder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2] Configure Git contribution guidelines for github.com
Message-ID: <20170613090427.igjz7erniblh3wie@sigill.intra.peff.net>
References: <20170613081807.33196-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613081807.33196-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:18:07AM +0200, Lars Schneider wrote:

> changes since v1:
> * mention submitGit
> * link to mailing list address instead of mailing list archive

You might want to link to https://git-scm.com/community/, which has a
section on the mailing list at the top. It gives the list address but
also talks about the archive, that you can send to it without
subscribing, etc.

> * reformat long lines

I think this is OK. For CONTRIBUTING.md, GitHub re-wraps. In the pull
request template itself, though, the newlines become hard-wraps. But we
wouldn't generally expect those lines to remain in the final PR text
anyway, so it shouldn't really matter.

That's actually one annoyance I have with PR and issue templates like
this: the submitter has to manually delete them. But there's not really
a better way to get people's attention. The link to CONTRIBUTING is by
far not enough in my experience (I had to put a template in
git/git-scm.com for people to top submitting Git bugs).

The text itself looks good, but two minor grammar nits:

> diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
> new file mode 100644
> index 0000000000..fc397bb8fc
> --- /dev/null
> +++ b/.github/CONTRIBUTING.md
> @@ -0,0 +1,19 @@
> +## Contributing to Git
> +
> +Thanks for taking the time to contribute to Git! Please be advised, that the
> +Git community does not use github.com for their contributions. Instead, we use
> +a mailing list (git@vger.kernel.org) for code submissions, code
> +reviews, and bug reports.

I think the comma after "advised" is unnecessary (you could also drop
"that" to turn the first part into an introductory clause, but I think
it reads better with as "Please be advised that").

> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
> new file mode 100644
> index 0000000000..2b617f4c25
> --- /dev/null
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -0,0 +1,7 @@
> +Thanks for taking the time to contribute to Git! Please be advised, that the

Ditto here.

-Peff
