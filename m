Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6C41F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbcHISjR (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:39:17 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35127 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbcHISjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:39:17 -0400
Received: by mail-io0-f180.google.com with SMTP id m101so19929413ioi.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:39:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Xqvq3Op0sDqbxwPsmlW27qrxtBtT9N2eZe03UpHKdQ=;
        b=LKB1W4f94cyj0HqCuXj7+hUqWQqtFSXAXoTFGsYE49mMuzBK7N6bF9CIynpY2neDdJ
         q4L6w9jd0uzO4dwT1SnJ8YWNf+NU8CXpLziU5yoX1vOEXvMXLPg1i1krZHzkqlosE7Zc
         xLjxJ3tY/g92dQGZDzFaKrsmgP6APPMALLyQA3uzAYirli53sXs55Tl+Mic8bkjJmVPb
         Clnlv+khWCe6B2Up3hG9hZU9V6tvKVAENx4ClO7nQ7Bhj+asFzphuPqCGiK4aPaRhMp5
         8J6BwpgX363XYtAfyCqjZNQ5ExwAYmgWArHgE7soWwZ0IoDei6o2gsn8HLfdkI9gXZVz
         1XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Xqvq3Op0sDqbxwPsmlW27qrxtBtT9N2eZe03UpHKdQ=;
        b=EEm6fp4LRjn9NfH7LqI4/rYLqsSCyWHoJVUkN/cfq0LYcxviV+8Se9lC1yFKWB8pIC
         NS49NKz52WpLsyWdrjPh6e3esIDIt1I58LCjdmyYUTCGHES295dm+kKPvJCVcn6gqXBC
         Ey7ZPTdJjEuI5IsRg/7qaTmycIXbfDz9D4KZ5RAMmL8XdArMUxHkzxEwytgX/Uk90A2r
         /0Qn3JfMukF+kKCCO1zzaJ87k89a7f21lEoZaJPz7yEQsiULcUB2vdGDaVnIpJ2AULoI
         uiHUrY0tm0ArNROOTVsxLQmO5i1gOSLOP189M6dW5y2D+HjthY8Hxf08G53KWcJg2ezV
         gDlQ==
X-Gm-Message-State: AEkoouvnjR64lOtV9Q5xtsoYUth7UBjWwQVfEn/l08aEdU8LbLMahDjz7mqJLNSRm6fqCWL63kP3X/fl6YL4fg==
X-Received: by 10.107.8.140 with SMTP id h12mr594940ioi.95.1470767956085; Tue,
 09 Aug 2016 11:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Tue, 9 Aug 2016 11:38:44 -0700 (PDT)
In-Reply-To: <CACsJy8DA7b9EYTDUMA5+kfk2Xg6hQGAuNTa5ghKH3zMiuvTRbw@mail.gmail.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com> <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <CACsJy8DA7b9EYTDUMA5+kfk2Xg6hQGAuNTa5ghKH3zMiuvTRbw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 9 Aug 2016 20:38:44 +0200
Message-ID: <CACsJy8A4xwiUZ50hH9srRkmmBfxhHCQWzN70sLWo5TqZBOPQrw@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 8:36 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Aug 9, 2016 at 1:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Could you elaborate why you would expect quality and/or quantity of
>> reviews to suffer? I'm really curious, and I'd be happy to pass your
>> feedback along to my colleagues.
>
> Since I have been using github at work for a couple months, I do have
> a few complaints if it will ever become the way of reviewing things in
> git. Some of these may be covered by other people already (I haven't
> read all new mails in this thread yet)

Another super nit thing: use monospace font for commit messages, or at
least have an option for that.
-- 
Duy
