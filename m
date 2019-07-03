Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28EB1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 11:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGCLN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 07:13:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:54753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfGCLN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 07:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562152400;
        bh=XCHCwRAfbkhO8KrUayImooYfpe9x0qGyi2LETv7DyoU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CPaNDkycVyIq/TWeE4EGHtCZihL1mdNbvwkI8UvpJeIqKvZK86PMjNiMWJ91OBDBw
         W1bt3YSYZAoG+1B399Qj4P0XhuhTayfxMgeIBbcZvshXkMSaVD7gyvRuAB38KsSqIS
         UKnC57yAW/FELxVH3RoiMdTMnrpVaYWDUCuKbrwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdFwl-1i17n10jEh-00ISa4; Wed, 03
 Jul 2019 13:13:20 +0200
Date:   Wed, 3 Jul 2019 13:13:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
In-Reply-To: <xmqqftno2mku.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907031308150.44@tvgsbejvaqbjf.bet>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com> <xmqqftno2mku.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ihaPJeSHStYMHl83IClPFBPm8AfFYH6LsI/N+5+gnrBzpS/OYdE
 J5OXUGFVrn6JFKBva4fvaNYxzuteRz2MpmYfphcU6K1y/z77ctoyP0myraX0bI/xEbkyQiT
 NUxkk1VlNUnEPneNzaRnClWbfSjL20GkwSsanyQI53ZFyftF6DW4Bt3QjFXJ9qz93fRmHzO
 PfXGoWvPZ+ozJK+4Swn0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PnoJBqqYgLI=:ShZWBlk9iLCIYvVTPU8rmw
 NuiLUNngvKBWEeyvUOoQQtBbe6zICPir8gHTUZF59k8QOEGP7AQV2ccsQLCH+htJOkUVEzT6f
 XFWr7gdbqCo3lv+G25e9EJDxjXQaGE15BbnzF8sC+3nyAc5EmBZKBwpTamnHoJH8f2PMqpm1e
 cxq/mMConbhMjYox1lLsIqyltpI044pIcHDTdLAxUyiTYF6qFWrEML6kKtvjuMNLHqoVoNIXi
 cmV+ln2czUzwlY6Rt1R7UTlBRHgPapQE9Nm+kGQOplaTS2tqaVdYtw9I8r/EMQluJWrAOtt8Y
 ioGpgtod8LnAski2eCmnBRKC8UD83zmq/YIP1ncX75dcHwyrZytTL8ehPexOgzF5a+Pc5BZUy
 8XLrIN0mCFQmPcmMUoxMWcJCfo3xgn3Goum2RvEWMu/d7E3koTz8VWkU43u+4qldyfxzbp2J2
 FH3ZvYf1rJlDlueS9sxTo1jUuf9oKbujnopowoCtSlZdA8MUibdRAcZ00cuYyzEBfOdc6GddN
 /ohYDK3h5gQQswJRk3prj5z+N3d2+cXblHIOqWgoPHstY6/LL93I5y4q96mnoP6vvbyLzeNzc
 PJu8ZHz6rzyFb9d0QRfYohVOQReAHMBGzbbhKQeTPjpxxqtF4gEadygaPuYEmZK3w39UMQrcw
 UGuubgPdC1q41WtY/aC79UugyzqwAU+aKz/SOSODbol1tvQCpDR74qkGijXP1u1LoGGv7MG6t
 CqX0zqfZgHQvyno749VldaWiEUNMGo2BbkIgyFsLyEbGdEI+f+5epcMO1CESz1yLfAyTCvmwk
 SNxLyGyTEWMq8dp/5wRzkRWWWBcuS5GolHPBx5vT7wKUAn2gipz+jxaQlnI5M+iqcHUR++ch9
 diGJuimI+CJ7z19LXmX/cSvGGojWcoINQrOPcslGEvUTAU2Dx4cYOQyN4Rew+8n1ddBxPZOqr
 mhS4P3haeXrBTHBO/4KRtubM67NAgOf8T7yNpyV7OWkVpcMLzYdNpMNegGoLk0qHCT8uEtQJB
 SMPwsnBV5BEQEbiDNs4vCjJyAmpb89ZIF0fzJ3R7z4o83MR0qan4ycBu7K3J5tvnxUFnZwUQ8
 KlPwqR8VORIoAq/V4AV94fojhczTqBOa4xh
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Jul 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > * nd/index-dump-in-json (2019-06-26) 11 commits
> >  - SQUASH???
> >  - t3008: use the new SINGLE_CPU prereq
> >  - read-cache.c: dump "IEOT" extension as json
> >  - read-cache.c: dump "EOIE" extension as json
> >  - resolve-undo.c: dump "REUC" extension as json
> >  - fsmonitor.c: dump "FSMN" extension as json
> >  - split-index.c: dump "link" extension as json
> >  - dir.c: dump "UNTR" extension as json
> >  - cache-tree.c: dump "TREE" extension as json
> >  - read-cache.c: dump common extension info in json
> >  - ls-files: add --json to dump the index
> >
> >  "ls-files" learned "--debug-json" option to dump the contents and
> >  the extensions of the index file.
>
> The t3011 test in this topic seems timing-dependent-flaky.
>
> When we get "not ok 3 - ls-files --json, split index",
> the "filtered" one looks like this:
>
> $ diff -U999 t/t3011/split-index filtered
> --- t/t3011/split-index	2019-07-02 13:17:19.676719212 -0700
> +++ filtered	2019-07-02 13:40:32.068638361 -0700
> @@ -1,39 +1,19 @@
>  {
>    "version": 2,
>    "oid": <string>,
>    "mtime_sec": <number>,
>    "mtime_nsec": <number>,
>    "entries": [
> -    {
> -      "id": 0,
> -      "name": "",
> -      "mode": "100644",
> -      "flags": 0,
> -      "oid": <string>,
> -      "stat": {
> -        "ctime_sec": <number>,
> -        "ctime_nsec": <number>,
> -        "mtime_sec": <number>,
> -        "mtime_nsec": <number>,
> -        "device": <number>,
> -        "inode": <number>,
> -        "uid": <number>,
> -        "gid": <number>,
> -        "size": 4
> -      },
> -      "file_offset": <number>
> -    }
>    ],
>    "extensions": {
>      "link": {
>        "file_offset": <number>,
>        "ext_size": <number>,
>        "oid": <string>,
>        "delete_bitmap": [
>        ],
>        "replace_bitmap": [
> -        0
>        ]
>      }
>    }
>  }

ACK, I saw this quite a couple of times in the Azure Pipeline, too. It's
an unreliable test case all right.

Ciao,
Dscho
