Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648E020248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYSu4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:50:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:35171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553539854;
        bh=ol3ZbTRawirZXgrJhsBNw2iX9PqngRKk9P4opAatS1Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bdua6WzwJ5v4aOKklfqWoy8Rt26KOybbJRFzBQLIFOO1D+f+CtSTZDY9SwibcAWWn
         SRmtmjtuJmpPSqhsYJc/pMgsDdI86RTp+Nd8ogJJVFKpZLLRw7DQPjVNBhsvpVSakK
         Ps1DsBtxt8JEqJfDINY4IwERuYEPceg2BOi8FT4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxgHz-1gtZ6k3zPH-017AKD; Mon, 25
 Mar 2019 19:50:54 +0100
Date:   Mon, 25 Mar 2019 19:50:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
In-Reply-To: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903251948200.41@tvgsbejvaqbjf.bet>
References: <cover.1553354374.git.liu.denton@gmail.com> <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NOTzdg+AJo4h1B5aEyzAlF5MJi/HVMV3L7p78fdQjgn2eJb/WsC
 sU0i5K6sUoDrgAxITrKqYKgvusZqj6WlTQMuA1x8v6LjyOY1FhxkfZkd4vEisPHLoSlnMxt
 sIa9MD3xMmk5pH3IwSJAC84tBmmyvn735WrVHWPAV7w7DZ2yr4I8+04gRwug/pNCa5laUV4
 9EPrX1fEWS/N7xsVfQOUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+RY+6W0oPM=:AUR1pqOSe0r2Brp3fMBZSk
 dSiFzCTa/GroZ5ZWQhXnh/hZX8pvbOi10EQYUhS1cyQD4667Pzx+pzrjy5MwYRJM/HKuaBJOc
 ATiAbkQimpND/XYyAG3TTU+8sqFht+4+HMTfKrCBUxJejPuIbZBYAKX4VoNmJVRj0M3JDyhcd
 O50UJ/Szdv+gZ5jA1qEaHqb+j89yU2eeLFXnXyGtkB5JKT0BgarjeZ97ECfV+byEzrsK64Qgt
 /7+T9qYolSSwo2gx/VaxdHZMsg52XQT20hAoIzy+Xet5u0+X97PMMwO4gHmsCstd1HvjKP60n
 cePaZXncDDBpqEmf4W5zMaskZ3UwSBNFYZYT90Pam97aBIJ0SDHV0sabHeCABj2fsPT+ItjqQ
 sHFf4j/gJAqSfr1iZqe4RjioZxW/PgmeroKPGe/35ec3mdbpg1evaKbacSs6MEq9xXPPB9VDn
 yCpBjfxSqsmYLy0aKJldtxeX45QhLG9FNymENES++x+u0C9fxfi9QbZkATzPqJGOe2mucQGXV
 F822L935m91FhckDYgxA22fETngasLB+INwnCs600miAUhdt1KuVGXnR8c3o8hQh8nfQgOxmX
 +Vopu0FMFnVrF2Pf03jfAt7MMMCdqyjlOwwk5hS1mBXmNUW72AbZ4VN0WpluE/i42QqFtgMqR
 jhVXLiGOkD0Dm4JaEWxbrS1lvIfuGeEgvjfiqbOXBaaXUm4fvu1OYchvakU1EfTcc7/7f8Pb0
 84cEE103G9fmEt33PWSCVdD781xnFnAIwL6lZ+HTX8hQ+K0AhUtH/rXbsRT8j9zPeipEafbJn
 CL8rm7dq7MO9uREZjVBk90AiuvuM6PT9CHN1NchSILCrQ6SH6sePoD+XQ3NI9bNF0aKiyoSNU
 QNpyZYRUV0W8Ii7T30VgCq2XDM7SyKwjemCDeQHLFq+pgZ/BTocJMORxgqTYWL9IBP9GiHSc5
 AFzTiK/yW0A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Sat, 23 Mar 2019, Denton Liu wrote:

> [...]
>
> This allows us to rewrite the above as
>
> 	git rebase -i --keep-base master
>
> and
>
> 	git rebase -x ./test.sh --keep-base master
>
> respectively.

Just a quick note: this breaks t5407 because that test uses `git rebase
=2D-keep` and expects that abbreviated option to be expanded to
`--keep-empty`, which is now no longer the only possible expansion.

I just submitted a patch series to fix that, and other uses of abbreviated
options in the test suite, in
https://public-inbox.org/git/pull.167.git.gitgitgadget@gmail.com/T/#t

Ciao,
Johannes

P.S.: Did you run the test suite before submitting your patches?
