Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF0A1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGCNBR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 09:01:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:33333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCNBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562158875;
        bh=pWnmDDhLAii503U6u9AyFv+htBDzyQc78yoar8r85f4=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=KedTcj0bIyPuZxqeXQnAuq1cJmPnfmUHniuzhPWvJiqXmr1QQXs4TCU6RqjYKftbE
         rdONy74AO8jd48I+q/OcWBLbEdj2ngwSvdLX88jHbaT3U8Il3Hal1il41zUqbvQTeE
         fse1pm+Qa6eX6RK5hPup28jmGE5BdrJNwxD9aSmA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgZRV-1iLGta1C2H-00nz96 for
 <git@vger.kernel.org>; Wed, 03 Jul 2019 15:01:15 +0200
Date:   Wed, 3 Jul 2019 15:01:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Virtual Git Contributor Summit
Message-ID: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m12FwU2WKLZIPOXtEtlVtRWKNSM8tBpJkX+M56k3QOeOVNT15fw
 43Hxu9eVQrrpXe9EhvDzDa4MLPWGFczm42MQ3rASzGYLJCDaiSYERFrqU/3d7PGbXnAubOa
 k2E5QpRWBS9qkYlZst5xqsy9c6wB/WkbVvp/4T/Aa9LVTmKMnA4FG+wAj0yMBvBkZYtqi73
 OiP40czjb9wtlQYN1AJqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4B+L7XzezYU=:G01w6lgGQJuPUvGmeI+Ztp
 FPrqBRq5BpoSewYMsmjp34wD9J5XDiX9Szh08dpCXW+p2WIZlLZonOKUlyfNzmpIBuewDj1zo
 dM9/0UTpyfHCOwH6O4+PArGGcSK6K5nHfcIcI9nrIXV+W4K0R0L98EeLJk2FUEpKGmKvxuWot
 +o8fZSbA0lXVwGkH3jiD0tRzLjlUQUqIIW2+miC+synyX3GAO+wFlBngAk/MqnXu9H0pFiPbr
 rgD2ZPc4DSmSdwgoMgezFhuhv17UHCndJ37ui4sNGyzD+IE+0SrrvQUAlRb6uFZwrSaxlYGmO
 dvUh23kk5AnLNKciHVWdNM1DsRy2faqBL9tcdlptwN4Wx3pxrFB72wHPH3ujcUo1WiCDYUg+M
 4g3++O4H1S0MU28VwC0vm3Q4/bd0rrCNsOU86/2VV3VyVHc1ABSzn8Fsmp//1fr72Ro4oNOle
 vzF+LUwbw1R0+BgKJwAyW/EKwCODUZPBvvA353bXjzGu6ae/nZDXaEmv7RX1OVgajf1tz1HD0
 htelSLpA9W5xRLHphzmNBUhBtiiQ0Yb8++FPNEU3vL3ZgJs9sOBDnlbTv9X+UDdcjQ8Y8Tclk
 LhxjwgF3+qYs7zEfgf02Pzdzswutk5KJ5ydr1w9TVmvs2TLyvu/UCFRgeZIT4BaqdVejQhUxy
 BsSA5rWyaaL6kDiOMZkO/uSgDJkPQTnnuoERe0MIsziIaeVn1ytXIRyHXXbOVFLbxO6CN1ptK
 Jbu/9klE32JTX0Xu9T+cKhYhTOx3gqsRxqUForYohqnjfZ7dwHwamB5Y/oDGO4lJCQAIT/yw9
 mra6aaa++NF64mjmWKr3NO6+3iJ1lb8ll2JwTdlBAEblHN9jcNoCkqQZBLksq72KezmIKwwYm
 /100sOaDdXP6CbYq55drl6tbWtHtmlDN1pqFJTf9nurYD3W7b08iYrZInFpwmiLlhr3NIrU9Z
 cbNAVmlTEBbzz3k/2/zdfioXq2KQ4KMz4D+oMQaaae4gLGqKMsWDojXl5TP+BF0VGql6vlcXq
 0N4/VexTpDjTgYWyTNDA5qNZbarkrhicNWsfFh8upOh7fw/gaMc/QVErxFLWFbGTUvZrWMF83
 DRigSQ6u7iu6XhqQ++lyHg3RMczqHLOY6pd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

I kept talking about this idea of a purely online Git Contributor Summit,
and it is finally time for action.

The idea: just like the Git Contributor Summits we have on the day before
GitMerge, but instead of traveling to the same place, we'll use an online
conferencing system.

From my point of view, the main benefits of doing this online are:

- It should make it easier for all contributors to attend (yes, Junio, we
  do miss you every single time you're not there).

- We will leave a substantially reduced carbon footprint.

- There won't be any jet-lag involved, including the consequences on
  health/sleeping.

- It is substantially cheaper and more sustainable.

Of course, there are also some challenges:

- Timezones. My idea here is to have all participants put down their
  preferred timezone and then compromising on some sort of Median.

- Timing. As it is not attached to a conference, we are less bound to a
  specific date, and that flexibility might make it harder to agree
  on one date.

To alleviate both of those points, we might want to consider spreading it
out over a couple of days? I already heard some fierce opposition against
that idea, though.

In any case, I think it would be good to give everybody some time to
coordinate and to shift work out of the way, so I propose that we look for
dates in the first two weeks of September.

Peff kindly agreed to use GitHub's Zoom license for this, which should
also make it easy to have a recording (and not having people in the same
room will benefit this, too).

To coordinate this event, I started a Google Spreadsheet where we can
decide on timezone, date(s), number of days, and later on try to imitate
the sticky game with virtual stickies for the discussions.

I will send out an invitation to the top 25 contributors (according to
`git shortlog -nse --since=1.year.ago`) after sending out this mail.

Obviously, there will be more people interested in participating; Please
do drop me an email if you're interested and I will send you a link to
that spreadsheet (as I do not read my mails continuously, it might take a
day, but I will, promise).

Thanks all,
Dscho
