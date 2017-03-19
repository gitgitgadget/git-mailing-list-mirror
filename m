Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAF020323
	for <e@80x24.org>; Sun, 19 Mar 2017 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdCSTMw (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 15:12:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59580 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752209AbdCSTMv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 15:12:51 -0400
X-AuditID: 1207440f-129ff70000003517-7a-58ced7b2b098
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.CD.13591.2B7DEC85; Sun, 19 Mar 2017 15:10:43 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JJAcgI014047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 15:10:39 -0400
Subject: Re: [PATCH v6 02/27] files-backend: make files_log_ref_write() static
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-3-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a949cc96-34a4-fb5d-06c6-e124f6c025aa@alum.mit.edu>
Date:   Sun, 19 Mar 2017 20:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqLv5+rkIg2cX+S26rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLWZetbbYvLmdxYHdY+esu+weHz7GeSzYVOrR1X6EzePiJWWP/Uu3
        sXl83iQXwB7FZZOSmpNZllqkb5fAlfF28mHWguu8FYu3/2FuYGzl7mLk5JAQMJE4uP0uSxcj
        F4eQwA4miUNLm5kgnHNMEtPaWhhBqoQF/CQ2HbvKCmKLCKRJLJ78nhmiaAKjxNljE8E6mAVu
        MEpcmviRCaSKTUBXYlFPM5jNK2AvcevNavYuRg4OFgFViY9nlUDCogIhEnMWPmCEKBGUODnz
        CQuIzSlgLnH35CawOLOAusSfeZeYIWx5ieats5knMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urm
        JmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhDv/Dsau9TKHGAU4GJV4eG9cOhchxJpYVlyZ
        e4hRkoNJSZT3nzpQiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv2imgHG9KYmVValE+TEqag0VJ
        nFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgtfpBFCjYFFqempFWmZOCUKaiYMTZDgP0HA3kBre
        4oLE3OLMdIj8KUZdjl27d71hEmLJy89LlRLnXXkeqEgApCijNA9uDixNvWIUB3pLmDfjMlAV
        DzDFwU16BbSECWjJshtnQJaUJCKkpBoYPQRdltxSmfiZc+FLlyqnT+fnPFoQvyrEp83c5ev6
        otCoJUnrXaYtZF+ScSJ2thKz7sVZM680qrxhaTxSe2jufJvk42uWOLOV3JtZwbV4tcaGh5tf
        3Vx+siT08YF16tOvBco2rPKZfn9r93UXv3Dl4yHrg1WfFhjZbzjUWqvV7bZpzv7YD/mRL5RY
        ijMSDbWYi4oTAe1Q+PMuAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
> but probably never used outside refs-internal.c
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 3 +++
>  refs/refs-internal.h | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e92f9..0a6d2bf6bc 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
>  					  const char *dirname, size_t len,
>  					  int incomplete);
>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
> +static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> +			       const unsigned char *new_sha1, const char *msg,
> +			       int flags, struct strbuf *err);
>  
>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  {
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index fa93c9a32e..f732473e1d 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -228,10 +228,6 @@ struct ref_transaction {
>  	enum ref_transaction_state state;
>  };
>  
> -int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> -			const unsigned char *new_sha1, const char *msg,
> -			int flags, struct strbuf *err);
> -
>  /*
>   * Check for entries in extras that are within the specified
>   * directory, where dirname is a reference directory name including
> 

You changed the declaration, but the definition still makes the function
non-static.

Michael

