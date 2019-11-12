Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0B81F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLT3U (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:29:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:33551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfKLT3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573586950;
        bh=WW6OCEPCJebLllwdDqngGs5AR7QEQODf+lr1jMdgjmY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=klilJBQQY338bmtdBdQFX8min64x10MOb+lMw8vKPrz7eMOaCxHQN4D8QpYaYJ08z
         JrWP+AKD5UP4nFev1UVLqORQVG98VjmsKagc6EFK35FEQBLMeEyKXBDgGN/6KGRtza
         C1pTdEWOOE18tJ3JR6B3Kr/bkOzhVBGCwfm78VNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1i9uAE2c0i-00nlLX; Tue, 12
 Nov 2019 20:29:10 +0100
Date:   Tue, 12 Nov 2019 20:28:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] test-lib: don't check prereqs of test cases that won't
 be run anyway
In-Reply-To: <20191112122438.17057-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911122028270.46@tvgsbejvaqbjf.bet>
References: <20191112122438.17057-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1687372005-1573586952=:46"
X-Provags-ID: V03:K1:HkcY+bQF1UXiglOZ6Clsvq7dbX7gH3Pwpk4qr3fhVCBdU6oRtlh
 Odr5kmHiKJWjmzkP4Bb6PnzKM7oSm8H+4z8/66V77qCQnm8ZP/VbhwJuc+IG+EbvhPLEim+
 5FcchJeFf9vHhtTDW5tbxnDO7N94Z+cy77Q6EBiBqfnktom9O3RBSZ8U6JeLHl4C9++9GnD
 KXJEphZGiDaQus0MqIpSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5HQB1uofhJs=:Z5gAgiSPTl5XBRyDxN4APd
 JKSwQ+iM6CHiqCWT/Nv3HPL8AWaG7GG8PrgwHPs7etY28cSxzXiIkM48SrTO6nrXo5whNqvUh
 JuPfdqMfQVXq/aou8COXr2O4idWZStDb4AbYScyGcX4AUSh4NQALtaITHGUIVCJMr7Jd3Ws+5
 da9NhYTnklTygGuixpchFAuIeyfaTcoqo81gSpvsr7g1WldWR57A3FuhmyDB1IzdS+1dxKtJw
 KrWC6N/TIAB5H+TrKIhLfVSZ1YG+cvZmGaOS/JOMwbw1c5ZYJ7m6dhm2f/13u7ZcGf00GqXQg
 uiDrPV+ZujHigAE/031OQFUQZ7oBaKDEDVhWgMAuLLMZ5DW8k4guhwi0d0yAqX6nXw9vXzKou
 QYouhWetSN68axoeDU0AXIXRXtAiFAUQJ6nCnuQO3XiZZLVhlmTVHnW7ABZu8jdvi6eaDa0dS
 mhqPMrmQCH+zCulbCvDAKtwdTVjSctEFcbnZ2c//g1uWpxxjrrp4qxiIVUn9hZWTgCx44z1lv
 kUaQH4PbAZYXfS/6wZ372J8xryPrB9V7E3Ejbi6YZOVZ+SDjuf0/YzxwnEebdoQMcFi9cxY4a
 j9qOF8BTc4MSbjRYZMFe4KG0O/DlLBIQgqZu5Dyji0U/o7K40dBvKjKduukdQkULzDVHRkwRE
 sckz5WSQaIWX0lmmEsXa4Kg2sxleXKSFauDacc+0MdQqyNbc71DUvRHM7aMDMIhgMG9UP2dwa
 OFurTKsbdnPsC30/nKD3+h46xg7ew5OZIF1p6ZqiRqjTDgfc9d5x5+ODknWq5SLE56oXJFsy1
 xbn1eBpzRFZjEyU+ZLHYcD65OIo9IgXZXBfuq8H6Ylw23w50IjDhUpYnMd9QWAUxPpsmOOMSd
 pscFyMTd6s7exMX/eqIGgnuxSWXwfeOp7cvGSp7011BHeSIRuRo2ZCQkqwrIuJLBc/9EP++vy
 Cr2kgWQrEmSR/wja+t5wzr5bjn90a5ERgiuzzELTj2cI7M0uAnaHHS7ezVy7hHNVRETbTnRq0
 cSNmBq755RB8cwUlE5siZ/CHaMysuQ5jX4mCPMAcwpRWqEG+xtn0gtDJYNo2PLBw7AgTvdZVO
 brumaXrHlclkonuGg4iBvXBtHCQeEecZF8oP4VVo7tn2y3/bgDkLJrRM+ddJRccSYl/tpwgHf
 lYtvP3JrkLN5bDUY8cOqVBoz5fChRpoOl6GW2W+eMsDaLj0BY8Jfr4L6RGe1RjAHZt+FF77RJ
 +8jyR7XRydH0c+B9FLkDZ2OdEgHQd5zdneFJdsHve0xNJY2lhfbAxStNXewU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1687372005-1573586952=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 12 Nov 2019, SZEDER G=C3=A1bor wrote:

> With './t1234-foo.sh -r 5,6' we can run only specific test cases in a
> test script, but our test framwork still evaluates all lazy prereqs
> that the excluded test cases might depend on.  This is unnecessary and
> produces verbose and trace output that can be distracting.  This has
> been an issue ever since the '-r|--run=3D' options were introduced in
> 0445e6f0a1 (test-lib: '--run' to run only specific tests, 2014-04-30),
> because that commit added the check of the list of test cases
> specified with '-r' after evaluating the prereqs.
>
> Avoid this unnecessary prereq evaluation by checking the list of test
> cases specified with '-r' before looking at the prereqs.
>
> Note that GIT_SKIP_TESTS has always been checked before the prereqs,
> so prereqs necessary for tests skipped that way were not evaluated.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---

Thank you for this patch!
Dscho

>
> Following up on:
>
>   https://public-inbox.org/git/20190923165828.GA27068@szeder.dev/
>
>  t/test-lib.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e06fa02a0e..24b541f494 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1000,6 +1000,12 @@ test_skip () {
>  		to_skip=3Dt
>  		skipped_reason=3D"GIT_SKIP_TESTS"
>  	fi
> +	if test -z "$to_skip" && test -n "$run_list" &&
> +	   ! match_test_selector_list '--run' $test_count "$run_list"
> +	then
> +		to_skip=3Dt
> +		skipped_reason=3D"--run"
> +	fi
>  	if test -z "$to_skip" && test -n "$test_prereq" &&
>  	   ! test_have_prereq "$test_prereq"
>  	then
> @@ -1012,12 +1018,6 @@ test_skip () {
>  		fi
>  		skipped_reason=3D"missing $missing_prereq${of_prereq}"
>  	fi
> -	if test -z "$to_skip" && test -n "$run_list" &&
> -		! match_test_selector_list '--run' $test_count "$run_list"
> -	then
> -		to_skip=3Dt
> -		skipped_reason=3D"--run"
> -	fi
>
>  	case "$to_skip" in
>  	t)
> --
> 2.24.0.388.gde53c094ea
>
>

--8323328-1687372005-1573586952=:46--
