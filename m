Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5FD2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbdBWUtS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:49:18 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33600 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdBWUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:49:18 -0500
Received: by mail-lf0-f50.google.com with SMTP id l12so1227236lfe.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 12:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sV6iZJD4hd8KFxEGtqyTQe9VEHukfn1cvlgKUl7BfNc=;
        b=sTuP+3OQSJ61g106kyUE9rKx/V5hixGVO45pAwT9ECmQkB1St3IW2B39eOt8KLzXgX
         F4gG5zIZxFUchiMqJ81I0KhMolXX7cd+6Oz4ufp6hhA1MdOlrlTxJN4rl60cmUghW5AM
         N+gNOosGJCdEodwCXGGvIEVsGNexFU7ixvEOwKx2ENQMqdfVjB3TNSoFboEYsY+XaiWf
         I1Snj8hz34AJx3ri8JpgTkX3GzKZ9Yjcdtht7hFAgrDLg1N0GSe8EwO97SHJyxk/i7it
         lzMeSmS0PZtB/mI6TzovSkZSuzciUXdHIDEfrHUEaSlWwU8gp0ZJDYjFvDKdwAMME1OA
         yGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sV6iZJD4hd8KFxEGtqyTQe9VEHukfn1cvlgKUl7BfNc=;
        b=Kmdpy89ZL29LJBOL9L4tMzooZQEQXhlrPeeQuDhE3BZ1wNLdJ02uozzW8e/FR8wDHT
         FSvMkRXbz7WGVncO42/Oo5TRwaUBqufQKA5kp4K3hQq+PT5EI7JMz06xUOYOvKKgh6aC
         rGpewqMHxd8SXNGLGra17AncEG3PnaFOtr30morS+Iib+TI9TqyKU1Zd5FuzmX05Z5M5
         fPfk13uTNfJyj+1P4zi2vJghlEH5cshZpE5lNKUlRd30+fCHW6i2Z07YI2rhb/5CWl1v
         c1zIQQsct4UdHg6oxaf17ZWJIRjkcYDJ4VKl4q0tyxMbqBig/2P+vD4hF0+2SPeltSIS
         OnSQ==
X-Gm-Message-State: AMke39mnt/oZXHApj81cXdtKYeUQHOT3jtaGFZwucUvmUaXiIDwzX+R2WGwYc/5FwpnEWg==
X-Received: by 10.25.79.69 with SMTP id a5mr1864362lfk.58.1487882956074;
        Thu, 23 Feb 2017 12:49:16 -0800 (PST)
Received: from [192.168.1.26] (elt110.neoplus.adsl.tpnet.pl. [83.21.213.110])
        by smtp.googlemail.com with ESMTPSA id 5sm8375885lja.58.2017.02.23.12.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 12:49:15 -0800 (PST)
Subject: Re: SHA1 collisions found
To:     David Lang <david@lang.hm>, Junio C Hamano <gitster@pobox.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <nycvar.QRO.7.75.62.1702230907340.6590@qynat-yncgbc>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e57958d4-7c51-3f5e-6ff5-f863920fd883@gmail.com>
Date:   Thu, 23 Feb 2017 21:49:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.75.62.1702230907340.6590@qynat-yncgbc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.02.2017 o 18:12, David Lang pisze:
> On Thu, 23 Feb 2017, Junio C Hamano wrote:
> 
>> On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>>> 
>>> Since we now have collisions in valid PDF files, collisions in
>>> valid git commit and tree objects are probably able to be
>>> constructed.
>> 
>> That may be true, but 
>> https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org/
>>
>
> it doesn't help that the Google page on this explicitly says that
> this shows that it's possible to create two different git repos that
> have the same hash but different contents.
> 
> https://shattered.it/
> 
> How is GIT affected? GIT strongly relies on SHA-1 for the
> identification and integrity checking of all file objects and
> commits. It is essentially possible to create two GIT repositories
> with the same head commit hash and different contents, say a benign
> source code and a backdoored one. An attacker could potentially
> selectively serve either repository to targeted users. This will
> require attackers to compute their own collision.

The attack on SHA-1 presented there is "identical-prefix" collision,
which is less powerful than "chosen-prefix" collision.  It is the
latter that is required to defeat SHA-1 used in object identity.
Objects in Git _must_ begin with given prefix; the use of zlib
compression adds to the difficulty.  'Forged' Git object would
simply not validate...

https://arstechnica.com/security/2017/02/at-deaths-door-for-years-widely-used-sha1-function-is-now-dead/

