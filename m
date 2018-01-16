Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EE51F406
	for <e@80x24.org>; Tue, 16 Jan 2018 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeAPJpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 04:45:25 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:37358 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeAPJpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 04:45:24 -0500
Received: by mail-qk0-f174.google.com with SMTP id y80so13518847qkb.4
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4fC++4HKAqAT2TU4xXvY/KzP444S4WBXDJ0ACU8+jiU=;
        b=pDAJHvOR7KKcRYlv2jikjuz0i7n/8rpY+Ivn02lVb9OhVdyndQn8hQjRwMTr5S/Oz8
         J7pzNuFMoLQQnMFJHfwjQ38Q4ZoKEltf2pCp0NjB2r/mfa8dveVB6yCjPRSadRqVRIjJ
         SCUwlobHYpX+0V/kbw6VYOQCQsBTEvOBPc7b5ShK5mHaBErpWQMaFFuen+YSPcctPqts
         brc1N6Fju0L+4a+qu4yhclS6Qv/NTZf/fsq6FFZ+70OTAsB5ZPCHI5wbNIWjCGx5J+UW
         kmZqec5msZAbZWjaTqhT5YhyMa+zqv9fCAsJg0+9xOk45bkDDAo6Mh97rFccw8mlAjhj
         OFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4fC++4HKAqAT2TU4xXvY/KzP444S4WBXDJ0ACU8+jiU=;
        b=epNCUtFT+BJ9MtTNbGVPOYxyQgNUI0N+iRv9Shj56Iyz3aAKHbbKJCILreUQfZQJXh
         aSKCRY2Gc2djZLGCWDPNlPR1Ae+BFAfeAKe9Xnp4/AGxh+ojx5e94mBwQ/ZVOz21c8lG
         k3Fx0zp9ZM7aYJbuyrC8oEy6CYVKtEszALW0XoMxp5wu9ZT4bsFCujuwHLWQhE1iDT7K
         JoYUhrsWCr1ps6v7q2NdPCum9QITv9o+fljdzPjgX/4bJDKqKlujn4A21wzw3k+b7OU1
         4w/eiQ4FO/8FsPS7JLJYFY5TzQ1vvVF3Kf6zx8GxIqf3kybtQ8MtXHsttwcXgTWpRkYk
         +TWg==
X-Gm-Message-State: AKwxytfHYVnVwhG+R88VQaZghBtEVmZWGzi466+eth7Lr5SVSQ7Ag5IB
        g802enqpZXWXSI38d7ZeSggNtdQaOnyiRmeOzy3mJw==
X-Google-Smtp-Source: ACJfBot765D+TIObiY5JzQio19hSbsYbAoJ2z7XBfgFQV0aCQqPrSTLmY51AYa/CD1Xf8wMtwyJdbmSK8DfJ8H1QNS4=
X-Received: by 10.55.183.3 with SMTP id h3mr54349263qkf.34.1516095923486; Tue,
 16 Jan 2018 01:45:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Tue, 16 Jan 2018 01:45:23 -0800 (PST)
In-Reply-To: <20180115213702.GC4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc51d-7cd5fb1a-9798-49c1-bc82-480108e1a90b-000000@eu-west-1.amazonses.com>
 <20180115213702.GC4778@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 16 Jan 2018 12:45:23 +0300
Message-ID: <CAL21Bm=WP3CN4OotC1pw3CY1anQALEcnnWMy6FJFaGwVJPARDg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] cat-file: reuse struct ref_format
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-16 0:37 GMT+03:00 Jeff King <peff@peff.net>:
> On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:
>
>> Start using ref_format struct instead of simple char*.
>> Need that for further reusing of formatting logic from ref-filter.
>
> OK, this makes sense (though again, at some point we want this to stop
> being a "ref_format" and just be a "format").
>
>>  struct batch_options {
>> +     struct ref_format *format;
>
> Does this need to be a pointer? We can just store the ref_format inside
> the struct, right? And then...
>
>> @@ -557,7 +558,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>  {
>>       int opt = 0;
>>       const char *exp_type = NULL, *obj_name = NULL;
>> -     struct batch_options batch = {0};
>> +     struct ref_format format = REF_FORMAT_INIT;
>> +     struct batch_options batch = {&format};
>>       int unknown_type = 0;
>
> ...here you would not need the extra local variable. You can initialize
> it like:
>
>   struct batch_options batch = { REF_FORMAT_INIT };
>
> -Peff

Thanks a lot!
Fixed, please check new version here: https://github.com/git/git/pull/450
If everything else is OK, I will send it to the mailing list.
As I said in other email threads, not sure that we need to include
last commit ("make valid_atom general again") into a new patch.

Thanks again,
Olga
