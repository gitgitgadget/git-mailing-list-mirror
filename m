Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C64201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdBSAUf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 19:20:35 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:19645 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdBSAUe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 19:20:34 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id fFEucze0F46SJfFEuc3LTa; Sun, 19 Feb 2017 00:20:32 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=CU4MO7oEAAAA:8
 a=gj22N-5vgI9MVBs86scA:9 a=QEXdDO2ut3YA:10 a=TFpHkJSqFpMt6cEQqPwm:22
Message-ID: <2116CBFFB78A482D8FA176BC680B3B9C@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Damien Regad" <dregad@mantisbt.org>, <git@vger.kernel.org>
References: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
Subject: Re: [PATCH] git-check-ref-format: fix typo in man page
Date:   Sun, 19 Feb 2017 00:20:33 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfC27lNrhZC2rizx43dpQaGLjiir48CojVYXioyi0Wlq3zyNEjKknnW4DTjCkRFk+ObNKK2A2nIuaxnWppOpm+bClCJeOwjeKJTekQhpq1gqpk11NIIlH
 Qqx9Gn0/VueQGUFd8f03rmlTgkv2BnWcqiCjYP8Xiuc2Orij2Xy/2EeXYZ0rnIQ5C+wIohJIHtorGGg/U7tYg0DheHIVL/j0VRM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Damien Regad" <dregad@mantisbt.org>
> ---
> Documentation/git-check-ref-format.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-check-ref-format.txt
> b/Documentation/git-check-ref-format.txt
> index 8611a99..377c85a 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -100,7 +100,7 @@ OPTIONS
> --normalize::
>  Normalize 'refname' by removing any leading slash (`/`)
>  characters and collapsing runs of adjacent slashes between
> - name components into a single slash.  Iff the normalized
> + name components into a single slash.  If the normalized
>  refname is valid then print it to standard output and exit
>  with a status of 0.  (`--print` is a deprecated way to spell
>  `--normalize`.)
> -- 

Could that be an 'iff' == 'If and only if' (which is common in mathematics)? 
Still could be spelling error though.
--
Philip 

