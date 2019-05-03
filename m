Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A861F453
	for <e@80x24.org>; Fri,  3 May 2019 08:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfECIdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:33:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:58069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfECIdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556872380;
        bh=/s1VJmWaAzjxEAJiHzxyy6LMnqfbYDOii5E0NU6wNIA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HDCGOOxXVFBW5rq3A2JmCRB8P3pE2XqGeyTwp62q/RtUi5w08GSLwxPNih/LE3D4/
         n6ACj21posLN6fJwWygT5XitGceTObrCmclz4gh2xWRd2aZhUM98DeLkK9PHy1vdWI
         6yVVVhjYlSZ0I4cmsAHoiQ4xOEuPw0NeTZJ6jej0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1hD1iA045S-00QzLM; Fri, 03
 May 2019 10:33:00 +0200
Date:   Fri, 3 May 2019 10:32:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install 'libsvn-perl' instead of 'git-svn'
In-Reply-To: <20190501231854.GE14763@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1905031032030.45@tvgsbejvaqbjf.bet>
References: <20190430123724.16150-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1904301816200.45@tvgsbejvaqbjf.bet> <20190501231854.GE14763@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-916072089-1556872380=:45"
X-Provags-ID: V03:K1:DkXqJRyyK+cAUb+52OMARRU4ZnMPnIvk9Hxppc1Q3xrrm+sT9Vf
 PZAQhrkHJMCJxIl9W2LZpa7iPjdYAPhYeB/i14wdsRWfhzZBP5u/hUocnXwEJ0Zepc2xmRl
 Vo6/kFdI+a7XCUaMGV3+t0Z2GZm+UbAQTBrx5BYNjBTxG/DjoyOlxRBw/bLxYYzF+3lIaYZ
 Dc23h6MnjpUit6iw2b+2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQoRl6wF1cU=:6C3N2BBv8v+93pw6VG/WLV
 1AqfcBuyUacQ619SAzsoKW9PYkooPx6k5/VecUVhv2+ZPb76SBTMA1DDd7bEa4VUgBxOsQ8ZK
 PyMyiPlWN6ovgtN4i5w58ZvEIyYcJZ8if3Ed2TOzFr2mvXNDU3L9a30BTLSPzylx8dmNyqw2Z
 sgJDnXHNgW1YO/7MZueRK/wTEyj92WXpPdKkok+Rh0J4LgPJmY9X7w8Qr+eaRBtQ2Xk1OahdH
 aWDuTY0Lv6yb1U3V3LljmmroMBxAuwe65wY1UZscL+/2z9SiZ3KSrxQ06aQ9ToCx/CH7BokWH
 HphioIeugMZoqvAaGLt7kue17KHDY/ogQJ648yUQ6itykrCCaSH23S6zTAoYt4pmCMgWmB9j3
 HXinYBMRlTcyUzywhmdNi1LYsfGSQurSbkR72GvkZpKlTdviwEwZ+E2sVFNQU1tEQfuBQvB2L
 0ArwGsV1RDwOCa7Wc/fa7eUiEisOHVHV9d5lgz9/1Fqk4VtCj+sTVHcq7Jph1SymswpJ+zQ5x
 EUinCSpg3zfDKok5Tuxp6qfoMOc4qk83yQclRu+fO5FDE4CuUkYmiA1CuDg9ys/1RHp25ZKfv
 MQxHHe0hPXUpApCHamjvW6DsogPahrJ2R7cmM9sGhp7/TSjUz8efj6FP+peyosFkxT6KVeyMw
 sC3OrhQ51XlfBjjFqvZghXsmcvgbCtsH2CTznnhNh5VrM8gM+jbvnAIkAttLuHS8O2lP+NRT3
 D8pf3ba2FtPH/tnalatZjTQ4j3GBYxsVfVd2q6GmvtnsJLAgvdUS77QmOjo8mxza5jAEz3ack
 8tlNLTqgVCis1znvK9+OxRHZ5lnqpc2w0YmgukxNXL8yJR+M5lBRxoAC17Chm4NSWddiSJqLu
 CJeGoM94WHN+0LTW2opTrMf+UprdZBxsXVL5cPWViSBX2tY9EmApreCSev5R5NmbIXXMzA6LW
 yY49rHRgsCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-916072089-1556872380=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2 May 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Apr 30, 2019 at 06:16:48PM -0400, Johannes Schindelin wrote:
>
> > > [...]
> >
> > I assume you verified that this works also with our Azure Pipeline?
>
> No, I didn't; only on Travis CI's 14.04 and 16.04 images and on a
> local 16.04 install.

I guess we'll find out once things hit `pu`...

Ciao,
Dscho

--8323328-916072089-1556872380=:45--
