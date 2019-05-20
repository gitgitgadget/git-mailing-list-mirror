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
	by dcvr.yhbt.net (Postfix) with ESMTP id 367FF1F462
	for <e@80x24.org>; Mon, 20 May 2019 18:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfETSGL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:06:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:48709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETSGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558375565;
        bh=jEASy77lF2IvAaeJfHkgjMuEEFGw/wj2AmeWUwlPl7s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IXaNaiL1MQQb5xN/rrlm0J0dXEOe4IR9PPNURQGz82V+kSNnlIhfmn7ERZrvZucwr
         2TqoYX24yi6UV3Rzr3Jobb0qdKILpzenhSvQUbmrBjaa+537AtWiG/s0v2HMhC1S5b
         Kgu89VrV8p6m2j2v1h1tvg5XEn2osq5iyiRQ/qyc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1gvdi83yFE-00bXxT; Mon, 20
 May 2019 20:06:05 +0200
Date:   Mon, 20 May 2019 20:05:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 2/2] merge: add --quit
In-Reply-To: <20190518113043.18389-3-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905201904240.46@tvgsbejvaqbjf.bet>
References: <20190514091322.12427-1-pclouds@gmail.com> <20190518113043.18389-1-pclouds@gmail.com> <20190518113043.18389-3-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-725443162-1558375565=:46"
X-Provags-ID: V03:K1:qxsI6cCABJAn5BehCx/qBRg4/dLVZvrUivduRixmvaggqgl7KCx
 dvNlrCWBWb5qpTaMG8uaheNbt63j/mDAHg0PLceMvzyFhzjzkF03ah8ZD8PvM3PTR6w8Zg7
 WmrRSnoMj6+U3wKYAdZO+Em/B/Z2oLM+14F9xuaOdvG4QE/g6BiHWwYMFkRoHuyylhf0ge5
 Bl3+Mib9gVnRlCTJq5THg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmBESlW8va0=:hwBbmcVRmHxI5nwfPNcA97
 TRnbZ+tBQlS1ILOG9fBDLnzeQ+ZwxBrwupdGoSVz1hs72v+7ZYEJAZWi6dKgaVsAh5zU6FpQw
 vZE+aTXDGDK7NdwruH157tVENbl+TK9v9AzgXX2aq2kmSIfaraH0uag8Kt1hSwIrFN6vTz4Ws
 ejCyeBFIiFoE6DoAgNakgSykMGFFLth5U+M+CwCdbZgHzlEqYdy1pTLINiru5KkfxvtErUdQ8
 NA1Eg8JYU46WIRqiYw0NJuNsYPE6nhTxIl5pTm56RUlAptxZZ8gkrL+gmnBYDRgFsubqafznG
 usA7Hkaxf2LxnplsHMeoqg1QFvLBE3vnHlgoa3jTQFs3ThuixEKTqrwsPLvTDzdTzEBn7KwCl
 zZnUEt0BIt13TAK9Egt6Vd9saFEiv3PnFjBCiXj091Xfoi6ISoF4kirrX7sYDVeyhw/2N8+51
 lnibh0E51MnsoxRg1WHgXFWJserhNaUwdvEtAm9aqMDAo3f/bghftGrGOOEvZ49YxpwAmdfmM
 IM/j4Bra/maSZD5xv/o08vJRKYyOMQeWuDXn/HNvnyWktQfD4V2WXYMgdwGeUvl8VpWncf6Qa
 ENvYUHbZ75yaVrFeh2Hxtw0IBWtVTw7VK592LnIN5SmTGnY8ZBGgGLDxGtKJKZTSNyuq1PRSe
 JI2fJQsqm0kcVQRHlmzooPqhBgxlXp7yi6Bh71MPlPn7ee3yrwlCsiuP0yxnSu445M9/rpm2F
 yyvIb6m3R3eIBt/HdBwNF0c6HG/JIxoCCVw6yGOPohHj1cRyohc9GJRNc2mJFHgmTrdTGuhCf
 5ogMsiXyD36mm03wb0wjmt6MQOowgKrC1ViajCQ7IFrRsm/64ds0BUzX3Xnd4dDW0ZY6wfPQl
 fZ12owwwn0ZLwAYNob3aaY38pkIPwaUSot5BgnJ/StZl5PEK2cZhkIwLtG1rN/Fc/2fGNmNGs
 fDtbRU9rkjwDShuCu+SUSX55UCJkq15km8hqcHDgVzIYZQd01Yx/R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-725443162-1558375565=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sat, 18 May 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 106148254d..625a24a980 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -822,4 +822,30 @@ test_expect_success EXECKEEPSPID 'killed merge can =
be completed with --continue'
>  	verify_parents $c0 $c1
>  '
>
> +test_expect_success 'merge --quit' '
> +	git init merge-quit &&
> +	(
> +		cd merge-quit &&
> +		test_commit base &&
> +		echo one >>base.t &&
> +		git commit -am one &&
> +		git branch one &&
> +		git checkout base &&
> +		echo two >>base.t &&
> +		git commit -am two &&
> +		test_must_fail git -c rerere.enabled=3Dtrue merge one &&
> +		test_path_is_file .git/MERGE_HEAD &&
> +		test_path_is_file .git/MERGE_MODE &&
> +		test_path_is_file .git/MERGE_MSG &&
> +		git rerere status >rerere.before &&
> +		git merge --quit &&
> +		test_path_is_missing .git/MERGE_HEAD &&
> +		test_path_is_missing .git/MERGE_MODE &&
> +		test_path_is_missing .git/MERGE_MSG &&
> +		git rerere status >rerere.after &&
> +		test_must_be_empty rerere.after &&
> +		! test_cmp rerere.after rerere.before
> +	)
> +'

Good test cases do not *need* to be excessively long. Something like this
should be conciser, and more importantly, less inviting to typos or other
bugs:

	test_commit quit-test &&
	test_commit quit-one quit-test.t one &&
	git reset --hard HEAD^ &&
	test_commit quit-two quit-test.t two &&

	test_must_fail git -c rerere.enabled=3Dtrue merge one &&
	test_path_is_file .git/MERGE_HEAD &&
	git rerere status >rerere &&
	test -s rerere &&

	git merge --quit &&
	test_path_is_missing .git/MERGE_HEAD &&
	git rerere status >rerere &&
	test_must_be_empty rerere

Note that this does not do an exhaustive test for all the .git/MERGE_*
files: this test regression promises to verify that `git merge --quit`
works, it does not promise to verify that a failed `git merge` leaves all
of those files! Using just `MERGE_HEAD` as a tell-tale for that is plenty
sufficient.

Likewise, this test case does not verify that the output of `git rerere
status` is different before and after the `git merge --quit`. That is not
the point of the test, to make sure that they are different. The point is
to make sure that it is empty afterwards, but not empty beforehand.

Technically, your version of the test case verifies the same (if a file's
contents differ from an empty file's, then necessarily it is not empty,
but it requires some gymnastics to come to that conclusion). There is no
need for convoluted thinking in regression test cases. In fact, the easier
it is to understand the *intent* of a test case, the quicker the
investigation of any future bug, and consequently the faster the bug fix.

Also, the less you execute, the quicker the test case runs. That might not
sound like much, but we have over 20,000 test cases in our test suite.
That multiplication is really easy to compute in your head. If all of them
were written succinctly, I bet you would find it much less taxing on your
patience to actually run the full test suite from time to time ;-)

And this illustrates a very real cost of a slow test suite in addition to
the time: developers will run it less often, causing more regressions,
wasting even more time in the long run.

Ciao,
Johannes

--8323328-725443162-1558375565=:46--
