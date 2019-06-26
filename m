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
	by dcvr.yhbt.net (Postfix) with ESMTP id 265D01F461
	for <e@80x24.org>; Wed, 26 Jun 2019 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFZOCd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 10:02:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:49979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZOCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 10:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561557734;
        bh=RPMA/5n2tl6cjjBuS9mAvEXmFvywyuKJOEkMLsis4YU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OsyqmhgbbiMLGRw6iD8p0sORSCMeCwF02Bw8f3XBu0N/kompZDkOgBhU2egjJNgTQ
         4fu5LGjDe/O889NWEIEdqCYw1qw78Rdy5W9jmKZ5y909UwBjam70VoYp1NMz3FRoAh
         FFcnhaEiR8Oz9/kpUaJkRQZ/Fs8NBL0WPMfdAnHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LymHf-1ibcvq47rb-0165xy; Wed, 26
 Jun 2019 16:02:14 +0200
Date:   Wed, 26 Jun 2019 16:02:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 0/7] grep: move from kwset to optional PCRE v2
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906261601270.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-15737342-1561557755=:44"
X-Provags-ID: V03:K1:f+J0Xp3mtMxmw/2IWlANPHv8gafOtf92g1T0I7LwVHzscFsrhBf
 ACe49aRUmUy4ecbvLvxRmZRH31ZyU3XQM46Mo54qq49Ff7O7by3p4SLMxfgNKKIRLn1ZIX+
 7qopoQpi/wSc4MoCdsdMUkiWD6pS9L8q03o9M3E84zttQbrELSpGtXL/uV5VbVgo3qgw9zM
 3ntfJ90PeJvdsm32g991Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D6llAln5BRI=:NybER6M9sK7DS5efWEYH0T
 yExGW/5FzM7ENOc5iFlOzDPHNZg0ryXeq/GXPzLnPi8ajrotiR0uunmuWUH0NaScWMH1PMrfE
 FaBvnxKUKZ+/BAfkppX/JZ9UIPdlvkJfTN8W76r7/vaCkujmCjW4W+f8OqnR/TWulJIXef9Ax
 lU5AUTwf+sKiTi4+iZ2g+zQnG/0GsdzTlguorirENIepl+iJLhGWnev6Sfej6VPnSquWbGovC
 mLB4zm7RNH73JVRf9bczfJ83Q58GSujbr3m6QOa0i/4lFkIc65O8R3HFDxaw8QiSD2jLnnBsy
 RirENARin1YVRBgUTCEk2pvYD9+xrIhnYnejlDK/zW+yJxspBf4qf5j4uqugFVQDt24HlrFjM
 AFEjOcxftqCz9FIMO4pSaHKQ4Qj/LOjMI75gmRRFiGx51sU25OaHdUdgnrIjIbx/SAfXbUT0b
 7Va02mtr3ntA9l05bnNGdM8gZspzPnDoyunv+X9295eKzMqLdu/ohhGuf0n5t89JMU/Uc+XHm
 +yGc6dvRORPULWRJ0ATv87JzXvtNGJ+4vtV9uQ+Uk/0IDfEbeeKT/HzTmntaSO/BBWSwEJEld
 V5QjShMVVpU63WRO08Kl6c7ICKi7hU4cLag9lKZx6lEHbm2gNai2snVgtD3xCAauYKtgKuuDo
 9GoFW2928XOSUnG8FSzTPo0ITGPwMS3rwAUYo4IGjMTMY28ahPW78ffsMEOMd1C4DMxJ0jkTH
 zf2nScGewJLart8lHe7Oaq06po1JH3lgyD5hypaIfQDlR72tVEU58fNnjzkRzilt7ZGkolL86
 VwsxsnfpIOcYGcKbJ1K8OqaoHdF9lg4gvxQalqG410Vhpq4Cw5til/CNmZU38PpK9S6HV5ful
 s08X1HjTHC6mglFfCrDBmdqIeWXvboYH9H6KN+FR6f8R+b0kNpEbKYUlJmHSbluCF/vdpX8Va
 gEY6uZdSZqlV7kQA+3gjS0cGmDV8cy30f3XvnAY7ZKSzWOy6Oln3kgyPNCHnFFZIdjeZalbrd
 spJzOKg+vVV1joVAEwQCdufJ2yHNgB+ryjQuxwQx7ky5r9DeCy1RdBc8b662z1FJDlnEXh9eU
 d8LIQq7z/fhazwqUqNjgKHGJ32GMFuMktoq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-15737342-1561557755=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This speeds things up a lot, but as shown in the patches & tests
> changed modifies the behavior where we have \0 in *patterns* (only
> possible with 'grep -f <file>').

I agree that it is not worth a lot to care about NULs in search patterns.

So I am in favor of the goal of this patch series.

Ciao,
Dscho

--8323328-15737342-1561557755=:44--
