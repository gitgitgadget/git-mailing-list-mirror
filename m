Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7FE1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfD2WwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:52:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:43227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfD2WwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556578336;
        bh=+pGJS9jvGrVZMjWHidjqNFyeSbiZiLM5MSmIZ7CKmjM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NGsrHxD8IFN4DLIUMTPeqDjO8BKH3Iu6H9kXzYf/BevWt6L7xNZJhWxy4yukvh57M
         +DLjEMv81M03qxOpPhM25x7FIVzzDb6sb/2CeFnt0IaUk8bG5pi1+6veHQFIa+RA4B
         V3IKPUSExy0erFF7i2XR5WbGs/uqOTXDpgQdgG1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiPD-1h7JBb1hZr-00MwIx; Tue, 30
 Apr 2019 00:52:16 +0200
Date:   Mon, 29 Apr 2019 18:52:19 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/1] t5580: verify that alternates can be UNC paths
In-Reply-To: <2c3c559da0a5e9b397f4dc80be233c66b8597678.1551104263.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291851280.45@tvgsbejvaqbjf.bet>
References: <pull.140.git.gitgitgadget@gmail.com> <2c3c559da0a5e9b397f4dc80be233c66b8597678.1551104263.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ecd/nMZkGX8wHCVKTRa3WFBTiSIMZlWrPv6mNjMr1SSBnUJHMNo
 Kt4rnThYvj9EXVafPJEDPJwfc50z5GrmKz2SwDshPy4YtvCYzL0J7GDQWQOM003MMgQzuSU
 Sbn2o9aGjl4A8UIAsGwED/4KJP191MRTG4F5HkSj35kXOMogpng7FkDw65NLRRSZEsW0XMw
 JhlJP/Z8ZMe8YhxNXgwkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jH593zRNqBs=:YCkT0vfPsSQF2zw2/kYt2i
 GYZwSozEBdPN50NotNcGSSXsiKIq6br15p8ZOqVi8NlX7b3LRlRQPhm/j/8yuF9n0t1kD32xa
 RbuojRKvIgK8wmRus1q+mphwOvzwZy4jFIvcoB9ovCsi2n9XfKT+pkYuiT5xrhb7GApYWtJcd
 CLCX0rotyvbZuRovOPgTFAK4+NbglMi21vQwQAWXmpNkLicFbO5hCWH+2QlqhO6135GybPsKJ
 W7cgl6O51iMRE3uu8oTGY54cMfXgDcI51k+dHosYAK1fc6ppHK1B7uDDjqWH8CRodOPzp1PgL
 c+FJ5Fii4b6cvCfaFc8qrpVM1nP1UePCQ3xRtLPioYkdWZeW2HpYoyDNRGdHBiWmZYpg1I75P
 MRVLEXMAD1gc569Wreu9RinGy96WMPvLiRDqcFIXPWu8g01dn5SqXReNt1WG8g4of8Eq9DqHs
 KAV23/lOPCcws2NzwNf1I1Hk6UpSu6hn43kc/S1/2iabs+r9ePqoXfCZC/2ETSYaHaSAZL7SY
 +vjuhJCd2dk71EeeraIEW13dJ+UWMI5yPsZQTvO/v/nZwJfpgeImn3lzXb6Bx0Iw3YYgbhvIt
 o1QMqFzeClUIt631FfSwBvuJatF44/ad468UrNB6C5lMfYU9YtlsoLLBaTSZMX4ucwc4kIzc/
 XN18YYEcALUnFdnZJ3RccrNyDF3Jz0h8KOME6AIQCKJcIh5roLe1wdyg/ahVACkWpcG9PRukT
 rxA/DP6sLpygA6Xz50eLwqmCHLJsGHoyjZXMwSRkxx48vzWEubmmdEHlxAeJyvGnqin5Qpx1g
 n+A6Zo4EFdJ6fM68lQRP77zv5BLhC1cVCzUTQTDy5NC2u1Xfw58KQIZaaV0ZhNI7G0YNCvBPZ
 xylhSx2c7/33FUNJ1gA+LpN+66JIaZ4gHDG0VY5MstnXgsrEClZ0V9CIZljQaVdx8c916ZwTI
 uAtruySO/bA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

gentle ping: this patch was not picked up yet, although it should be
pretty uncontroversial.

Ciao,
Dscho

On Mon, 25 Feb 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, UNC paths are a very convenient way to share data, and
> alternates are all about sharing data.
>
> We fixed a bug where alternates specifying UNC paths were not handled
> properly, and it is high time that we add a regression test to ensure
> that this bug is not reintroduced.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t5580-clone-push-unc.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index 217adf3a63..b3c8a92450 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -62,4 +62,16 @@ test_expect_success MINGW 'remote nick cannot contain=
 backslashes' '
>  	test_i18ngrep ! "unable to access" err
>  '
>
> +test_expect_success 'unc alternates' '
> +	tree=3D"$(git rev-parse HEAD:)" &&
> +	mkdir test-unc-alternate &&
> +	(
> +		cd test-unc-alternate &&
> +		git init &&
> +		test_must_fail git show $tree &&
> +		echo "$UNCPATH/.git/objects" >.git/objects/info/alternates &&
> +		git show $tree
> +	)
> +'
> +
>  test_done
> --
> gitgitgadget
>
>
