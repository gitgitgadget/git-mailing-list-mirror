Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77BB920248
	for <e@80x24.org>; Mon, 11 Mar 2019 13:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCKNGE (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 09:06:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:38419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfCKNGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 09:06:04 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpgew-1gX0DT1IxC-00fTG8; Mon, 11
 Mar 2019 14:05:49 +0100
Date:   Mon, 11 Mar 2019 14:05:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, hi-angel@yandex.ru,
        peff@peff.net, ramsay@ramsayjones.plus.com, sunshine@sunshineco.com
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
In-Reply-To: <20190308092834.12549-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903111401220.41@tvgsbejvaqbjf.bet>
References: <20190305120834.7284-1-pclouds@gmail.com> <20190308092834.12549-1-pclouds@gmail.com> <20190308092834.12549-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1686699052-1552309549=:41"
X-Provags-ID: V03:K1:gactMQRsN47bTRLSE8fMjvPtE+IxF1UZKMGfVdw7AaukQYtdSUm
 7YkRkn2MpDeAw7rLxE60ItgH9JTJphorKjDpEUkMmbYr0wnDhMEghfiJAFW+76Eg15GNMJy
 tVX2SXekck+M4HOI19KGb9ik7qQ1RuDC12B5qLMulT8qIM2y/ODJRd9ulqiNQx+VweHG5um
 l5uTJ980AczeZks6Qb49A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XfmOYe4gcbc=:pQ0q7Pkn6bNdk3brXO5ou6
 7i0qd+rUSrpU7ol7qpOoS6yeYGX4dRdpsojcUSGyVeHEq3C5ilgPTLvEUk3APeXojDZsMIEJG
 7+Aqm3njR7yI8IoYqxKdysBI87vegzrcOMhFOlY4Da2yX9k/vNCgqcot9dRKFP+14dpWzqett
 ao2LIsFJnIb+cRUW1+HAQ2EmGadp+scnWal84XrqJn1lR6Wan+KZqxeRHfJB94fnxihqPg09k
 LgZZCtVbT+sbAxTDiFBRzv/AWLzfymPT2OkiiZ5oGiMtwSJvWi/7sFGqzpogpQLDFX5imAZR3
 s/wrgQlxOwZTguJheK0oaS2GLmG/e8wIPQ5b5PcUMyPUJA5sAqkuXcMOzwAxqgGOCIQwHSxpS
 p3yyjZHjdffWwOmhOSYKUH0Z11oCLHMZXC2tbOFlS5cTlV+VhTcBF8Xz+E7MhFxbndviHbUAJ
 XQ14Ak7VfVZ2E5M1hnF8D6rhuHFCoIRBF3SNUKkkTZdBHEisBvZlHwwFnYA6RMYv8yVFxrauY
 3qRJ3BxpcQ4fhE28FLef80f0xIPw0upry0emxvVZs0cpBnX6fUcG0qT9A7J1Cucm2nXTWpP2w
 CdaMTnQZ1vabKqkErxfXzPRdtlaZcoC2ijxo2wRKOheEphNQueaPbNOnwzzo3Mvtvna6Nj1eK
 3oK6RJVIJSeH60UeEfzOYn39uMATz+LXVsNqJiK6a8hTiVWLvTT5A+TvfoNbOKMrDSA3HlhRU
 etjq2Ny6n50e7DW0WRqiwVx2u08ZXW1v/Shg4n7fy4zm/JOXTRGAryrNkfwopm0r+T2ScDBYX
 SyYCSnMVtHTOs3pVreF7VG71UD350PZ7vy+VQi6sbCHuLvGYbBsNlj2gOLqidqE+Qj2DekOUo
 HS88rSkRwlQM5VP+w2DsNhEShSg5cuULMcZowqHeIOJCW8L19gomp5UvenvsXpyD9aUauNcXj
 KrPMHlRf3TQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1686699052-1552309549=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Fri, 8 Mar 2019, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/refs.c b/refs.c
> index 142888a40a..e9f83018f0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -72,30 +72,57 @@ static unsigned char refname_disposition[256] = {
>   * - it ends with ".lock", or
>   * - it contains a "@{" portion
>   */
> -static int check_refname_component(const char *refname, int *flags)
> +static int check_refname_component(const char *refname, int *flags,
> +				   struct strbuf *sanitized)
>  {
>  	const char *cp;
>  	char last = '\0';
> +	size_t component_start;

This variable is uninitialized. It is then...

> +
> +	if (sanitized)
> +		component_start = sanitized->len;

... initialized only when `sanitized` is not `NULL`, and subsequently...

>  
>  	for (cp = refname; ; cp++) {
>  		int ch = *cp & 255;
>  		unsigned char disp = refname_disposition[ch];
> +
> +		if (sanitized && disp != 1)
> +			strbuf_addch(sanitized, ch);
> +
>  		switch (disp) {
>  		case 1:
>  			goto out;
>  		case 2:
> -			if (last == '.')
> -				return -1; /* Refname contains "..". */
> +			if (last == '.') { /* Refname contains "..". */
> +				if (sanitized)
> +					sanitized->len--; /* collapse ".." to single "." */
> +				else
> +					return -1;
> +			}
>  			break;
>  		case 3:
> -			if (last == '@')
> -				return -1; /* Refname contains "@{". */
> +			if (last == '@') { /* Refname contains "@{". */
> +				if (sanitized)
> +					sanitized->buf[sanitized->len-1] = '-';
> +				else
> +					return -1;
> +			}
>  			break;
>  		case 4:
> -			return -1;
> +			/* forbidden char */
> +			if (sanitized)
> +				sanitized->buf[sanitized->len-1] = '-';
> +			else
> +				return -1;
> +			break;
>  		case 5:
> -			if (!(*flags & REFNAME_REFSPEC_PATTERN))
> -				return -1; /* refspec can't be a pattern */
> +			if (!(*flags & REFNAME_REFSPEC_PATTERN)) {
> +				/* refspec can't be a pattern */
> +				if (sanitized)
> +					sanitized->buf[sanitized->len-1] = '-';
> +				else
> +					return -1;
> +			}
>  
>  			/*
>  			 * Unset the pattern flag so that we only accept
> @@ -109,26 +136,48 @@ static int check_refname_component(const char *refname, int *flags)
>  out:
>  	if (cp == refname)
>  		return 0; /* Component has zero length. */
> -	if (refname[0] == '.')
> -		return -1; /* Component starts with '.'. */
> +
> +	if (refname[0] == '.') { /* Component starts with '.'. */
> +		if (sanitized)
> +			sanitized->buf[component_start] = '-';

... used a loooooooong time after that, also only if `sanitized` is not
`NULL`.

Apparently for some GCC versions, this is too cute, and it complains that
this variable might be used uninitialized:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=4352&view=logs

And quite honestly, even for mere humans it is not all *that* clear that
`sanitized` cannot be changed from `NULL` to non-`NULL` in the code in
between, *in particular* because the changes extend over two hunks, the
code between is not shown.

I would strongly advise against trying to be so cute, and just initialize
the variable already. Over-optimization in such instances makes the code a
lot harder to reason about.

Ciao,
Johannes
--8323328-1686699052-1552309549=:41--
