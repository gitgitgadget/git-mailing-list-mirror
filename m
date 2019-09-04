Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2041F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfIDVll (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:41:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:37047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbfIDVll (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567633299;
        bh=zZGi0kyN3gOlS4M9+tR4K0D6h4P2I8UR2H6mSSdj2ko=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zev8+mNuRKtdxTD7zq7wuw8TtVDKkMq1S1lQPCp7CQgizzn3qe8LU38YIEL9AmJbd
         ygWnDYPxXNe7DZWJ7YdgEU8xihPHBn7li3OjGN04OjWl9tH8PQLNkJZDbFrRd4NXYw
         97oMwepNdUsKHxYNqiWU/CmosSc6V1Th40QA8NxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBBl-1iXV0Y1efV-00jbEC; Wed, 04
 Sep 2019 23:41:39 +0200
Date:   Wed, 4 Sep 2019 23:41:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw: apply array.cocci rule
In-Reply-To: <dcb92cffd7bd0643e7af68d825f7517d490dcf16.1567595331.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909042340520.5377@tvgsbejvaqbjf.bet>
References: <cover.1567595331.git.liu.denton@gmail.com> <dcb92cffd7bd0643e7af68d825f7517d490dcf16.1567595331.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BsU5KUSPeQ9x5EyPNHPKgaGGGGhVmEsZvJgzViJOOH/b2dQOQam
 xfzxzIh9meR5dhulyn0AZtobcJdvcOj+Qvc5hmwtHrZY0eZ9Hw4NNEuzfqQ+m8HEYoiK4qR
 31CUZpr05fRmby2OiIut3M/4G7k/m3h06nTUQIRpKnbIVHrNqLT8AbPtL7eSY62ICBmxxhV
 3GWs+77iWZzoAzdgMsdgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEuYO9QK8VU=:gSLT7P3kDcvOWmUwxWAJ2d
 /UOED1sa93xeMJXM3ScwcopecKBj56SkQhQaVyheSjG0F4IkXHqvRbN2PvGsQeIBNUryk3Kx/
 s6DjJ0Mi8m3xTwmWADKNoEWnjmOBIXNT8JINT+29I4msqu4srYcK0xG/J/0j4DyZPFW2FkgNl
 jTuxkWQTIXj44uyJTue+sHr/Iwn82j674HihKylT1kweKB5q2R2v73qz8w9x1xtX/3ykHG2eJ
 LmxoSCARBW4+JeLa9ZBW8vKjyck1CtufX4DK3ZV5vRAZ1UwAflIw2Yxq9YorKT4MEeoreweWv
 2myq0wWYCpd8GJp5bBnIfh2Js2swdlX+3jx/iY8+oRBQB7leMwrClxQNe7bIc2XeNoeL/PIvQ
 Gq6pzZDvKE/FwiWpfBm6fohe6rLziFPiaJXz/oQI3dnW1FGUp8WDjIUmRVP49lU7xOXGOWP7d
 4vcoPm6hLCdgfOwzgximT/qSe2fjnStEhGapvwoQrmasfbOvvNreW0wwCyBWjhZK0JWYnMSZa
 41g/sEg89RYxRjLZUUwfLl/uJxCY3p3McR6AbuZuSf7wSE/V4pyCdEdb9v6nDBib3+j8GnUuV
 20tORrdgjwM72UX4jDQEW56jXnsIxCMc/OoQsBcf0+p+fSSA2NozpZt4+PY4c66XokuTk/Svj
 aQ/E+0LtN7Xd82vNuGWEgXydmk6cCUqg+7Jgoqp0ZM5mxQ5c6XuSfuQCA9Jv9A+Fbs0+aut0L
 UkIc6oNonRKxveuM2oSXNf/VKEDig7WE3i38+tu+CUGfbNwBnEjKf0LdZ+gAwnNjMnndDfgkD
 3zyCQ6IsmL/lVI5STAR6D9KhkuT8lnANzZXu9PL1YNkVQOprAvpbw+cGisERJi7mDSEJlh1IB
 /os28sOexpmajdLijoP1bJQnsMexkeJdPg/r5zHiCZ1umlgwmL8BAwSH8fuKmO9t801oIMPt2
 KP16sKpLbHXoY4BLwOAPi90n4f8UAx6rC6xUOHfzq5QPFZ//0OY5xgViAY2lvrFtyLOFcjBFJ
 goznWEvS275tTY3yOPjf9dB03McBd+BkkxLN21HD6gJ4t+un1oWLRockfmZ7uLQTBj9CCBgDD
 Rj7vuq8dOGQiIsTAaUQgETHoOuYiU5tk+6eLDiUSuFh6k/OJwJcb0irWl4rt7lcgN2NrbE2Fc
 rAFaylGc39eVcXZaRuKjyA7Mx1GPQicItIoHhMaQ7KY9+xeEICYoeRo8x9HcubvLaPj1rPG19
 BmB9cDE+HfIw9vU/w
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 4 Sep 2019, Denton Liu wrote:

> After running Coccinelle on all sources inside compat/ that were created
> by us[1], it was found that compat/mingw.c violated an array.cocci rule
> in two places and, thus, a patch was generated. Apply this patch so that
> all compat/ sources created by us follows all cocci rules.
>
> [1]: Do not run Coccinelle on files that are taken from some upstream
> because in case we need to pull updates from them, we would like to have
> diverged as little as possible in order to make merging updates simpler.
>
> The following sources were determined to have been taken from some
> upstream:
>
> * compat/regex/
> * compat/inet_ntop.c
> * compat/inet_pton.c
> * compat/nedmalloc/
> * compat/obstack.{c,h}
> * compat/poll/
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  compat/mingw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 738f0a826a..a3b1e9e3bb 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1265,7 +1265,7 @@ static wchar_t *make_environment_block(char **delt=
aenv)
>  		}
>
>  		ALLOC_ARRAY(result, size);
> -		memcpy(result, wenv, size * sizeof(*wenv));
> +		COPY_ARRAY(result, wenv, size);
>  		FreeEnvironmentStringsW(wenv);
>  		return result;
>  	}
> @@ -1309,7 +1309,7 @@ static wchar_t *make_environment_block(char **delt=
aenv)
>  			continue;
>
>  		size =3D wcslen(array[i]) + 1;
> -		memcpy(p, array[i], size * sizeof(*p));
> +		COPY_ARRAY(p, array[i], size);

ACK!

Thanks,
Dscho

>  		p +=3D size;
>  	}
>  	*p =3D L'\0';
> --
> 2.23.0.248.g3a9dd8fb08
>
>
