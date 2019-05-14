Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDE41F461
	for <e@80x24.org>; Tue, 14 May 2019 13:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfENNov (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:44:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:35483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfENNov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557841486;
        bh=6MUgi+bOcRBvsEFQqYhmmXrSHPnuCrGxKV0wGb/GM/8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B8tPg4h5wPibtcQznO8zKwVMhHFFlHyjChfzij3RGrKVc7laT0dpqjfUSQeDt2qcA
         nDDW8tVFSZUkR464uC/eiHMof9Qi+thnJLLcC67NxM5jCWNDSPmgxmEbBGDR9g6uEj
         5QhwNSWeE7rDkfgqDOjYAlcOdfmbtsqtFeGARraI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCwbX-1hZ6K50ESZ-009l2p; Tue, 14
 May 2019 15:44:46 +0200
Date:   Tue, 14 May 2019 15:44:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] merge: add --quit
In-Reply-To: <20190514091322.12427-3-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905141540300.44@tvgsbejvaqbjf.bet>
References: <20190509101028.24656-1-pclouds@gmail.com> <20190514091322.12427-1-pclouds@gmail.com> <20190514091322.12427-3-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-111578576-1557841486=:44"
X-Provags-ID: V03:K1:Jqsty75zmxdS+aN2WWX670bF0stBTd7uBIBrr4tY8ZqUCTW2VPz
 DCq9TCNNXlGwpAsA8pPWbyx0joM5bKlurjwkVthqGIpxr7cOcXBM8ruWug0Y18zpZSG8jHJ
 ET+ihwnW59nsMfh+UlOtrwHLrOt13Q6Pa8hldoyGibKHozkVd4WXlE3Rg0yIyYo2gzmtzwc
 17iWC7F0vuQAz4G5NfSEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kIQWHVjUVVs=:cBsYmZh10BMHIDXoVCu47v
 7HxrOidwosw9G/AZv3bK0RPwuJK0NcjMqkprWc8XwsZ/U0il7uKu6FINcmND5Va0IkZ6BQDZb
 cj+UHwCes4cu2jL3NDxZhS+0YZHVdE2gCnbCJRoHtMSS9qA7/frOql+NnhAH4spuAnWB12Y9g
 HWb+EJtEcu52tcKl47hgdxqpz/hGIYpvWUdU9Ip25V1F3MBj1BjulZD57wFuDQBTT+YgrYlIM
 qczGe3lpfX5D/4z19xoFGFyoasmUm7nSV7D/obG+eAqL4s5PmBJgvEPuZYrqtsOHTQQUdax8f
 Tc+DCbbFdaL/czrwHDC5dQtiiUHpefd2SsQsBxj9DpC1WywsMGwmyn4ZwU/cnWXZzk0RycYrW
 FSPQ3joOepuXxIf5T6GmUBD6ag3/UeSyM6Lr6wZHJI3SRUokHrIhZR8EPNcqO6RJg2/qVdd1Z
 c4Ftl+frbMHH6yFAPjHThM0PZwXYjdFRs7TL4XiqimUSWQjaXQeyHk3rA8HpVG73rsAF4NQgN
 Uu7E62mh5Fkt/1C7rTo1GrIh+/KiS0DQR5lylshGMt7gmDRoc2ayTwm3BeZZBbfKe4i0o6Y6I
 jqLLT3tqK8V+wmfIY1QejzkpFtHVGHloz7MKtFdo4L/3RA+HXWuz0wSbwBxQUqsIWf6zCKtdt
 zbtQeTFc7xqZRhW5UmqnrB4VR+nNE2DpGE1YvdpKiQd22t85cl9KypIiZCJZ3583RyaX9iujn
 gJYPmXzv38ObUYiYj8Q2uAcWJh9FWz0yc4gSKQ8zUvGPLU3783fkVGV95GwEnu22MB4qr75vM
 ojoh9oWbH0ZN9gwmXJt13b2wgeBuggijgcKa5/m6kmCqg64Lmg+eF50fYr7qbQRSSRy4Y4kKt
 PTHqW7b+3wXDt/JEABS0cEq0obO5JDPq8WDhbKRTo86525LlzWSLk/RChj2xKvN50tVSoOJri
 Xoy2BZEKvRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-111578576-1557841486=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Tue, 14 May 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 106148254d..d453710ef6 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -822,4 +822,18 @@ test_expect_success EXECKEEPSPID 'killed merge can =
be completed with --continue'
>  	verify_parents $c0 $c1
>  '
>
> +test_expect_success 'merge --quit' '
> +	git reset --hard c2 &&
> +	test_must_fail git -c rerere.enabled=3Dtrue merge master &&

This makes me really worried. It is the same `master` (i.e. *not* a tag)
that broke this test case in the previous round.

> +	test_path_is_file .git/MERGE_HEAD &&
> +	test_path_is_file .git/MERGE_MODE &&
> +	test_path_is_file .git/MERGE_MSG &&
> +	test_path_is_file .git/MERGE_RR &&

Isn't this a clear implementation details of `git rerere` that you just
taught `git merge`'s regression test?

That's *prone* to become a test failure without a bug.

It would probably make a ton more sense to look at the output of `git
rerere status` instead.

Ciao,
Johannes

> +	git merge --quit &&
> +	test_path_is_missing .git/MERGE_HEAD &&
> +	test_path_is_missing .git/MERGE_MODE &&
> +	test_path_is_missing .git/MERGE_MSG &&
> +	test_path_is_missing .git/MERGE_RR
> +'
> +
>  test_done
> --
> 2.21.0.1141.gd54ac2cb17
>
>

--8323328-111578576-1557841486=:44--
