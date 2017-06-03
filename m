Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138C81F7D2
	for <e@80x24.org>; Sat,  3 Jun 2017 01:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdFCBYv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 21:24:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33204 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdFCBYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 21:24:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7C9C41F7D2;
        Sat,  3 Jun 2017 01:24:49 +0000 (UTC)
Date:   Sat, 3 Jun 2017 01:24:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: public inbox links, was: Re: preserve untracked cache, was Re:
 What's cooking in git.git (Jun 2017, #01; Thu, 1)
Message-ID: <20170603012449.GA20194@dcvr>
References: <CAGZ79kboxyUKy2j2GDZzWhOHeLHM17fYhQ0Wy=HxKaM-zXFC3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kboxyUKy2j2GDZzWhOHeLHM17fYhQ0Wy=HxKaM-zXFC3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> Today I learned again how public-inbox is awesome! Thanks Eric!

You're welcome :)

> * You can just copy the message ID INCLUDING the surrounding < >
>   and public inbox still just shows you the correct message. I had assumed
>   you would need to strip off the < > and I did so since.

Yeah, it's a fallback since it's probably a common mistake.
AFAIK, git-send-email also avoids redundantly adding '<>' and
only adds them if necessary.

> On Fri, Jun 2, 2017 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
<snip>
> > Issue #01 of June reports it in 'master':
> > https://public-inbox.org/git/<xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
>
> * However with the < > unstripped, the awesomeness is limited:
>   Some tools (including my mail reader as well as public inbox itself[1])
>   do not recognize the link when there are < > in there.

Yeah, that's actually bad form on Junio's part.  public-inbox
can only support it up to an extent...

I seem to recall seeing some standard or style recommendation
that URLs (of any type) be surrounded by angle brackets in text:

<https://public-inbox.org/git/xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com/>

So public-inbox (and other parsers) should stop looking for URLs
outside of the '<>'

But I think the newer style manuals state having spaces around the
URL is enough.

> While the second point is not the end of the world, it's still
> slightly annoying,
> which is why I thought I'll point it out here.
> 
> [1] https://public-inbox.org/git/xmqqvaodx6g4.fsf@gitster.mtv.corp.google.com/
