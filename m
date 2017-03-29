Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D759220966
	for <e@80x24.org>; Wed, 29 Mar 2017 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbdC2Kqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 06:46:53 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52194 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752485AbdC2KpZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 06:45:25 -0400
X-AuditID: 1207440d-029ff70000003721-c7-58db903e3aab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C6.56.14113.E309BD85; Wed, 29 Mar 2017 06:45:18 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2TAjGxG017534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 06:45:17 -0400
Subject: Re: [PATCH v4 5/5] files_reflog_iterator: amend use of dir_iterator
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-6-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8be27726-7de9-925c-47cd-60346206d635@alum.mit.edu>
Date:   Wed, 29 Mar 2017 12:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490747533-89143-6-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqGs34XaEwcH7JhaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZXw8
        d5qx4D17RcvsO6wNjJfYuhg5OSQETCQe73vFAmILCexgkji9zbWLkQvIvsAkMWXVS2aQhLCA
        j8SdV/OAijg4RASsJa6v8QIxhQTKJT7ukQSpYBawkTje1MsIYrMJ6Eos6mlmAinhFbCXONri
        DmKyCKhK9P1WAKkQFQiRmLPwAVg1r4CgxMmZT8AO4BRwlJg48yELxEQ9iR3Xf7FC2PIS29/O
        YZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRES
        tLw7GP+vkznEKMDBqMTDuyPvVoQQa2JZcWXuIUZJDiYlUd4ThrcjhPiS8lMqMxKLM+KLSnNS
        iw8xSnAwK4nw6isC5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwf
        +4AaBYtS01Mr0jJzShDSTBycIMN5gIb/B6nhLS5IzC3OTIfIn2JUlBLnndgPlBAASWSU5sH1
        wpLKK0ZxoFeEeW+AtPMAExJc9yugwUxAg8VtboEMLklESEk1MDL7FP0rbtj++enPSw/3nVxv
        eON9s2zB73nyu0Tq1x05kNy8qPX94UIJN/fXQqfUI5+EnbNuFlgeoli9S6LNb/LUPS4dErLM
        TN0ae3cvjHKdlLq1YlOr3j0/L+OdgakKhfYXDdL57l33+GTN4OK7OLaPobR2Rln2bVbvjdEp
        PrKH6w7XTZn1Q4mlOCPRUIu5qDgRACFZA00FAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 02:32 AM, Daniel Ferreira wrote:
> Amend a call to dir_iterator_begin() to pass the flags parameter
> introduced in 3efb5c0 ("dir_iterator: iterate over dir after its
> contents", 2017-28-03).
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e9..b4bba74 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
>  	files_downcast(ref_store, 0, "reflog_iterator_begin");
> 
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
> -	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
> +	iter->dir_iterator = dir_iterator_begin(git_path("logs"), 0);
>  	return ref_iterator;
>  }

As mentioned earlier, this patch should be squashed into patch [2/5].

Michael

