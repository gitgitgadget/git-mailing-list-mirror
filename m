Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B611A1F42D
	for <e@80x24.org>; Thu, 31 May 2018 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbeEaMGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:06:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:53471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbeEaMGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:06:52 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1fgjbx40Uv-00PejF; Thu, 31
 May 2018 14:06:49 +0200
Date:   Thu, 31 May 2018 14:06:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] refs/packed-backend.c: close fd of empty file
In-Reply-To: <20180530170302.191176-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1805311406050.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8e7ae9GXSCixM18IyHKV2fRshYEdXpWUL8VXOPg6fkVa00EVnMH
 qtVyOpGXH7/GqxOUfE75lwSUx520PgL2EzLA0TU05vbLOHOO9m1TqqjyMCppeQC9xYTiKZ6
 JFC6Fh3owpdZRrRAyEYZebFXLKbsLQjpCL9pGfsUzCQpNEFoFICavDmXlq4mm7rKIG+/HvM
 nptAPappHP+1rtrjiCaAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:smUJMygqAAc=:UZatVykjYDPw+RbbaIpovg
 bPTjY1ze35Ux0zRolQkEfIk3fdtq+R+evd5RKQw7F+vkVgDQlh5z8FrjXPa031VicUEVfSYM0
 AgFMAu93LRlGmGufoANgQcrGFiyolqsm3kCl+xCaso/dC+vzMTLrGHn+Qv5aM2V5iZyNtv805
 +8wXMVd2VhyuoWuu62gk7V1cVjO32JLTXI5DoEmRkoGcY8AQ17Fdma/rACehgcv7BlTzZnh5B
 itt/bFjokP1Cb+M0tKH0sP4zEiKuf1xpXbRAxFAmk0Ug4/rlJg5UJRHVVKMw9BauKJuqnJ0ho
 HXbgp9ii16II0d/sJwPIXZeEPR+KPh0nEMo80/omFhEiarPVwqV5dVQf5y/SRWb4b1+iC69Rn
 snI1rw3+lh/C8p2phbIBH7b9oF1FWg83ho20P30RMoA2GKtVYs2kszKZSBXpZbWaxuJSCeOcY
 QGpfXqpe14+tur+BhoeD/gIwJN3cdThTI3+JrT9q5WdSkW2j9vCE3Kxd/DoKN5ey/ad3O/HrV
 aFedtIQTazTaIV8JyvRohGpySySrMuAXNkHAyl8lhjoBIiLV+ZQbS67BQtQckEYJZKltBJGvP
 UNnDR81vSp5fcuvyOiV7K3CB+dtMMDLZiFmWDCE9hdsl4fenqSHToa9zkqsXSWlfC/XhUectJ
 1rzoI+yVlI1ZVApn3FmbD6e3cgk/p65MP66PfW5qYZoGQEvL1GeTPPw2whx/GsgZAQFprwjNy
 nzMkoHNmCZSrQK0r8uI/NkPl6CF59E7ImMf6G2+4Fmm3O4rjTyMysxfSOtdNTYR2EpD8Em5Po
 kC5NaLS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

I am Cc:ing Michael, the original author of the fixed commit.

On Wed, 30 May 2018, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This was an oversight in 01caf20d57a (load_contents(): don't try to mmap an
> empty file, 2018-01-24).
> 
> This and the following 2 patches apply on master.
> 
>  refs/packed-backend.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index cec3fb9e00f..d447a731da0 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -499,6 +499,7 @@ static int load_contents(struct snapshot *snapshot)
>  	size = xsize_t(st.st_size);
>  
>  	if (!size) {
> +		close(fd);

Good catch,
Dscho

>  		return 0;
>  	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
>  		snapshot->buf = xmalloc(size);
> -- 
> 2.17.1.1185.g55be947832-goog
> 
> 
