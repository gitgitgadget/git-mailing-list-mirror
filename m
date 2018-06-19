Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3741F403
	for <e@80x24.org>; Tue, 19 Jun 2018 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeFSXtH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 19:49:07 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35769 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeFSXtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 19:49:03 -0400
Received: by mail-qt0-f196.google.com with SMTP id s9-v6so1482961qtg.2
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=953jyTbmXnD8K/FAnQFExGspN2UwPXsEmkKGIUUSBQg=;
        b=MqMy1dQNjEiPS+DGkzA59SLUJ5sOHWYzbHvIGqyAsxQVn6CvTPDPbQzXJ7bGzMFAJW
         ndjFTNFML9LR4g90Dy5J0SnyLLsQMycs3lpc9SAx9tvg2IhC6YhG1HBRPXL1OvLTnKpj
         THuzn378hr1xi1BHz3ry5m94i81Sl0aioaIXGSOqik0kcsdieBnKDV0ucVNghG82MLE/
         Ifd/KusJcnIRItc+JVOSH19JOh4x7/Px/Qf3/xJghdW2lSxFRXoMP29eX+MdEVnz7Qix
         RpfFVYdBWnabGL4aNkLwmSCxs9SMxhlybvdH7AY05X2U8XnZKcmFgN4CXxy/68m+nUGM
         syyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=953jyTbmXnD8K/FAnQFExGspN2UwPXsEmkKGIUUSBQg=;
        b=nZTtI/Xcay/5djI0pgxxj+Jq2HlwXgXGURN9d5Xdl//KbobFo+2rhdN6dBHTjh8ipR
         txPI90IA98tIcd6BrQt940uRWugTtY/7svPVbxDkSQlwxpUl6P5c1rpnOAZcYjjV5XLq
         +RjpqUwJpPcvYN5Bt7w7ZqzgGEhj4DraA1gDiz9Nn+5mtEExW6TjtfEegjPk1o0gMgoW
         rnFnypksSkgwcSJWazC6zjPBs42sJCnH1fnKCLd3uexd05jcu8lE4ysAI8PhYiM2Q9rr
         lTOTVEWUk/NUDLX/Is/Rc4hH/k03/ptDKFh4wR9t759asO1MO90UT4kwW71g3ogEs3BB
         4IQA==
X-Gm-Message-State: APt69E3stkhXCqLyXaukjq6kfJWHhn15635o7hRDZxZXSTVXXTFpeRve
        d2wNRm9+nGkJ59yKwlLFmzM=
X-Google-Smtp-Source: ADUXVKL7KlHsJInXZmWV2QtpnTrBtVq8ocXtt5WoK9DIGhR6YpQjH/DJ9WF8YvoBItuwwTcjTl+ReA==
X-Received: by 2002:a0c:8992:: with SMTP id 18-v6mr16406959qvr.61.1529452142734;
        Tue, 19 Jun 2018 16:49:02 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v88-v6sm856599qkl.57.2018.06.19.16.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 16:49:02 -0700 (PDT)
Subject: Re: [PATCH] ewah: delete unused 'rlwit_discharge_empty()'
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <7bfb528f-ef65-4de6-7d01-6ca91f0072e7@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <795ca948-1633-a1f7-1d7c-88ace8361445@gmail.com>
Date:   Tue, 19 Jun 2018 19:49:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7bfb528f-ef65-4de6-7d01-6ca91f0072e7@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2018 5:51 PM, Ramsay Jones wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> Complete the removal of unused 'ewah bitmap' code by removing the now
> unused 'rlwit_discharge_empty()' function. Also, the 'ewah_clear()'
> function can now be made a file-scope static symbol.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> Can you please add this to the 'ds/ewah-cleanup' branch, before
> we forget to do so! ;-)
>
> Thanks!
>
> ATB,
> Ramsay Jones


Looks good to me! Thanks!

-Stolee


>
>   ewah/ewah_bitmap.c | 20 ++++++++++++--------
>   ewah/ewah_rlw.c    |  8 --------
>   ewah/ewok.h        |  6 ------
>   ewah/ewok_rlw.h    |  1 -
>   4 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 017c677f9..d59b1afe3 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -276,6 +276,18 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
>   	}
>   }
>   
> +/**
> + * Clear all the bits in the bitmap. Does not free or resize
> + * memory.
> + */
> +static void ewah_clear(struct ewah_bitmap *self)
> +{
> +	self->buffer_size = 1;
> +	self->buffer[0] = 0;
> +	self->bit_size = 0;
> +	self->rlw = self->buffer;
> +}
> +
>   struct ewah_bitmap *ewah_new(void)
>   {
>   	struct ewah_bitmap *self;
> @@ -288,14 +300,6 @@ struct ewah_bitmap *ewah_new(void)
>   	return self;
>   }
>   
> -void ewah_clear(struct ewah_bitmap *self)
> -{
> -	self->buffer_size = 1;
> -	self->buffer[0] = 0;
> -	self->bit_size = 0;
> -	self->rlw = self->buffer;
> -}
> -
>   void ewah_free(struct ewah_bitmap *self)
>   {
>   	if (!self)
> diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
> index b9643b7d0..5093d43e2 100644
> --- a/ewah/ewah_rlw.c
> +++ b/ewah/ewah_rlw.c
> @@ -104,11 +104,3 @@ size_t rlwit_discharge(
>   
>   	return index;
>   }
> -
> -void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out)
> -{
> -	while (rlwit_word_size(it) > 0) {
> -		ewah_add_empty_words(out, 0, rlwit_word_size(it));
> -		rlwit_discard_first_words(it, rlwit_word_size(it));
> -	}
> -}
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 0c504f28e..84b2a29fa 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -72,12 +72,6 @@ void ewah_pool_free(struct ewah_bitmap *self);
>    */
>   struct ewah_bitmap *ewah_new(void);
>   
> -/**
> - * Clear all the bits in the bitmap. Does not free or resize
> - * memory.
> - */
> -void ewah_clear(struct ewah_bitmap *self);
> -
>   /**
>    * Free all the memory of the bitmap
>    */
> diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
> index bb3c6ff7e..7cdfdd0c0 100644
> --- a/ewah/ewok_rlw.h
> +++ b/ewah/ewok_rlw.h
> @@ -98,7 +98,6 @@ void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *bitmap);
>   void rlwit_discard_first_words(struct rlw_iterator *it, size_t x);
>   size_t rlwit_discharge(
>   	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate);
> -void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out);
>   
>   static inline size_t rlwit_word_size(struct rlw_iterator *it)
>   {
