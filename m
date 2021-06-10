Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFEC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7EE61009
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFJIif (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:38:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:44995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhFJIif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623314187;
        bh=IpNOOqgDZ19l6Bt+zT8pmWAIPMKj/K2XJ4W4J4+KGUU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AsvdBShL5hNroUNcEL5cYed8vNdUNC0kAvuCVg2ZtCk3b9oV7hBW3ZaT/UN4CN65O
         LMClBjm07l9WlC3WMk1jlV7VottKEJoK2aR6In7ucYsToK3UbIPxS9vJoxmtp+fy97
         AgOW8RSySvAc1AAnyA/xaoYSACsnJQhLXkMT78JA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1lgCVW3eie-00ODi1; Thu, 10
 Jun 2021 10:36:26 +0200
Date:   Thu, 10 Jun 2021 10:36:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] *: fix typos
In-Reply-To: <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106101029490.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com> <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TiHe95ja52LP31dzrxGmPzinYlPwlf9tCBbjlppQbgAyew3EinO
 psE+Nqnd+zreWUVECR3o2rn1RLQzPymXqURsfPOv7m7qOTg5UCgQUsWPz8Qpif44tVnTmCF
 W1ImYSrrnUCvPtKONqgHPy8RR/odqNwxLzatEhmnj+8hlvKHSZy4AMYja1Vkk8EPZ2FYbN8
 pIu7+q4sY0idXqR97WP7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRsGafXpeN4=:G8entR54Muw7YU0/gyYNVL
 lmV49W3OiNa/49UkVzz/aLJAga+gWNrOys0ab5PTVpxCV7N6zSuD6linq3oyMX3oKtPLDYJ6y
 RUb9ODAQzbIJ12H1hh+uy1Ny86bhn1EVMLsDk0usGtxYUprVM2RAEtPfOVIgi77ho+CYooVyN
 SWFxuIGkBRtIegKaN1HSP2KguS7BHDfzZtiUvLSwB6F4iJMngjeeSRpBfhiZY8e2r5Ltr93Of
 w7YRU96LqP7RCC8b/VqHEo2FgV6RR3w2soj5TF6HPxUstx11Ds2rcW0rukyXnnDPCZ99pk8kZ
 zrZev3AG1QBA8P6ifbknNr5wArIlVuNHXDWwFPufgADsmDFaNlmizwTlg5FTyMThCqrA9h/sy
 ACKuYvACSGlxC+VEey3UrJQu++L3ktzXzTls/n7Cgu9H00rGcMEajrnS0wMyx3x2NJoEX5RTa
 PiKrf00sFMg0wdMnR6lue14B/DwrBukZ2+rX3vU+pd2/vzEATS+pNWNZogTtHRr/Ikd+ydAMl
 fDbT9pOA6VIuYyTT5vS+hKOV1WlNW5z3w/DwpPbMYX5Jz9PvK2KEztcJ13392UU+PPiVXk2Pn
 2UtPAh2cRezM7qvA6RS3JMByon9/BX7WSlJSXlj8lHWK8tpw/1K0tBfjklIztl2GDwnoaYPQS
 7s9zgx7eyAcEl/stPidA/uM4DDajJZxLddf5yoHP35yHveP59NlueX8CgDBOtTAvNwI2KLhcr
 O0zhO32eqoYLQ08AH/8QoRW/zl24xRQ2gi7J0yYxVq+Zn6219VknUQA2YZFJFBtDCa6bUeyBe
 8NGG/nGHjpLW9pnT9zB32X1vN7BNc1Snv/mHcE209Xk1qQcsWJVMTrnPx7VdeCEyU12HW9aSQ
 w/nswcgSPQs7HRFyp2iS4QMUnhJGigHGLT5Ebw0yfo0g245McGRJd57nBKotuuQfmSnHhxklF
 VggTWIeuhmAf0HYq1AV/gGXkdzlwJ4gFoZE07H1CdFeoHEJ9wpqVNeeV4mn+5pQISkUhoYFqZ
 NIR6HGT6Afiw4qCVmRITGIBtMpm+zQQe8OjqrJnlSxSpBv4+wylCdygZ5miwV3xcOncRD9EUE
 vDjKcHiDiZ0JiJM5xS/GSuKtTMxuVJiLP1hbYuo823pnGraOt4vfaoFaQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 7 Jun 2021, Derrick Stolee via GitGitGadget wrote:

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5c47ac4465cb..7039b5c6028d 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -1538,7 +1538,7 @@ test_expect_success 'O: comments are all skipped' '
>  	commit refs/heads/O1
>  	# -- ignore all of this text
>  	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	# $GIT_COMMITTER_NAME has inserted here for his benefit.
> +	# $GIT_COMMITTER_NAME has inserted here for this benefit.

What is this even supposed to mean? I fail to parse that sentence in both
original and modified forms.

Looking at 401d53fa350 (Teach fast-import to ignore lines starting with
'#', 2007-08-01), where the comment was added, I deduce from the commit
message that the personal pronoun _was_ actually intended.

So maybe a better way to express the original intent would be this:

	# comment added by $GIT_COMMITTER_NAME; fast-import should ignore it

Ciao,
Dscho
