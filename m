Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A8E20248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCMW5k (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:57:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:56151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfCMW5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:57:39 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7kwW-1gqxDP2Y5Y-00vMw8; Wed, 13
 Mar 2019 23:57:31 +0100
Date:   Wed, 13 Mar 2019 23:57:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] merge: tweak --rerere-autoupdate documentation
In-Reply-To: <20190313182756.8076-4-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903132357070.41@tvgsbejvaqbjf.bet>
References: <20190313182756.8076-1-phillip.wood123@gmail.com> <20190313182756.8076-4-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uOrqvRxjJJvlVrzB8KYNiBKpFsv1ibbcZr8aN4EC3Zjsosx3LZU
 HJRYAhAq6tgYHVhov5ygC262Ge9Vl3mrwPDqni+W4bm2NhKiMFaeYXjq6Xfu9V+rVnGmCqR
 3kxe/VxH2Z4lDBS86Uks8FrL3tO3hsNus6BMa50YfFM2jPJdHCN88FWwjuId7MP8B1BydQ5
 jDszUXw8OaEa4ZlMlPk4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yKbQweCS7VA=:dLDc5j9eTK43fyjTXqM1N7
 d2s3XRbmD2sWLsLcvEOVxLe7q5rvxEF2qQnPVOoG9w8ABnQsjbOW2ksnzNFBghuLbmSmE9ivI
 Wb+JJIiANKaMQbzbIoUyKcvhf7kezyMGEQI7CvwcWBDqUh9JQ9C7IpoOepYs4N0GPYR5A0Vod
 3DmgCZDSbVX2QNtaJGmiK71nv4p2mI52ccW8z2nYxttjO+Dsco+lGiRNPKXy3+mHJ4fUJh1M5
 n2znauajh3LgeOOMYPAqqJFEFTAbNzE2Nxj1vurXqBf3ok9L7R6H+NnTBYSk86lMmV7m4h1MH
 4EyeatpAy8+NCh1dgy8iuK/zN6NHqukD1M7QBXF4OMuz5bxJX9blnidvbpjWq0CyvGUvpc1W4
 l5t+qD3oB2w6mPgsuiCVosioAzerwx3QZU4Ifax+A3a7OQt5lE0EsrqSq6+etx2cnOcb3xtlL
 R+kB1Ls1w/Tl1iHPIHgvxXYdTMB2ket5ZVp0z+0yKiZ3P+cyE9RmUKs+IgyCsUefAMvbjyb7X
 OMiQMPAVtQ0CnHr2yHdp3+PbKTi5Q1UKFUZZPoDdPESl4xOLmFWXaG5YItd6ON3ltmivXc5zC
 TNdFvR7YakJrzIkV/AuXrrzxfoDBErE8edSbMwN98kPLX97RFFsqZyRbM85PJA82qK5tXVQld
 NYk5MaPY2YcV09rwJ2wD5MaghVjMRzGAdYU6LwbBWuRo4VkXBGE2duG48qCqsmD8LY8a2DA1s
 +K4FBydSpmhb+PRVf+xQIUMLthzIedkK91If2wVPj30EpRVsvtTxmaQdj/bYX1SLG8iF3OdTS
 tM5Msti2GRp40iT04wvDULPY6rubutDQpy7a5VNGZ3ku9+oexBA429K8+7eaKjmSrJwt8FeHK
 Hye72EEPvG2F3kTl9skTYJxxk0rCTr+auOamLPVmP+Z6XmI6cWm0pFozZfZQMoS103nXURbpG
 LkI6F90LfLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 13 Mar 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Spell out --no-rerere-autoupdate explictly to make searching
> easier. This matches the other --no options in the man page.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-merge.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 4cc86469f3..6294dbc09d 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -83,7 +83,8 @@ invocations. The automated message can include the branch description.
>  If `--log` is specified, a shortlog of the commits being merged
>  will be appended to the specified message.
>  
> ---[no-]rerere-autoupdate::
> +--rerere-autoupdate::
> +--no-rerere-autoupdate::
>  	Allow the rerere mechanism to update the index with the
>  	result of auto-conflict resolution if possible.

All four patches make sense to me.

Thanks,
Dscho
