Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7483EC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 14:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLKODp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 09:03:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:51701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhLKODp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 09:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639231421;
        bh=fZQlIyVe0ZVSwZwjo4DtABx13DGwUCT04zsHUVMr21s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DxytJ9qXtI3pCNYNa2PA/9WJJ5+hR8lGCHYZnPNMpUXi03Atk0z6Wh1lkCJ2d7SuU
         4kMFj+TVXZvG61iAsWDDh3u0ExOTff9/AqoGt5bTO1WB85u1QoaB1vsF3WxqexTMMx
         aBEk4LGZFQ1mgrp7bGd7tA0Hl7u9FF1E4cU8kNI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1mlIO42JnV-00Fgv6; Sat, 11
 Dec 2021 15:03:41 +0100
Date:   Sat, 11 Dec 2021 15:03:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Robert Weyrauch <rweyrauch@firstam.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: Git and ActiveTcl
In-Reply-To: <BN7PR08MB4993D6DAF501472017175C65B7719@BN7PR08MB4993.namprd08.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2112111502210.90@tvgsbejvaqbjf.bet>
References: <BN7PR08MB4993D6DAF501472017175C65B7719@BN7PR08MB4993.namprd08.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1327625447-1639231421=:90"
X-Provags-ID: V03:K1:42flMLhHPAwixLZ0jYaDcqYgIuwcDc/kmASQUD+C5RiQggtpe+Y
 rYhFs3Txqg5MjYsfawI9LQMzjvZpfEiNqiAvNGhoOqk1fDsenk6XsOIcszfDSZPK9djUAhh
 mgic8mXhwIvnX4EBQ1izf5DI9mbH3cvHXJS8lOKgDs5xcafmwIU4lYQkCbN6KtzDDdCuvu/
 5fQY/nhl9rXaH74s268Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ew69siBNqIg=:sKhhlRd8QpUWTB7bQABxZD
 dW7GCy6+/OErR1ZIH/jx9bHkLHV9Nk/KpJrFyHBg+fedd9uHJfkN+oZ9mGq7ZjZB9Ph4v8fLA
 AlG1cWkUVQQObSJo3ChCiTmK5GIV9KBcBWn4ZQ6hFBTVQnEkDvjTrCY7pUoysmRyTXfrrUlxN
 WLhfhxK3AUJgG5DPuYCLPQ2Crs8mDsVHC3FiSjUpmz1ANMAoC2mnuBm+BkyO0oDcih9mCqwpc
 qUIwwiSQ2bjCaKDMnL0lV5nTySZ9Z+n0QYlCIp5f9MQipLu6ykUwiyaTYD2haeYAGh2YjpJDo
 Pyttwje7WiS1HhGufyBJwr7JvdSTOxlZDJm85LReRfbF8+wJAk0R6J1hgiYdNeY4rZB4nY485
 gtRjzWhpijjkWuM3eUFRd/RZd9xiGg0b+m+yeMNjkwJxTHAGHNSfqhKnUeP9RYni0z5fSZOK2
 4rF9OKwwzjUOqefuyFs7MZ72q25ZIRzOGevohAl7nBvCBXYZRoyuq4m3EFjIX+FG4ommyG7Od
 GneCVst0MteZVDHGxU0TLRz1G9vFwIrX5jfKncr9urdK57wSLd08l5G+Y19wl05D0Vj/zmDXh
 3J3fJuAU9niI8knVcOWXETLV2IZjr5G5RTNEXLK4phcAukM3u/HVauUIXC4fS9d8MAxDLBJBQ
 SEOEvXTVVs3ulv3nVlDjFFoxgiheXaolq6T/sodkkpSUKYSE8R0o4AwE/RPXkGEADUbaMKz86
 iRMbj6p41hOlE+zbWQSMZoq9+9dSAs09FHHnGCv3oevGPLO2/9U3e6cF7qZW01kb6k9RJfXjC
 gQHuL80bJVT+PhQOIxwzvjp/HRpLyxo4UvilcvM/vxv0ogndr6g++Ljiaih/DuuHsgTttopzE
 PvpLBSBMjalZ/Qz8qxwSXOrbMu7ftkJ0+6pKE5RRzJkDRnlSZwaKtLI8F5/u++58ucJEfq+Hk
 dpWhIYYse0soOSQfe3T7rl4hfO+ycTGdrleazvWeneEVLVvyOrbiQJuzbL265UsnrFgTi/Mp6
 l5QvGaiSL2/NsEY9rwRHABEvT98uMZQ74W8IOzeenn5aKoqWEhhRHYx43MbRXuREiq063NAs9
 ndbIwRNVxuzawc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1327625447-1639231421=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Fri, 10 Dec 2021, Robert Weyrauch wrote:

> In June 2021 ActiveState, a provider of curated Tcl/Tk, Perl and Python
> distributions, changed their licensing for their community editions to
> require payment. I would like to ensure I am complying with these
> changes.=C2=A0
>
> I am reaching out to see if the Tcl libraries used by Git are those
> provided by ActiveState (ActiveTcl), or if you use the vanilla tcl/tk.

Since you talk about ActiveState, I assume you are using Git on Windows?
If so, you might be talking about Git for Windows' versions of Tcl/Tk?

If that is the case, the libraries in question are built by the MSYS2
project, and not by ActiveState.

Ciao,
Johannes

--8323328-1327625447-1639231421=:90--
