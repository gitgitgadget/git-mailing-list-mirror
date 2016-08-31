Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618CE1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 10:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760153AbcHaKwV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 06:52:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:50890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759408AbcHaKwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 06:52:18 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lj4xG-1b6GWo1u2w-00dCzH; Wed, 31 Aug 2016 12:51:40
 +0200
Date:   Wed, 31 Aug 2016 12:51:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/20] notes-merge: convert struct notes_merge_pair to
 struct object_id
In-Reply-To: <20160828232757.373278-11-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1608311250170.129229@virtualbox>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-11-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:coaR4vocmmx9tz5gJs/picm6gUGvOj2YSpybd3K2qXfiZC/LREy
 WKBsWv64/SVZli+0LvO1JJq7iRk9FTQI/GhXa+cXaTiPsYmS5sO+8EJGpttkxDb8TcTJkaa
 tkfKbODxxYqKGBvFx9dLiHHEVGjkVk2omksJD0tHxfgNWlg58bmGlziNXTS1y+IdZ/Giy2M
 O1h6SjStPVwK2A6HKH9EA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hyr/yoPqXTI=:iUgXagAB8ELEfnt6I1rJVa
 biSptogU7xCIIXrNqO+ZO/PuaAjJi5UHtcA0byzb/XSqIQ/pRrh9Hbk5FxUyRseuzzOzLJmTh
 DmJlk14W61UZnxxYTo7t7q1ZR8vy/2cMDwFPWJ9tlMnbfZuh+HuT31DZ90y8ZH/ggfHp3ZIR4
 BXUGVzpHsAusWkROkrw8U/A6y106lFVAV5g32GiaSzwmM/2G67JFW3OjwHkZ5NnatAqQ/lmcu
 NzvE7mtAEowI9Ho3kAdAGUAxdjaYofdSdlT8ryEe65p+RfM8cMAM2MlxBDqlJv0FMcbWYQ4E3
 W2BUa7ZbVDt703iCQGnN2OcFMCBCl1iNKNwbRCbzModDrMMP3+WuFS5rHxiA9gerOIqQA/zvn
 hqG/yabVmQVQZJfJwHWpTQ+bM1yhOsFB7v+xWa1C57zaew1DmvZhOgwYzx6GvCANDNgs6kmV5
 WY09CX/su4nEMMRWrRuuqbq6AWI0NBX2sCuIDBfxZjB0rSl65O6wuaZAS6pZEEK2ZS4aCKga/
 lucmnSvIKIM5yc4TEYBQdBc5MljodGE9EL/eGSD9Fyv9T7Z2Ozhdz+KdgV770RJ1bTM9crH3h
 vf282aSaS+6jSkMcHDOTS6r7oCdjTpd9Niv3dqOvHiDlW8l3YqO0YOxIhnbUFF7kH+1yBBaS5
 5zJ33fwLvGz8Cd4TKsWgmiUegKu/xZ2dhcejdv3b6pozX6asuL8lpuNkS4BfhMJhD9r4jNlN+
 gqYADxlsxuuFVCiFHuCKTgLk/TtSC64ZEsLsVqXaJ6h3JZi0BZSF9GDzd2MfyiUWtQzWLidtL
 KRcs2f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 28 Aug 2016, brian m. carlson wrote:

>  				assert(!"Invalid existing change recorded");
>  		} else {
> -			hashcpy(mp->obj, obj);
> -			hashcpy(mp->base, p->one->oid.hash);
> -			hashcpy(mp->local, uninitialized);
> -			hashcpy(mp->remote, p->two->oid.hash);
> +			hashcpy(mp->obj.hash, obj);
> +			oidcpy(&mp->base, &p->one->oid);
> +			hashcpy(mp->local.hash, uninitialized);
> +			oidcpy(&mp->remote, &p->two->oid);
>  			len++;

This puzzled me at first, and a little bit of digging revealed that obj
is a local variable and uninitialized is a file-local variable. I would
have thought that these would be converted to object_id's, too...

I guess that's left for later?

Ciao,
Dscho
