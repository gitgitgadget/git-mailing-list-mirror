Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CEF7208DB
	for <e@80x24.org>; Tue, 29 Aug 2017 08:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdH2IdY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:33:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58049 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750758AbdH2IdW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:33:22 -0400
X-AuditID: 1207440e-bf9ff70000007085-19-59a526d04164
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CF.FF.28805.0D625A95; Tue, 29 Aug 2017 04:33:21 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8XII0003454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:33:20 -0400
Subject: Re: [PATCH v2 1/2] refs/files-backend: add longer-scoped copy of
 string to list
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
 <7f6617d2f1df9ee6746e4cbc41dc84bdb7788574.1503951733.git.martin.agren@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <49134978-130d-ff43-e3c6-bde211710064@alum.mit.edu>
Date:   Tue, 29 Aug 2017 10:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7f6617d2f1df9ee6746e4cbc41dc84bdb7788574.1503951733.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1L2otjTSYNdmbouuK91MFg29V5gt
        /r7pYnRg9tg56y67x8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZey8epqt4KVcxaFTFxkbGPdL
        dDFyckgImEj8ufyGpYuRi0NIYAeTxN6OC1DOeSaJacuOM3cxcnAIC0RJvN3DD9IgIhAhcX/m
        XWYQm1lATaJ90xRWiPrFjBIbun+wgCTYBHQlFvU0M4HYvAL2EkcW/GcFsVkEVCXOr9kO1iwK
        NKjv7WV2iBpBiZMzn4D1cgrESly88ooVYoG6xJ95l6CWiUvcejKfCcKWl2jeOpt5AqPALCTt
        s5C0zELSMgtJywJGllWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYISHNt4Ox
        fb3MIUYBDkYlHt4V1ksihVgTy4orcw8xSnIwKYnySqoujRTiS8pPqcxILM6ILyrNSS0+xCjB
        wawkwhvMDpTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw1oIMFSxK
        TU+tSMvMKUFIM3FwggznARo+E6SGt7ggMbc4Mx0if4pRUUqcd44KUEIAJJFRmgfXC0s5rxjF
        gV4R5n0I0s4DTFdw3a+ABjMBDVYUXAgyuCQRISXVwMh+1zzd0LLE5BuLTeK+nS+8axt+J64/
        cqgwuzJD5OCab7Z1HItyvz9fJDpLMTP/5MkJAolf32jYiB8oXxz3ZctZpcp75x58/XL7poK1
        Z7bIjbv3NrV97Zy7u3LbCXmjfym7G2a67Gs3PH1rzoYu296m2MbNs50/l51aqlo9/y3HhC0+
        DH4WEq1KLMUZiYZazEXFiQDWRKHDFAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/28/2017 10:32 PM, Martin Ågren wrote:
> split_symref_update() receives a string-pointer `referent` and adds it
> to the list of `affected_refnames`. The list simply holds on to the
> pointers it is given, it does not copy the strings and it never frees
> them. The `referent` string in split_symref_update() belongs to a string
> buffer in the caller. After we return, the string will be leaked.
> 
> In the next patch, we want to properly release the string buffer in the
> caller, but we can't safely do so until we've made sure that
> `affected_refnames` will not be holding on to a pointer to the string.
> We could configure the list to handle its own resources, but it would
> mean some alloc/free-churning. The list is already handling other
> strings (through other code paths) which we do not need to worry about,
> and we'd be memory-churning those strings too, completely unnecessary.
> 
> Observe that split_symref_update() creates a `new_update`-object and
> that `new_update->refname` is then a copy of `referent`. The difference
> is, this copy will be freed, and it will be freed *after*
> `affected_refnames` has been cleared.
> 
> Rearrange the handling of `referent`, so that we don't add it directly
> to `affected_refnames`. Instead, first just check whether `referent`
> exists in the string list, and later add `new_update->refname`.
> 
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> Thanks Junio and Michael for your comments on the first version. This
> first patch is now completely different and much much better (thanks
> Michael!). The commit message should also be better (sorry Junio...).
> The second one has a new commit message, but the diff is the same.
> 
> Martin
> 
>  refs/files-backend.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5cca55510..bdb0e22e5 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2140,13 +2140,12 @@ static int split_symref_update(struct files_ref_store *refs,
>  
>  	/*
>  	 * First make sure that referent is not already in the
> -	 * transaction. This insertion is O(N) in the transaction
> +	 * transaction. This check is O(N) in the transaction

The check is not O(N); it is O(lg N) because it is implemented via a
binary search in the (sorted) `affected_refnames`. The insertion below
is still O(N), because it has to shift entries later in the list to the
right to make room for the new entry.

>  	 * size, but it happens at most once per symref in a
>  	 * transaction.
>  	 */
> -	item = string_list_insert(affected_refnames, referent);
> -	if (item->util) {
> -		/* An entry already existed */
> +	if (string_list_has_string(affected_refnames, referent)) {
> +		/* An entry already exists */
>  		strbuf_addf(err,
>  			    "multiple updates for '%s' (including one "
>  			    "via symref '%s') are not allowed",
> @@ -2181,6 +2180,15 @@ static int split_symref_update(struct files_ref_store *refs,
>  	update->flags |= REF_LOG_ONLY | REF_NODEREF;
>  	update->flags &= ~REF_HAVE_OLD;
>  
> +	/*
> +	 * Add the referent. This insertion is O(N) in the transaction
> +	 * size, but it happens at most once per symref in a
> +	 * transaction. Make sure to add new_update->refname, which will
> +	 * be valid as long as affected_refnames is in use, and NOT
> +	 * referent, which might soon be freed by our caller.
> +	 */
> +	item = string_list_insert(affected_refnames, new_update->refname);
> +	assert(!item->util);

We generally avoid using `assert()`. It would be preferable to use

        if (item->util)
                BUG("%s unexpectedly found in affected_refnames",
new_update->refname);

>  	item->util = new_update;
>  
>  	return 0;
> 

Otherwise, looks good!

Michael
