Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9615E200B9
	for <e@80x24.org>; Mon,  7 May 2018 19:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeEGTZM (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 15:25:12 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:46749 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEGTZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 15:25:11 -0400
Received: by mail-yb0-f178.google.com with SMTP id f3-v6so1921552ybg.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zVSP51Ingwl2UVlqRpP/I0FJyovmY47JrxzcmpuE23w=;
        b=Xn9qWw19EeImCY6xmBbpxuIAOrlJVLTaHqExB2VvRs+H3MGMO8676C8gcU4qB0gDI1
         SkU7nFdfiVOIJs0Yclc4duz6LrepTlhsgN+ppv36LU9VlO7A8RbkBrNDLvbCQHgWbRBx
         Gc3Oh1xc9tbrUHPQKHayxAq8n0J1L++yRDhR38ucAyMiuibbAKV9StjK/0/XoZLYnUvm
         PFjNtccLi/MR08Wr6Mi+VI/+XCl7Qi/59ehWR7T9KUjegVuCmDmRP3mRU4Y46pi+g4iI
         NxqoNCIUxTjcrJ4QIZsF0lFGS0ob7VM/r9vZdEz5/77qmmLsv55b3qZTD7N5faz+J4uc
         gxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zVSP51Ingwl2UVlqRpP/I0FJyovmY47JrxzcmpuE23w=;
        b=mY1ZxlOSDKpWpLQVp3m12G2EVuWQp7aVtDT5oW/+rW+Gjl9P/BPGWg8j2HF2IHGQJ2
         EUp7eS7cijhneQGlbDTwmGU50YB89Ywq7wXMGr6MdWgnwsZwaDuNm3ts2T7zMGLOVrNo
         I726uIFP1dfQeYp8l/ABacM69Mmu4hyFiBuQ3BpgRK840BbykClGQR9rFuf+1Iw/s5e7
         QY3punmZ8v6AM7E08AE9oQ09dxHRVCUkM0fDfSQebrtqxVQN+AQJdt/eatkgYOkn6WUu
         iW5VsYTxAmssCMFr5wTscb4kHlHXi8VmddYa0U0WA07DutI6QobzjsZ7t16lI3/hbL+W
         YAkg==
X-Gm-Message-State: ALQs6tAtfUcLmMXdT4SxsrfIHKQWJPok48N+NUVDO8HbI3obvpuvqVLm
        TtGdJhzLVlMcDh6sg8v/FP92D+FtYwvp/jEsMhAIKQ==
X-Google-Smtp-Source: AB8JxZqK1kNkm/n29Q79tUU+j1PsjNvuItCwQ7QrlqHCqpaZUJsyfG7AkAc7XqQv7pSKW9UyKrwRKiAwzU57jKlcpKc=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr20476647ybi.515.1525721110536;
 Mon, 07 May 2018 12:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 12:25:09 -0700 (PDT)
In-Reply-To: <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net> <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 12:25:09 -0700
Message-ID: <CAGZ79kZXXiWrGgO-KU+afncfNTZzp=AHHJY5qZqA9qAg5YLuuQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update brian m. carlson's email address
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 8:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> The order of addresses in the mailmap file was reversed, leading to git
>> preferring the crustytoothpaste.ath.cx address, which is obsolete, over
>> the crustytoothpaste.net address, which is current.  Switch the order of
>> the addresses so that git log displays the correct address.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>
> I initially reacted to "was reversed" with "yikes, did we break the
> mailmap reader and we need to update the file?", but apparently that
> is not what this patch is about.  I think what is happening here is
> that cdb6b5ac (".mailmap: Combine more (name, email) to individual
> persons", 2013-08-12) removed
>
> -Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
>
> and then added these two lines
>
> +brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
>
> where *.net address did not come from any other entry for you in the
> file.  I guess the author of the patch saw that you were sending
> your messages from the .net address and tried to help by unifying
> the two addresses, without knowing your preference and recorded two
> reversed entries.
>
> Will queue as-is for now, but if you want to update the log message
> I do not mind taking a reroll.

brian,

sorry to break you there. I was the author of the patch Junio found, organizing
the .mailmap file was one of my starter contributions. I recall asking all the
people if they were ok with it their names combined in different spellings
94b410bba86 (.mailmap: Map email addresses to names, 2013-07-12)
f4f49e2258a (.mailmap: Combine more (email, name) to individual
persons, 2013-07-14)
and I vaguley recall asking you about capitalization of your name there
and you preferred the lower case name, but apparently I never asked you
about the preferred email address.

Sorry and thanks for fixing,
Stefan
