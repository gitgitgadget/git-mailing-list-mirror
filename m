Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71A71F428
	for <e@80x24.org>; Thu, 30 Aug 2018 07:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeH3LVe (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:21:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50538 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeH3LVe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:21:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E5AD51F404;
        Thu, 30 Aug 2018 07:20:49 +0000 (UTC)
Date:   Thu, 30 Aug 2018 07:20:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180830072049.dgsjn3537xzo6qcm@dcvr>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830033000.GD665@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Aug 29, 2018 at 10:02:43AM +0000, Eric Wong wrote:
> > Anyways I hope to teach public-inbox to auto-linkify Message-ID-looking
> > strings "<XXXXXXXXXXX@XXXXXXXX>" into URLs for domain-portability,
> > (but it's ambiguous with email addresses).  But yeah, I don't
> > like things being tied to domain names.
> 
> That would be neat, but I think it actually makes references less useful
> in a lot of cases. URLs are universally understood, which means:
> 
>  - people who don't know about public-inbox can just follow the link
>    (and in fact, that's how they learn how useful it is!)
> 
>  - even for people who do know about it, they are likely to read mails
>    in their MUA. And most MUAs have some mechanism for easily following
>    a URL, but won't know how to auto-linkify a message-id.

Heh, one of the (unstated?) goals of public-inbox is to educate
the users on how Message-IDs (and email in general) works.
And to that end...

> So I too dream of a world where I can say "give me more information on
> this identifier" and my tools search a peer to peer distributed hash
> table for it. But I don't think we live in that world yet.

....More than dreaming, our goal should be to BUILD such a world :>
After all, it was my intense dislike of centralization which
drew me to DVCS and git in the first place.

> At the very least, I think if we plan to reference without an http URL
> that we would use something like URI-ish, like <mid:ABC@XYZ>. That gives
> tools a better chance to say "OK, I know how to find message-ids"
> (though I still think that it's much less helpful out of the box
> compared to an http URL).

That would be awesome if somelike like <mid:ABC@XYZ> could be a
standard and adopted (likewise with <git:$object_id>).

I haven't checked, but are there existing/similar RFCs?
Surely somebody has tried to get <git:$object_id>
adopted by now, right?
