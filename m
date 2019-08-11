Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560E11F731
	for <e@80x24.org>; Sun, 11 Aug 2019 11:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfHKLU3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 07:20:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:45497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfHKLU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 07:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565522426;
        bh=+hTKgDZNVPnMPAB5YyirbhPcNxrYxI3//YH6S9vBc0s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LeHDxYdblZAU93wZgNmyOTxBC7a6hE1HtvR+0eyBfUBwarg5cc531lUPGcNOAdjXL
         jXgZGU9RZszA7MMqmZYXoOxNgfw6CZJJiGZLFJjkifhFGjZrqi1Iu2ewE41lJxAYQk
         tWbSNZAEi6qxkB36S/ee6VQZ3tP26LBkNVdY947s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1ib13X1pvR-00liBJ; Sun, 11
 Aug 2019 13:20:26 +0200
Date:   Sun, 11 Aug 2019 13:20:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
In-Reply-To: <20190810220251.3684-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
References: <20190810220251.3684-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-398096661-1565522428=:46"
X-Provags-ID: V03:K1:wU/fk5GlF3wlDtZoEseHHBXejKZ16BvllvbydXrbDp2VTdSiJ93
 g9NxTZnPMu13YYCHZSqbkhZUjGxaSqQysDNSy1o5vZacV/nHj9YMX3hMJqD5oxCJQdAytc9
 yx/eWyUfTR1ylE82OE2nHawg35F9ktgSGuDs//jAtMezwJ6gVo2/CrtgKgQulrvtTxTVj1E
 5af0pe5A9x7hti5mcaVCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iICA1JFB534=:p6m+v8xQufk6EaR/OKRye6
 1h5ZHlYfLG/FBm/DgnudwpDkMAe0bQJxgBPYJurVBKufSlrk9BpSCIyB8hh6dlKOBtcDbY7rj
 cYhLPBo1QLZyVCsBhod6phbVf0FDbftRa3xSh79VW2r9O2lmK7kt89336V/PM3VeHyDgVrY/M
 vDlZ3iUozFJEQkBJE9/NR37DTjWyl/LGONIPe+0e4dwxtDLRGmRmrsslMul4dKq58ltYFRG07
 KnjvYUIfhFX7prXrLMeUDk6HjEFhPzUonCuXY2CpksXi1jkYB2mmXlVVsSr0TnDNWIMY1J6+N
 1bMxu9dEfOJsN/68ZEl10zDjEHAJxAlYM0oKC097bZMZMeCMVr6wjNkZEE8VvvDPa7WNt8GM8
 m/6tfV7+EiogNdjgPy0uWzuwNiiVVeSaIEYGMbuP1wTkKaU1F5t+jBnL6vrb9lrIY9o5snKak
 4UkRnu5Bx/vo6T0LeS+vM/LsWRu7/6+2Q14YXiWtp7jqKaaWrL+21tNsMywb8oCcxWpCG8Jh5
 2lVv33pYV6Bd9mm5FaSELXQ76lRRTE8cfyRe9objB90BZkUhe52Eo104Ll02A96n/ZDgDhs7s
 b52Y2Jp7wKrpKdwFdvaEZjvyfhSlsy72YJwKUoIWtjVFvM72XvDqTDauvV2D7kkkGOfTWjRcw
 UBZBkEZaqvnjFE55VVMO9UYrpOwNJe0q19xmel0p9jtbSTP4vgLQ7jXtk1I1IwdtHLPuEv47m
 RM9DsNx+wcyUeFi+ANIGx0/E2Pn1PppkO8cX5WRAegrDxVIcuCh11v4vvio8nFFtRNlypUC0g
 M3jWqsh+jSrhsF6kGjGSDiizXaJMD8Xas7L7aq26y6uffXHkxPkEYMAW+JC9yp5oZXSDnwM0o
 sisDGI4YRf3LF6swcGaGJIJ7UndBo3D0wS71GRCXMp3FXnAAHZ3HlRksYhvJKoQZIH199036c
 MSFIQsf+cC2R013RmTCkFNGb0m8QrhqLoM68Tp/Qz3KfOOzDR2XEYRJKHwCG90Nk7dQlDSc8P
 v7FBTAyjsP+KavE5+1T78VyUqP/rCxZe08VLCqaRdXSp7Id6aMBXqeVMnGZ984EL+C7kqxSm5
 wuIPStYzv721Y3cfQadiOftD10WfVVpwyR9KCfHUWwQjHjv0cQWsfg34Vxrdehg2CrnyFEDHR
 QWRuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-398096661-1565522428=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Sat, 10 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 4a30976e28 ([PATCH] support older versions of libcurl, 2005-07-28) added
> support for conditionally initializing cURL but when f0ed8226c9
> (Add custom memory allocator to MinGW and MacOS builds, 2009-05-31) that
> support wasn't updated to make sure cURL will use the same allocator tha=
n
> git if compiled with USE_NED_ALLOCATOR=3DYesPlease (usually done in Wind=
ows)
>
> tested in macOS 10.14.6 with the system provided cURL (7.54.0)
> and latest (7.65.3) and while the API used should be added starting arou=
nd
> 7.12.0 (mid 2014). couldn't get a release that old to build and therefor=
e
> the current mismatch is unlikely to be found while testing because of th=
at.
>
> cURL is very strict about its allocator being thread safe and so that mi=
ght
> be an issue to look for.

Looks good to me.

Please note that this did not cause problems in Git for Windows.
Probably because we leave it to cURL to deallocate whatever it
allocated.

Still, it is a good idea to ask libcurl to use the same allocator as Git.

Thanks,
Dscho

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  http.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/http.h b/http.h
> index b429f1cf04..59ec4cbd30 100644
> --- a/http.h
> +++ b/http.h
> @@ -27,6 +27,9 @@
>  #endif
>  #if LIBCURL_VERSION_NUM < 0x070800
>  #define curl_global_init(a) do { /* nothing */ } while (0)
> +#else
> +#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
> +						xrealloc, xstrdup, xcalloc)
>  #endif
>
>  #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM =3D=3D 0x0=
71000)
> --
> 2.23.0.rc2
>
>

--8323328-398096661-1565522428=:46--
