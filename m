Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3705320899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbdHJHFL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:05:11 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34142 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdHJHFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:05:11 -0400
Received: by mail-wm0-f47.google.com with SMTP id t138so18751760wmt.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9jWV/0fY1p83MX+UnN9YCbJvFjqqrNmoaLTl99W6Rtk=;
        b=PpXTBdjQQJ/f1eewpqEAY7WZM7ZyDw7zEN4XQdTJJ+UfnVVjI1QqL0u5CrvKBMWUP0
         a0kkQMhuW+JRHnHFUGKvBfGiiv5pI6d6UPcrTtAD1BDaLsPZL3Ks1Xb8jmUyOEoKwDLT
         phDfdG8hwcTugTpGxIROJ9MrESYsXWrHuP8ePSsrBGIp0bk82pj+b+Wugtd976CtBrJV
         Hvr2SRwuR/BdQ+z/xQZS6Q7QtTu3zAFFudahWYvREiQcmaerOecjWk9Y4iViTADf3IS2
         s6AJQczHSdep+mJXHU7J/tzYwXnvdY03t/ral79doaOkGHKXz1ZemuuyqPShFF+aIK8I
         pTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9jWV/0fY1p83MX+UnN9YCbJvFjqqrNmoaLTl99W6Rtk=;
        b=D7RPh7jik2m/KuA29YWy1UbDCRnLkRIClKFT18OfedQIHkNjm5hfUY/dU2GFnXZe+I
         Z0UZUJCK9ONVLYCPiefJLMT+W1SFb/jLYL3h0zkGOJg6QgENIDMCO0fnhPPSbs3+7ZLW
         EPdii/riLivAtYKQq/dFReZ9SxySIPbd2JJmpKk6w3HY5mEXHHiTVtxTa3W98Bb6i1Uj
         t/DXAz+r4ol+lMOWpPDEbB4L6Sp0IsJEzac2Fo319oOQSPvjrh4WecP2fTpfdPVJCrel
         2xgjCWhKsoDApWsFrzVkBPCkcIHPuMEFSibBt38P2L4NPELK3sV0iTqxHCV6FgnnIOHR
         OUeQ==
X-Gm-Message-State: AHYfb5hdwB3J/mDEAoOO5WXzSRalo+va0fEftuV7PyA0fTCbPAkHtlBD
        zjwhhXJVwWEkvOzHt87LnNlTNuthDw==
X-Received: by 10.80.137.61 with SMTP id e58mr11052620ede.67.1502348709764;
 Thu, 10 Aug 2017 00:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.134.38 with HTTP; Thu, 10 Aug 2017 00:04:49 -0700 (PDT)
In-Reply-To: <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net> <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 10 Aug 2017 00:04:49 -0700
Message-ID: <CA+P7+xoifkJyH34Q0NJdE_=UzWK1SA+2gwyXrHpF7Sv2PBHATQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Parsing trailers out of a commit message is _mostly_ easy, but there
>> area a lot of funny corner cases (e.g., heuristics for how many
>> non-trailers must be present before a final paragraph isn't a trailer
>> block anymore).  The code in trailer.c already knows about these corner
>> cases, but there's no way to access it from the command line.
>>
>> This series teaches interpret-trailers to parse and output just the
>> trailers. So now you can do:
>>
>>   $ git log --format=3D%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f |
>>     git interpret-trailers --parse
>>   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
>>   Helped-by: Stefan Beller <sbeller@google.com>
>>   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>   Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
>
> Thank-you, thank-you, thank-you.
>
> The above example made me wonder if we also want a format specifier
> to do the above without piping, but it turns out that we already
> have "log --format=3D%(trailers)", so we are good ;-)
>

I was going to say, I thought we had a way to get trailers for a
commit via the pretty format, since that is what i used in the past.

Thanks,
Jake
