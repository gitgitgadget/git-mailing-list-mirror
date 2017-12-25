Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3C21F404
	for <e@80x24.org>; Mon, 25 Dec 2017 08:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbdLYIwG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 03:52:06 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:46350 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLYIwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 03:52:05 -0500
Received: by mail-pg0-f52.google.com with SMTP id r2so1428453pgq.13
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwPd20fit+9LZw2j7jp75R2Ug/y1Gffu8tO2X0AapKw=;
        b=lolnbi/WhHEp6qhusgyS2DJtIX2tF7RhdQCau4BzzsEnkSFavE3j0MUA8AtmCc/KeW
         G+/IRDN1WXMGBa+/xu3fl4Fc73q7E1ygPbdN6+AT9MAy6sgnq+B/p4rAUF9pmNVu3Jo2
         S/ZXmxfPaGRuttHmAKyXg74t/dXjRZvZyktLULay/CHjUTelGC1pN0H86Y+J9/abH4fU
         pZsmAgJu2xHt2RK3ojBRG4fjO1VLhL0Ev9EcKhkjUXY5wNFqujL41557p21HcWZbXSTJ
         GZwGDjdyJjXffY423/tJfMYhh4e0+sN4D+tM6E5t8WOwf3Rtc8Orxk1XlcZ6H3MGujsH
         VWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwPd20fit+9LZw2j7jp75R2Ug/y1Gffu8tO2X0AapKw=;
        b=Ogxlep77RwlpusD/JEqnN51MKKQ43O9wGz/UISYOurh6oyxVpaHH7gyaDMJlOEshDI
         iGKUMxsKIv/6xOdjzU8NEtu4/tZBo4qtVfPtBCj5qFTbwp8ITObrgLSQDfhq9hXWNfNy
         FGkFtoPaJtqglbh/C5z97trA5BBEteNz/Sgcq3XxExWLSEPtBxA0j8Pp3vKEx9dr/kyd
         iyPfBEji5s7UsIRgx1wfdOakUVokLPgmFE6/DBrUrLkzPljh/2HDtQvv5E+6BLsHK27C
         cBUwfgKfj3VmEy4H2T/ryhwBB85CFa4wgjREMWtGGdqiS8TwGRo2KUR/8AGuPxZdr7it
         UoOw==
X-Gm-Message-State: AKGB3mLqmV8k7U19ohU4TcqcTXaU9gB82YVqj05z3qP3z9B92YApbNbd
        2ueyZhlieosCU5+Pv5Hjbsg=
X-Google-Smtp-Source: ACJfBovAi+VqB0DCt4qxQqAFIUHGHGW+DGZDquWMR9epYf9vJ+Pen1Z6dBf07ahEt/f6wa8jxdkA1A==
X-Received: by 10.101.85.78 with SMTP id t14mr1247846pgr.362.1514191924492;
        Mon, 25 Dec 2017 00:52:04 -0800 (PST)
Received: from ?IPv6:2405:204:718f:c16b:a7c:cd30:39f3:e3e3? ([2405:204:718f:c16b:a7c:cd30:39f3:e3e3])
        by smtp.gmail.com with ESMTPSA id s68sm56624801pfj.81.2017.12.25.00.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 00:52:03 -0800 (PST)
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
 <20171213114621.30250-1-phillip.wood@talktalk.net>
 <1513794792.9785.2.camel@gmail.com>
 <alpine.DEB.2.21.1.1712211442470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <1513874528.9646.2.camel@gmail.com>
 <alpine.DEB.2.21.1.1712221201210.406@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <71f9236c-9e55-8489-54b2-5d7c7df1eb0c@gmail.com>
Date:   Mon, 25 Dec 2017 14:21:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1712221201210.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 22 December 2017 05:19 PM, Johannes Schindelin wrote:
> Hi Kaartic,
> 
>>
>> I think I didn't mention I've set `commit.gpgsign` to `true` for that
>> repo, did I?
> 
> Hah! I had troubles to associate the correct line in my versions of Git's
> source code (the line numbers alone are only reliable if you also have a
> commit from which the Git binaries were built), 

Should have mentioned that, sorry.


> but I did this free() at
> (https://github.com/git/git/blob/cd54ea2b18/sequencer.c#L1975:
> 
> 	if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
> 		if (!starts_with(buf.buf, "-S"))
> 			strbuf_reset(&buf);
> 		else {
> 			free(opts->gpg_sign);
> 			^^^^^^^^^^^^^^^^^^^^^
> 			opts->gpg_sign = xstrdup(buf.buf + 2);
> 		}
> 		strbuf_reset(&buf);
> 	}
> 

Seems you got the right one, regardless. :)


> The culprit is that we have these really unclear ownership rules, where it
> is not at all clear who is responsible for releasing allocated memory:
> caller or callee? (Hannes would not rightfully point out that this would
> be a non-issue if we would switch to C++). In C, the common pattern is to
> use `const char *` for users that are *not* supposed to take ownership,
> and `char *` for users that are supposed to take custody. And in this
> instance, `gpg_sign` should be owned by `struct replay_opts` because of
> this (https://github.com/git/git/blob/cd54ea2b18/sequencer.h#L38):
> 
> 	char *gpg_sign;
> 
> Technically, using `char *` (instead of `const char *`) does not say
> "you're now responsible for de-allocating this memory", of course, but in
> practice it is often used like this (and the signature of `free(void *)`
> certainly encourages that type of interpreting the `const` qualifier).
> 

Nice explanation.


> I spent a little quality time with the code and came up with a patch that
> I will send out in a moment.
>

That relieves Philip of the burden, I guess. :)


> By the way, Kaartic, thank you so much for focusing on correctness before
> focusing on style issues. I know it is harder to review patches for
> correctness than it is to concentrate on style issues, but in my mind it
> is not only much more work, but also a lot more valuable.
> 

Though it's good to hear these words and I do like to focus on 
correctness, there wasn't much I did to focus on correctness in this 
case ;-) It was you actually, after seeing such a clear explanation!.

I just used Git built from 'next' for my personal use and encountered 
the issue I stated in the start of this sub-thread.


-- 
Kaartic
