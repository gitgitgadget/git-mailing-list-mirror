Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3598D1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfBLAAg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:00:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:40820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727232AbfBLAAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:00:35 -0500
Received: (qmail 18205 invoked by uid 109); 12 Feb 2019 00:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:00:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19172 invoked by uid 111); 12 Feb 2019 00:00:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:00:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:00:33 -0500
Date:   Mon, 11 Feb 2019 19:00:33 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] Microproject on git-credential-cache
Message-ID: <20190212000033.GB13301@sigill.intra.peff.net>
References: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 09:45:21PM -0200, Matheus Tavares Bernardino wrote:

> I've been contributing to the Linux Kernel for the past semester and
> I'm now looking to take my first steps in the git community. I'm also
> interested in GSoC 2019.

Hi, and welcome!

> I started looking at https://git.github.io/SoC-2019-Microprojects/ and
> one that got my attention was "Move ~/.git-credential-cache to
> ~/.cache/git". But looking around at the code and the mailing list,
> this microproject seems to have been already solved at 60759ba
> ("credential-cache: use XDG_CACHE_HOME for socket", 2017-03-17),
> right?

Yes, I think so. We should remove it from the list (you're welcome to
submit a PR at https://github.com/git/git.github.io.

> For the microproject "Add configuration options for some commonly used
> command-line options", are there some options already known to be good
> for adding to configuration file?

Hmm. I don't offhand have any suggestions. That one has been floating
around since at least 2015. I wonder if it may also be time to retire it
(or give some more concrete examples).

> Finally, a non GSoC-related question. Just to confirm my understanding
> of Documentation/SubmittingPatches: I must send patches to the mailing
> list first and after some feedback from community, send to the
> maintainer with CC to the list, is that correct?

Yes. Often the maintainer will even pick them up without being cc'd (in
which case he'll usually reply to say so). The main goal is to avoid
overwhelming him with first-draft patches that are not yet ready to be
applied. :)

-Peff
