Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26491FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 11:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbcLQL4X (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 06:56:23 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58273 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcLQL4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 06:56:22 -0500
Received: from PhilipOakley ([92.22.46.253])
        by smtp.talktalk.net with SMTP
        id IDb9c4ayQxR4bIDb9c9UmD; Sat, 17 Dec 2016 11:56:21 +0000
X-Originating-IP: [92.22.46.253]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=HVo2oSqvnpFDrJ9/Aa7uoQ==:117
 a=HVo2oSqvnpFDrJ9/Aa7uoQ==:17 a=8nJEP1OIZ-IA:10 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=aM8jztsd7vx8E5MsmZ8A:9 a=wPNLvfGTeEIA:10
 a=avl4LiGQNoF5OB0DmCJ7:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <67572777448E4DCE967BA079110A3487@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.e.keller@intel.com>, <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>
References: <20161217012431.29548-1-jacob.e.keller@intel.com> <20161217012431.29548-2-jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/5] doc: add documentation for OPT_STRING_LIST
Date:   Sat, 17 Dec 2016 11:56:19 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfN0hq2Eu1IG7U8GguZHCooaClhcVPPFAAeeHPNaqvdZguwS8JD4T3vDyBxed+U635NGh7oZgbp035YqplHOdEBOe2NXvCXvlVFL3GuZovI9rllv/hYe/
 7krkXX0rNx25P+L5/twiCCJE4V4OcPmEk6ZS3vA8o6+XfIYEQDTRsftzUNhMHwg751OU0Y9paSogiKfTENjYvbpfh1DxasMSqGPijyqxTVI3FTk/rKAuRsgQ
 PC5UFc+JGS4LsD0brT4//FJXqLbk9WnJJP88+0YuNQI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jacob Keller" <jacob.e.keller@intel.com>
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
> 2011-06-09) added the OPT_STRING_LIST as a way to accumulate a repeated
> list of strings. However, this was not documented in the
> api-parse-options documentation. Add documentation now so that future
> developers may learn of its existence.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Documentation/technical/api-parse-options.txt | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.txt 
> b/Documentation/technical/api-parse-options.txt
> index 27bd701c0d68..92791740aa64 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>  Introduce an option with string argument.
>  The string argument is put into `str_var`.
>
> +`OPT_STRING_LIST(short long, &list, arg_str, description)`::

should there be an extra comma between 'short long' in a similar manner to 
the OPT_INTEGER argument list below?


> + Introduce an option with a string argument. Repeated invocations
> + accumulate into a list of strings. Reset and clear the list with
> + `--no-option`.
> +
> `OPT_INTEGER(short, long, &int_var, description)`::
>  Introduce an option with integer argument.
>  The integer is put into `int_var`.
> -- 
> 2.11.0.rc2.152.g4d04e67
>
> 

