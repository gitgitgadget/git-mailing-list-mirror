Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EE71FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 07:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdJZHfh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 03:35:37 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43055 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751166AbdJZHfg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 03:35:36 -0400
X-AuditID: 1207440c-7e5ff7000000143e-6c-59f190453e9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 91.ED.05182.64091F95; Thu, 26 Oct 2017 03:35:34 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCA47.dip0.t-ipconnect.de [87.188.202.71])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9Q7ZUOs028342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 26 Oct 2017 03:35:32 -0400
Subject: Re: [PATCH 2/2] files-backend: don't rewrite the `packed-refs` file
 unnecessarily
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover.1508924577.git.mhagger@alum.mit.edu>
 <4c03fc458f619a5f02dd4cae38da8b9b139b850b.1508924577.git.mhagger@alum.mit.edu>
 <xmqqpo9ae79w.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <edd90206-7ad3-739e-b8ab-5aee469a8a48@alum.mit.edu>
Date:   Thu, 26 Oct 2017 09:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo9ae79w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqOs+4WOkwZMX7BZdV7qZLBp6rzBb
        /GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bFJSczLLUov07RK4Mv7umsRYcF+24uGjeUwNjMfF
        uxg5OSQETCS2TLrH3sXIxSEksINJYvevq2wQznkmiU175rODVAkLxEh8W/MMzBYRUJOY2HaI
        BcRmFjCSuDNzAxNEw05GiaZ1+9hAEmwCuhKLepqZQGxeAXuJX1/OgTWwCKhKtH3tZe5i5OAQ
        FYiQ2LCRH6JEUOLkzCdgJZwC1hKtredYIearS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMArOQ
        tM9C0jILScssJC0LGFlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRuYoSENM8O
        xm/rZA4xCnAwKvHwfvj4IVKINbGsuDL3EKMkB5OSKC/DHqAQX1J+SmVGYnFGfFFpTmrxIUYJ
        DmYlEV7Gto+RQrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd7V/UCN
        gkWp6akVaZk5JQhpJg5OkOE8QMOdQGp4iwsSc4sz0yHypxiNOY5tuvyHiePZzNcNzEIsefl5
        qVLivOf7gEoFQEozSvPgpsHS0itGcaDnhHm3gAzkAaY0uHmvgFYxAa1qUv0AsqokESEl1cBo
        rMy2bsKy3sm8cSxr2OYmrlZw5790eXN1i0HUue6d2xffCpJWsb0Z6ecre2397mmtohX3vt/Y
        ruz0T8C3u4zZYde8qVdZXzh3TJK9K+r6j3WztNCUtX6Oejczfc6VTu+aHHpFNZhlN/OLI8aW
        vV3Pbu1KuLD91Zy804vKphzgX26b1fFMV+2oEktxRqKhFnNRcSIAk2lY0CYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2017 08:46 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Even when we are deleting references, we needn't overwrite the
>> `packed-refs` file if the references that we are deleting are not
>> present in that file. Implement this optimization as follows:
> 
> This goal I can understand.  files-transaction-prepare may see a
> deletion and in order to avoid a deletion of a ref from the
> file-backend to expose a stale entry in the packed-refs file, it
> prepares a transaction to remove the same ref that might exist in
> it.  If it turns out that there is no such ref in the packed-refs
> file, then we can leave the packed-refs file as-is without
> rewriting.
> 
>> * Add a function `is_packed_transaction_noop()`, which checks whether
>>   a given packed-refs transaction doesn't actually have to do
>>   anything. This function must be called while holding the
>>   `packed-refs` lock to avoid races.
> 
> This checks three things only to cover the most trivial case (I am
> perfectly happy that it punts on more complex cases).  If an update
> 
>  - checks the old value,
> 
>  - sets a new value, or
> 
>  - deletes a ref that is not on the filesystem,
> 
> it is not a trivial case.  I can understand the latter two (i.e. We
> are special casing the deletion, and an update with a new value is
> not.  If removing a file from the filesystem is not sufficient to
> delete, we may have to rewrite the packed-refs), but not the first
> one.  Is it because currently we do not say "delete this ref only
> when its current value is X"?

It wouldn't be too hard to allow updates with REF_HAVE_OLD to be
optimized away too. I didn't do it because

1. We currently only create updates for that packed_refs backend with
REF_HAVE_OLD turned off, so such could would be unreachable (and
untestable).

2. I wanted to keep the patch as simple as possible in case you decide
to merge it into 2.15.

There would also be a little bit of a leveling violation (or maybe the
function name is not ideal). `is_packed_transaction_noop()` could check
that `old_oid` values are correct, and if they all are, declare the
transaction a NOOP. (It wasn't *really* a NOOP, but its OP, namely
checking old values, has already been carried out.) But what if it finds
that an `old_oid` was incorrect? Right now
`is_packed_transaction_noop()` has no way to report something like a
TRANSACTION_GENERIC_ERROR.

It could be that long-term it makes more sense for this optimization to
happen in `packed_transaction_prepare()`. Except that function is
sometimes called for its side-effects, like sorting an existing file, in
which case overwriting the `packed-refs` file shouldn't be optimized away.

So overall it seemed easier to punt on this optimization at this point.

> Also it is not immediately obvious how the "is this noop" helper is
> checking the absence of the same-named ref in the current
> packed-refs file, which is what matters for the correctness of the
> optimization.

The check is in the second loop in `is_packed_transaction_noop()`:

	if (!refs_read_raw_ref(ref_store, update->refname,
			       oid.hash, &referent, &type) ||
	    errno != ENOENT) {
		/*
		 * We might have to actually delete that
		 * reference -> not a NOOP.
		 */
		ret = 0;
		break;
	}

If the refname doesn't exist, then `refs_read_raw_ref()` returns -1 and
sets errno to ENOENT, and the loop continues. Otherwise we exit with a
value of 0, meaning that the transaction is not a NOOP.

There are a lot of double-negatives here. It might be easier to follow
the logic if the sense of the function were inverted:
`is_packed_transaction_needed()`. Let me know if you have a strong
feeling about it.

Michael
