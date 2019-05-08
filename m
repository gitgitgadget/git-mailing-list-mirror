Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B7B1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEHLeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:34:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:33967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfEHLeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557315236;
        bh=nb9cHQkAda+kvqMKVR9eGMaMEejAOAL+J7X+lj7kkC0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QVBjV+yL1WH+QFNwtE4YMB3MK62ma4CDGX0VGB465TlCsTf+DOIMg8+pfEX6lbGan
         t4OnALNqx7G+wImfM2pS9W9f20r+aeeTLamZLhNFglSifsZaildu4kAlqlOjgnr+H8
         gb47g3sRQVn3IJOji7qdEmzm/jAGS8aAvt7aAOZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1ghbdJ1I6n-011DOy; Wed, 08
 May 2019 13:33:56 +0200
Date:   Wed, 8 May 2019 13:33:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Alban Gruin <alban.gruin@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@i10z.com>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
In-Reply-To: <20190501233641.GC202237@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1905081333220.44@tvgsbejvaqbjf.bet>
References: <pull.134.git.gitgitgadget@gmail.com> <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com> <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org> <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
 <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com> <20190501233641.GC202237@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-763959945-1557315237=:44"
X-Provags-ID: V03:K1:IPSg4Bk5z9Aj7jcT1H9y78mAtdiv80whwzft6vusjyPW15D+eXa
 RBXxcnfv5JtAe2io81KDbsZeowcyvJyuIoitxqHpuBj5wbCPMS49ExfEm1TSb4mKWa5YsJx
 LWrdeTzmK8s872IcUg/gxHThR+tCOKFfcwbXDVgJny44oO+kPMuVmSzlMhu8FndSGIo2H0T
 BrLyg3YdTlR3NZRJ2wbzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GtX1P+K3eu4=:7+sRxURLXgxhObfAYl0rlc
 D1ZyJEJ4svsTVKwzkxDIVp6Gdj4RNdb7oUbvQaQ2zWTiuYLN38HWGKQ01qLfe5gb2zWsW9+PN
 saLNGtI9o6jeWtfabNKPqGu3xU9Yr58GTC0cBaw5FiwvHLlcc9Dn0x8RNMNZ9ROJlNx9etGa1
 OTXGE54BqQzLotJFC5XcyMirPz3+yc7R4beJG84sKpQuwY2gZQ7ZLL676fabyiT5qcfNN/ZDH
 n7Htf34g91xJSUJMxQSWgxHo+rOOZfzIn/7Hf5ery8xcbIKK3/W4gJtnTmtlTfpdcvz0yTooq
 lukkDVAhRnAIo47sULNaNh2PSee9h3hKR6kOJCFtCPQjJxBpiAKvnlY21quZcWpG5lIO+5I3m
 iT0OIz1JED1VHnFDHSVYvJIPlH3EsDvvhwfcVSNTCF3MVy+jJGa5w6/L/doKnxisvTbFzyPFZ
 zEgWeyOEL2X3IczbCrxZ0lLSf9IlKMtOMGkVTS1JVKmpqRCyUp9RWoA+iNL2iHPsOLCxWD0Z3
 z9W4TTv90luYusebpA5R9fa4F8tmlTlDBY/Gd8ANlXEwQT1n42nyjgT1LHaxeQzvCnGQMJC5/
 VYjLb92SKJk/cv8BDRr2w7rXuJJnDvRnsEM9DNXsBOoadrZUwKga88s42UfAre/xNuwTKK/bD
 yieqba9Yutqw/m/Zd4so6SITZ7LhQhDXdCppIld1S8VEfafe81NjeDb1Z2xCg/F3uR9qxiId4
 yT9dH7LKrEbarxvlLTJ7yM+CbpLdNrI3Sy8vv0kP4su5I95ueDf7wJGqU4rLPR3M5OZsfTM3z
 Kk2B5Ev0eAAlM85MoCyyDfDa36otb/3cg9zTIrcHBp3PmAt/OP1iHc10PdvseiNmj0NqAWIXw
 TX6D+ZLGJlmcnKaC3/5HKi1j4tbhZjge8OLqOLwSx9KFS5MLUkSMCbFurxtlYrSQpltuYfXoz
 V/eVoX+d9ww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-763959945-1557315237=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, 1 May 2019, brian m. carlson wrote:

> On Wed, May 01, 2019 at 08:39:22PM +0200, Alban Gruin wrote:
> > -Og also exists to debug[0], even if it=E2=80=99s far less known.  Per=
haps it=E2=80=99s
> > better to check for -g (and its variants[1]) as the user clearly state=
s
> > their intent to debug the resulting binary, rather than checking for
> > special cases.
>
> I can't speak for the Windows folks, but Debian frequently builds with
> -O2 -g and strips the debugging symbols into a separate package that can
> be installed in case of a crash. So -g need not be an indication of
> non-production use.

Precisely, Git for Windows imitates this strategy.

Thanks,
Dscho

--8323328-763959945-1557315237=:44--
