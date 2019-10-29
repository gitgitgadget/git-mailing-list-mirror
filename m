Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D441F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfJ2NLj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:11:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:56765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbfJ2NLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572354697;
        bh=Dq+bSWngUE93q5AnS/eVyajQKxXein46dE+V7A+0rdU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FfwS6qeLohgEwE69Thhng5TEt48fpyfcwjYatBeJaxh6pZn4f/La7zsrRtLbeAmvs
         pE2TwmnIofYTpWwJDcSEmElm2/pKvvBgGnADh2YC8WfGSp/25kFnkyMqq5sAtxsrr3
         zN7HNVlzjCvAjVDEU2/TVi1RTVmI+ooJCLCFbYg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1icgqf2hmK-00M2Ui; Tue, 29
 Oct 2019 14:11:37 +0100
Date:   Tue, 29 Oct 2019 14:11:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Davide Berardi <berardi.dav@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
In-Reply-To: <20191029092735.GA84120@carpenter.lan>
Message-ID: <nycvar.QRO.7.76.6.1910291408460.46@tvgsbejvaqbjf.bet>
References: <20191029092735.GA84120@carpenter.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D5gDJ68Q0DdUEkOxHSOvMumiMD1IoB8TvvlAl03QQBp9GqxKtTT
 NBuzsHrI6pP2143scJke6xOClG8UUJl1VL48xCdBz5R6/npXgDVpLOBy/AnW7o2lhHokyDK
 N3a736ZcsJTjcxzpYxqQMTx45Iz9NC2CYf5RLb3hkFdi+RYIizg1y6wANWBd+2EfiJdqxrt
 lkDZWpE3R0ft+r7DesPcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sli11RgBuEE=:+PP/pZKlCE97eW/VYYrnQY
 wcIAy8Y+55cxIEKDp44HxuN/YkgcC7267lF/oYIAPYARKwrxVCtqXVlEYlN6+VPwljv8tWDyS
 mpCjYAdFQQY91PelDwFGWoNncl75ESAZ9Tylc7+iTh64ntrACvI9cwGGlHxkmh4B1bgy9IvyN
 BfeBn+g0EnXeiYrtmb57Zdo82JeDdpMaKQCdcQbeKcWu38VbVMO6POl8ZMZZ4C4o050UAF5MZ
 /w3UBW0X7B3dB9oq18FSSjI/CkZQtA2EZzaCQTazDYIVOBDgEYoYMX1v8wAS2xIdI6/DGn4nK
 nHOMSFDfX7bvsykgKerNBpDq6mj9+O8NacDFwGZDFgOwIu7/CtXxrCj7TSA5674oezZtIkEeP
 g4b+WXAhLS42MVq0HI/oatv3+wgl3DAwvlRG3eiqSP0qfkZqgXOcb9G7nTzeiRNp64+tx8Kcu
 tYNET2wYwUVtauRKVveRWeoZ5jlcTbtnBBXZDN3jLoWU5+7WBMCMz+HYul2qO5ndHe/OvLZ0R
 HYRhTh0mWZkoA1qqdLvXdQpTykYnDx0hRvp4Zfy+kE/Zj/JEtUM6GWAUjdVYc6S84/ZIjuYFu
 5REwIkvIAXnKL342cb+cowgsn/grBz+tBH6xOUD62LhCpeY/Xn4D+atXjbKvaTKHZR/efHLQU
 Pp+J+kiquxuKWeCC86uEZmDXgAERpLTJcTeoTw9ajU5jZKtmfxRVjcGKnp+827UlpPLfyF2jL
 lhluALyDuOEbZ4+4ueqL5yq4/KIgwUBYIScpd3xDGEzVdKwlks2KXMjyz/JejU2yOtir4wSwb
 H7t1OtKDXh66fXG5BlkEEqSGsx2ggITjEK/uuFnAbzl9QG74eoYqIjqygB1+rOHkxZeJbk6cO
 p3ori4/RPgTzJ2nJitxQOa4sMPkAEH2EnIwITX4m/noQKUDtllWvEwqHyu8/QJdewx2NdHl/w
 LrNZtGcpYEpiSNn3yqeN2usqka+yMempxgB5I3eyQ4IS7EgGYPDpuCIEbMX4kl0U0Mhg2b2Xr
 x9SUGDula0kaU+IzAqhQ0v6wbTD/zycTpNI4BU7IR+yL+ob2GtdvrFukLzfHxmyVLamkwssap
 P0iwjEVpswXjqXoUbjJTGDVYHt2dqep8boXk6apRS6d+iXAzSNFLJXgxFXE7M7Gx89Px7iHGH
 JMmIcLN14bXnzwyz1wr1y0SvhBuAp1zAiC03F4gFHiW8Q5QDWcITZ2EqxFsyQKichLarEDWq1
 ra6Wf5zpAYjsJJ4EciIeeQ2oNzZ8oahJBfkU1sgpZQINGV+bFp51iGKhNQk4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Davide,

[please remove the trailing period character in the commit subject]

On Tue, 29 Oct 2019, Davide Berardi wrote:

> Fixed segmentation fault that can be triggered using
> $ git clone --branch $object $repository
> with object pointing to a non-commit (e.g. a blob).
>
> Signed-off-by: Davide Berardi <berardi.dav@gmail.com>
> ---
> builtin/clone.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f665b28ccc..6ad2d8fe77 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -720,6 +720,9 @@ static void update_head(const struct ref *our, const
> struct ref *remote,
> 	} else if (our) {
> 		struct commit *c =3D lookup_commit_reference(the_repository,
> 							   &our->old_oid);
> +		/* Check if --branch specifies a non-commit. */
> +		if (c =3D=3D NULL)
> +			die(_("unable to update HEAD (cannot find commit)"));

Could the error message maybe repeat whatever the user specified for
`$object`? That would probably be more helpful. Maybe even say "not a
commit"?

Ciao,
Johannes

> 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
> 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
> 			   UPDATE_REFS_DIE_ON_ERR);
> --
> 2.23.0
>
>
>
