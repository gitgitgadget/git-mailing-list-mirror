Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453191F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfACHWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:22:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53744 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfACHV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:21:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so28434337wmb.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jYx1c48kjW2daZWQwHQYKC9HPh6irNjZtDui1eo7l4M=;
        b=fawRANg9PlaQBmzyo5d1S+k7ItUw/aJ49eIo0Wo58iBrSEgIMctRAD/q9a46M/Jc+3
         xbkpirwx33wahf7jOPot0+iL9xP7Ft/oIeH6BcburdT40bCnKgXqBvWVDIaxMKMh63Nl
         Ixnv13Mf0+ACwZi6IoC3zztBFYWm8kAfDVkdc15HxXJ+bJ4d20vuzs2svgfRdXPHG5dK
         ILk0W/VEctXhYXiqAMBYcENxid3WHriQV1OwLfjiJ91ezZKJhoyIcpNCGnRViFxl64/m
         4c42nb1IskYDS1C8iiX1mVEhxta/oe8rLVB+u/pqaKFESChysppND1Bjq+/EdS8RBPxE
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jYx1c48kjW2daZWQwHQYKC9HPh6irNjZtDui1eo7l4M=;
        b=uOBX60jpMeVYhc5/0hGZSZOpnDx4DvSIOcv1hyb2UStd0lLBueOau6eJnSx20h9CaG
         8Rv+KqFJYsZfXxSGM5UW7PvFrigMPIm1xuQKIJRgKIlXjH0etZyOMHnE9O7J3EuQ6B28
         5MTV7GPlPo7h5e3NGKNJTIKy6+/ty9eqDCoe78k0NUl0aDqldTSeNYHFmHOtcUX2BZtu
         eulXTKPLL73DglMVtjy9y/Zr86Rh7MuwDVH9rAW6fsdrTYSfQ3qkRaXjoLdzmLPUL4U1
         28P3PSzG6ubJ9s1oKm1nNgNhq2KxEJThgH9tAapAFQ535uDxE0ij6XupgmpIghehAB31
         NISQ==
X-Gm-Message-State: AA+aEWZab4B3ZKxcpIMUA7llfRKqXXa5XR5tb3S5ipbbMvoDn6WLwoEo
        llN6taoL8JhVXKAkWWXKaoJQHkIH
X-Google-Smtp-Source: ALg8bN6p9Oa0R66ThAdY0q5K4gxHDSDQx9mJJhtTQcvGOKfMnA/zFGCIkrG89VgCPnM8hzyuN1kQcg==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr38521059wmu.52.1546500116219;
        Wed, 02 Jan 2019 23:21:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c12sm42894151wrs.82.2019.01.02.23.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 23:21:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Albert Burt <aburthinds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2] doc: remove unneeded TODO for release_commit_memory
References: <CACsJy8D_gTKWXogPDNW7NQk_a0ChBu28HfGu388hFn3-by_cRw@mail.gmail.com>
        <20190101200818.81273-1-aburthinds@gmail.com>
        <CACsJy8B4FCkrV0srm8pvcU41DMWoZwDHgW8Wu0j3nZT5JLhEBA@mail.gmail.com>
Date:   Wed, 02 Jan 2019 23:21:55 -0800
In-Reply-To: <CACsJy8B4FCkrV0srm8pvcU41DMWoZwDHgW8Wu0j3nZT5JLhEBA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 2 Jan 2019 18:17:44 +0700")
Message-ID: <xmqqftuai4to.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 2, 2019 at 3:09 AM Albert Burt <aburthinds@gmail.com> wrote:
>>
>> Remove TODO that was left in from:
>> commit 110240588d (Merge branch 'sb/object-store-alloc' - 2018-06-25)
>>
>> Todo can be removed as:
>> 9d2c97016f (commit.h: delete 'util' field in struct commit - 2018-05-19)
>> deletes commit->util.
>>
>> Signed-off-by: Albert Burt <aburthinds@gmail.com>
>> ---
>>
>> Thanks for looking at this for me Duy. I updated some of the changes you
>> suggested.
>>
>> Let me know if there's anything else that I would need to clean up, or do better.
>> :)
>
> Nope. The patch looks good to me.

Yes, but we'll fix this with 6a7895fd ("commit: prepare
free_commit_buffer and release_commit_memory for any repo",
2018-12-14) anyway, so I am not sure if this is worth pursuing
separately.

>
>>
>>  commit.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/commit.c b/commit.c
>> index 2d94e0b199..2ff6dca0bc 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -357,8 +357,6 @@ void release_commit_memory(struct commit *c)
>>         c->index = 0;
>>         free_commit_buffer(c);
>>         free_commit_list(c->parents);
>> -       /* TODO: what about commit->util? */
>> -
>>         c->object.parsed = 0;
>>  }
>>
>> --
>> 2.17.2 (Apple Git-113)
>>
