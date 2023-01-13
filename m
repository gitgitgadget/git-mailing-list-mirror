Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EAC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAMQVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjAMQUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:20:55 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538D7816F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:14:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j15so13927263qtv.4
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rIoq2q7gLrKUXwWle/riYdyLJ2Ket7VUp2SwmGLVB4=;
        b=gGamQa5EK+RpojfW0z2pV229RrC385HMNdHN9mQwdovexrl/yDFv8ZVcUPI1GJ1oJ/
         uc+kaUAzYeU01hMS7FkMozn8ZP2oWEJB5AtSRL4Qw7nFjQ+Y+z0oc3utte07bwfvhpW2
         L9UznrQ5MqNwlbBZ6xbACCaG21nqE4XHcOjuQ2H6nctk0e0TjGTGlGXDPvDRSNNoSXy0
         UF2cirg9zM7m0//oHqRa9KELEIq/M1GagkzVn+IZlM7q2UDeGYtvu01eOMl8zsulOAvM
         WZ7Z8uKTTpbpImNPBt18KUzII7pA4OghxfQ10DqJlKUQpwKw1zCxrCu4FbjxAji6dqHT
         kZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rIoq2q7gLrKUXwWle/riYdyLJ2Ket7VUp2SwmGLVB4=;
        b=QTl2cCB61S3RmOWwOiVWzWWovsxJRleoJ820x1BoY18aFXGBg50j+rtm/swVA5iENL
         tyjJA0cbgyTRLcv7HEZ4Be9PV9fR3PSbvq5CzuZY8tgG04EdYfczZmZjl0v22MCQxC+b
         uPlNa39qZeJe46Imodi8PxqqP5/vy5NBpSu7duU8leikuyPBK88GxqCrhE2zIYw09gcQ
         GClvEO1TzuyZ+s4axomDRW7xpq10qWgo4fp9ikCayZPPCb0YZSVBu+5dkYdyFYlsM+Ql
         bIcT9TudN2u6Cyg4czhbt2LHisJ6NUhQwM95ZlVcQXhR8hSXW+V4ai9jDPimHaiels+t
         TBfg==
X-Gm-Message-State: AFqh2krfY7V21LKMMyS+UKRCgECwIFNDtf7nP/9CwiAUvgciOK3wgS5v
        lc1oOAZAxDB11kK3H1jotNs=
X-Google-Smtp-Source: AMrXdXtw4lvy7uk8eCeCJQqaaXSS4KTX5MJVglrPDIejZO8c7WCyLEtWOIqJeK/aIs1LlSY21jCNgw==
X-Received: by 2002:ac8:1382:0:b0:3a9:8b48:f8f with SMTP id h2-20020ac81382000000b003a98b480f8fmr112626732qtj.67.1673626478816;
        Fri, 13 Jan 2023 08:14:38 -0800 (PST)
Received: from [192.168.1.172] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id l6-20020ac81486000000b003a981f7315bsm10759618qtj.44.2023.01.13.08.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:14:38 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: link generating patch sections
Date:   Fri, 13 Jan 2023 11:14:37 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <0DE08530-2F10-4656-9B50-E7B3CBD60D68@gmail.com>
In-Reply-To: <xmqqk030xfrd.fsf@gitster.g>
References: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com>
 <xmqqk030xfrd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 9 Dec 2022, at 19:29, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 3674ac48e92..5acffdd129e 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -22,7 +22,13 @@ ifndef::git-format-patch[]
>>  -p::
>>  -u::
>>  --patch::
>> -	Generate patch (see section on generating patches).
>> +	Generate patch (see section on
>> +ifdef::git-log[]
>> +<<_generating_patch_text_with_p, generating patches>>).
>
> Is this "prepend underscore, downcase, and replace each run of
> non-alnum with an underscore" ASCIIDoc magic?  AsciiDoctor magic?
> All such backends prepare the anchor in the same format?

Yes, I believe this is asciidoc magic.

>
> I am mostly worried about relying on automatic magic that can
> silently be broken when say the title in diff-generate-patch.txt
> file is improved.  Whoever is updating the file would not know
> it is being referenced from elsewhere (and it is hard to check).
>
> Or perhaps you forgot a single liner patch to diff-generate-patch.txt
> that adds [[_generating_patch_text_with_p]] anchor yourself?

Good point, adding an explicit anchor makes sense.

>
>> +endif::git-log[]
>> +ifndef::git-log[]
>> +Generate patch text with -p).
>
> The capitalization makes it look somewhat odd in the resulting
> text.  Quoting, e.g.
>
> 	see the section titled "Generate patch text ..."
>
> may make it acceptable, though.

yeah I agree here--I can adjust this in the next version

thanks
John

>
>> +endif::git-log[]
>>  ifdef::git-diff[]
>>  	This is the default.
>>  endif::git-diff[]
>>
>> base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
