Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2088C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D00A222BB
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="FI+qD8sT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIRWx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRWx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 18:53:28 -0400
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037DC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:53:27 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 2A54E1DEF5; Fri, 18 Sep 2020 18:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1600469606; bh=1jQJ03AxkMUXykZZBqmOcEfvaAoPcj7ZRy1yfChXMew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FI+qD8sTgohB+6riT+2zg9U6C9JPfoTSxH9j7tOycfkFAVNzsCaVXL31qDctR8Pim
         Ummi30uOt2/FXVT07wiRHFteNmf/B0uDiAZs5MvlKpmjHn9i42Rcy/4Y9xOdpp+vjm
         cpiRgmGgG4M2qiK4ZWxAmMezb7olM09q46QZ+Crp7JtPDPPLI3TsmeFwgoUQpVP5g8
         VrQ9TeENb6cIdD4S5wyAAsHqE1TpB5oD0DnSVMuFI+UhphRJcCInRfG9FzYgrg2lN6
         dbHh+J8iwlmU1BDu4eSZ/3V4IDAybyULiPfH63t+Buq0pq4IgtWh3faf2UFK5kTyv+
         XoPywe5hReqbQ==
Date:   Fri, 18 Sep 2020 18:53:26 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Message-ID: <20200918225326.GA1367@pug.qqx.org>
Mail-Followup-To: Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <20200917130139.GB3024501@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917130139.GB3024501@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 09:01 -0400 17 Sep 2020, Jeff King <peff@peff.net> wrote:
>On Thu, Sep 17, 2020 at 10:11:17AM +0000, Kerry, Richard wrote:
>
>> Has there been a change in Git Mailing List settings?
>> Up until sometime late yesterday, messages from the list came from
>> git-owner@vger.kernel.org, on behalf of the originator.  Now messages
>> are coming directly from the originator.  This means my Inbox rules
>> have stopped working.
>>
>> Is this a deliberate change?  Unexpected change in mailing list
>> software?  Will it be changed back?
>
>Not to my knowledge. The smtp-level envelope from on all of the messages
>I've received is git-owner@vger.kernel.org. Is there some other
>mechanism you might be filtering on?

Comparing <20200911143321.GA2374950@coredump.intra.peff.net> with the 
message I'm replying to so that I'd have messages which I would expect 
to be similar before the list handling I see that that older message 
included the header

   Sender: git-owner@vger.kernel.org

But the newer message does not have a Sender: header.

I don't know if that was a deliberate change. 

>(If you're not already, a reliable way to detect list messages is by 
>the List-ID or X-Mailing-List headers, both of which are sent by the 
>list software).

Yes, since I've been using the List-ID header for filtering for a long 
time now, I hadn't noticed that the Sender: header was no longer being 
sent.
