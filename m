Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1152013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdBOV4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:56:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:56035 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750719AbdBOV4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:56:36 -0500
Received: (qmail 24966 invoked by uid 109); 15 Feb 2017 21:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:56:36 +0000
Received: (qmail 17971 invoked by uid 111); 15 Feb 2017 21:56:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:56:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:56:34 -0500
Date:   Wed, 15 Feb 2017 16:56:34 -0500
From:   Jeff King <peff@peff.net>
To:     Fabrizio Cucci <fabrizio.cucci@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Back quote typo in error messages (?)
Message-ID: <20170215215633.deyxp76j7o3ceoq3@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
 <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
 <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 09:51:30PM +0000, Fabrizio Cucci wrote:

> > Some people use the matched backtick/single-quote to emulate the
> > non-symmetric start/end quotes used in traditional typography (and in
> > fact, ``foo'' in languages like asciidoc are typically rendered using
> > smart-quotes).
> 
> I definitely didn't know about the use of them in traditional typography!
> But I couldn't find any example of non-symmetric quotes in AsciiDoc...

Grep for "``" in Git's documentation directory, and you will see many
examples (asciidoc only accepts the double-quote form, not singles).

You can also try:

  echo "this is \`\`quoted'' text" >foo.txt
  asciidoc foo.txt

and then open "foo.html" in your browser.

> > I don't know how much we care about standardizing that punctuation.
> 
> I mentioned it was very minor but, still, in my opinion a project like
> Git deserves consistent punctuation! :)

I think patches would be welcome, but as Junio said, it probably should
wait for the next cycle.

-Peff
