Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FE71F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755415AbeBOKev (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:34:51 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34931 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeBOKeu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:34:50 -0500
Received: by mail-wr0-f182.google.com with SMTP id l43so2831162wrc.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KY6mxNLtboo0puMRI4zUsyyWblE05o2VxXyFPJi2umQ=;
        b=IaCyfvFecwq0Q0X2BcyBL0W3NaaGVPo9p+AC+mTchaw3Rxcol0Y8GeEhRh5gLw4+HU
         H9KF1tBBr+0xHYDuRhzdEpd8uHpamELOpZJdIPz7mP9Jlc07KxPlw3Le0dxT96lde1Q1
         NMd6K/p5sbPtwuPeLtSAVsXaL/UGNLcErNRGVLph2X4nF05Ta3h6iyWZlWV/30iOowas
         uoZJzwWUF85PM/6UUXrOP9qONcmicCRGRr5yPBovcAOpD6pPeBkOPdCbQzdJfDs1voI3
         BIK1qsbUfU93oXHcVu6bEOzuzAOWlsP+uWirIWlg7SPqTdr44E0avBwXzlrl+lZqwUSU
         TwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KY6mxNLtboo0puMRI4zUsyyWblE05o2VxXyFPJi2umQ=;
        b=fzjHW/ju+jf8YmN4SrN23ps9SEhAlrIQEhvf+b7nmkIEQRl8mc9/VObyQ5TU9/9eIN
         PyBP1QDeILIHmy76DgMPZG1cPLuzMcpou6Qr/O9ppjO/2pdtKyLndh66giIEVYxgOyvI
         Qa5jclEq1zpv71I6YjwzTBB/377Z03V2RptWgjjsWUT5k+UKbIrZq7vU+SAmkOUE55bJ
         SlI/SwJRZDs1bpNjfD1mYGQ+grjmM2tEf1NKvw7RdULLOANuTyed+LF65uMjy3S238DN
         DeR6RgLLtp444v4FZu6nJSWVFw9Acfgm9F3ufdayYtua0DCR1yFsCcpxKL72hanC9SkU
         ioIw==
X-Gm-Message-State: APf1xPCMVUHLpzl/CN3zmdH1mE8Xg6Fts5jLdkOIqjfVcnNNguGUtQrY
        uNpv34hiGMDZDo9rXUJ+TY+wslCGeFq+voqmZcc=
X-Google-Smtp-Source: AH8x224IGyuMUuFU7m81x1YtHXH53JWM7RiPe2/BWabfB7VY8MKeQl3z7ECRVUIyT+4KHaEGun0AtY3bk204upB86mA=
X-Received: by 10.223.160.157 with SMTP id m29mr1997042wrm.119.1518690888942;
 Thu, 15 Feb 2018 02:34:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:34:48 -0800 (PST)
In-Reply-To: <20180215055618.GP18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f437a-302b1577-f034-4a24-a3a2-851d1cda0044-000000@eu-west-1.amazonses.com>
 <20180215055618.GP18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:34:48 +0300
Message-ID: <CAL21BmkVgCzihUOxM=Mih=EzYKZwYzpgkSrAZFVr12nkfoCtXw@mail.gmail.com>
Subject: Re: [PATCH v3 20/23] ref-filter: unifying formatting of cat-file opts
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:56 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> cat-file options are now filled by general logic.
>
> Yay.
>
> One puzzling thing:
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 8d104b567eb7c..5781416cf9126 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -824,8 +824,12 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>>               else if (!strcmp(name, "objectsize")) {
>>                       v->value = sz;
>>                       v->s = xstrfmt("%lu", sz);
>> -             }
>> -             else if (deref)
>> +             } else if (!strcmp(name, "objectsize:disk")) {
>> +                     if (cat_file_info.is_cat_file) {
>> +                             v->value = cat_file_info.disk_size;
>> +                             v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
>> +                     }
>> +             } else if (deref)
>
> Why do we care about is_cat_file here. Shouldn't:
>
>   git for-each-ref --format='%(objectsize:disk)'
>
> work? I.e., shouldn't the cat_file_info.disk_size variable be held
> somewhere in a used_atom struct?

At that point - no.
I think it sounds like other separate task to add this functionality
and to test it properly.

>
> -Peff
