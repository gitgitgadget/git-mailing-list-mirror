Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABF420248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCDPG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:06:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:55027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfCDPG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:06:28 -0500
Received: from [10.49.208.72] ([95.208.59.9]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQI1-1gjzFe1hEr-00Gphh; Mon, 04
 Mar 2019 16:06:19 +0100
Date:   Mon, 4 Mar 2019 16:06:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
In-Reply-To: <20190226105851.32273-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903041603320.45@tvgsbejvaqbjf.bet>
References: <20190221121943.19778-1-pclouds@gmail.com> <20190226105851.32273-1-pclouds@gmail.com> <20190226105851.32273-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1617370718-1551711980=:45"
X-Provags-ID: V03:K1:7z5csXvYWGGGRvfbwfTS56qiKd55VNpLd1s16cVF89rdcGt5jVV
 iyBNEBJNypE4uO5gNXB+mcFjAGjD2CiwYYD/NKq85WMS9kckMS+8SOxotH0FjzlVjn/j/fd
 A7X8gFxRUDdkZpOP7HAoF2869CsYnkZTnAtTSP6E7zJR0f7c8Klydbub0bVTpWgDaZtC58v
 T6FFsinmST17bqnSlN6FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:71nLyxO8gUg=:3MZsICFsuLijRj7le45yim
 0r+AZMTIFdUsA7nzwlDyh0nn1Mj2v4fWG0o8AAuR9FblVDpVb1hoULY94vTOCCQIiqNMs+3/Z
 o62uzDDJ/kCX/T3+mRCbaJ1Gdb9MSxvZJaf+jFG4ZXAxv1WfKAzuON/pJz9daz+qssHErLQn5
 m/AXJI6ZFDu7VymCpmAuzYFNB434B66tW0Bcl9BB9szxX/z1Hm0zYJV2bAZFJI0PiOUURdYcu
 nI1h7/zA3Jms7/F+RduYCqY98qMdJ6cukDVL6qefeMUZVIAtz2sw+sM1DIc+b9izLEf+mWDyy
 k+gn5oPLc0+VOChyHYRzZfxbPaRttFukYkxJ4csu8binVkrOd+U6OuTDegDTIzQlNYM/6BgEk
 vvyj3fLZqialPXeZhKad/Ub93RjNtWtiJ1QeIrxjNZpPwVHF0bxfJ9NrT1D1V/fcGlP5z5pf0
 U2N60jOGA3SjySkPq48fwAsgy6rOCypW4/u7ulEdVyzeRENVJDJ4XYWy/35XZ1GiCuGmEjjh1
 ECRoOMx53YiGz966d+ydb1fGl3KThP1B6nSBTcqRztBNbAAo9VKiguA1/zU2QFSm1FJGjyu1Y
 6R1OFB/hdo2P4KTXPUsYIg7fgRTys6B1K30s0nU16Tk/FN+VWHxRgrE0UGtQJHZOgk/j/KdgT
 Tjvtj9FeOpFeXxFys54aiYLj4CiZxmde+Ppji/6JXFdEnOsMBnr7tax2nO7wpyMNWepdkuBzM
 14kpwhSk6fza7sm+GsIY5IFM5MnUAubGs32HXR8/Va7N5fKnKLNTsTH9mDYQNwzGHyA8Kal9Z
 oepMCGDmuY9EceywvBSOvy6WVd2insEs2qpwJo9EAplYmek9OpTjEkuDkWUiQEIDYTQL2/lUp
 P79+kjS0RyEkiBAGWjHU3DDrf3qwi+99/+JJrKk0jECbCJQ/5sNCODdh/PkH9OxDWNspPF0Pr
 5cREsTOJYJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1617370718-1551711980=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Tue, 26 Feb 2019, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 286bba35d8..ea22207361 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -570,4 +570,11 @@ test_expect_success '"add" an existing locked but missing worktree' '
>  	git worktree add --force --force --detach gnoo
>  '
>  
> +test_expect_success 'sanitize generated worktree name' '
> +	git worktree add --detach ".  weird*..?.lock.lock." &&
> +	test -d .git/worktrees/weird-lock-lock &&
> +	git worktree add --detach .... &&
> +	test -d .git/worktrees/worktree
> +'
> +
>  test_done

You probably missed that this added test fails on Windows:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3782&view=logs

The reason is that you use a "funny name" which cannot be represented on
every filesystem.

Please use the FUNNYNAMES prerequisite (or introduce another one, if you
are uncomfortable with using a test whether tabs are valid in filenames to
indiciate whether wildcard characters are valid in filenames).

Ciao,
Johannes
--8323328-1617370718-1551711980=:45--
