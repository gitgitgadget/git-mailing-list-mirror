Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAE71F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 20:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfJJUtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 16:49:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:51885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfJJUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 16:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570740549;
        bh=wNKhL2rBg9rThOGMAmezJTJv7sYeXGygZDdparvOdak=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gZC9mzKV17TIutzgCbhtZFp9HtCqedJOQ9LQuLract2tAbkMmZE31Q0xHH+ELuKAB
         RBCCrwK9eRLJpdoxPtQ7/Yx55949tyyjNO8r16XuRw+szeJnzNmb3xlcLzVva5Djnq
         bNNlB5ZGvtT78vuCcu5xXPVRZYBzsPVNsrK/Vfh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1hzcwr423Z-00sRIy; Thu, 10
 Oct 2019 22:49:09 +0200
Date:   Thu, 10 Oct 2019 22:48:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tanay Abhra via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 1/1] t1308-config-set: fix a test that has a typo
In-Reply-To: <7b88e36723e3e6d51118d62211f487b497c532cc.1570710932.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910102247570.46@tvgsbejvaqbjf.bet>
References: <pull.387.git.gitgitgadget@gmail.com> <7b88e36723e3e6d51118d62211f487b497c532cc.1570710932.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1sizJiFRGyiw9vRtVsa8ZUmoxOJMBpvh/ml90b5jOuKnfHyCjHu
 EMjQWoRys/fp0hWzq1nEZVOohn/1/GlWvyeRBn1pYWT8wHbgyivKFREs9tU4jj2z3vDvbBo
 w+GRZAlvSWPG2wcfkqPx8eX6uBSgdW6zy+DM1SFbFD8QAB/S+Zs2H5eBiGz/MsQcymQWAxv
 t9MeyyX68AwkxFMrt3fmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RLhvAImgqd0=:D16OCQ9pFtifua8x8q2ilY
 7xMq1/3IV/1hagyi2ZnFkwmWNj7rtJI5LB4GihSLN+Fm4UlgJl2yKcAfFWRy7MfITDW/2fgaz
 dHJ/tylpdua073sDAceyai21atUuoERPUq3FV3LKyBJ/JvYYn2FL6F+thgco0H8fTrTmKok/K
 wKR+BSp3u6CXaoB+EbqgIdbeIl+5uMgLaIWkysdY7ldX5OuSiWwmAs4VmjqxwfTr1SKFISPQT
 SMr0m21k3TUo6Cz2MoQAr5BsnFwBnD0MVwA5G825p1JE2cdV0K7HsLgZ8Z/UTPMVQe0By7xYM
 uIM5QkQ8xvbc2zrEBubjb0V63iW94sI40XHG3cBih1KYr7yF5DPdMxlVLTdO1QxiByEAZpKSv
 QUJwQNxFISu3iKdhOY6DTEuKO2Xt8+v8Sih5lQ8p/9vkMZapCNhY65l8vmCeFStbk7UF+Ns9j
 0ktoYDlWmC6MW2tJbShCtv7D1Uu9wsT5Hzrjaf3ZnOoHf/b7b4OTJvMyVPlxJt/F6EWB7z1Fo
 wFRXqS1XBER3W/Qq32uDIuowX8UI4Z4v0jQZlAsJMt4Hoi1GBYMDcdMFAbNBs1dp70rkC4rFF
 2J1m67qc1c6QDTFCg1VdwQ3rsqHbd+G7c9PbkctS8M2c6LKIORQAcmrT9VmoatkBme18YJMn8
 dPk9CIrpkf8ODJWU9HjgVHor3nfYYMszrPcdcG5RFromYteoMAfmAih4q4KYA5EvlkJ1jhqey
 Uzn1YRSYwvZbpOIgEV9Y1O2NTsg2ci7qv7zleTBRiqkYNj7OyZZwWuzKLp/f+qMBG6y6FhedN
 NaaMPdcGsGtoPVgqsauXZQqGzrsg1YIC6RVFR9zl8dENjypDS6hRXL0k8Ey6iUq9exDBeR4tx
 37OYyk0atl0hnT/dtija9+2cxiujK2hd/wkNcpdacplz8FWN7WfBBVpZlmJ2nCDf3M0Nb1KQR
 uNz82t96fT1emaWtFH/TGbFGnrUPJEePYXnwkPKn5eu1qNmjjpreP9bvCDhPH2xHxRdT2R8d3
 T6tvzQ5SR9UODMx2QUxV7zF+2QNcuzuta9CSI+hvJgOktikeHphfuFrmfWKhGgCh3xbBfMERH
 NKCceTRUcK6leQEzyaj5+5DtfmumoSC0svoxpG0VAbs9oZvLvlO5Rh2As8hk79oLVaVVaS9s2
 AMoPOE12h8TYQJcEDZcYIWl4O6DJln9WyWf+xFs2erFwie++VD+RDVWOKicbD/3kLQWWxhSeL
 1aZxCvYrbtElDIFLqXkmTjviwKqSIvY8cxewNAHk/ser/gOTYZ7EoyEfhAuo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Thu, 10 Oct 2019, Tanay Abhra via GitGitGadget wrote:

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index d0a2727b85..7b4e1a63eb 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -166,14 +166,14 @@ test_expect_success 'find value with highest prior=
ity from a configset' '
>  '
>
>  test_expect_success 'find value_list for a key from a configset' '
> -	cat >except <<-\EOF &&
> +	cat >expect <<-\EOF &&

I should note that I looked through all of the hits of `git grep -w
except -- t/` and did not find any other typo.

Thanks,
Johannes

> +	lama
> +	ball
>  	sam
>  	bat
>  	hask
> -	lama
> -	ball
>  	EOF
> -	test-tool config configset_get_value case.baz config2 .git/config >act=
ual &&
> +	test-tool config configset_get_value_multi case.baz config2 .git/confi=
g >actual &&
>  	test_cmp expect actual
>  '
>
> --
> gitgitgadget
>
