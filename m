Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A30C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33C660F4B
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKJMt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:49:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:36273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhKJMtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636548422;
        bh=HXbgzrslyCXl5ZR0uPYL4ZG3mQMGBkqc2xc8iCQNqQU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pg9BX7K7Du7RPERewT0bEnV3lF9Cd+2Tmiwb5NkcQsJpwDcB2SUM39nP2B1kcJ47G
         T/nepcerUeQ4CE4MndU+Zpvct2auGUEPIiPdVhauKe1aCqyybDJSGLED/GQeRy79Ju
         MviDvcQWmbwGZbX+PFhVZfbJLWSJMlMFE0ZEY3fw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1mlKhU2T6k-001lQW; Wed, 10
 Nov 2021 13:47:02 +0100
Date:   Wed, 10 Nov 2021 13:47:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/scalar, was Re: What's cooking in git.git (Nov 2021, #03; Tue,
 9)
In-Reply-To: <xmqqy25wygek.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet>
References: <xmqqy25wygek.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7PWauHmYG4rTHNyg9DisF7M07hcCefNBkRFRfZVDBDE25tdWmeC
 eOD9SWGhMdjpYYMAxawN6vF6ax6a65mIGpH9JzvV3fXtD/M0CSWe0UwgPjlZAUKSyGSSbWO
 GG2JKJ3pJ5w7R2ok2J7bO4J2QkQ9NN/oykgRrzQ13OVJ7fy7yYJjcEQ145h6yCrGARX8Uxj
 dsIevYH+7pggzsKl/NcLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hUqI4TNo3As=:OLD5jILUcf8RwQ/foxtRw7
 H4tIQBONVYUXO+wP63Mbxe9KPWFhUPx2HDh63vS4XC6Ox05AHqkEt8SSdkZSSeKO4KJ+cEYJC
 efsqTYSa78bgde+cr0dmZz0taZ6Zwj5b+z2iGlcPwWRzQtRki9Rs1IthSvaN42WnA9dQQmZNj
 wMwCRg39k+0XMTc+MoTMYePIfYYcf8qve1472DpWdj0ZGA67lFHxSLgS1Xt6wRtt9+MSABMZ3
 AwfWl1blzxDbBJWgr6YNXVKriNdn/qJclpEKv2/MbQFup+3wThMi8Ev9uzLRVDOaCjcMaFveX
 iMqiiViaZaAO3rf7Wzt5ewAlp9/6kNXMG2gnGtKtxqANnEdYfIY3EHirYlDm6zt9gvVl7BcXG
 6OXnN1a0tcucAbjkl15pQfENxvQ6tqEpDP3tpG+oYH3a/pUrGxVrgA8eR/Lm3kzCE8dez/VJm
 6cJquBKsG7tO+T/opaKSd4KqJodv3FpMu40EL4BMxWaxdsoTn2hNiPrpZ4MkQJS9c7GgWqOWA
 jnIXg0BWXjpdUZaMLcVYnN4jHE/ex3j+3+rkAbF9nGFToNTNMT+sNpEhcko6mwhgelLR+CCR+
 C3xGIvE9d9osM7ojIi64nwdmtBOJsPf03RbXblbztBNXiGWd4LuzTyROjcsJpv5h0YHDIpapu
 XPhzgn+A1Tj0yL2IaZe+Ijw6iugU50y603tRQDOKJZsCdLzzlipmDj5I0BDxxnM5+81Ni9g09
 C9O+eKg2O4ViSLsUigL1xzKbdOpEjKUlaWHACrEr0OjhS4nfk8QBIOKTeN461fbLjCAHV6Gje
 gpXxR20OwUwJLw3bjgo6nQk+u27/iGXgHawZNaTjBT98B62xRvXPJP8oBuD62Zp3i2UjB0GWD
 +KOLJ+BgnWtc8CMdhrD0t2MYvyECwJ4Bs6wVWTK1nxzdi6Prmhz2LzxPW63XVJLDqWqsuCrtz
 Swb/E4kvaTodjNxgvmNR0VCYq1khjjHd+t+RxDOuNI0BjPgnS4rDvGzDDx49+RFTF/PwAlKjT
 PG6/pehBEzhSvojQ73IuX6DGmw7q69zIKwncKiTL2+Uue0IsV/fozTcaKTcZIXnnIGj0uH/4N
 ROeCZI1CSVRiIQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Nov 2021, Junio C Hamano wrote:

> * js/scalar (2021-10-27) 15 commits
>  - scalar: accept -C and -c options before the subcommand
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlis=
tments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracef=
ully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>
>  Add pieces from "scalar" to contrib/.
>
>  What's the status of this thing?

It is on hold, for two reasons: we're in the -rc phase now, and I think we
all need to focus on it.

Ciao,
Dscho

P.S.: The second reason is that I was uncertain as to your decision
regarding Stolee's thread about the optimal final location for Scalar.
Since it seems that we can actually go forward with `contrib/scalar/` even
if you eventually decide you prefer another place, I plan on submitting a
new iteration with adjustments for v2.34.0, after that release.
