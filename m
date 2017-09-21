Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01002047F
	for <e@80x24.org>; Thu, 21 Sep 2017 08:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdIUIkt (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 04:40:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60092 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751635AbdIUIkq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 04:40:46 -0400
X-AuditID: 1207440f-a43ff70000007960-58-59c37b0df7a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.2C.31072.D0B73C95; Thu, 21 Sep 2017 04:40:45 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCB74.dip0.t-ipconnect.de [87.188.203.116])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8L8eh5m023821
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 21 Sep 2017 04:40:44 -0400
Subject: Re: [RFC v2] refs: strip out not allowed flags from
 ref_transaction_update
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
 <20170912225921.27705-1-t.gummerer@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4ae6cb35-ecf4-e2a2-302d-95e1442cf101@alum.mit.edu>
Date:   Thu, 21 Sep 2017 10:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912225921.27705-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1OWtPhxp0NGoatF1pZvJoqH3CrPF
        hdW32R2YPXbOusvucfGSssfnTXIBzFFcNimpOZllqUX6dglcGXuWHmEsuCNf0Te9ibmB8b1E
        FyMHh4SAicTiGWpdjJwcQgI7mCS+TMzuYuQCsi8wSVza08QOkhAWCJW4s28xM4gtIqAlMelr
        HyuIzSxgLbHs9DMWiIYGRomHz5axgCTYBHQlFvU0M4HYvAL2Ens394I1sAioSrzZ9ZgRxBYV
        iJDoe3uZHaJGUOLkzCdgvZwCVhJHjp1ihligLvFn3iUoW1zi1pP5TBC2vETz1tnMExgFZiFp
        n4WkZRaSlllIWhYwsqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3ECAlo/h2M
        XetlDjEKcDAq8fC+MDscKcSaWFZcmXuIUZKDSUmU90ghUIgvKT+lMiOxOCO+qDQntfgQowQH
        s5II74QyoBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYL3eCVQo2BR
        anpqRVpmTglCmomDE2Q4D9DweyA1vMUFibnFmekQ+VOMilLivKogCQGQREZpHlwvLOG8YhQH
        ekWY16gKqIoHmKzgul8BDWYCGpy94QDI4JJEhJRUAyNX6NnHT/J257c+swyZdNFEY/b3u0mq
        mfbLhHufcineZDy+s6P52adDu7WfT0yO0RQQjlmn/MH+wNYia9lryV7bThRwd/eqWBRPqy9L
        iDtktSsj3Nb9xZvCxuYDaY4JbxWdk8ss0jvnnMlbpSV01vpceYKRc19S9Y2bp6wqJNnkv3so
        iG7TUGIpzkg01GIuKk4EAE4nC5MTAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/13/2017 12:59 AM, Thomas Gummerer wrote:
> Callers are only allowed to pass certain flags into
> ref_transaction_update, other flags are internal to it.  To prevent
> mistakes from the callers, strip the internal only flags out before
> continuing.
> 
> This was noticed because of a compiler warning gcc 7.1.1 issued about
> passing a NULL parameter as second parameter to memcpy (through
> hashcpy):
> 
> In file included from refs.c:5:0:
> refs.c: In function ‘ref_transaction_verify’:
> cache.h:948:2: error: argument 2 null where non-null expected [-Werror=nonnull]
>   memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from git-compat-util.h:165:0,
>                  from cache.h:4,
>                  from refs.c:5:
> /usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared here
>  extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
>               ^~~~~~
> 
> The call to hascpy in ref_transaction_add_update is protected by the

s/hascpy/hashcpy/

> passed in flags, but as we only add flags there, gcc notices
> REF_HAVE_NEW or REF_HAVE_OLD flags could be passed in from the outside,
> which would potentially result in passing in NULL as second parameter to
> memcpy.
> 
> Fix both the compiler warning, and make the interface safer for its
> users by stripping the internal flags out.
> 
> Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
>> This might be a nice change to have anyway, to isolate
>> `ref_transaction_update()` from mistakes by its callers. For that
>> matter, one might want to be even more selective about what bits are
>> allowed in the `flags` argument to `ref_transaction_update()`'s
>> callers:
>>
>>>         flags &= REF_ALLOWED_FLAGS; /* value would need to be determined */
> 
> Here's my attempt at doing this.
> 
> The odd flag out as the flag that's advertised as internal but can't
> stripped out is REF_ISPRUNING.  REF_ISPRUNING is passed in as argument
> to 'ref_transaction_delete()' in 'prune_ref()'.
> 
> Maybe this flag should be public, or maybe I'm missing something here?
> Having only this internal flags as part of the allowed flags feels a
> bit ugly, but I'm also unfamiliar with the refs code, hence the RFC.
> If someone has more suggestions they would be very welcome :)

I wouldn't worry too much about this anomaly. `REF_ISPRUNING` is an ugly
internal kludge, but allowing it in the mask doesn't make anything worse.

>  refs.c | 2 ++
>  refs.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index ba22f4acef..fad61be1da 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -921,6 +921,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  		return -1;
>  	}
>  
> +	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> +

I would advocate considering it a bug if the caller passes in options
that we are going to ignore anyway:

        if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
                BUG("illegal flags %x in ref_transaction_update", flags);

Would this also squelch the compiler warning?

>  	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
>  
>  	ref_transaction_add_update(transaction, refname, flags,
> diff --git a/refs.h b/refs.h
> index 6daa78eb50..4d75c207e1 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -354,6 +354,14 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
>  #define REF_NODEREF	0x01
>  #define REF_FORCE_CREATE_REFLOG 0x40
>  
> +/*
> + * Flags that can be passed in to ref_transaction_update
> + */
> +#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
> +	REF_ISPRUNING |                      \
> +	REF_FORCE_CREATE_REFLOG |            \
> +	REF_NODEREF
> +
>  /*
>   * Setup reflog before using. Fill in err and return -1 on failure.
>   */
> 

Thanks for working on this.

Michael
