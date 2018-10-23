Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85CB1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeJWSf5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:35:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:56315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbeJWSf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:35:56 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz4KW-1fb2hC36GG-014DJR; Tue, 23
 Oct 2018 12:13:10 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz4KW-1fb2hC36GG-014DJR; Tue, 23
 Oct 2018 12:13:10 +0200
Date:   Tue, 23 Oct 2018 12:13:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     carlo <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] compat: make sure git_mmap is not expected to write
In-Reply-To: <20181023051216.64266-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810231212190.4546@tvgsbejvaqbjf.bet>
References: <20181023051216.64266-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1020242874-1540289594=:4546"
X-Provags-ID: V03:K1:jVU4dsWHFOZsz/wtBZ7GFfiNaNJkTxDz+bGypB4dvHWW04+Ircv
 CriTc5UOM4eu9KzF91lsq30iMH5y3jqdEa5M2bE5Pfne2tZ/K+D26tawEntmfQuy4UDjvK6
 c2WceehRLzFHlnsnTEbvPHPpRrdQJQA266XNT+TKdJp0wdVlzFq7J1pj4/a4dlzeZ9LJuOA
 71ODTgndElUrbLVqT8BIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DNZ1czL/G2s=:3hWf2A2oEiJNcvRBia+c38
 bQVg29k31J06GiTm0eSfr1WwJO0OHa53znjaP0SJnj1AxaFsLkBBNthYtXYu9y00YEbGEHRc/
 lhpeiNaYcTo6/oeHUCKcYWdHibaBIJE/PvEJQpLgOGBAvBfgBolutJMVBExDCV7ktzu20Pwha
 fPpVCJxeCNVdCtM2xbwYotnB4fSzoY8kSplfXzaC/vIe41GFkA0sjuekSerBjjDMFOfWisr6Q
 99Ue3heXKxiu4o1vJooDo7RF8NfcU+SxEEVIfp7kGgWrhbGF21D8R67UzMMXlfz/KhcFdCmK3
 howlTmJEk5YtUYlYknw1i4vcrkvGfLfaZD9oWNDfWUAGbq+Q8yKPmZRyyfVcOn+3CefZ5pAj9
 hdGluOyi4dBuvohm6zjbJkn0Ajbjv1pTGAiZNgCkauFiounzbE6LlhqwyNOQNBkCCRX792Do3
 0ukrkI3xLcwHWPx4P0oQtXKLdN5cX1/pNPFPTlAxiyyVlGaV14fuzwC9MDrIlqvCVuesH5qFH
 dkEM52ls1+Gxu9/2XRERXrZld8LQ3R/RE2sqFK1fzq1/OSIqi3LxDx2E6+vZa4Kcgo0G4L0ZQ
 NE1WlDWRG0klN8y3y3Fic/s4uERLIhyo5MceymzTUn3dglBDZYoxiJVpyNDL1QsZm/aE78HaX
 INriUSAQcrYkt+FkVa2McVqX9o0N6rBjH/VZt3ffu4Q1izRQ/VWFrCV+YLYon/94BlWz8slLi
 GSJlnIJWOi8qGplNfUgGF4MKUgVtEpKoy4VgpACbqyaW1ICjFBEN73yiUXbvE3mKVMp+Qscie
 fwWQdZheaVxM8Xg0CgTI++zY8PN6WTNpQ9NU40BzIGs6Lrq0oI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1020242874-1540289594=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi carlo,

your mail's "From:" line does not record your full name, but the
Signed-off-by: line does. Let's use the latter?

On Mon, 22 Oct 2018, carlo wrote:

> in f48000fc ("Yank writing-back support from gitfakemmap.", 2005-10-08)
> support for writting back changes was removed but the specific prot
> flag that would be used was not checked for)
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

ACK!

Thank you,
Johannes

> ---
>  compat/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/mmap.c b/compat/mmap.c
> index 7f662fef7b..14d31010df 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -4,7 +4,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>  {
>  	size_t n = 0;
>  
> -	if (start != NULL || !(flags & MAP_PRIVATE))
> +	if (start != NULL || flags != MAP_PRIVATE || prot != PROT_READ)
>  		die("Invalid usage of mmap when built with NO_MMAP");
>  
>  	start = xmalloc(length);
> -- 
> 2.19.1
> 
> 
--8323328-1020242874-1540289594=:4546--
