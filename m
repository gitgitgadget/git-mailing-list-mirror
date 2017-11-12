Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219D8201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKLUZL (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:25:11 -0500
Received: from mout.web.de ([212.227.15.3]:58036 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdKLUZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:25:10 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtqS-1egcZt2QwK-00X7m7; Sun, 12
 Nov 2017 21:25:05 +0100
Date:   Sun, 12 Nov 2017 21:25:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jerzy Kozera <jerzy.kozera@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] gpg-interface: strip CR chars for Windows gpg2
Message-ID: <20171112202505.GB2677@tor.lan>
References: <20171112130710.16000-1-jerzy.kozera@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112130710.16000-1-jerzy.kozera@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:cfHWej74RRr934m3h7m61eTsTDlb09HMR/EyBBSU8pc7MRCxxNE
 LmU1pXGJum37QJUEfbLUJbLu1ljplOhaGuLUD6+Lr9m0dfTIlzNlKCXoZB1dxyfdXDq5X+9
 JQyxVmUhQQ4/ZIZ2Ws9fI/UhQ4HYUug1ojQ8kTMASxKmkCZlXVhE/7IbW3C6q59Rj55dwcl
 GufsJSr9uigPirSmJ9f4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s6P9DXfqEWk=:lJNNZbtTF2iwa76NrHEuFA
 9luTMq5Pwh8LNwnbFGujoxeM4AOBx61+nLR5v7jNd5650xKjb6sqjex9xAZWeLbf33MTOQ4PH
 4GU02ek+b1ERZQnU1U/Mns608dJY6g4/6eoXrobLmspoxYpogK++4t4FIuN2rLtCCnma0eDes
 mG5GfoMYxWT0JBCobp+QlIt/NPmPjYLE2GOa7oC6rA7cqE3K537Q/2uDldZ83KKcG8y87Qb+7
 IubtCckuW2mZu4QqnkHKxV6POffXuzqwSfnrAZBwZfODS9iSQ6SV6AMF6SdECC9f9cqkvVnIQ
 kL0RwyoEtc5+Kok0DvGf79BCsO0IzTFMloKxPXFMsDL3G3RAsLF+q2PMgpNsTHF72AAtUEP8d
 R9nXOIL/hbxnvjfdY4xWsIUWnaSO5kVMCR/ZKUVd51rRGaiWd3xCvKsvkXO5o9gIUMBgpyDuL
 HT6mb4K//b+dOV6W2jpvG6bHmO8PIVe2r4E+hpQLeETdxjM8C0Jg7kRdGloKRJxmhFAcN7hJG
 wYeRDY1N7yGd7RbttN9AjUcxc8utFCFsdhEKbJQvydPG3afBaA1MTXmByYVjL+iTBZiZTZHne
 4q8X/YROU90OnTwxtfXcdPojobLDyFArrEVoa1zrCiEsRUv6wP9LbMMV8mQcYlvc5OCVFW3Dl
 YTCTVKwyI2FZHZoAGuSN8egJKLfS50mmJnKL9qBHjPP9OGOOqgWuNHVQgJr9umXN/WoP9OKs9
 VNfrQjPoEDy0v+Jbjq127uXusiPGXYZ0D+6S6jKA1TtTOpPhyMbkRqaxKtOvmV1PhT6W0opdi
 5VYY01k82y0wtaXLqJqi0Yt4H/30g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 01:07:10PM +0000, Jerzy Kozera wrote:
> This fixes the issue with newlines being \r\n and not being displayed
> correctly when using gpg2 for Windows, as reported at
> https://github.com/git-for-windows/git/issues/1249
> 
> Issues with non-ASCII characters remain for further investigation.
> 
> Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
> ---
> 
> Addressed comments by Junio C Hamano (check for following \n, and
> updated the commit description).
> 
>  gpg-interface.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 4feacf16e5..ab592af7f2 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -145,6 +145,20 @@ const char *get_signing_key(void)
>  	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
>  }
>  
> +/* Strip CR from the CRLF line endings, in case we are on Windows. */
> +static void strip_cr(struct strbuf *buffer, size_t bottom) {
> +	size_t i, j;

It is not wrong to say "Strip CR from the CRLF".
In Git we often talk about "convert CRLF into LF",

The comment somewhat different to the function name.
The function namd and the name of the parameters can be more in
in line with existing strbuf functions:
(And the opening '{' should go into it's own line:

static void convert_crlf_to_lf(struct strbuf *sb, size_t len)
{
	size_t i, j;

An even more generic approach (could be done in a seperate commit)
would be to move the whole function into strbuf.c/strbuf.h,
and it may be called like this.

void strbuf_crlf_to_lf(struct strbuf *sb, size_t len)
{
  /* I would even avoid "i" and "j", and use src and dst or so) */
  size_t src_pos, dst_idx;
}

Thanks for working on this.

[]
