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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4153B1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 20:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfJIUnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 16:43:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:33263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731976AbfJIUm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 16:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570653777;
        bh=+cyUx9eNl9qm10+ZLUN1GmCXc8Otr9HHtis6mw3FIPk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N+8cwX6EcbWPTW+GiLLvlq0du1FqBdOVkkjIPs68mZhEelg5nIAsHhQtR8SSXauwh
         TddIviJsiDGdtVbvVsmmIr9mfVSTVwzR6AFCulKpZ4EA6Sh5GyXN95dvkDUE7LaFSV
         JfeETJ4vNl1BU6MVI/jhdd/PmslYBdei+PtIescs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1iRbNX0DHC-00Pw8X; Wed, 09
 Oct 2019 22:42:57 +0200
Date:   Wed, 9 Oct 2019 22:42:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Harish Karumuthil <harish2704@gmail.com>
cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
In-Reply-To: <f751705949a7fd23c77cbbf839c081b95b12394b.camel@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910092240190.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>   <20160331164137.GA11150@gmail.com>   <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>   <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
  <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>   <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>   <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>   <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>   <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
  <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>  <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>  <nycvar.QRO.7.76.6.1910071159530.46@tvgsbejvaqbjf.bet> <f751705949a7fd23c77cbbf839c081b95b12394b.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KCkvVhYBX3R/e1RL8oSePUfC1NIlrCJOCjZfDVxzqrZVa4UO4ol
 xRnLpt3aKRp1LtZp3hFGcJ4kmHs9s8hDM36TM5PmvH9e/OmAjqmXBFhTZbKnRvdgIeZjBEF
 RcBv8mpwDQTQak/cP3yrS8jbbvCMdNzqnuspJgsOUAr4uNpvzDIxj/YcV2BIHqIlyIeMt7q
 S2i4NC7URAFbFzg7UBsPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5vFRmEQaE4E=:pe9MLazUmNQ2Y0pGbmN9gL
 b42B2sbAE2gQN0pSr6/WhQ224GhxDZfz5RuFx6oBe0QXSXjuodcUFcvw4ACZILDPo3v218Zhj
 U6aCBAhPC1cP1HAFxmFQQaLnxHJREFipC1zbefOlAQCcN47H/jLiDvpzAP9snHff4AYtuKhRN
 YW7Ex98lWZ1opdOHbHDJpS4ZATc6HPbxfceQrsXFz5qyFtvC5DSvWQ+vKbNV8e86DjYrNxIyk
 24DNyeFF1/TMOy1smaeNNjIF76AEdqx0OwE2yMGME663vmNrVS7xSjRkfwNH44oIHiyoReTo9
 v8uoNAVfXJ3g4FXr7mMAr6AuQU+x1/CbQwO4q3XZH40tCmIBOFmwr8Qyo1aP6Emrs7dilf9zh
 7iQ+jy6+l45RKUt7rNsGf5tzqbVsflegw6GnAP4/7ffmWmS7ZOZhyHerInXQUDLJv3VBk+P6w
 0HV4EHREp2QOZ67w3kwgkRwvxOf51Q+gKE2MdLrDMATiHoEzXQ7Jzvqb4db7NQKqhH5yf58Pj
 PKMcBND66MieUYrNAWc8q7vVq0Pzwkf3V8uDb3scF7G8JZXnCnp35Gv58PZhUJqyF9Mw9IKmL
 Uh0Bk9unmXcCoh7Ktp4AJeGjuGi5/ONm9jXEtgUuD+ZaCH59mNKIu16zcmZNih6SctB/cFTAm
 IVL1oCISvlYwWzD6qHCgKjUutp+mo0QVpVQeVieSUDFoEZjaWa+fPryGOliAe9KwJsault7O2
 pzsVb/6nuCW9OrXadYbav79jB+zyNCt/UXo52YmS+nE5msBdQ3g+SsGzREVH4xNDe7cXBiriI
 E6L08+uTVUhQWRjFzo6ito+tN/amsh2d1BYSiC7f0tPUtVjKWzEtLXxe2UoDhX/WzEkcCdeBm
 q2t6R87yZoq8yXkZbDidsJc9LnAHVzKi545cZwRmhvm3VJyCjI8hW9rfj58LpsdJSIiAXxX5B
 BQ51Tb1HiYfbz8Np+jjAJZx1pGFeHo39qyo3VuRIOoUA/zH6WFknnDfoP9IkosY4Zn9QbLVP4
 q8TccP+8I1aum+m0GdYfQcjL4NBWJpJxGYpo0eLqC0GJQDlddvTsdIbfnei7MK58AzVHhVuNR
 gedAVTlJoSHXFzoembcK+TVUi31+kco9ePwXxn2+biNDBpEK/8+Z62wOuA3FOo5lIc1qQnvYm
 MqfAQozLxDo5eVDT2xH3lEXVQghTN0kuyp6SpBHbrJQKZCmiBKPXhQmHBBHiUBLw+qFtxEvr8
 MLqlpebkfKF8kthlWO4KM3IXt3SFQysz9W5CYnkF/IxLFW9cYtETdW59xS1E=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Oct 2019, Harish Karumuthil wrote:

> @Johannes Schindelin: In short, from your previous message I understand =
point.
>
> 1. shortcut codes like "<Control-,>" will only in Windows platform. It m=
ay not work in Linux / Mac.
> 2. We need do translate shortcut codes somehow ( using one-to-one maping=
 ).
>
> If this is correct, do you have any example on how to do one-to-one mapi=
ng of a list of string on TCL ?

This took much longer to find than I expected, probably my web search fu
is deserting me. But I found something: `string map`, see
https://tcl.tk/man/tcl8.6/TclCmd/string.htm#M34 for details.

Ciao,
Johannes
