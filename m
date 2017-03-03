Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9021420133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdCCPvN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:51:13 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59040 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751927AbdCCPvK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 10:51:10 -0500
X-AuditID: 12074412-4bbff70000000b04-79-58b9905aff72
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F2.87.02820.A5099B85; Fri,  3 Mar 2017 10:48:42 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23FmcKU002224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 10:48:39 -0500
Subject: Re: [PATCH v5 19/24] refs: new transaction related ref-store api
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-20-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f837bec6-301c-b9a3-83f4-99d03ca10432@alum.mit.edu>
Date:   Fri, 3 Mar 2017 16:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-20-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1I2asDPCYPpHCYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZcxcspil4JhlRceFRsYGxkW6XYycHBICJhKfb95h6WLk
        4hAS2MEkMenKSWYI5zSTROvbE4wgVcICnhKfLq5hB7FFBNIkFk9+D1U0gVHibPsyVhCHWeAG
        o8SliR+ZQKrYBHQlFvU0g9m8AvYSF07/A+rm4GARUJHYvZgVJCwqECIxZ+EDRogSQYmTM5+w
        gNicAhYSvds2g9UwC6hL/Jl3iRnClpdo3jqbeQIj/ywkLbOQlM1CUraAkXkVo1xiTmmubm5i
        Zk5xarJucXJiXl5qka6ZXm5miV5qSukmRki4C+1gXH9S7hCjAAejEg/vBZsdEUKsiWXFlbmH
        GCU5mJREeQ8V7IwQ4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbWgmU401JrKxKLcqHSUlzsCiJ
        8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4LXrB2oULEpNT61Iy8wpQUgzcXCCDOcBGr6pD2R4
        cUFibnFmOkT+FKOilDjvGZCEAEgiozQPrheWjl4xigO9IsybBrKCB5jK4LpfAQ1mAhrsJwM2
        uCQRISXVwDhN+u2iw+a6Z3Xi295oqlmrn2PMcmCZ/kokujaP/8OpdGv5W4u2s++bf2T7N16J
        y6x3xJ74er9J2vfarsO1Lv/41jzPLsXUukd+XeJRgmfXhAu4mDI+X6E6qcrkzZSAIpttc0LU
        A59+3tTOucSn/YxLfc83bqFSF91luS0yDfVnN0wpaZx8QImlOCPRUIu5qDgRAMbLeOUiAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> The transaction struct now takes a ref store at creation and will
> operate on that ref store alone.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++------------
>  refs.h               |  8 ++++++++
>  refs/refs-internal.h |  1 +
>  3 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 9137ac283..851b5e125 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -618,16 +618,19 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
>  	return 0;
>  }
>  
> -int delete_ref(const char *refname, const unsigned char *old_sha1,
> -	       unsigned int flags)
> +int refs_delete_ref(struct ref_store *refs, const char *refname,
> +		    const unsigned char *old_sha1,
> +		    unsigned int flags)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
>  
> -	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
> +	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
> +		assert(refs == get_main_ref_store());

Hmmm, I would have expected this to be checked via `(refs.flags &
REF_STORE_MAIN)`. I guess this is temporary; once we have compound ref
stores either version will need to be changed again. So I don't see a
strong argument for one vs. the other.

It might be more natural to make `delete_pseudoref()` take a `refs`
argument and do the check internally.

(Same comments below where `write_pseudoref()` is called.)

Michael

