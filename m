Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A831F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeFFHCl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:02:41 -0400
Received: from mout.web.de ([212.227.15.3]:45745 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932116AbeFFHCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:02:40 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaZQd-1g8d3P0n7v-00mOT2; Wed, 06
 Jun 2018 09:02:24 +0200
Date:   Wed, 6 Jun 2018 09:02:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] t0027: use $ZERO_OID
Message-ID: <20180606070222.GA11992@tor.lan>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-5-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604235229.279814-5-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Znj/DTIQhJegK7Lh7sYOjcIzU05Y2F3Yo8muoqFnHpgJgPmJEdz
 gn5bPPigo4V7QGvqj2f3Hy/o5BoGYvkffReXiPkmpM1NMflxVW2zhgqY8HEGlmX7EXrvk99
 9VfdQlRJbHQxCQm91dVvVIc6GETzK79ejdE88frrFr7tNSzdgtmB/2A/ZYAIWgcc5DrnqXm
 bbnyuA/WOfVvOq+x9wY7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3LYW7/XcyL4=:5PjMmFnlssBcUG977GR5qx
 HBVacEX/lulN8kfsuvlPc3/RgrUrIRh035tFJhZtMDL8IYQgQoYw6aonoKHJGM84UvWnDeDbR
 KtYjlD7cYhkVuWYoV+AYXBUsH9KO+ZXsWqM60JPdnwBJzFcrQcj9yD4JRdTrr0HoTr88q2YWC
 n5dQDmsZ8bc4+cXjmlcD9+6kHzEvUiSaZ0NpPBftrA8Dany5UAlK0Cy+hyf8mST4NUIYUvPDq
 VtpaEq/uCG12XZUOfE2xSHanPHbEWuwgTUOi6OwhLY9Abc+w0U+tB95HdNaGMlYPPHWKeW78G
 GTrcKhJK2Jd6+fnfS4UT2LrgCoz5cSoDV/wa8s3CT5wJAaFtk2rYB6TBHpcUsIH72Z7KFB8KZ
 kel2Ms9TpVv3t62VyosF29MRbHoWbagn/r7WnG60r2VP22sGWhsBtlzuzauRHh91Dk+vQI2Bh
 HbbRI9T24FvNMDqP3zFjEF37Zmx+Q6kqAtWCLZv5ypCWUJnG082wEGJmTIIVoHRz9TbpnkfBy
 K5PlL3HCygRKWyz+ZB80gLhGKi+2avYWer06dam3Ftq5pvhGmVSf/yvJlHFFeG+F+TUU3Mwrk
 2O0trc5TLNCAo4dCCHYnR2MhN+iVc9vUlb8esLNiV4mN3ANB7e/d4Z7b2pF3OYiUA9LcOT6L2
 ciCEPss+wDMABQLt7oSP43z5M8LmS0Fets3QipmtGZCufQkcW3glWNEdnBDEtmld3pcOf5sDk
 2bfOy2nGO5ZCiD2NSQaNqS3HFxOkd4w+7q1EbyXmlhz/yd9zoC5ZgyKdqIc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 11:52:23PM +0000, brian m. carlson wrote:
> Use the ZERO_OID variable to express the all-zeros object ID so that it
> works with hash algorithms of all sizes.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t0027-auto-crlf.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index beb5927f77..14fcd3f49f 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -371,13 +371,13 @@ test_expect_success 'setup master' '
>  	git checkout -b master &&
>  	git add .gitattributes &&
>  	git commit -m "add .gitattributes" . &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\rLINETHREE"     >LF_mix_CR &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
> -	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
> +	printf "\$Id: $ZERO_OID \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
> +	printf "\$Id: $ZERO_OID \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
> +	printf "\$Id: $ZERO_OID \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
> +	printf "\$Id: $ZERO_OID \$\nLINEONE\nLINETWO\rLINETHREE"     >LF_mix_CR &&
> +	printf "\$Id: $ZERO_OID \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
> +	printf "\$Id: $ZERO_OID \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
> +	printf "\$Id: $ZERO_OID \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
>  	create_NNO_MIX_files &&
>  	git -c core.autocrlf=false add NNO_*.txt MIX_*.txt &&
>  	git commit -m "mixed line endings" &&

Nothing wrong with the patch.
There is, however, a trick in t0027 to transform the different IDs back to a bunch of '0'.
The content of the file use only uppercase letters, and all lowercase ad digits
are converted like this:

compare_ws_file () {
	pfx=$1
	exp=$2.expect
	act=$pfx.actual.$3
	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
	test_cmp "$exp" "$act" &&
	rm "$exp" "$act"
}

In the long term the 'tr' may need an additional 'sed' expression.
