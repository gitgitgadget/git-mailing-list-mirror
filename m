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
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4BD1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 10:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfFXKw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 06:52:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:59401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfFXKw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 06:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561373548;
        bh=FVNUSCd3agdd8aaPVLtd6MYBOwmh/oHWx+N0kPKqOuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SRQ5fUHEqaLIhoe4UYKek329dYTc7hktM99AZg8H/TtomDmFhLDSZHXs6greqZet6
         gjo9qv9CXGEyTxxUA+rMoGvm9V/WEGlhj45LRfz3RZaLar/tmFdPoU6g55mNt1xZ/T
         aZU7N6tCpxUB2jJUtBFeE/W4ZsC5aycXPBmTvRDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1iBy3A3dw7-00fh03; Mon, 24
 Jun 2019 12:52:27 +0200
Date:   Mon, 24 Jun 2019 12:52:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rm: add --intent-to-add, to be used with --cached
In-Reply-To: <20190622122417.28178-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906241251040.44@tvgsbejvaqbjf.bet>
References: <20190622122417.28178-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-868592721-1561373568=:44"
X-Provags-ID: V03:K1:fktkGnByHAxFLGVEqobeV1Zh6+C7yqpZwQPKG6X0PF7EDoK6lDK
 /HmohLcGtRQ1HE12jA5DUTS2nKC3MT+RCCuDoHifhu6v6qHxplm16E/TuQBMHutsnsfDrER
 Y2KrwQa9cZeBH064T7wP/9bBOWpPjf77n51f636DR0LO5+xvsVA+aFJrfrMN5BhlqOy2I6y
 TtZdRlUvdTGeiewPqjnoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:APr7BQTfVbA=:HfYHm/wdtdWB2FCRoEcDF6
 LQ9Ou+Vzo3I4Nq1UFBR/9kyXY17H0iGJY6GAoRJnhSLPewdgt4SZqGi7tzRp8upDqW41xytrZ
 TfzsRXaaK5MrcbtHMLCR2wp6+kkX4K25FR94Wdv5k45ynEpXwJlPi9p4xoiECxUYHfSV92KDq
 D00y6WVChbfmy+QE8rXI2wrFvflucJEqzDE5NZr6Yxd6hXB9NjmSY0rn09qjcqUblrJYvu9aP
 O9FKlLpRy8kw2+wvpbADoc0foiaam1/ZPl72M+ksUKkF5omo9lrTWte5D8ZFEOQ+jkL5z26/e
 7PAUGHmR4nCEWozrkcoxQGntdV0XHOJwdxz4mPVDT0oBK6fJheWudPrds+0QXCc00tDEiGQrg
 N5fvdBnAeFxPL+UbG6LrhseUgopbU6Ufvhr4TnvUWWsmj6n7p88BxH4wpkmhZStjKhz7aq0lu
 TgSWeT+CBiwUTodyqgid7qw0++yhbaHZmRM4Q4kuzdwLGaDF5TSf5dS7FUZwM44GCv7KW79uL
 HmL8AcoJKzp5yw0H81M+ihmhgTLKnZ3b2RlBxuAT6kUDONHueVQMBHtp0SSL84gF/EXtIHE27
 kiMIVXLL/6ti0ToTK2m1LIKnOupd47gBfBmADjzQ7BEH/StNLXCpn29/6kT3kfZFxA/Wucde9
 getlURTYhsieXXLU2lpc1Odm7/qEo8AVQIto/W1omERDt57hiHOWU7D6v7p2LJ4+vGCPthKSo
 RLIAeRQ2i76oUnwPabi332UhhCRrzF9GyCxrWBxu2453ePjfafoZES3q87+wVSMz1WC24mzqO
 FihqfrXQl8eUmmxewTsVWFLgAqsbLe78QCbc0Zi/4n6Sx2/Bf4/r+1M8g6uAmphpL1p6Rl3vm
 bJRO5jGXrIgqk/SOIdztBSq3Uo+2E805vi2iAhmYL2icf9bBpQdtPnlp4IlNpmmiVSn7jeoG6
 D9zW/68TtQYDmik/yu/qh4kmXKzxRG1BLaySN1YAWfE0W4OafneLC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-868592721-1561373568=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sat, 22 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> An index entry serves two purposes: to keep the content to be committed,
> and to mark that the same path on worktree is tracked. When
>
>     git rm --cached foo
>
> is called and there is "foo" in worktree, its status is changed from
> tracked to untracked. Which I think is not intended, at least from the
> user perspective because we almost always tell people "Git is about the
> content" (*).

I can buy that rationale. However, I do not think that "remove intent to
add" (which is how I read `git rm --intent-to-add`) is a particularly good
way to express this. I could see `--keep-intent-to-add` as a better
alternative, though.

Ciao,
Johannes

--8323328-868592721-1561373568=:44--
