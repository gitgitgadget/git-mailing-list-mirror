Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4174720323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdCSUi0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:38:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60118 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752131AbdCSUiZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 16:38:25 -0400
X-AuditID: 1207440f-141ff70000003517-4e-58ceec3f5f36
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 03.3F.13591.F3CEEC85; Sun, 19 Mar 2017 16:38:23 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JKcJLr018271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 16:38:21 -0400
Subject: Re: [PATCH v6 11/27] refs.c: introduce get_main_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-12-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <511a2789-0f4e-2e65-94a9-eaaff858aa76@alum.mit.edu>
Date:   Sun, 19 Mar 2017 21:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-12-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1LV/cy7CoP+jmUXXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4Mu4v2MpUcImj4vxW/wbGf2xdjJwcEgImEltezmbtYuTi
        EBLYwSTRvG8zE4Rzjkliw+l5jCBVwgIuEqcW9TCB2CICaRKLJ79nhiiayCixY9NEdhCHWeAG
        o8SliR/BqtgEdCUW9TSD2bwC9hJrvhxgAbFZBFQllrZsAtstKhAiMWfhA0aIGkGJkzOfgNVw
        ClhIHJv0AyzOLKAu8WfeJWYIW16ieets5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbomermZJXqpKaWbGCHhzr+DsWu9zCFGAQ5GJR7eG5fORQixJpYVV+YeYpTk
        YFIS5f2nDhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwrvhIVCONyWxsiq1KB8mJc3BoiTOq75E
        3U9IID2xJDU7NbUgtQgmK8PBoSTBO+8VUKNgUWp6akVaZk4JQpqJgxNkOA/Q8GsgNbzFBYm5
        xZnpEPlTjIpS4ry/XgIlBEASGaV5cL2wdPSKURzoFWHe7yDtPMBUBtf9CmgwE9DgZTfOgAwu
        SURISTUwTpOc0J5ZoaKx2ZtJvsg5d9+BfTqCnU9y+rq/TrevyJk/WUc9sD+28KjDK+mV+39/
        791x0qpiabZk0KVLYqc/n1r8UXPtHa/Nx8uefV0lfqT/5/SXDy7671tTa6ncyNhn8vHHa4mF
        B7YX/Z2qsfv0wse+suYVbGvzHPz+KwiJT9V+f7jg7ZzUbiWW4oxEQy3mouJEAMVWeuEiAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index e7606716dd..2637353b72 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1456,15 +1456,23 @@ static struct ref_store *ref_store_init(const char *submodule)
>  	return refs;
>  }
>  
> +static struct ref_store *get_main_ref_store(void)
> +{
> +	struct ref_store *refs;
> +
> +	if (main_ref_store)
> +		return main_ref_store;
> +
> +	refs = ref_store_init(NULL);
> +	return refs;
> +}
> +

I still [1] think that `refs` here is an unnecessary temporary variable.
And even after your "kill register_ref_store" patch I think it is
superfluous and the function could look like

static struct ref_store *get_main_ref_store(void)
{
	if (!main_ref_store)
		main_ref_store = ref_store_init(NULL);

	return main_ref_store;
}

> [...]

Michael

[1]
http://public-inbox.org/git/0bef1e49-e96b-1666-9b88-f4262c2aeeba@alum.mit.edu/
