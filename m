Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41658207BD
	for <e@80x24.org>; Sat, 22 Apr 2017 06:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041968AbdDVGhr (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 02:37:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45167 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1041963AbdDVGhq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 02:37:46 -0400
X-AuditID: 12074413-0e1ff70000001dc3-7e-58fafa350741
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DB.B7.07619.53AFAF85; Sat, 22 Apr 2017 02:37:44 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M6bb64000840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 02:37:39 -0400
Subject: Re: [PATCH v3 06/12] refs: add refs_head_ref()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-7-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4519cd91-80e1-a416-658e-e10e542b41ff@alum.mit.edu>
Date:   Sat, 22 Apr 2017 08:37:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1LX49SvC4PVNXYuuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAlfGt2PLmQpeCVT07jjJ1MC4h7eLkZNDQsBEYtHqe8wgtpDADiaJDfeVuxi5
        gOwLTBJNh3+ygySEBcwltu3qYQSxRQTSJBZPfg/VkCjR3PyKEaSBWWAXo8SZ53fAEmwCuhKL
        epqZQGxeAXuJXad3gTWzCKhKnNjzFaxGVCBEYs7CB4wQNYISJ2c+YQGxOQXMJG7vXglmMwuo
        S/yZd4kZwpaXaN46m3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        uV5uZoleakrpJkZIYAvvYNx1Uu4QowAHoxIP7wqWXxFCrIllxZW5hxglOZiURHlDfv+MEOJL
        yk+pzEgszogvKs1JLT7EKMHBrCTCu/41UDlvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZq
        akFqEUxWhoNDSYJX7SdQo2BRanpqRVpmTglCmomDE2Q4D9Dwzz9AhhcXJOYWZ6ZD5E8xKkqJ
        8yqCNAuAJDJK8+B6YYnnFaM40CvCvLwgVTzApAXX/QpoMBPQ4LN+P0AGlyQipKQaGEuCLx66
        qjNBtPtV78+Ha2e3f/rDpvrh0pwdn1wFtx57PMu3wcf+xGvGk0cVLfcJnJRfI3nDmMfp08xJ
        0m/Me699n3Xkz6RKG1Vf54N10zJZH/X+/sRzN1XxcavrG6Zt5zLuzRCLuaGy2FH+7Hz9j86H
        36af//qxL8l6Le/EpfpH5Ld9XJZ/Xu20EktxRqKhFnNRcSIAse1vtBcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 19 +++++++++----------
>  refs.h |  2 ++
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 26474cb62a..a252ae43ee 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1208,27 +1208,26 @@ int refs_rename_ref_available(struct ref_store *refs,
>  	return ok;
>  }
>  
> -int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
>  	struct object_id oid;
>  	int flag;
>  
> -	if (submodule) {
> -		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
> -			return fn("HEAD", &oid, 0, cb_data);
> -
> -		return 0;
> -	}
> -
> -	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
> +	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
> +				oid.hash, &flag))
>  		return fn("HEAD", &oid, flag, cb_data);
>  
>  	return 0;
>  }
>  
> +int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
> +}
> +
>  int head_ref(each_ref_fn fn, void *cb_data)
>  {
> -	return head_ref_submodule(NULL, fn, cb_data);
> +	return refs_head_ref(get_main_ref_store(), fn, cb_data);
>  }
>  
>  /*
> diff --git a/refs.h b/refs.h
> index 447381d378..0572473ef7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -233,6 +233,8 @@ typedef int each_ref_fn(const char *refname,
>   * modifies the reference also returns a nonzero value to immediately
>   * stop the iteration. Returned references are sorted.
>   */
> +int refs_head_ref(struct ref_store *refs,
> +		  each_ref_fn fn, void *cb_data);
>  int refs_for_each_ref(struct ref_store *refs,
>  		      each_ref_fn fn, void *cb_data);
>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
> 

I'm seeing segfaults in t3600 after this patch, apparently because
`refs==NULL` gets passed from `head_ref_submodule()` to `refs_head_ref()`.

Michael

