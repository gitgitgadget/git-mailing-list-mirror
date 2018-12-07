Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934CC20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGWTK (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:19:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:39349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeLGWTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:19:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1hP0Lb0hbz-00zZFe; Fri, 07
 Dec 2018 23:19:08 +0100
Date:   Fri, 7 Dec 2018 23:18:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v2 3/3] Refactor mingw_cygwin_offset_1st_component()
In-Reply-To: <20181207170500.9078-1-tboegi@web.de>
Message-ID: <nycvar.QRO.7.76.6.1812072316290.43@tvgsbejvaqbjf.bet>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170500.9078-1-tboegi@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VER0Wq/ndIRavmLWcwHb3DE6Zy8VrkVDQZvz2a0Lk2y1FwlpdkZ
 HRul8dVVnWQ0zK+95LYAXUY2mwucUaYHU2mfOR2P9HUqLZyikK3ojc69hmbQ1iucIJjAE3Z
 UZ1fQBbNnO2B7X5UGuVHH364hOwFjJN4Q+0j/5JU5zBFguG142IAiUhNFpjR2w3ENVrY/H5
 t42mKuS3azNDzgQXT1iNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NgG4hBUHI5Y=:K4HDfSvkU6C0zSlu4KBJeJ
 p76SfWANnPxZf8l/Wi3Pswum3taGgf3/TvfOKNUXW+pOSkgbolFZ3tWM/tMUjigJ4hiHiUsS/
 ahwKX3yp1h/WutvV1dV09SRT7a3QYzqcktd7mp4o9Rb0qoqOnF0VYhGZu3XcjM5X95ZBOz4NT
 djy+l9czOpYLqyRFYTg8QclpyNwyIbFeeTO4pdgLsI7pyzIzkZQ9JU8dZkRm9COeFwZ+5zCcI
 0MHwEcdbPKletaS9Gt5VOoYAIZvQX8QcJQTN2RAAsoeNY4g6lHx1laF/Gd2+ezWD05+BJZFKR
 0fPN8CEAj0Mjv8upq9cC11FjHCCobwAtS2HXjpbCq6TZe3A+I7nGO1P6vHqbFPuLAw4AuSvv3
 hv6cXXOBT+lBcIztvYjMY+au4QOESBUuGWRAPknc8BNLTiI8WS2Y/n7h8JVZpjuPE+7OJkJmH
 AqCthAHrZF0lXVtP7ZBBrdYcu0qUvqvS+JCNv+KGRFznDMABQ4mT7wkD91GuIoVaPCipN3akW
 xVfU2RwR7+zyDUa1ybi0pO2cBGDAKJnw5y3Ss2CTU2dcI3XJ/pwVpJq5hk6AnAnelYsRrZMyj
 PFUkpKgnfrcBPWm0uPbXnc309pcOnzIn8FoIuz6JNROXE7y+rBIDUWpaIhZwxHOW6J1sRNlhm
 La/ytbvwr/5/aXZXMgAKzG3iX7yhQYYs2SYhDiVvlJV9bw7XhHRi2hwqNFkio2/Sy0J7oHp3j
 Qqeb/oroIH1O3dwVSvi7X4iFUFB9L9qfpvSi/Wqu09sG60jcaxjRAhgSCk1g+GyDs8PrCFOk4
 hrtbW18Y06zlSyjrj46lBeOOcPOE4qtu0NXdzK1eHC1+Ya+fB4/AS8Phc2lFJ0QJDOCkjHPNJ
 FtL1E2FvskM4mHFsbstJb5VZAVnGo2DIn913HMCdmS62YIovHVmfUDwmQzDM2h+wzKwp9o5dr
 zHbpxy0Fzqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

On Fri, 7 Dec 2018, tboegi@web.de wrote:

> diff --git a/compat/mingw-cygwin.c b/compat/mingw-cygwin.c
> index 5552c3ac20..c379a72775 100644
> --- a/compat/mingw-cygwin.c
> +++ b/compat/mingw-cygwin.c
> @@ -10,10 +10,8 @@ size_t mingw_cygwin_skip_dos_drive_prefix(char **path)
>  size_t mingw_cygwin_offset_1st_component(const char *path)
>  {
>  	char *pos = (char *)path;
> -
> -	/* unc paths */

This comment is still useful (and now even more correct), and should stay.

> -	if (!skip_dos_drive_prefix(&pos) &&
> -			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
> +	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
> +		/* unc path */
>  		/* skip server name */
>  		pos = strpbrk(pos + 2, "\\/");
>  		if (!pos)
> @@ -22,7 +20,8 @@ size_t mingw_cygwin_offset_1st_component(const char *path)
>  		do {
>  			pos++;
>  		} while (*pos && !is_dir_sep(*pos));
> +	} else {
> +		skip_dos_drive_prefix(&pos);
>  	}
> -

Why remove this empty line? It structures the code quite nicely.

The rest looks correct to me,
Johannes

>  	return pos + is_dir_sep(*pos) - path;
>  }
> -- 
> 2.19.0.271.gfe8321ec05
> 
> 
