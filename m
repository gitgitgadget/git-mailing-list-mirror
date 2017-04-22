Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9EC207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1040625AbdDVF1K (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:27:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45862 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1040584AbdDVF1J (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 01:27:09 -0400
X-AuditID: 12074411-cc7ff70000003efd-57-58fae9a909d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BC.A9.16125.9A9EAF85; Sat, 22 Apr 2017 01:27:07 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M5R1Vo030451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 01:27:03 -0400
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to
 get_submodule_ref_store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-6-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <378b8e50-562a-a311-2e0f-505de036aaf1@alum.mit.edu>
Date:   Sat, 22 Apr 2017 07:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-6-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1F398leEQdtkXouuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAldG5+v1TAWdAhV/jsc0MO7j6WLk4JAQMJGYfoq5i5GLQ0hgB5PEhQc7GCGc
        C0wSLbPWsnQxcnIIC6RIbO5pZwaxRQTSJBZPfg9mCwkkStw6+4wJpIFZYBejxJnnd8ASbAK6
        Eot6mplAbF4Be4kl03czgtgsAqoSS770sILYogIhEnMWPmCEqBGUODnzCdgyTgEzib49s8Fs
        ZgF1iT/zLjFD2PISzVtnM09g5J+FpGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtL
        LdI11cvNLNFLTSndxAgJa8EdjDNOyh1iFOBgVOLhXcHyK0KINbGsuDL3EKMkB5OSKG/I758R
        QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4Pz8DKudNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJ
        zU5NLUgtgsnKcHAoSfDyA+NXSLAoNT21Ii0zpwQhzcTBCTKcB2i45QuQ4cUFibnFmekQ+VOM
        uhwP9n99zyTEkpeflyolzvv5OVCRAEhRRmke3BxYOnrFKA70ljCvFcgoHmAqg5v0CmgJE9CS
        s34/QJaUJCKkpBoYm2/e4Olyqyz1N2dpePdL7cTjxSvuzVhpdcLc1+PzTZVDCW1F/hoiEwpn
        pTzdd9D2sHqL/wEPZyHJynXK3879Etutuz9/6oRp0kwbTy/wtV+71Tal5sPz4jiV3HPWM84t
        WfOrqqPNkGkmR5bY8QMm57fyNrJ+KXD3kujOP7j/5U+5FaXx+koFSizFGYmGWsxFxYkA8XZZ
        iCIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> This is a better place that will benefit all submodule callers instead
> of just resolve_gitlink_ref()
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5902a3d9e5..26474cb62a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1422,25 +1422,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  int resolve_gitlink_ref(const char *submodule, const char *refname,
>  			unsigned char *sha1)
>  {
> -	size_t len = strlen(submodule);
>  	struct ref_store *refs;
>  	int flags;
>  
> -	while (len && submodule[len - 1] == '/')
> -		len--;
> -
> -	if (!len)
> -		return -1;
> -
> -	if (submodule[len]) {
> -		/* We need to strip off one or more trailing slashes */
> -		char *stripped = xmemdupz(submodule, len);
> -
> -		refs = get_submodule_ref_store(stripped);
> -		free(stripped);
> -	} else {
> -		refs = get_submodule_ref_store(submodule);
> -	}
> +	refs = get_submodule_ref_store(submodule);
>  
>  	if (!refs)
>  		return -1;
> @@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  {
>  	struct strbuf submodule_sb = STRBUF_INIT;
>  	struct ref_store *refs;
> +	char *to_free = NULL;
>  	int ret;
> +	size_t len;
> +
> +	if (submodule) {
> +		len = strlen(submodule);
> +		while (len && submodule[len - 1] == '/')
> +			len--;
> +		if (!len)
> +			submodule = NULL;
> +	}

Ugh. Should a submodule named "///" *really* be considered to refer to
the main ref_store? I understand that's what the code did before this
patch, but it seems to me more like an accident of the old design rather
than something worth supporting. In other words, if a caller would
really pass us such a string, it seems like we could declare the caller
buggy, no?

> [...]

Otherwise, looks good and makes a lot of sense.

Michael