>  		return delete_pseudoref(refname, old_sha1);
> +	}
>  
> -	transaction = ref_transaction_begin(&err);
> +	transaction = ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, refname, old_sha1,
>  				   flags, NULL, &err) ||
> @@ -642,6 +645,13 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
>  	return 0;
>  }
>  
> +int delete_ref(const char *refname, const unsigned char *old_sha1,
> +	       unsigned int flags)
> +{
> +	return refs_delete_ref(get_main_ref_store(), refname,
> +			       old_sha1, flags);
> +}
> +
>  int copy_reflog_msg(char *buf, const char *msg)
>  {
>  	char *cp = buf;
> @@ -801,11 +811,20 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
>  	return 1;
>  }
>  
> -struct ref_transaction *ref_transaction_begin(struct strbuf *err)
> +struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
> +						    struct strbuf *err)
>  {
> +	struct ref_transaction *tr;
>  	assert(err);
>  
> -	return xcalloc(1, sizeof(struct ref_transaction));
> +	tr = xcalloc(1, sizeof(struct ref_transaction));
> +	tr->ref_store = refs;
> +	return tr;
> +}
> +
> +struct ref_transaction *ref_transaction_begin(struct strbuf *err)
> +{
> +	return ref_store_transaction_begin(get_main_ref_store(), err);
>  }
>  
>  void ref_transaction_free(struct ref_transaction *transaction)
> @@ -922,18 +941,20 @@ int update_ref_oid(const char *msg, const char *refname,
>  		old_oid ? old_oid->hash : NULL, flags, onerr);
>  }
>  
> -int update_ref(const char *msg, const char *refname,
> -	       const unsigned char *new_sha1, const unsigned char *old_sha1,
> -	       unsigned int flags, enum action_on_err onerr)
> +int refs_update_ref(struct ref_store *refs, const char *msg,
> +		    const char *refname, const unsigned char *new_sha1,
> +		    const unsigned char *old_sha1, unsigned int flags,
> +		    enum action_on_err onerr)
>  {
>  	struct ref_transaction *t = NULL;
>  	struct strbuf err = STRBUF_INIT;
>  	int ret = 0;
>  
>  	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
> +		assert(refs == get_main_ref_store());
>  		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
>  	} else {
> -		t = ref_transaction_begin(&err);
> +		t = ref_store_transaction_begin(refs, &err);
>  		if (!t ||
>  		    ref_transaction_update(t, refname, new_sha1, old_sha1,
>  					   flags, msg, &err) ||
> @@ -964,6 +985,15 @@ int update_ref(const char *msg, const char *refname,
>  	return 0;
>  }
>  
> +int update_ref(const char *msg, const char *refname,
> +	       const unsigned char *new_sha1,
> +	       const unsigned char *old_sha1,
> +	       unsigned int flags, enum action_on_err onerr)
> +{
> +	return refs_update_ref(get_main_ref_store(), msg, refname, new_sha1,
> +			       old_sha1, flags, onerr);
> +}
> +
>  char *shorten_unambiguous_ref(const char *refname, int strict)
>  {
>  	int i;
> @@ -1600,7 +1630,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
> -	struct ref_store *refs = get_main_ref_store();
> +	struct ref_store *refs = transaction->ref_store;
>  
>  	return refs->be->transaction_commit(refs, transaction, err);
>  }
> @@ -1719,7 +1749,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>  int initial_ref_transaction_commit(struct ref_transaction *transaction,
>  				   struct strbuf *err)
>  {
> -	struct ref_store *refs = get_main_ref_store();
> +	struct ref_store *refs = transaction->ref_store;
>  
>  	return refs->be->initial_transaction_commit(refs, transaction, err);
>  }
> diff --git a/refs.h b/refs.h
> index 70d4eb87c..342cecd23 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -330,6 +330,9 @@ int reflog_exists(const char *refname);
>   * exists, regardless of its old value. It is an error for old_sha1 to
>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>   */
> +int refs_delete_ref(struct ref_store *refs, const char *refname,
> +		    const unsigned char *old_sha1,
> +		    unsigned int flags);
>  int delete_ref(const char *refname, const unsigned char *old_sha1,
>  	       unsigned int flags);
>  
> @@ -414,6 +417,8 @@ enum action_on_err {
>   * Begin a reference transaction.  The reference transaction must
>   * be freed by calling ref_transaction_free().
>   */
> +struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
> +						    struct strbuf *err);
>  struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>  
>  /*
> @@ -548,6 +553,9 @@ void ref_transaction_free(struct ref_transaction *transaction);
>   * ref_transaction_update(). Handle errors as requested by the `onerr`
>   * argument.
>   */
> +int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
> +		    const unsigned char *new_sha1, const unsigned char *old_sha1,
> +		    unsigned int flags, enum action_on_err onerr);
>  int update_ref(const char *msg, const char *refname,
>  	       const unsigned char *new_sha1, const unsigned char *old_sha1,
>  	       unsigned int flags, enum action_on_err onerr);
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 5f26208c2..690498698 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -200,6 +200,7 @@ enum ref_transaction_state {
>   * as atomically as possible.  This structure is opaque to callers.
>   */
>  struct ref_transaction {
> +	struct ref_store *ref_store;
>  	struct ref_update **updates;
>  	size_t alloc;
>  	size_t nr;
> 

