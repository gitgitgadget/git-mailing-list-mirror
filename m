Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19F51F954
	for <e@80x24.org>; Wed, 22 Aug 2018 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeHVRyK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 13:54:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43305 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeHVRyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 13:54:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id 130-v6so1304506qkd.10
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=i8eThQzP8/Eq4yoSX1qTmdVLINmEDQIhrl7vHKOb+To=;
        b=E/9asNvqfPFAkP/5nwSXWk1h8SCKRPOuhAMpHYLNRXUJTuRVwg9j/pB5Gm8q31uCG7
         NX7XpNzDeOghvghRADWfkhq45ngxaFsAcMmgQkXmAh4fqso/eYcMikL6ZA1IytESx2g+
         OFp3SY1zTnP7S1Xqz+O/fgSwq9/w13l9ngoGZAWjy9RKjcyWwY15JJDyd4xxEUBbhtoa
         6ERtWbPSCtBGm9+VKgbFA1AXP9nosv0ehxkQfCu2rC2I8yINNDg2WCMUADhfUSzDPE9X
         +WJwUL8MsglNtKpyOE8Z6My0UfvllIkpoxyHxfplc0hIbkKXcHIihppDI6+Jh/S5X/UD
         7kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i8eThQzP8/Eq4yoSX1qTmdVLINmEDQIhrl7vHKOb+To=;
        b=KEckdZkvFvldTz+0TR5+DW0O6VkrbaVFq8uPOcaPFM928g+t+BsisH62HIKOg+vA9v
         mk9b79jTVEadxdO0Ql0DC1uRJUwA4NBXNbj0+/h73IVECEH0BzD/htApDtPgZUWboyGg
         hb+iw2hVDfMYssra1uej6Rh4Wqeod1wBpAruNoTZYSkMQS2UJlbN/mC3573uDM7hXfsM
         5/kRY6Q33YOFUEUf3YNH9N60T/JhUJ3ekVPKWkrayvSB6TR9PkgxIqG8+ooqUIa9cNI6
         fn+iYA0cE/J0CSIA1kgbYHL7ekZ2/HWVlXFezL9hzM3CdVVnqQj1zPZPOOGbyotLoCmJ
         9Tlw==
X-Gm-Message-State: APzg51D31jBNDfktfgJW+tnJGVihqLpPnIKOksJ8n6ZbMpcA9iJIb8Bo
        e3fH1mHEHeHHnGLXODhzLZAcRyrD
X-Google-Smtp-Source: ANB0VdYhOIjCEQUUaggAE2WsWCYaDY/lY0Y+/29vV0hmTXpBk6+CYm5HkymiIB2BLcHJ5B9pzC5m1Q==
X-Received: by 2002:a37:4a51:: with SMTP id x78-v6mr3094334qka.188.1534948140915;
        Wed, 22 Aug 2018 07:29:00 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id s73-v6sm1058165qkl.65.2018.08.22.07.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 07:28:59 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <459f138f-78ba-6465-0f2b-b2419bbc36ff@gmail.com>
Date:   Wed, 22 Aug 2018 10:28:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180822053626.GB535143@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2018 1:36 AM, brian m. carlson wrote:
> On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
>> So I wonder if there's some other way to tell the compiler that we'll
>> only have a few values. An enum comes to mind, though I don't think the
>> enum rules are strict enough to make this guarantee (after all, it's OK
>> to bitwise-OR enums, so they clearly don't specify all possible values).
> I was thinking about this:
>
> diff --git a/cache.h b/cache.h
> index 1398b2a4e4..1f5c6e9319 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1033,7 +1033,14 @@ extern const struct object_id null_oid;
>   
>   static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>   {
> -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +	switch (the_hash_algo->rawsz) {
> +		case 20:
> +			return memcmp(sha1, sha2, 20);
> +		case 32:
> +			return memcmp(sha1, sha2, 32);
> +		default:
> +			assert(0);
> +	}
>   }
>   
>   static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>
> That would make it obvious that there are at most two options.
> Unfortunately, gcc for me determines that the buffer in walker.c is 20
> bytes in size and steadfastly refuses to compile because it doesn't know
> that the value will never be 32 in our codebase currently.  I'd need to
> send in more patches before it would compile.
>
> I don't know if something like this is an improvement or now, but this
> seems to at least compile:
>
> diff --git a/cache.h b/cache.h
> index 1398b2a4e4..3207f74771 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1033,7 +1033,13 @@ extern const struct object_id null_oid;
>   
>   static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>   {
> -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +	switch (the_hash_algo->rawsz) {
> +		case 20:
> +		case 32:
> +			return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +		default:
> +			assert(0);
> +	}
>   }
In my testing, I've had the best luck with this change:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..6c8b51c390 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,7 +1023,14 @@ extern const struct object_id null_oid;

  static inline int hashcmp(const unsigned char *sha1, const unsigned 
char *sha2)
  {
-       return memcmp(sha1, sha2, the_hash_algo->rawsz);
+       switch (the_hash_algo->rawsz) {
+               case 20:
+                       return memcmp(sha1, sha2, 20);
+               case 32:
+                       return memcmp(sha1, sha2, 32);
+               default:
+                       assert(0);
+       }
  }

The fact that '20' and '32' are constants here may be helpful to the 
compiler. Can someone else test the perf?

Thanks,
-Stolee
