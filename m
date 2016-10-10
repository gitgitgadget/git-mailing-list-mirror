Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3897A20986
	for <e@80x24.org>; Mon, 10 Oct 2016 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbcJJNAA (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 09:00:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48110 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751598AbcJJM76 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Oct 2016 08:59:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4028E207B4;
        Mon, 10 Oct 2016 08:59:52 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 10 Oct 2016 08:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=bOAKHn2Do+EXGCrwwypPBgzRgEQ=; b=Fn7Xcl
        9i8jEoUlgygmPDlEyx6N9CWDqBEMppC1BsZNswZbzxIB0Huqw3ldRZOxiIbJ34n/
        8nAQpT1QW/+V5IhiYk1l/fP+wBBj7PCYVAmg4r3a0WRMRMFC3VJDxH/EX7NJZgpp
        9FZeXTZ3di3AE7fpFUhPUA5LlTvibXC1kwOIk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bOAKHn2Do+EXGCr
        wwypPBgzRgEQ=; b=oVl4IJYFp3wzcBq1G6X9+VltGhTb6cl8vjCk4JTGgwzUi/w
        wU8WcZSmkj7dcAU8BIz3vFnpBPhVq7pktZo/h8zQSZmfO0yMs0jCHZz1Z8cCQnad
        Kd34V2xWCGX+q27+PypYn/MizJvsAJS/JlsdyWMoe8NtLc/a87jZPT1SCbPU=
X-Sasl-enc: VjEEQM17zRHoMCUaSjud+1LYpAgFQHI5OkwL3cgbfmjG 1476104391
Received: from UltraSam.fritz.box (ip147.236.mip.uni-hannover.de [130.75.236.147])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8478CCC083;
        Mon, 10 Oct 2016 08:59:50 -0400 (EDT)
Subject: Re: [PATCH v2] gpg-interface: use more status letters
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
 <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
 <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
 <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
 <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
 <xmqq60pdbbxh.fsf@gitster.mtv.corp.google.com>
 <xmqqk2dli25w.fsf@gitster.mtv.corp.google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Alex <agrambot@gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <8e496061-ce6c-450f-7c9e-785572d50b79@drmicha.warpmail.net>
Date:   Mon, 10 Oct 2016 14:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2dli25w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 06.10.2016 23:43:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Also, I'm open to using another letter for EXPKEYSIG but couldn't decide
>>> between 'Y', 'Z', 'K'. 'K' could be confused with REVKEYSIG, I'm afraid.
>>> 'Y' is next to 'X' and contained in 'KEY', it would be my first choice.
>>
>> Sounds good enough to me.  Thanks.
> 
> I really do not want to leave too many topics listed in the "What's
> cooking" report to be in undecided / waiting state.  How about
> squashing this in, with a fully updated log message to replace?

Sorry, this got "lost in vacation". Before that, I was looking for an
easy way to test expired signatures, but gpg1 and gpg2 behave somewhat
differently in that respect (2 does not allow to create already expired
signatures).

Is there anything I should or could do now?

Michael

> -- >8 --
> From: Michael J Gruber <git@drmicha.warpmail.net>
> Date: Wed, 28 Sep 2016 16:24:13 +0200
> Subject: [PATCH] SQUASH: gpg-interface: use more status letters
> 
> According to gpg2's doc/DETAILS:
> 
>     For each signature only one of the codes GOODSIG, BADSIG,
>     EXPSIG, EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted.
> 
> gpg1 ("classic") behaves the same (although doc/DETAILS differs).
> 
> Currently, we parse gpg's status output for GOODSIG, BADSIG and
> trust information and translate that into status codes G, B, U, N
> for the %G?  format specifier.
> 
> git-verify-* returns success in the GOODSIG case only. This is
> somewhat in disagreement with gpg, which considers the first 5 of
> the 6 above as VALIDSIG, but we err on the very safe side.
> 
> Introduce additional status codes E, X, Y, R for ERRSIG, EXPSIG,
> EXPKEYSIG, and REVKEYSIG so that a user of %G? gets more information
> about the absence of a 'G' on first glance.
> 
> Requested-by: Alex <agrambot@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/pretty-formats.txt | 3 ++-
>  gpg-interface.c                  | 2 +-
>  pretty.c                         | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index c28ff2b919..179c9389aa 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -146,7 +146,8 @@ endif::git-rev-list[]
>  - '%G?': show "G" for a good (valid) signature,
>    "B" for a bad signature,
>    "U" for a good signature with unknown validity,
> -  "X" for a good expired signature, or good signature made by an expired key,
> +  "X" for a good signature that has expired,
> +  "Y" for a good signature made by an expired key,
>    "R" for a good signature made by a revoked key,
>    "E" if the signature cannot be checked (e.g. missing key)
>    and "N" for no signature
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 6999e7b469..e44cc27da1 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -35,7 +35,7 @@ static struct {
>  	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
>  	{ 'E', "\n[GNUPG:] ERRSIG "},
>  	{ 'X', "\n[GNUPG:] EXPSIG "},
> -	{ 'X', "\n[GNUPG:] EXPKEYSIG "},
> +	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
>  	{ 'R', "\n[GNUPG:] REVKEYSIG "},
>  };
>  
> diff --git a/pretty.c b/pretty.c
> index 39a36cd825..f98b271069 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1236,6 +1236,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  			case 'U':
>  			case 'N':
>  			case 'X':
> +			case 'Y':
>  			case 'R':
>  				strbuf_addch(sb, c->signature_check.result);
>  			}
> 

