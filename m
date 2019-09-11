Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6F71F463
	for <e@80x24.org>; Wed, 11 Sep 2019 21:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfIKVYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 17:24:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:48739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfIKVYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 17:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568237086;
        bh=f0+QluOBrsiCIXel24G2pRxkEyV9G/+67L/tofZhfX0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ga7yegqY8Q3hx0bEEln7O/SkltZUnYPNW7LZ2UQ3ubZ9S1rkhOd3EO/3NU3L3TycJ
         kmoBpbVDZ3CYE6ZHu2iItNqi4uESIPgr+M32hdjUadzYu8F7BydyHrGsn+AAOVPqhM
         /d1JoBNdeuG8wTvQNaURKgsNI8BBwYBpoPRsmu54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1iFtvW1u4S-0137a9; Wed, 11
 Sep 2019 23:24:46 +0200
Date:   Wed, 11 Sep 2019 23:24:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Cameron Steffen via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Cameron Steffen <cam.steffen94@gmail.com>
Subject: Re: [PATCH 1/1] doc: small formatting fix
In-Reply-To: <5248e3332c90e91c1c6a911090d331f005789014.1568071262.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909112322220.5377@tvgsbejvaqbjf.bet>
References: <pull.330.git.gitgitgadget@gmail.com> <5248e3332c90e91c1c6a911090d331f005789014.1568071262.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mEBmNXacNcVyt3D/SBgpk8A9lj99tx2PG/u8ki+WupuPj1JWBHd
 y32gr+l7jXyaFq12foiHTzJlcPEP3eOdT4mtymzBb9DD0j3xwiHmNUysNwsk666ZNvocn+t
 vz7WLQSdzlzd/cV2pxe8LimDxmxQKCOKBz9ATcgDGg7G4eKNHfRScn07s8SG6xmleszqsYn
 uf2HuolBL3nZL4dJI6etg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ncty1374BrU=:qPKq8GRJ77kILiyCDJ3g1k
 w9D8BvfzsaVFkwCFPlAwldwz1ljmuMPbVaQm2JlL6/M6CE11rKI60sN64/pyRW7YZkltU3Lov
 6czLiwzWwaG2ub/vWUyq7iUB1KfdIxjUf8QeGCh62zwfYmfndoCSrby+6Ug5JmAIC47L7Wz6w
 nqQjdPLLg3eukBrYS6fX1ttLhGYsYyn9ylSkJcdfEKBdnSa7lHw/CDsF+lcbY6MM81he8FQZp
 Wy5UV6RCcUVT9Uapon2IP5BQ1Jf3A2zjwXeL9ZdMPO0iWyIGy0d+l6CkN8GX6KW5vYDV3GePx
 cV6x2knjY31czAQsri3aFoY7Aj05NxHwaVOY9fVBtT9ehON2Z4S3SnoUp1z/bSjHNKPvSQUsu
 xui0/Gs83eCqmNw6jsBUmHnBVHOHvvR6eD3SjKRxJ1PMaTEnlZ2zpDlRw3wX2xrdFuj3f9ctQ
 cWAA7XTXBAx/9585ZAaboP93riex+F4FT4rqCb+z339piZrdOT6/omlXgBN6uAt8ZoJQ3MQGH
 NzSjPOVfRgPkqXVHtvnwt1FW7457ab3ZUtEyspo3YDQBLclRVhxxcRN9qenZw+VfvL5i9CPw0
 EQc4+YoBpE6wt0gZvvwt5n4q51mwR+BEFrZ9EVDUStVK8wBbFEiU+Yx6uo1ojgWv7h9cZOMBp
 TajFFyPViM4JjRDbjntaRY52RaGX95iUw/V3oI0un/Vu19tcNTyY9zHtRPo2/AenRQsIqDG1k
 ylW5SGCONbpclRlABuZn6boU3qoJCwNtpbc4qpUp3wHr3b/ZO9YENr4gDHByCMXNWgpwORb08
 MVxCoIkzD8gCW73Dq0bDtqbiUqw990rRCwy4YcDr1BOUsv7QGFuDq6PPxeiKtP89zdv4dCMTB
 12YI4TxsfmfaaqnCYcDA4cCx+NtMHaBm81df5T8ZoPnpYLL1/NgEH7nQmg0n+YDlHgLLrVbbC
 wnUs9XFGao1SkufF6+ykUw/upTTMiRya7ghDfnY5i1J02LS7NfbX3RwRa6RJumCKmeL3VZNb6
 oYWgBP153v4c1+AfAyW9t+FNUMtLrIrbDmQj26LOtHQ6Cxd2rvJegidL3WmPfQClbVih+GHCL
 RMNlbff7r78zYG9fJJ8wIlRDMiHyFZu3WE9iWxNIsjl2eMfgUfWnys+DVhL5CVnARYUGj+6Vy
 Uf4sqzG0qsgPIZTv85SNHf9idxyiQLBs4KbrjsKx3DTRSLABnvJTtQzsIZkao76CvkemtNP0U
 5kmmzBJzWwclH16kB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cameron,

On Mon, 9 Sep 2019, Cameron Steffen via GitGitGadget wrote:

> From: Cameron Steffen <cam.steffen94@gmail.com>
>
> move an incorrectly placed backtick

This sentence is incomplete, and does not really explain _why_ the
backtick needs to be moved. Something like this would be much clearer:

	Most likely by mistake, the closing curly brace was added
	_after_ the backtick instead of _before_ it. This breaks the
	formatting. Let's fix that.

The patch looks good, though.

To send another iteration of this patch, amend your commit locally,
force-push, and issue another `/submit`.

Ciao,
Johannes

>
> Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-for=
mats.txt
> index 079598307a..b87e2e83e6 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -208,7 +208,7 @@ endif::git-rev-list[]
>  '%GP':: show the fingerprint of the primary key whose subkey was used
>  	to sign a signed commit
>  '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
> -	minutes ago`}; the format follows the rules described for the
> +	minutes ago}`; the format follows the rules described for the
>  	`-g` option. The portion before the `@` is the refname as
>  	given on the command line (so `git log -g refs/heads/master`
>  	would yield `refs/heads/master@{0}`).
> --
> gitgitgadget
>
