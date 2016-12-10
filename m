Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68071FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbcLJUsj (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 15:48:39 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55670 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbcLJUsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 15:48:38 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id FoZQc6KT7gKstFoZQcLBVs; Sat, 10 Dec 2016 20:48:36 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=aVMwsvu81cJ0ykTX5RIA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <2C16DAFED0D94B28AF9CE7F8BBA122F0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-3-kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 2/4] doc: add verb in front of command to run
Date:   Sat, 10 Dec 2016 20:48:37 -0000
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
X-CMAE-Envelope: MS4wfCWeqsClkFlGpxTq2dKc0MehXjb/UTfPT/o7zVKrTAncTij7Dn83GtiJdyONyuidf/kQ4lOopQrDv0zPipNtNB8Qk0glZzhyy0Tp1pjjAD1h5u9Q/rpD
 4O5V52o4Lr+dtAqKXAuUEWKJfmfRN5B7TRvRe639zgvczBJHxqdEKru5grrOh4eB5yWBHYpsl/xwhksebZO3YwPtbK1sDnyrDCKtv+lGV7rO6lIOX4zCXXDh
 KzBke7T9Ad54Rlayg85nzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
Sent: Friday, December 09, 2016 3:51 PM
> Instead of using the command 'git clone' as a verb, use "run" as the
> verb indicating the action of executing the command 'git clone'.

I would expect 'cloning' as the commonly in use verb here, with the command 
then quoted.

>
> Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> ---
> Documentation/gitcore-tutorial.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt 
> b/Documentation/gitcore-tutorial.txt
> index 6c434aff3..72ed90ca3 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -1478,7 +1478,7 @@ You can repack this private repository whenever you 
> feel like.
> A recommended work cycle for a "subsystem maintainer" who works
> on that project and has an own "public repository" goes like this:
>
> -1. Prepare your work repository, by 'git clone' the public
> +1. Prepare your work repository, by running 'git clone' on the public

Perhaps ?
... by cloning ('git clone <URL>') the public

The full command is shown using the same terminology as the following line.

>    repository of the "project lead". The URL used for the
>    initial cloning is stored in the remote.origin.url
>    configuration variable.
> -- 
> 2.11.0
>
>
--
Philip 

