Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061BF1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbcIISvn (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 14:51:43 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33488 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbcIISvm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 14:51:42 -0400
Received: by mail-wm0-f53.google.com with SMTP id w12so14452015wmf.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=f/UDPGBkQkbwCkf5sHQz/ANI6qck5R5YjQFDAcfaakM=;
        b=un0o0Av7u11ZrBq/W37Ecsvh5wFPu3YpMJZJXhhjqlgaYqdWfHmN81SCyvM+rZA9RY
         orqTN9E+knUkf+j6OVlNVpZyX58xj0w/vKtVgytsAtXcK4ifFOzF7Sid9zLD22isO98E
         0dL3utd1C5NW8Rc2r8LJgzLtYOpS8A33IDPaYVudd+cmNtiocFs8GpLj4qEfl0kahbam
         9ORaRVdu4NB4blA6I5tpGVuHOj8Hq5k9ZAsySU3Ep6O/C1dC6G1XNYZxSCBT0bcPmPZ7
         MnmhSsb+7oX0zOC+FBeUlp6gzpMcpABkdizU/BTVaGkt1GDisW6GZltvtHfntZWm/xzp
         weaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=f/UDPGBkQkbwCkf5sHQz/ANI6qck5R5YjQFDAcfaakM=;
        b=LyBTRfK9p+XLiHA3IXpFsn1A0NLmkORwipilKOSKrQtUoCTkY8A8zIRCSPq/JzG2WR
         W7+m3lNm9pYE1n9ZwcIyZurfAjMGLDWWrZYyPZfsKUkI7vRHiVnd07G9zTR4sz6Z1M7q
         WCjkt7V+i4VFQRo19/p6qv8nt7lEwoOrM4B5RXN6Z6YmDW8uGFySE7OMxLe/Zetr0ZO/
         h3u0I3f3w+xAArEBTrlPuTY859AcYN/53UMzUeuXhLhEK7jh81K8cYBN+SBt7e0j+Q4E
         0rX3i+5WGLHTp5D6jpi5zSgaM5YP+MteUW6DOxNwzHx1AZXz7ArAoK+G3vP3n4jjg9ok
         ukhQ==
X-Gm-Message-State: AE9vXwNaT+AaH731wiTjoBWow0PmqQ916ZuSlJYITuUTncpCrG9h8CbeW7Q3JlYeOW2vMg==
X-Received: by 10.194.107.69 with SMTP id ha5mr4415649wjb.100.1473447100784;
        Fri, 09 Sep 2016 11:51:40 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id n7sm4698853wjf.11.2016.09.09.11.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 11:51:39 -0700 (PDT)
Subject: Re: Announcing Git User's Survey 2016 [was: Working with
 public-inbox.org]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
 <5e480a5b-3752-55c0-65ed-52ca5802851f@gmail.com>
 <alpine.DEB.2.20.1608281036460.129229@virtualbox>
 <bb1ee52f-c4b6-ded3-19af-ddb7b65b376d@gmail.com>
 <alpine.DEB.2.20.1609091503410.129229@virtualbox>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <feae2490-8d53-ed3a-d9a5-cc8907bc91d6@gmail.com>
Date:   Fri, 9 Sep 2016 20:51:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609091503410.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 09.09.2016 o 15:06, Johannes Schindelin napisał:
> On Sun, 28 Aug 2016, Jakub Narębski wrote:
>> W dniu 28.08.2016 o 10:38, Johannes Schindelin pisze:
>>
>>> I would like to strongly caution against putting too much stock into
>>> this users' survey. It is the best we have, granted. Yet I have not
>>> heard from anybody that they participated in the survey, unless they
>>> were also subscribed to the Git mailing list.
>>
>> I tried in past and will try for this year Git User's Survey to be
>> announced more widely than just Git mailing list (git@vger.kernel.org).
> 
> I did not mean to criticise you. I think you are doing the best you can,
> and it is valuable.
[...]
> 
> The question is not so much how to advertise the survey. I skip almost all
> surveys I am asked to participate in, because I am just a little bit busy
> all the time. I feel that my colleagues do the same. Unless forced to take
> a survey, they skip it.

Right, that's a problem.  Thanks for reminding me.

I hope that the fact that by default (via the use of cookies) you can
return to Survs.com survey at later time (assuming that you do it from the
same computer and the same web browser), and continue responding.  Taking
30 minutes or more at once may be a problem, taking 10 x 3 minutes may
not be.

But I won't have too much hope...
-- 
Jakub Narębski
