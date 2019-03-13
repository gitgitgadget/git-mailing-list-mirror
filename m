Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FA920248
	for <e@80x24.org>; Wed, 13 Mar 2019 21:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCMVH2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 17:07:28 -0400
Received: from kwanyin.sergiodj.net ([158.69.185.54]:43972 "EHLO
        kwanyin.sergiodj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 17:07:28 -0400
From:   Sergio Durigan Junior <sergiodj@sergiodj.net>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
References: <87k1h55bx0.fsf@sergiodj.net>
        <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
        <877ed459eh.fsf@sergiodj.net>
        <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
        <8736nr6g94.fsf@sergiodj.net>
        <e0e1e159-844d-c9bf-e1cc-ada05384ef76@gmail.com>
        <87pnqu4i1n.fsf@sergiodj.net>
        <20190313205926.GB5397@sigill.intra.peff.net>
X-URL:  http://blog.sergiodj.net
Date:   Wed, 13 Mar 2019 17:07:19 -0400
In-Reply-To: <20190313205926.GB5397@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 16:59:26 -0400")
Message-ID: <87lg1i4h6g.fsf@sergiodj.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, March 13 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 04:48:36PM -0400, Sergio Durigan Junior wrote:
>
>> Huh, I do have some of the files opened in Emacs!  They're in
>> background, but indeed, now that you mentioned I remember that Emacs
>> keeps track of changes and invokes "git status" sometimes.  Next time I
>> see the bug, I'll try closing the files and see if it happens again.
>
> If Emacs (I guess maybe magit?) is running "git status" behind the
> scenes, you might benefit from teaching it to use "git
> --no-optional-locks status" instead. See the section "BACKGROUND
> REFRESH" in "git help status" for more discussion.

Thanks Jeff.  That's going to be helpful.

-- 
Sergio
GPG key ID: 237A 54B1 0287 28BF 00EF  31F4 D0EB 7628 65FC 5E36
Please send encrypted e-mail if possible
http://sergiodj.net/
