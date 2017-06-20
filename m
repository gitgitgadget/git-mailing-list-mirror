Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD6A20282
	for <e@80x24.org>; Tue, 20 Jun 2017 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdFTNqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 09:46:12 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35058 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdFTNqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 09:46:11 -0400
Received: by mail-ua0-f169.google.com with SMTP id j53so67925955uaa.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7bUfsd2xaKE7J0WGef9hI2A6hUkRwXXVJyLa/pxa6MI=;
        b=uhKdWOX4yOKd6rEJysfWtLy5lyFxxbYsc9Py5j5BHUz+AZg4jUlA/H/HOAXDcs2NdI
         IMWMP2pBaCF5JXYveGT3/0OEOCCrHBpzC4iGk8Y1mQBMBWxgAipaMfz+3XqeO5srW/SF
         ugOT77TIUONAaJELI1mt5/7UKgY2wZ2YnaCW2w61xxpzNOqXKigNFBQb470YINu2wUpc
         xp+NBCqFGLQfK61/4GWr6efXVFhrXugesafGBvfP+YEaN8dgRM59ecVZS6cDZW4whALu
         qilpyXp90H/EdaxvRpjBFfrXguCKLmpMDWusdBRS50yejsPONDnVg7XV6OS7pztf3+yd
         BKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7bUfsd2xaKE7J0WGef9hI2A6hUkRwXXVJyLa/pxa6MI=;
        b=k7PdopvxMNCOxPCW7glTcREmKqcw62Kt8+uzTVRcasB8svyqPcqN1+cj5JvkrpeP4M
         kajU3hpBhou2X7uy0z6uhmt/uJ5I9zmMsNpi71/Aux2zgSxaZTQ11gLgKvNz20nqFe2C
         Pi8aJrDAJQ0/Fgh3cT2s5bjxC0Xu0e6YFo2R+Pu7+iYq+/PIS8GX+MurXQP3WnHm7Jd5
         u1AvGarhpa9kwaQYmtxbxAJgBrLxTUrclKMHi49a8COaL+y1b63c3o6mPZchB3BXnCU8
         LKF06CLZ+SWuFI4nRsg5jXZFgdyayyBYm7enNN+RWAaXh4IheFHWkUMOmRIb1m3rfIBH
         x5iw==
X-Gm-Message-State: AKS2vOxkTsS6O83KGhIK+hEba3/XBQUIXgf3CvbWdPGX7bT8abGjQXCI
        GnH4pQ3TBJTpWCjufdvhRsNolQOE5Q==
X-Received: by 10.176.2.203 with SMTP id 69mr11235162uah.36.1497966370747;
 Tue, 20 Jun 2017 06:46:10 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.85.157 with HTTP; Tue, 20 Jun 2017 06:46:10 -0700 (PDT)
In-Reply-To: <20170619205636.7adzgolilpfch3ux@sigill.intra.peff.net>
References: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
 <20170619205636.7adzgolilpfch3ux@sigill.intra.peff.net>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 20 Jun 2017 08:46:10 -0500
X-Google-Sender-Auth: T-fL1gB7PJcGxEJXgVClZQ3NTLM
Message-ID: <CAHd499Ckn4QQp4s3kO61a4wRxopu7rywPOpNXJ=_zmHffp0d1Q@mail.gmail.com>
Subject: Re: Better usability of stash refs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 3:56 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 19, 2017 at 03:32:54PM -0500, Robert Dailey wrote:
>
>> To drop a stash, I have to do this (example):
>>
>> $ git stash drop stash@{3}
>>
>> Using the full "stash@{N}" seems superfluous since the documentation
>> states it must be a stash in the first place. It would make more sense
>> (and be quicker to type) to do:
>>
>> $ git stash drop 3
>>
>> Is there a trick I can use to make this shorthand possible? I thought
>> about creating a "s" script for "stash" that intercepted the
>> parameters for only a couple of stash sub-commands and created the
>> ref, but that seems a lot of work.
>>
>> Any productivity tips here? Thanks in advance.
>
> Junio mentioned that this is already possible. I suspect the problem may
> be that your Git is not recent enough. It was added in a56c8f5aa (stash:
> allow stashes to be referenced by index only, 2016-10-24), which is in
> v2.11.0.
>
> -Peff

Thanks guys. Actually I'm running 2.13, I just haven't tried it since
way before 2.11. I always assumed it wasn't working like I expected
since last time I tried it. Yesterday I just happened to remember that
this would be nice to have, so I wrote the email but didn't bother
testing it on the newest version first. Sorry about that.
