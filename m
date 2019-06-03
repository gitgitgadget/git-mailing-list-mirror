Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117F31F462
	for <e@80x24.org>; Mon,  3 Jun 2019 10:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfFCKOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 06:14:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:46903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfFCKOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 06:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559556852;
        bh=ByL1+EmKxSHmVtFBLVyfvvpXn41xQYozXFRzwT53ZuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VBPwApaWdNETeJOX4HrIODinvzaagKUran0JTmtgAuljCbc4HZFwgKwM/yi2hD7nw
         uHI5mKk1iUBmlaAFpF48TWupHb8ZmRYqivvlKSutKZ1ea5bP1tJXW8Foj9ele8AJjw
         HfZ7kWtx9P8TenL+cwPZxWyC/Jpbqwv09Vp/d/DA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1giwg73iPY-00tE4R; Mon, 03
 Jun 2019 12:14:11 +0200
Date:   Mon, 3 Jun 2019 12:14:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeffrey Walton <noloader@gmail.com>
cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA-accelerated Git
In-Reply-To: <CAH8yC8n8XN1wKiF4FgTm6xfnRHUDi+1=iuWXE8F91P=7mLNsLg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906031211470.48@tvgsbejvaqbjf.bet>
References: <CAH8yC8nMcVuLeLWrVumLaz2Pbi3GugzgY-Bw3SMipjJkaph85Q@mail.gmail.com> <20190602132150.4c1b320f@naga.suse.cz> <CAH8yC8n8XN1wKiF4FgTm6xfnRHUDi+1=iuWXE8F91P=7mLNsLg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-514479594-1559556859=:48"
X-Provags-ID: V03:K1:+79XLMI7eMkGzHCzHQFXtG/K7S/wC4SHhQo0tOt7T/a+kzYczRn
 z/KRf+6MN/7Hb0giXjxkhkTSosbKbQWvJJt8LgVv95DcqizIJqOBuSudnr0kAAFpIfOM+Fw
 aLsK+WwTga8ge7T+G5cIRnEmBe5XfxFwcUg8z/yyx/KoW81CLomWZ11biDjwT9zkjf/SMVK
 TlBxfOE20TfydsnAn6qog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QyWkpCnlw7s=:Znq9vJPRj0foFmYuD1uGZM
 bktzrVBehSWveOl4poRcE2U0/UjJPdoLtSsZLHDkW4i4XESr8ZButaGoAUsZpkc4PiZLc8tBC
 htvqHsSOkgL+AaNWLMXLCjO9GBo/J4evbU2l+NSWiwx6uZ88IgdKUBB7jjEs/FeghP6LAtLmS
 NidHLvsWo7lgiefNCAZO0PwRsPKorK7YwDVcX3v2vM2NWW6fcknYNttjswsZAmQzrY/k9FOXQ
 gR4LTEBNhRnS+hUxCXGHKP1T1mkEDgPFmkE6iC6koNCivgdjNM2h/GSy/pD6PMqdmof82Lzcl
 QHgHwJ77rHg4UKzLxuuCEJF3MTs3y3D32iMqB7aoa9Jq9gS5mnfFg5le3qW+Agw5GszGuKDv7
 nJ+ER5qpy4UjA97LgyFyfGPTNJCWZl0xI/7YbOi7AGxatN/vD2hrm0ybFa24OoGapMzd6ghlP
 qbzqeemBfCzPRHN8Xtx2r3eNqUioDSu2ljaazujZBb6Z7+STezSClRDQN7aCzrFzgxEqCjMzG
 rsVs0oMAsZNnm/40nAlzomtdMrOJAamw9lVYzluIyPIUc/3QIkpRv6HpmQWa7e3cOafVcP5fC
 ztWnkwmIdbfSGYaRzP2eIvHC47x9WiZbbZ8V3KjCL9Edj4Xv4e9HFCG6ybkJeeXB7m6LJ5iH6
 Yvol1cLyuzcfNr/RzzjdDUqklni7gZ0+JcsvY22wGCScpUwKY8bMgh2ouvD/lUn/IDlFpE+Mb
 kvtjteizfg0RT0x3TnJ8CcDczKgM0vdzCIAHck1tKPR+lY8PpithEhVNmU2rPmTbE/KXWE1RJ
 EMQF2htHMs34HBn44NBs07YDRxq0QO6LVsbHZn0KR3EdK5psLVXZrkgTVdzXWrNDgrlDcui1f
 x0dD3WxeHKjlxrni4joJ6mYsUdM0sq5xQ3Zw+r6F3coMTb+TOcH068r+MX67QKOaEEuNMfiYa
 jkaDtPctOtqZWt+YvXc+6lrBo8ExFgqW2I5QERLJaXvgMqb8Q/ne0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-514479594-1559556859=:48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeffrey,

On Sun, 2 Jun 2019, Jeffrey Walton wrote:

> On Sun, Jun 2, 2019 at 7:21 AM Michal Such=C3=A1nek <msuchanek@suse.de> =
wrote:
> >
> > On Sun, 2 Jun 2019 06:43:07 -0400
> > Jeffrey Walton <noloader@gmail.com> wrote:
> >
> > > I have a lot of experience with cutting in SHA acceleration. I have
> > > no experience with Git.
> >
> > sha1 is dead. Git is planning to move away from it. It will not happen
> > overnight but it probably does not make sense to accelerate it at this
> > point.
> >
> > https://github.com/git/git/blob/next/Documentation/technical/hash-func=
tion-transition.txt
>
> SHA-1 has been dead for years. That has not stopped Git yet :)

Even worse. Git has changed from an OpenSSL accelerated SHA-1 to a
collision-detecting SHA-1 (sha1dc).

As long as your accelerated SHA-1 cannot guarantee the same level of
safeguards as sha1dc, there is a negligible likelihood that your patches
will be accepted.

> Comparing against a standard C/C++ implementation, Git will see a 3x to
> 6x speedup depending on the platform and algorithm.

Indeed, this reflects my findings.

It's just that we struck the balance on the other side of performance, in
favor of preventing possible attack vectors as best as we can.

Ciao,
Johannes

--8323328-514479594-1559556859=:48--
