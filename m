Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B6E1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503787AbeKWWIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:08:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:44025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503783AbeKWWIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:08:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1fd3Af47JS-00n7Y7; Fri, 23
 Nov 2018 12:24:28 +0100
Date:   Fri, 23 Nov 2018 12:24:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     tboegi@web.de, git@jeffhostetler.com, git@vger.kernel.org,
        newren@gmail.com, pawelparuzel95@gmail.com, pclouds@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v1 1/1] t5601-99: Enable colliding file detection for
 MINGW
In-Reply-To: <20181122201640.78495-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811231221201.41@tvgsbejvaqbjf.bet>
References: <20181122175952.25663-1-tboegi@web.de> <20181122201640.78495-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1031139593-1542972269=:41"
X-Provags-ID: V03:K1:nrB8WDXbcM9JXvwk5iyA99KxryLsq6eq5+fMEqYGJ/C7/QolR/V
 Sy8rmMxyxC+gXo5+80UokOenT7i9gYIY/griaWKkg5fu/e0BbZs0PII3x57nv/if1F6F2T5
 Ja0F6TlLi0AOqO+M+I6AZgyqo6f2lBuDrY1cnbQh+7Zgr6JSdNK/5Ud0JzRg7NhVvnUekDi
 JfK5C9+n95a7gOcn4Xogw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u4V0STIYorU=:EuG55MF0r2jLLYIR0p+pbg
 /8RnSUyF+q6SC3/Ml1Ky08aghiCjQiPSMMy6AYCCSr2vL1cTwLpClVSmSR0Gs91AVvcN9T4E3
 3nVOa9jsTZ7V6twC+afp6uSJFDzN3SlHngKQpoHI4fNDmx3F1sLTJ7WGrMykCGPSINYdYimd4
 nB76LHoo9jcEnPRro92OwSzYlutSTMn7Zay6AivU4LTGSh5QIbZHv7fM1sqZsraZ+kw9K1evU
 u+MYtdXlRiVOM+Lyg8nnWdPu7Q9seJaU56vrJ1skXEOtCxwPs6tID4J7DIiuNLO8HJ/k3mVM5
 4Zq0v+SFKahVhXbSTpCJyGkeqnwk/sZffm7aFVOm+6uTPojiXWKV5Buz64bIo76lzII1TbG3G
 /nGGcW4xOwDOiqYx2MScdaI6TK0Yf9gyoyH+uS7YbYZJS6yM7x9VgDRp16i3zSnkwS0VBG8q8
 pe1PzUmkpAHePaRzBFmA4ME3HDBHVvLwnY0+6gqJW8Ocb4xuaoPt1ydcNEJ/qfWysxg2Rzs5x
 +1BmWQR6Al+5b8Tl5uQudA/ozxwBOQs2d7XuaOl8P6w3nmL2izehbuKHGkUKOM7GH+SMl7XU9
 FPHLMl+TVityG7Oz7LnACWxdRLtGMnRVdstxKWkAe5EJqdgez12/0Ov0kbjAtIBbYNfh5b/4o
 eiJ/QBfaEPbR/wnv0j3RsgLmsoEJAoTzdln/GRHkQtdbsdY3lV8rvOq/3oN5AkYLrBqy47poB
 kLsnVgLuO8J+48qfQeA3WMUM120ERY1l4nauGa6/Dk8b0/9t8SFal6aghZRwyIN8nO7afUGcb
 FY1It0c5iM4oKkh3kai1kz5DLsBxxmuIr+iixx3lro+duwqqMUPGSzaG0kegHAHcvq/H8ux2i
 SxF6v1GpUesH0RW0zO8Ndl093PrC0tBJ+0ozr7vIHbpx3n0VV14e2CXYInTtUu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1031139593-1542972269=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Carlo,

On Thu, 22 Nov 2018, Carlo Marcelo Arenas Belón wrote:

> Subject: [PATCH] entry: remove windows fallback to inode checking
> 
> this test is really FS specific, so is better to avoid any compiled
> assumptions about the platform and let the user drive the fallback
> through core.checkStat instead
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  entry.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 0a3c451f5f..5ae74856e6 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -404,10 +404,6 @@ static void mark_colliding_entries(const struct checkout *state,
>  {
>  	int i, trust_ino = check_stat;
>  
> -#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
> -	trust_ino = 0;
> -#endif
> -

No, we cannot drop this. You may not see it in git.git's source code, but
in Git for Windows' patches, we have an experimental feature (which had
seemed to stabilize, but Ben Peart is currently doing wonders with it,
improving the performance substantially) for accelerating the file
metadata enumeration in a noticeable manner. The only way we can do that
is by *not* insisting on a correct inode.

Besides, IIRC even our regular stat() now "fails" to fill the inode field.

So no, we cannot do that. We can probably drop the `||
defined(__CYGINW__)` part (Cygwin even generates a fake inode for FAT,
where no equivalent is available, by hashing the full normalized path).
But you cannot drop the `GIT_WINDOWS_NATIVE` part.

Ciao,
Johannes

>  	ce->ce_flags |= CE_MATCHED;
>  
>  	for (i = 0; i < state->istate->cache_nr; i++) {
> -- 
> 2.20.0.rc1
> 
> 
--8323328-1031139593-1542972269=:41--
