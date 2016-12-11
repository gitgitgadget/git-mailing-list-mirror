Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8380720441
	for <e@80x24.org>; Sun, 11 Dec 2016 13:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbcLKNE5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 08:04:57 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:63779 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbcLKNE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 08:04:57 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id G3oEc8HcbgKstG3oEcLeH1; Sun, 11 Dec 2016 13:04:55 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=LI31VYkt35nQEw4drjcA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <2645548666054ED5BD30436E9DA41C14@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>,
        "Git List" <git@vger.kernel.org>
Cc:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-5-kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 4/4] doc: omit needless "for"
Date:   Sun, 11 Dec 2016 13:04:54 -0000
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
X-CMAE-Envelope: MS4wfLjmnryJsXIb8qo6JzwcvVCC0ZInck/6CxJhErc+AK/Ac/6LZV/cL8ECZ9jkx9C9o6DkUPYzlRGkZToExYwbtKYa20x0AuoshWe6spXTDcPcgWWaSCqX
 kgZKE35JEJbYTPgusmbHBB1GV3AvAO/p6F1/QthzqptZBihxRUw+P5fY4DCY70boVROtegLko6U3ZPoXdzvleHsat0XNdBeOfX8AEqrRi9x0PfqGHSAeX0Hf
 PX39hvynrUoNC5hTQh4cPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
Sent: Friday, December 09, 2016 3:51 PM
> What was intended was perhaps "... plumbing does for you" ("you" added),
> but
> simply omitting the word "for" is more terse and gets the intended point
> across
> just as well, if not more so.

After some thought, I think the original is more 'right'.

Without the 'for' it suggests that understanding individual plumbing 
commands would explain some issue being seen with a fancy porcelain command 
which they probably don't. Rather the 'for' is forward looking toward using 
the plumbing commands as tools to investigate and then re-plumb the 
aestehetics to the desired output.

The whole porcelain euphemism makes for some awkward phrasing.

>
> I originally went with the approach of writing "for you", but Junio C
> Hamano suggested this approach instead.
>
> Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> ---
>
> Notes (kristoffers):
>    The original patch was sent to the mailing list on 2016-11-04, and
> Junio
>    replied with his suggested correction on 2016-11-10; see the cover
>    letter.
>
> Documentation/gitcore-tutorial.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt
> b/Documentation/gitcore-tutorial.txt
> index 72ca9c1ef..22309cfb4 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -25,7 +25,7 @@ you want to understand Git's internals.
> The core Git is often called "plumbing", with the prettier user

If we are tidying up here, then perhaps
s/core Git is often/Git commands are often/
to better clarify what aspects are plumbing / porcelain.

> interfaces on top of it called "porcelain". You may not want to use the
> plumbing directly very often, but it can be good to know what the
> -plumbing does for when the porcelain isn't flushing.
> +plumbing does when the porcelain isn't flushing.

I'm not so sure that the direct allusion to 'flushing' is exactly the right
tone. Part of the issue is the 'porcelain' is the initial euphemism. The 
other part is that both porcelain and plumbing commands have the same level 
of CLI un-prettiness, so the distinction isn't there.

In the end I strung together:
"
The core Git commands are often called "plumbing",
 while those with the prettier user friendly
 output are called "porcelain".

 You may not want to use the plumbing directly very often,
 but it can be good to know what the plumbing does
 when either the porcelain isn't flushing, or different output aethetics are 
desired.
"

Though having both prettier and friendly in the same phrase maybe overkill.

>
> Back when this document was originally written, many porcelain
> commands were shell scripts. For simplicity, it still uses them as
> -- 
> 2.11.0
>
--
Philip

