Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26011F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbdARWJ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:09:29 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:38070 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbdARWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:09:26 -0500
Received: by mail-it0-f49.google.com with SMTP id c7so21242080itd.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MP8m2tBALYnHpG3MEDIUmUARoc4OlTG2MCxR0qd/Pz0=;
        b=QKfe6Z5JOpYc/Ob/VDwGoF+KtLYJZNkvPe9HSSHWc+tMWYzc9QMyukIGEJBxEA8QH9
         xYGKwGYN6Xy6D2ClYuLKCu0xc/i3B2YP3c9WmUqxk8bVmvM0h4xD4sR6P/ru1MtBeVDm
         xsOUn099VNy/wGVNAn+7azbIiGp57p+3bfWRUpYrNOAxpYI1IAlR6fTiweyn4/M5H4K9
         uL2q4oviVVKggTNuFYQzZV1sffhtkT02BAyyYjejlUCgayqqpw7XchOrfdLFUIiwSoc7
         iYSZ54CgmDDI+m3cmY9QjqtahnbUB2i6BNkWjTiALf/AtknjUQ/wVLOvOSdrVCyWHVct
         0MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MP8m2tBALYnHpG3MEDIUmUARoc4OlTG2MCxR0qd/Pz0=;
        b=gZhKvhvMgw9Oq7kE2dIdFQFpnWh6MUC3Q9GMYfFquqq9pQDid1bnIOmuC5CSnLjRja
         GMJ+BLX45QNjPKSdNlSsA21R3DLdVBie8jVfOLKFjWxwm8tC9VIfuZgvSb0WyigWQctz
         u5+qpaEdGhokAL30BWcL/nSKESiQIFPO1rn22kh4u1dBgjkSuvgat/4euIkqfHSSlfoG
         Dt8DqFi7GjHAg1DCbILu8ZWkdbOWxyG7Mep34OC8cimiKIFBEuLHW+nysYTZ+ZY8Gj0P
         T7R3AGNsL/rrkBZpJIQbleNCj9GEb0xwFOs1c9OytVEqTzDAahsyt38JjEB3wYw+ifwK
         /O+g==
X-Gm-Message-State: AIkVDXJvZxX5Ur76Ie4BI9tEYn1MNZ+iHZvstk0f9BR+eWZHyenC2MwszRTRBHH+wDExCektROM2VB/5fMky9xBZ
X-Received: by 10.36.141.2 with SMTP id w2mr27640031itd.114.1484777354485;
 Wed, 18 Jan 2017 14:09:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 14:09:13 -0800 (PST)
In-Reply-To: <xmqqbmv43vx9.fsf@gitster.mtv.corp.google.com>
References: <20170117233503.27137-1-sbeller@google.com> <20170117233503.27137-4-sbeller@google.com>
 <xmqqbmv43vx9.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 14:09:13 -0800
Message-ID: <CAGZ79kZ_j8YbLTtAH=3u8vZ5y+uJQ=cYJ_VbdT8_Mvhk=FMLoQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] document add_[file_]to_index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 1:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  cache.h | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 26632065a5..acc639d6e0 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -605,13 +605,20 @@ extern int remove_index_entry_at(struct index_state *, int pos);
>>
>>  extern void remove_marked_cache_entries(struct index_state *istate);
>>  extern int remove_file_from_index(struct index_state *, const char *path);
>> -#define ADD_CACHE_VERBOSE 1
>> -#define ADD_CACHE_PRETEND 2
>> -#define ADD_CACHE_IGNORE_ERRORS      4
>> -#define ADD_CACHE_IGNORE_REMOVAL 8
>> -#define ADD_CACHE_INTENT 16
>> +
>> +#define ADD_CACHE_VERBOSE 1          /* verbose */
>> +#define ADD_CACHE_PRETEND 2          /* dry run */
>> +#define ADD_CACHE_IGNORE_ERRORS 4    /* ignore errors */
>> +#define ADD_CACHE_IGNORE_REMOVAL 8   /* do not remove files from index */
>> +#define ADD_CACHE_INTENT 16          /* intend to add later; stage empty file */
>
> These repeat pretty much the same thing, which is an indication that
> the macro names are chosen well not to require extraneous comments
> like these, no?

Well I got confused for pretend and intent, so I researched them;
I did not want to comment only half the constants.


>
>> +/*
>> + * Adds the given path the index, respecting the repsitory configuration, e.g.
>> + * in case insensitive file systems, the path is normalized.
>> + */
>>  extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
>
> s/repsitory/repository/;
>
>> +/* stat the file then call add_to_index */
>>  extern int add_file_to_index(struct index_state *, const char *path, int flags);
>> +
>
> As you do not say "use the provided stat info to mark the cache
> entry up-to-date" in the add_to_index(), I am not sure if mentioning
> "stat the file then" has much value.  Besides, you are supposed to
> lstat(2) the file, not "stat", no?
>
> I'd cover these two under the same heading and comment if I were
> doing this.
>
>         These two are used to add the contents of the file at path
>         to the index, marking the working tree up-to-date by storing
>         the cached stat info in the resulting cache entry.  A caller
>         that has already run lstat(2) on the path can call
>         add_to_index(), and all others can call add_file_to_index();
>         the latter will do necessary lstat(2) internally before
>         calling the former.
>
> or something along that line.

That sounds better than what I had.

Thanks,
Stefan

>
>>  extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
>>  extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
>>  extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
