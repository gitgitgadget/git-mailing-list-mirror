Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7B11FCC7
	for <e@80x24.org>; Sat, 24 Dec 2016 10:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbcLXKu7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 05:50:59 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:34135 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbcLXKu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2016 05:50:58 -0500
Received: by mail-it0-f42.google.com with SMTP id 75so36619633ite.1
        for <git@vger.kernel.org>; Sat, 24 Dec 2016 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rLbrZfDUm8CSXvJva7gHE5c3TG19fq4jQWO1dBpJCNE=;
        b=tLRP1L0SAhu3xrydmQZCi1Fr6wQ6gVLViFyYTSaHYkxJq2nUnsXD3Wfy12gvZXKJKJ
         y2oN4KVkDNpgS3sHX5A5frEEbVg6hG7UsZf+HYnGmzqIKxtLD0vveAbJM0QpVjivAxvN
         BMOKIJbEs53JRd40EH2Mhlw9CUhuJ5OteEEi3dmlTD6YXMvqNb7j+0+ygSXRFtBswtSJ
         TgogxCcPzM2O5b8XfPJQG81KAOuSeGnRO70hZnkJkKQ3oF4dcER0NHHUxATZDt06IOVM
         PGfIVlQ9OyMoE47HSCuQd29LAealEzvzx9RFLWMH6yiQ4Lbcwf/AjrbwaVNikocu8MDI
         7HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rLbrZfDUm8CSXvJva7gHE5c3TG19fq4jQWO1dBpJCNE=;
        b=IzmCt1O+wrHzdOH44lRRoRuzfI+3SllfRSS6djAWI13RLj2myqNY/4UYVYoIl0hIN5
         lSjdHZZSBJT6rjZjPBixDz6UyrnSgBY50UED8kDwtLZCPzc2viVE5Wb030Bn8vs47Uhp
         eDpUz5140QkQZ3Bv9kg9uyvUVAJbmLovyXGSLlZy1GywuYWZsj7ytxBcV3EHxX11NIrY
         Jalh6RERoUczZipRUe6C7/VhhicO1N2K1RP3J3oSrnRwnFkMd13mM7B2imj9mTlXSV8R
         9bjbr9BlUyyABBYPukBJ+6ig9WaVer4FLEQczCWEU2Ay9TqIYUc1S7WP93yWf6Ke1X9n
         J5PA==
X-Gm-Message-State: AIkVDXLaRggau77Ab2WuUz4Cq+V00hTkKLw01sBshxqHXKIOiLeDA88FLF00M9AQctG75jHMAczutuFMVwbwAA==
X-Received: by 10.36.184.194 with SMTP id m185mr16343371ite.3.1482576657642;
 Sat, 24 Dec 2016 02:50:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 24 Dec 2016 02:50:27 -0800 (PST)
In-Reply-To: <xmqqd1giedxr.fsf@gitster.mtv.corp.google.com>
References: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com> <CACsJy8CEKj6Lbn++NHhyB7J8HBrMW4F37SHi2soCH1z=RJz4GQ@mail.gmail.com>
 <xmqqd1giedxr.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Dec 2016 17:50:27 +0700
Message-ID: <CACsJy8B_h4u11LdQyvZBNFBTxbD58QZb1M_ugL+Nr9R2Wd-4Qw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #07; Thu, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 24, 2016 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Dec 23, 2016 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Will merge to 'next'.
>>>  - nd/config-misc-fixes                                         12-22          #3
>>
>> Hold it. You made a comment about rollback lockfile on uninitialized
>> variable or something but I haven't time to really look at it yet.
>
> The fix for it is squashed in to the version queued. Please double
> check by fetching from me and comparing it with what you sent out.

Looks good. Merge it! :-D
-- 
Duy
