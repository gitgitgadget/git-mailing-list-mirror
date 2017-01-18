Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C6F1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdARWHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:07:51 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34766 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbdARWHu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:07:50 -0500
Received: by mail-io0-f173.google.com with SMTP id l66so23570804ioi.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HzaFHoHA1IcKv3rGRLLAB349cKg6KzJ3SH4vqbdw1T4=;
        b=MTL9Lah7z0KLmnQc3b8flaESUzblHxcOA+GVtlfgdgX9XOv4HRQlxFW6fLW3tex7Kn
         J3w1CvE4E6TdTkMk0jmjQqa501AzbLaJV/fBg3G7w2aC4nuEg6L4db/7YSbdpPk4tnCW
         zwDHHc9/XLtxzL5+DqhNQSQEQ1bl7oar91GZlIeE1hFgfVfQTjrPgfJyDyROz+rRd3eo
         3NoVI8CspQ7X7u4E406olZgFJ6cZJESHhA/MwTjkgoS0zPdCZ5aSSxhE/C2bZjXu/n15
         ksGce239uWWg9KE3GFD5D2XAHy/APbcOw1oKk2tVXQptGD5zBorgrKiH5JANZkVtZ418
         dQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HzaFHoHA1IcKv3rGRLLAB349cKg6KzJ3SH4vqbdw1T4=;
        b=B318DWBuxhsrBNKfg2/Y5plLEnBVrQSm1Z1a6W+k2NgiZnrHz5XxBYgsw/hMCl+Jgz
         qIe58i51O/u5IdYMLiDFQOA+bSViErIgqOL5RGPx0zcrwsNGEeywiKQ9YHzGURappZQK
         zgWAq6uU7V+4UP539Fh72WkQgWL4PQkNtldqCMYhafbSD9JBzwiD3XhaTqJX0YSPIMNf
         wdgbwfB6owzh+ejeQwVvJK5bDicxg7aKe2dPFN/Uu5EuyiHsYhXQ8UGaaLiIparXhawA
         chz+NFEenEJ1uApUzeIGzebpwflIZbfa3bi7rx+h3RYcfRW9fqmvSWJ2Dx854oz+4dTx
         py4A==
X-Gm-Message-State: AIkVDXIQ5L3CW6wMv2Jm0NvSfhaPgBPE3zLHzK4RIggBmgaMpKvSqvAB0j0dj7Tz4Xc4ap5+sYDIF4mOZ6WS0Sz7
X-Received: by 10.107.37.148 with SMTP id l142mr5395913iol.159.1484777205111;
 Wed, 18 Jan 2017 14:06:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 14:06:44 -0800 (PST)
In-Reply-To: <xmqqfukg3w7t.fsf@gitster.mtv.corp.google.com>
References: <20170117233503.27137-1-sbeller@google.com> <20170117233503.27137-3-sbeller@google.com>
 <xmqqfukg3w7t.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 14:06:44 -0800
Message-ID: <CAGZ79kYoZOWDHewA4f9VjVkEZBXWaG5Uq8nU=M30mE535zVa2Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] remove_index_entry_at: move documentation to cache.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  cache.h      | 3 +++
>>  read-cache.c | 1 -
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 270a0d0ea7..26632065a5 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -599,7 +599,10 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
>>  #define ADD_CACHE_KEEP_CACHE_TREE 32 /* Do not invalidate cache-tree */
>>  extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
>>  extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
>> +
>> +/* Remove entry, return 1 if there are more entries after pos. */
>>  extern int remove_index_entry_at(struct index_state *, int pos);
>
> What is the reason why this now promise to return 1, as opposed to
> the original that were allowed to return anything that is "true"?
> Is it because you are adding other return values that mean different
> things?
>
> If that is the case it may be fine (it depends on what these other
> values mean and what use case it supports), but please do that in a
> separate patch.
>

Actually my line of thinking was to improve the correctness by being more
specific.

In a reroll I move the comment verbatim.
