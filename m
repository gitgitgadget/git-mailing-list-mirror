Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C1C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 13:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiKRNZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRNY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 08:24:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2384319
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668777893; bh=5WbVUhXu6s6n1oBy+636y0CIVPB82SG6Dh3VPpp5HZY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Essb3AYp6nCO09fRtg0H4p/7gpQz5kbM5N9B4hxZ2hhopTgMlSgrm/l7BR+SR8MzD
         ka+XqWmiQRueLr73jn/3AHKK3Iul7SV+gbj9Hw+yAaUW8bY0Fo59tTHITnsQMXqk6q
         ewuspUFPiMTPd+S+0wk4Q1vHZno+N8Fw5jA+Z1kDMHnvqgYCdBpqJp1aJbTaK2FlTE
         XRA1fUKYJye0AodcQYEhSxboDIdhKnRFRDqyjAgV0JcxKLsHvgTAKceqfap+3gnrwW
         9FCV/W8Ytmj8U2j9ZkU0Dio00tfjfei83kyAc5b9GZ1U/LeWcnQM9GmbYTdnLf7T8y
         uAyC0Qctg27GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1pFU1V45ij-00tWO6; Fri, 18
 Nov 2022 14:24:53 +0100
Date:   Fri, 18 Nov 2022 14:24:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
cc:     Taylor Blau <me@ttaylorr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: ms/sendemail-validate-headers, was Re: What's cooking in git.git
 (Nov 2022, #03; Mon, 14)
In-Reply-To: <874juzglx8.fsf@amd.com>
Message-ID: <40q20nq9-4qsq-8130-3783-8o97o06824qq@tzk.qr>
References: <Y3Mag8qG2D3qjlmg@nand.local> <4p90qnq3-580o-9n59-34n0-rs3pp635908o@tzk.qr> <Y3Q69UlrmyCXLCsY@nand.local> <874juzglx8.fsf@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1432515424-1668777893=:189"
X-Provags-ID: V03:K1:ezgUlKh25g5RMVaJN4TVSLCwDv18bXo1C2MBFFksPWVA06frwmo
 Guu97PP0SJKD4x0GhJz4NEbRmV3l0fNoh5e5g0N+j+r48Q9DmYiWTEMhR+SUYvrynFpGwva
 G4JD/IVLyg03jb+Hq5OjyQSjhYoqDGXCjWyolVvifCpWEZnnBlcJuyVtbG1swxAB/zcglzK
 4R/wuf+mXZN5C9B8n/oFg==
UI-OutboundReport: notjunk:1;M01:P0:bCgeuokcXiU=;NMYQsqJKDMvzy/UAkP3oZFFN52x
 c8o1zFVFTSFwuWLa/MVuBUgfr9uJGakknelK8/ZcAJkq7tUjLXtOIDs6o7vHp24ixvnARTVM9
 e+5vGcdPrXf6xbX8MTyqO8vTPa+Alx8la/aje1oVK3iyFp8OEtYSpw7gDGJ42/Fnthhq23tjX
 WHSri+Ro3qkqBM8WaNxT044nt/+6ljfjYsMt0p18nzsQDCuaMiM5+zicIJQUKxHF74CU3rDNe
 g2/y+TWpzK8E7tnHdlu1GhYwRNmxfESeMy7qxqRJP87/a4iha3FNREw37P7yJbk2PX91aWIZo
 /v8KcE4n0/xea6z68M8nOasK9Xc8npUZxeYpM9kKs1G+qb7B6e04iQLzyhQ6Xw7nEoIGD2TSe
 dnE4atOEPY3Q8UEWeJeTkI8Sj27SO5JIHyHwDb0foyaIUcw13exBuSDD/ZcpqAnUaTj2smPvT
 xl++u8oufoAwknGChryPKKQgrMTvBKYD7ZAynGttH6TBoAM3gvaC4q6XDObiQ2Kev5kjwFyZf
 buXlPA6snFnIAyU/VVnaqhP1ujmvuPdgBUqutDGb28dJy72srcWigNqJ6VGO5KB1PMkiujJ0m
 tiMJGdfBapXBHAmoAm0+vFkUMAxRgjeXXPtyfzlPm48XCNGLUVzHm3RIITQ9xLh/cv6v4DBvt
 fybEefgFpqmLWYnuzaMW6nODgE9KVMKnVtlVOc7NaSQ2gkUUrOro/uRlcASsIUlXzR/KufcAf
 p2H9Vbbz48bhPzWV5PRkeQlHG3yA9ecfA1aFfsKZKSUR3dyT7QbbOsTw4pQzWFURJt2/OwI75
 9yN/v+DD3OEhHLdq4oMNTeU/w5qHCgnsLaAhwiN0kzcT91O1ydDCDjThBdooYMUB575qpHGGq
 Zvw0E0MHAH2E4MaLPdMX4QTf4SkeoPRBTzHC5TgMXrCd7uT5Ume8ZZiAPiDCUwBjgCfFLxP8O
 jYAyLqZUccl3jO8QzkBYaXXNC4c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1432515424-1668777893=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 16 Nov 2022, Strawbridge, Michael wrote:

> For ms/sendemail-validate-headers (2022-11-11) 1 commit:
>
> My apologies.  I think not having the patches chained in the same email
> is causing confusion.

Please do not apologize for something that is not at all your fault. It is
an unstructured mailing list, after all.

> I did have some review on these emails:
>
> v0 - https://public-inbox.org/git/20221109182254.71967-1-michael.strawbr=
idge@amd.com/T/#u
>   + replies: Brian M Carlson, Taylor Blau
> v1 - https://public-inbox.org/git/20221111021502.449662-1-michael.strawb=
ridge@amd.com/T/#t
>   + replies: Luben Tuikov, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> v2 - https://public-inbox.org/git/20221111193042.641898-1-michael.strawb=
ridge@amd.com/T/#t
> v3 - https://public-inbox.org/git/20221111194223.644845-1-michael.strawb=
ridge@amd.com/T/#t
>   + replies: Johannes Schindelin
>
> I'm currently in the process of trying to run the T9001 tests.  I am
> getting: error: test_bool_env requires bool values both for
> $GIT_TEST_PASSING_SANITIZE_LEAK and for the default fallback.  I do
> wonder if the change in validation location (as Brian mentioned) is
> changing output (even though the new location is needed to have all
> information for headers).  I'll keep looking into it.

Thank you!
Dscho

--8323328-1432515424-1668777893=:189--
