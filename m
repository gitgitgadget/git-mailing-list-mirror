Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB88C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 22:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885242075A
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 22:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QZK+iUkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFWwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:52:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:58193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFWwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 17:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578351166;
        bh=aPXx3t5jvFBeA+D/HOBasO7FMbAgsoo/r8htn2wIByo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QZK+iUkwJmsF9oyHwjCmJ9WoaCufp6KeJgq7HJLqcy0aos8SMHIU1h1VLYDiRQVpi
         w3JAEhRqjojCkM39d42D0zOfVoiCzruvIBVH3R8lI9AWZOdd3Rw8wdqyX8seu+CHMk
         GoG7CB/OEEcvt8zG+fnJM1CUVV6BKundjBWLzT2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1jODEm2ruo-00b0Fn; Mon, 06
 Jan 2020 23:52:46 +0100
Date:   Mon, 6 Jan 2020 23:52:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, thomas menzel <github@tomsit.de>
Subject: Re: [PATCH 1/1] doc: submodule: fix typo for command absorbgitdirs
In-Reply-To: <xmqqblrga4h1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001062352010.46@tvgsbejvaqbjf.bet>
References: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>        <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com> <xmqqblrga4h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9Q3v8lF8a5HELbu3HedvZx2FrViJRcuAFOIK4AE6GjAhyvxqE3T
 ohR6Rm+xL51wodPZ4iGzmZ3jQ2Eu/P+HJw3+w8+B2tX9+OkRmzX/I5YjwNqQqaGesf9Kj6K
 JzIcbcuW6JtMWQQRv/y0HLPTP46m1jYAMByme8nHAUA7PPbWqaqPzVXE8UbZXnkLXguGZ9M
 hPwRRF7/IR1scmWpaaAqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D+H/N+DRRa8=:MYoK+7P+fEvX6F6dSobWBu
 jNWGGenUgUC8yQo9xH05MWh2MLEnyx/RjYe2AxiYgEXqdFCr2TkW432/zd4v1LPFa21r/qFzj
 0gsIYoDb4OtfKrtLTvNg8MTlCueuERD0BhGGXxDrvbkeCtgSmNJlo3SP53PAlGUYXho0iimt0
 WQ2No0CAq230uCaF3Mq7wkEYo8PGN5BAzj20p0014DahVQlgyr1AgvSJKoT85JAEdTzE0/Rbt
 NOfDjIeP0fvWgyPNzZ+i4003I0CiwydOyEaKGS6m1HOle5jyaSkXd3dHCtwkIxqKd3XBR218o
 fI+aMHi3cIbV4X7hXZRaf+XkGO0wHiLNqBiyTaEPFAIYTbdaIcb0XQ8uPK1hskufILh3ZkKdQ
 OYWG9lQbsQ8tY8TXTAYw0AMRHBkhFuRue/whGVMlQgZZ7FbVTHHU1emgrbG2Jt52KW3xy9VMK
 2KILSBiq/O/40rQAP6YQrSt2Rk3EaxJUWeCPNkQk/xABWyiGda5XegubR0pV+6IsNIlvTPqpa
 8XFNO0MtkIQk6qQZQtzFrGR1L+aKE0jK8OCr9tmjob8OIC4g+joUz2NdW6pbZBvVl+JetHq4W
 l3KtTUJfb0zfa0OzFahvbUE5GueyRHPiJ6b7YwacQg7uaQ9u0Mu+I+uZytKe2lKGOS1ryBZdb
 4qf/b7h7FpNvAdUtZhv8h0zkg3yJifCPq5qj3MrIroAhCqp8Yv6D1P0G5U8OxPlFUvgOHSD32
 V6Ba1/NfjyJPOZzW7w5SkEzoUREpdiQ2Lbqouf+eAkeImMWfDD33oNath9BUf+U+GNNjariRd
 VB2wIcInzqOopDLt2OwYaqIT/AINxN2CXk5hGk2+TAb/LZs9oEfUHLqzZGjlgaOinWFvuPBgU
 vhhfAEFDoYAJ3aEI4vIUu8F0kqQ7zBdBjLkovw5QA1P+qZrMvoJVgChwQdTjvrOMRESgBxa/u
 wWwvhBJIifatGL6FyXFvUz/X1ESmn3HScPV5UF/84TmizC7nLIDUYMgUQX8A3IoOJUo3VY1W3
 PLdZshiqi3XruYIStdJaFyg+euMMyOiuR7xS/GGffASo75KPip2b2zZHjzAPy8ktEdu8h5SrB
 0a88q5P+VlV7MT/NdcPgDCksB4mLMsVN+rnI+QFo1aWbVmZ8vRjL0B50qpdkqorqF2Tp+6grt
 wNHec1VLQMyG+W4PT7VhSDz6f2CiiF0rLKOu+ltIH1TzePe4VM2ZroKciTIJXyvhPbrFREZ9m
 goU3LSsJ4LGMVqba1vmerN8frwgwICeXtq732QXrJmYzS6xcjz0sRy+Yw2GE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Jan 2020, Junio C Hamano wrote:

> When anybody tries to respond to the quoted message [*1*] that came
> from GGG in the way recommended for the list, the
> *.noreply.github.com address gets placed on the Cc:, which is
> probably not wanted.
>
> Can GGG do something about it?  As GitHub specific service, it is
> not wrong for it to know what noreply.github.com means so dropping
> such an address from its Cc: line shouldn't be too difficult.
>
> Thanks.
>
>
> Reference *1*
>
> <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gm=
ail.com>

Right. I added it to the bug tracker:
https://github.com/gitgitgadget/gitgitgadget/issues/182

Ciao,
Dscho
