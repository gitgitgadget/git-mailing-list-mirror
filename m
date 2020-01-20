Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C01C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5F0207FF
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 12:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WiIPXmzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATMQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:16:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:49293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgATMQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579522562;
        bh=9jCJISvI4XqZ8AUrKYk+ovtJSj90zC3vZSJIXsoLYfY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WiIPXmzSvz3PPHD3aGEQM+Dm8CKEXzT3CvjGFgVJA/0OSUfwg6HhvgF1IaT3AOfe3
         2rSS6mzfSituMd7OZZ8n/P70xhDoVLdtjpcawu6dJKVguqicHcQ9JOPKTOFIPVz5/A
         VTJ7sIkv/Lz+TFxjG8QqnV40yQG6d1vqRdYDe5uU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1j4Kpn0DTl-00Sspc; Mon, 20
 Jan 2020 13:16:02 +0100
Date:   Mon, 20 Jan 2020 13:16:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: Patchwork instance "Submitter" attribution and GitGitGadget
In-Reply-To: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet>
References: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1251200087-1579522563=:46"
X-Provags-ID: V03:K1:YbSfvtSkFRBCfCtyM59sGHoU8+fvbT7Ees1ZOQe7/YUvPr87HYg
 HofAVdhp0Xy0z1q7vhB+CoxLvtHIq5dPhtUi5QF3JMK/KY8Mvn6xJ+zo9dhMMe7SnGnn5TK
 iFmWXcNobcvKuOEiqFuMehF4c+2Pu7typcWWoNCmuZuMc+4k2wskx+CyEN1fI1HEitMEeFp
 mE8qd6hA2gmZk1JJBzxhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aRrqNxwYrcU=:l0Z/ifRu1Ds+FmWvXo6QdC
 tDBRh+VxOf2MQWMIRc5zD2h0msVX/OE6pzGWou3KN/Zg9SHLHiGWcRdJsmVlGBlNBm3oMJ0zH
 BIHJQQqRffj0dPP+vmyT+wamKAaZADZIxeHNsU/ZU0uG0dyQ9sZrxHBlcUXxTh0Tu7yzPgcKE
 aoht0d93qhrRQvi1wAaspr4YFxJ1GyDxTS925tiEecIlHWKl0/h3+d7XjfZhqO4MrxZKXv6Jz
 UtnRRwDrDErrUuTgOu8LcseneiSGZyT5aM+z8aorLl3bdJ/esg+yCcA4/51zSTiVbDDQQXHFp
 nnduX/LVzi7o3PgTaDK1ME2Rw81XkIzoujI3b8CdLGU7kjm+k9gAKJN5s/afQcLPgR3HZAOXO
 H0uxnLNKvNXScF2E290UeHgrSWkoJijGgwLaq6a8jqgZWB8zBncNPWt6pVhn1f3OnVmkRhQ4R
 RBk2nN0JQPG/2b1qA9EjH+tcFetjG0m8HLNgfmnWGSU0Wt3jjsOnA7UqlhJfCVma3TUkkaUvA
 WXYOmHYnqlJqR19yjTs5mig2844Oxe+RSZU5NNuG3tHiGV3JDIST+JQ2KWISTCzfSkbt5zoO3
 JxEGj0O/GibTxZn101qdg+BxQkl1JXEGQmpsWCZrddvXMbRyy21KxLt6BbTup1eCRK+PFSEJR
 yctlLItza8YKLcTgHKL9ZW+AH+os9ua5iHXRLoeCLoHdApBiVPeVFc3nNTlJQ2Gdu3LLntdkA
 nAcwiQ3vK2yHGcI0kj4DvPqI928FvEjG/wNpllS2scLNRc2VKpJvzTdNMpHQVkfSlJC/XF69/
 eIYUgfUhc5Zfw/CPcOdMM9IStUsTGmx9IxYQnocci8WszjRb6sZN98RgnBNct0qZTQKd8+qHq
 p5zKzKTh6xL1ntn1Jh+edTEI39df+8/X9LPG9J9qGzk1sFF25NJLEpKz3gTS5g4NA9Ud0OjWh
 T9RvlG4Id6lGh0MDbytZW1MKMXNHCJwbT4TDUSMJ3Q98JrAPjbOXNxBAeOyZ0Kily4vNHYvMF
 r+PXyI5c3vcLIhUMFR8BbtrP8acg+owOoVnJDXHi0nrDXy2I0RbfeTR4/8F2dUcccpkhf5h0y
 WVj/239L9daEWJ8qJNFQtzkhS6Xfcz/ix4pd2MA2SRpxefk8+UxOcwQcxxZZ0eYk06tKilCLV
 Hl4TZScEPnlyfYTBSnNp+ojDx8ecllPZCC5o4pVZZTr7kMa8Aal6Gz/5S6AX/XAT9j7rsHb6m
 l45iBRNkKVWJKeUcdLtrhdOAxLWlrjC/7VHR7Ufubw8riid+MU8cFQRthw5g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1251200087-1579522563=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillippe,

On Sat, 18 Jan 2020, Philippe Blain wrote:

> I=E2=80=99ve noticed that all (I think) patch series sent to the list us=
ing
> Gitgitgadget are attributed to Dscho (Submitter is "Johannes Schindelin
> via GitGitGadget") on the patchwork instance [1]. I don=E2=80=99t know i=
f you
> are aware of that or if there=E2=80=99s a way to fix it in patchwork=E2=
=80=A6

Right now, it shows "Lucius Hu via GitGitGadget". Clearly, patchwork uses
only the email address as identifier, being unprepared to accept that the
same email address might be used by multiple contributors.

Ciao,
Dscho

>
> Cheers,
> Philippe.
>
> [1] https://patchwork.kernel.org/project/git/list/?submitter=3D182351

--8323328-1251200087-1579522563=:46--
