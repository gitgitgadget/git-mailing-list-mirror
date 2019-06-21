Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B670E1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfFUSD4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 14:03:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:50133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 14:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561140231;
        bh=ibIFrUmUU/1Auex0BCEtahCimY4yW5W3JwmCyYv5iAY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GiEUgM0Fbh3wiPTgpXYr9hPz5Rmm69vupILnqndktGu0BY+LVBZCfa/BdYF7sfhkg
         ymIDDHn29PQK1mqeXBy1kTHSovrLXHWVxwVQpl2YvY8cXWYA48Jj6WmfZlVcWbBi+e
         B25x9bKwTM8G86vLoUU3bbODbUUwUtxme738Ck7U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5q45-1iXHvq0DuL-00xuVk; Fri, 21
 Jun 2019 20:03:51 +0200
Date:   Fri, 21 Jun 2019 20:04:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] tests: mark two failing tests under FAIL_PREREQS
In-Reply-To: <20190620204227.8947-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906212000580.44@tvgsbejvaqbjf.bet>
References: <20190513183242.10600-1-avarab@gmail.com> <20190620204227.8947-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1574376282-1561140248=:44"
X-Provags-ID: V03:K1:bw6bcpJck9eQgBYKW60DR7gf7vwh1eSlJA/kHY1a2L0T9Wq/+ET
 RLKb24GPLXIaJR3OT0qTKbhFuZ59z3c0ZftQaOWtoUh2pVuVrL3Wmlfpzf/noKzmcm917GD
 x9+xte35pvofbHs1L4thfKt08dqegImRRzcZHbLNR2RAI92vsaddwslbduHO7Iacu1U30Hr
 bcwstzYD6VuYFkeqvqLYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g4BN5A0j9AM=:vQCBq1KJPa/hEfngW60lbN
 +xGL6VHCfaceyIFuBhwXTfU7DraOXO1pyQ13AIsaKAe0Rgj6RZYuOGhv22N7yKRAxqiv+0Lil
 ZoMzI/KyL24a+493Pm1P9xFblUfduqFl832NrN0JLc5XYYdemakAb7s/eccTCp/Ie7lKEhgOE
 YthAMTNooqJk/Tw8VV3V7TMsx/0q9iJXIa1V1GT/U2vc2NrkzBduz16WcSR5EFmHfkROeVOip
 0YAFFeAMFPeXtQF+bjpxIczQLp6Nz/nbxxg4of5B+bY6nohLHkPFqisOBnSW2wtEe2SFiMEYG
 Nj6E84XjJVNfZegUd8Jgrns6s+W+78Qy3Bx8gFgrAwFksF+TALrgMMP1dVEEONsEIFwTpqoJa
 pgtZ1rxv/Y5zPjYMxduF3NHsLU4tqpJtEphkGv/0PMt5FHQkm5UFcpvrkluBueZepoQnNXXRG
 A2RM2WoVe/HWwWGDvFN66FnPGtUt3t8gspxd0g3ahsiK5FdTDs+lBPFSQqfOS4mv/04Ji+1R+
 j54IdBHsfw+7wDJ/8FV1eLCHSaWt5ZQOFSwQmCuM+yVQ2CK9CL2OLaL8tYVeAtHss9mnJYQJd
 IIPCKPAE9P0ri2NRnlS5sgNQ0/KLW0v1elvZs9wOU+ui44WqHdoY0R0fhS3hhLDr8A3hx3uca
 SzRO9SXTsibLLi8x/xOEOrdQv+m7TIT80388sZHahH9bVJX0Ro3B0LU0cK2GZLLkUxyGquelc
 Bf6W/d3JXeHpUxVJmof9ZT8ZUWPETu05P5Z14YrMerAzRzTGKxvlWf1KteJdGMVIQYTMTcTrl
 /m6eCRnFw93Hg8R3wNTDS85dLjyxcl5+b8Ac3uJecuKVjRUUUhChQTNZORInUqZadVK4DpVw/
 8ebj+kg2B9yE5HnzSmtx7NEdNH2GbNrp0nSePibSnBvOs1UDnViqNMHunUnK+SVvtQ6lrQKgl
 PoqSjSpAbYqFAspq4buO43CWHe1kbziUWDjhq0I8V3rejFRtjlIPo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1574376282-1561140248=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 20 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Fix a couple of tests that would potentially fail under
> GIT_TEST_FAIL_PREREQS=3Dtrue.
>
> I missed these when annotating other tests in dfe1a17df9 ("tests: add
> a special setup where prerequisites fail", 2019-05-13) because on my
> system I can only reproduce this failure when I run the tests as
> "root", since the tests happen to depend on whether we can fall back
> on GECOS info or not. I.e. they'd usually fail to look up the ident
> info anyway, but not always.

I had to read the commit message (in particular the oneline) a couple of
times, and I have to admit that I wish it was a bit clearer...

=46rom the explanation, I would have assumed that those two test cases fai=
l
often, anyway, so they shouldn't care whether `FAIL_PREREQS` is in effect.

The only reason why they should be exempt from the `FAIL_PREREQS` mode
that I can think of is that later test cases would depend on them, but how
can they? Those test cases would also have to have the `AUTOIDENT` prereq,
and they would be skipped under `FAIL_PREREQS`, too, no?

In other words, I struggle to understand why this patch is necessary.

Could you help me understand?

Ciao,
Dscho

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t0007-git-var.sh          | 2 +-
>  t/t7502-commit-porcelain.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 5868a87352..1f600e2cae 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success !AUTOIDENT 'requested identites are strict' '
> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites are s=
trict' '
>  	(
>  		sane_unset GIT_COMMITTER_NAME &&
>  		sane_unset GIT_COMMITTER_EMAIL &&
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 5733d9cd34..14c92e4c25 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -402,7 +402,7 @@ echo editor started >"$(pwd)/.git/result"
>  exit 0
>  EOF
>
> -test_expect_success !AUTOIDENT 'do not fire editor when committer is bo=
gus' '
> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'do not fire editor when c=
ommitter is bogus' '
>  	>.git/result &&
>
>  	echo >>negative &&
> --
> 2.22.0.455.g172b71a6c5
>
>

--8323328-1574376282-1561140248=:44--
