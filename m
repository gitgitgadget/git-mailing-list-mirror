Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F001FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdFPUlO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 16:41:14 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36144 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPUlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 16:41:13 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so5624660pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SLV5roKWUVqviD51y77DVlTum2TLZQAbAehcNzkEgM8=;
        b=f4SSjjl8qn1Fz+r1dL6dOuwQ7ohwFZFmh6dikm2O3AVkt441iPiQefCCTGdwjjMsDl
         S9o39/q46RjMl2m4fAol1HVzzUpKvD0kwSPjP4aspm5X/seRYdbhMQVkJbnwnv8LMk3V
         gzjfvXSD+PW+fQiEyxR38WUa2Fr/TrCiru5Jt2XAowujGj8yJFTcdnIra1dpkQ0OHHpZ
         JZ5NqRpO5yT07MWpCckINdYVFK6x45yXK/RWvDf1xkvQxZSH9JWZIV/Q1tpKs/SF26sP
         sSwbFj060DjHZk35ZIQIfZLBnd4pCb7q+Ec8EP4xXoxMaG1xpGmd6xwKYpKKPlYnRQSF
         KdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SLV5roKWUVqviD51y77DVlTum2TLZQAbAehcNzkEgM8=;
        b=Ns5FrOXTQ+bIn/0mfBKGs+4HIJnsULoqeyGFDlImIlDi+DWhHTqbDdKLYKIwp5ybfA
         eQxinBj1w+JzS+CDgLGiW5xqd2DQxwc1JvXuR4dgWKCXjotxo9eJBMMKCdyo9da92fyZ
         wnY1BWskzv8XbqPJHGA7qKVCVQ4+ulvUi17BT4VmdnS/vATYqUspj7yKSA4V+SX6uwN+
         bZhLtO52nHIyBVCXJQrjGpb1XMXBFUEPdxDidPkhEzYgmwez+clxlsACkruLhGambnbv
         8bYjst/1SG11zgclHVbLgeJRtvAFJqB0domBhVckGe7RU6Xwi8ompYi6+VVVzC6KFBSj
         HZWg==
X-Gm-Message-State: AKS2vOwCEVqaDj3XOjUAWm5lbz9l+yC11jFq3KNFf2RgSQFiWVORZMjF
        o1DSz6oHF0YDHQ==
X-Received: by 10.84.217.213 with SMTP id d21mr14837485plj.45.1497645673013;
        Fri, 16 Jun 2017 13:41:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6ce4:5915:18fd:ad77])
        by smtp.gmail.com with ESMTPSA id t2sm6411075pfi.76.2017.06.16.13.41.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 13:41:12 -0700 (PDT)
Date:   Fri, 16 Jun 2017 13:41:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored
 configuration variables
Message-ID: <20170616204109.GB133952@aiede.mtv.corp.google.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
 <20170616173849.8071-3-szeder.dev@gmail.com>
 <87wp8b94gb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wp8b94gb.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jun 16 2017, SZEDER Gábor jotted:

>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -186,6 +186,11 @@ objects from the source repository into a pack in the cloned repository.
>>  	values are given for the same key, each value will be written to
>>  	the config file. This makes it safe, for example, to add
>>  	additional fetch refspecs to the origin remote.
>> ++
>> +Due to limitations if the current implementation, some configuration
>> +variables do not take effect until after the initial fetch and checkout.
>> +Configuration variables known to not take effect are:
>> +`remote.<name>.mirror` and `remote.<name>.tagOpt`.
>>
>>  --depth <depth>::
>>  	Create a 'shallow' clone with a history truncated to the
[...]
> But this is now cooking in pu, Junio: is it clear that this patchu
> as-cooking ideally shouldn't land in next/master without the fix on top
> which I mentioned in my mail above? I can just submit that as a patch on
> top, but I'm confused about the current state with this cooking in pu,
> so I thought I'd ask first how this should be handled.

I think it's simplest to write a patch on top that discusses --no-tags.
That way, Junio (and anyone else applying the patch) has the
flexibility to apply or cherry-pick this change to old branches
without the --no-tags discussion and newer branches with it.

Would you like to write it (or suggest wording), or would you prefer
if someone else does?

Thanks,
Jonathan
