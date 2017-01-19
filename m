Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F961F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 00:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdASAPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 19:15:53 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:38791 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdASAPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 19:15:51 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so23078352itd.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7V3QeP0ZMlGluJnjRx7qkif3uC2r6zp/9rK0qv5Q7qU=;
        b=vkiBa1JuCEnAuEz7WnnqbAUErC+qhNz/JDFxG7Pcc8FgGnIuwaXShcfBgeU8MZOnvp
         rSvTs4HHo2Ty1EPsCbuZmOgPuneDbJQb9bT8pUriqhGn3luzjn+MNvqzPsrQ8gA8A4ag
         pyPxM1H6O06tEFaPKvM+EECzTne8k9ds7Ny+FF4Qp1ZE3d/pgMT5MHMqlesdmQeVeQWY
         iY4OagGowAS07RqVFoFdbd6eWmjRVqFKxw2xUmeo9FJMBRQ+juxjRo2m4tdtpeQVZnWu
         UT1YIe1HOX51GQ+GuSbalwomOWcQOAhn7r2tOaFiDRFCufqaF9B+TZGOS7Uqx9IqbrPD
         n2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7V3QeP0ZMlGluJnjRx7qkif3uC2r6zp/9rK0qv5Q7qU=;
        b=F/QuSt+YLe57a98DII77GwD+NW2PgXTZH3+AoFcQL48vVWw4evyBqjcy0pOs9naa3T
         NJSTIi7NTh6HUTzhlubLLbD9Ak8LEXVVboggpFq3RCyJwouic0uYdYIOBH+c+MlFmmLU
         UueC9qrdaSSYvmDT/MB47p5/GZiO7KKWcVZYWvUYdk9l33hjQMUm158hV9Bnsn7OgD7o
         TTCfvps+5DLq7K8RwOzq2L1Rw1a/lg5sh3H54oWzoFDJOf/ifnTHH09gbrOS2Z0WRLk7
         fDmjMplKUzQ88VspjpCYvN68LtJ4pjKxeyTrOmzk7ADHM0kDO8NqXYkZEby7aS5I2C/1
         u0ig==
X-Gm-Message-State: AIkVDXI9fpRIeSIdRCa3xj9C+q65ddaevj/WpKiF08Un0mR5pZgAZouoRXC+QXTbh1gwYXzhjP4hXBz5VT5OawE/
X-Received: by 10.36.193.135 with SMTP id e129mr28289955itg.69.1484784502547;
 Wed, 18 Jan 2017 16:08:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 16:08:22 -0800 (PST)
In-Reply-To: <20170119000037.GF10641@google.com>
References: <20170117233503.27137-1-sbeller@google.com> <20170118232145.31606-1-sbeller@google.com>
 <20170118232145.31606-4-sbeller@google.com> <20170119000037.GF10641@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 16:08:22 -0800
Message-ID: <CAGZ79kY_nbHuThnSDAyLhEwnRWYEQBmMLS4RtGPKOzYt_9Bgsg@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] cache.h: document add_[file_]to_index
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 4:00 PM, Brandon Williams <bmwill@google.com> wrote:
> On 01/18, Stefan Beller wrote:
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  cache.h | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 87eccdb211..03c46b9b99 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -609,13 +609,24 @@ extern int remove_index_entry_at(struct index_state *, int pos);
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
> I usually prefer having defines like these use shift operators to set
> the desired bit '(1<<2)' instead of '4', etc.  Is there a preference for
> git as a whole?  I know this is just a documentation change so maybe
> this isn't even the place to discuss this.

eh, and I forgot to remove the comments that Junio thought of as redundant.
I agree that (1<<N)) is usually better than the actual number. But I think
we do not want to change that for the same reason as we don't want to add
these comments there: Digging into history just got more complicated here.
("Who introduced ADD_CACHE_INTENT and why?" you need to skip the
reformatting/adding document patch to actually find the answer.)

Thanks for spotting,
Stefan

>
> --
> Brandon Williams
