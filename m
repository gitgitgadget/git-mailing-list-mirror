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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C80B1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 21:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfIKVWG (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 17:22:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:38677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfIKVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 17:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568236920;
        bh=1OXRLbK2x5rDykWhRJwDsLv45/pQVU3EFc8jurvwYG4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JcAcZUHsgjMIZU5QF8WNKPKw8ErQcM1xPUknWSaOzcqiAp/H9CwWzJAla2jedQHs6
         bpMsu4WvxWrwItxUDi+ok/NI5JokVzr6JiFFUaWpbt0ytesxpQtwdfw9q+5dPeLeaS
         CFQ78HEpAcfnCW76e1vqhgvCN8WQrLmPsLDrASro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln8Tl-1ibk732kKT-00hOU6; Wed, 11
 Sep 2019 23:22:00 +0200
Date:   Wed, 11 Sep 2019 23:21:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Cameron Steffen via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] doc: small formatting fix
In-Reply-To: <pull.330.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909112321270.5377@tvgsbejvaqbjf.bet>
References: <pull.330.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SRVKYeSVPTosOeg+Nm8RUPpRx7KTWrBkkGHrpvQWZp+HM2xrAsx
 U+Q+6sffQ+N1rYQsBMp+qMQFv03vNciv4xsAGxmh+vCj74jTMEN7rAiLOSNtqPk4oCUQr19
 kjTqcT8wkmDKiN2UTI09BS2nOTXd0QtL8SCT7ZzpjpjMFubNJ/rB4TfmsSbMfqq0IM0g5gU
 irMyHe7ZWWRkND4yai5Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lGYyjGyb5X0=:upwIwsgBRo9k14wies8p0C
 hv6D3BCTyWMzyY/iGTTEiRJUeP9Z0OP5mHClcafjr/NYAwE705c5NAcCbsB/PK3QlT9LMs56C
 juqmTn6lKs5kNM/aC3FL7Wkjrp1I3Su+YZY4CC67maXUZEvHrfu+OvXomyDnMWpP1RrbkamI0
 kcSEciSWY8sNmpxSi3jBKV8MJ9fFZ5S0MLwIU+sbCMs7g/2QScZgi4cRvSxGlz111miRuwNpN
 dtVWoK/9Hwncit/4SxTf6tlpNRwI1VHVaiBtr4NIQedmVSt1uExGu1/GL+/jDfpR8xLAfvCXs
 nyRwog0GxH2aU8C+ZA61P2fDkNr0HKMaCpW6pke9h961BBvYyiTHFnD7R70ehFDfRP2lbi8O1
 LvBUsFDmZEf4htANS502dozD5K005DsK/H0WdfN5UdrFfqA9g4OJSzc+8BbcHimxtfVxWgWfh
 C8EJBpy8H1I4CkwRblE6JLnQS4e5Zp5EvNJUlZYod9vT/to2XzmVtNaX6Epc3KzvyDYlco1JW
 YA6NX0zSOBH1iNZkF42F+Z8tgk7lXUd61G+yJM1ivhwxz/HmzArJ1CYxazwGFx75UBGKZ3FEi
 rRilP1txclh/bt/if16cB4fm3ugHNzfM8zJ5v+Q+2o4RXL6e8pBk2aQ9Jr2UHIFqhl7caKuqn
 TRC5edFymClYywRTr/0tLoPPzku9eTgiBFtthOZFMiBTOAy7ZNqvXVCKncp4g0PqKqiBs07vs
 VM3bnG0sajIlkGr0tIkd28T1yFH5n8gfIyDUcptvs/3bQjADo80PVguUHWPEWGKmyObDyO58o
 WL+zfxt4zGwot4knA0WqYf/dbACu1RtZhPvc/rSHufrtCuW3kHLbPzM5aFKf66mDaBHryFcM8
 QGLNcd+BP2fW78xxf8IRB9bhpRScS8KrTr3YFMy495mTB0SxIYzoLWWIFe38iWNd/Bbom7qSN
 23nlqzuJB3U7/mkdNyW4CyDjYKInWU7qQbg1OUU4rUs5lLBaBlUpN41FFr2sveL++Jv3TyjRd
 dTd8oe3CAe+VWA4AoalWs9o3m0Vzu0eWaazaci+FJhsffBAo8w0XNZ8A6vi3k12kVlhoU3x3q
 D22GffT589ezm9PM3swvT4XGDisdpmcqhS7CASkTRGJU957B9jOURqs0GuXJq2z/cvqAHDk5q
 C4vbWr0FQRhEuAHYHsuVQfiJ0EQlWnnMl9ftT9/by8cNU7wQ1uWJORh60l5HRaMrRlHRgUoTi
 9bRKwDaX3VKGrm64md4g3spHYT0TxouQdnTnM1gJCq3IaJVMDOK1MdFdwuU8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cameron,

On Mon, 9 Sep 2019, Cameron Steffen via GitGitGadget wrote:

> Edit: I need permission to submit please

You got that permission already ;-)

Ciao,
Johannes

>
> Cameron Steffen (1):
>   doc: small formatting fix
>
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-330%2F=
camsteffen%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-330/camst=
effen/patch-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/330
> --
> gitgitgadget
>
