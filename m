Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DF51F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdL2P5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:57:00 -0500
Received: from mout.web.de ([212.227.15.4]:64071 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbdL2P47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:56:59 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1ejnFZ2spO-00G58b; Fri, 29
 Dec 2017 16:56:43 +0100
Date:   Fri, 29 Dec 2017 16:56:42 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/5] strbuf: add xstrdup_toupper()
Message-ID: <20171229155642.GA23935@tor.lan>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
 <20171229152222.39680-2-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229152222.39680-2-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:NZV5Vt4t3WJ3qHR5t/wbDTDtai8/XHyRwdTrU2Q19OWmQZqqwzG
 R7E5BinItqzFMF63s6UHCzwNe1X7Oiaxq9Rsw89IsZJIoc5eU1UHuFBjLh0LglzoM0dqQDe
 IA90CC2XcceJ1GWFqPRFdU1nQIbNtPZA1yvkETk9OIZe/HZTrWYC44HC6B5yNZD7w/WaBAP
 lWHa06iu8oBwinR/TtQjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:49bLDWIgweM=:XSju5WzBB35Mt1wCeyaxcI
 4nKE0CRP4xgo9vjgwuTM0n4O9saenE4uKYoNTmEYjOEhqYYVQecPHWTTYdYr2f0DX89TMD3/O
 xpxZAybaSD9aYtZFlsuVjZ51Mo08nQkI7ZxAqBPUiRe+aTol9785wawprzFxvlRUae/UHZFgx
 UbxOe2/X56f7UhD1kA9Y6UwoItBnxegVB5R7OENvLlpK7XvIZ59+ISQ76Tmy9kWiQEPP8KnnO
 foHm4m2kxfGtlNyUhZiQVF43DEH//isBOnvKHpxSnWitJ+n5sOQtkCf8O2MmvF4MlI6qCJNXh
 r/6xPtB3ZI61ql8DueWw6gqcz764ZD2WFCbd0ON7100MgyGBus14SxawStUs5hp0AC1ORCx52
 X7GtgIq56SGEfy6U324Zlh/JQxyYLW8htAB8HYsU0ZErQi28oWvYdV9V5bNo79uPdIUYwG8Cl
 RncEUecwxJXScCHjQRTgxN9FefeTFZtSPB02xO3lEVJcEW/GrJD6mn2EGgQK026aBfrnwRh4E
 7enQlVQaFmi6nrgdL6Y9dSd0ehQ9tnsPTdrjM5339Y2XZ1s1javVHR1HHMGBTTo7m1djSMi/m
 shlGVXP3YJJ4i6UiksYi6GpPnmG5x9jX64V0F5W+N0E1MgFJbjb5FufUi12NRUajykYzITlsA
 VFdVSq9PmPnP6I7PK1VPD+ru1if35YJtD9G5fbfDOTbLlXC+v+O5kz0qoqmfgUIMgKdQD+lHH
 ZttE09UJxB5uiZsNWIU1LyVm97CVZrXGkVYCYzCE8UPVzSq3mGFaUl7R6+4SyA5DW16R4enI/
 cUGmB7/jHx3/j7m1nqtTJgp63fPzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 04:22:18PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Create a copy of an existing string and make all characters upper case.
> Similar xstrdup_tolower().
> 
> This function is used in a subsequent commit.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  strbuf.c | 13 +++++++++++++
>  strbuf.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 323c49ceb3..54276e96e7 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -760,6 +760,19 @@ char *xstrdup_tolower(const char *string)
>  	return result;
>  }
>  
> +char *xstrdup_toupper(const char *string)
> +{
> +	char *result;
> +	size_t len, i;
> +
> +	len = strlen(string);
> +	result = xmallocz(len);
> +	for (i = 0; i < len; i++)
> +		result[i] = toupper(string[i]);
> +	result[i] = '\0';
        ^^^^^^^^^^^^^^^^
	Isn't this already done by xmallocz()

> +	return result;
> +}
> +
>  char *xstrvfmt(const char *fmt, va_list ap)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> diff --git a/strbuf.h b/strbuf.h
> index 0a74acb236..2bc148526f 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -616,6 +616,7 @@ __attribute__((format (printf,2,3)))
>  extern int fprintf_ln(FILE *fp, const char *fmt, ...);
>  
>  char *xstrdup_tolower(const char *);
> +char *xstrdup_toupper(const char *);
>  
>  /**
>   * Create a newly allocated string using printf format. You can do this easily
> -- 
> 2.15.1
> 
