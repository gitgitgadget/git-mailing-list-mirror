Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C6C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8DC61424
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 12:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhDUMjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:39:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:34457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238336AbhDUMiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 08:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619008690;
        bh=kLP4Xb40n1/xJrKCChuD7I2BqfJNvH0LtYiVkL+4k3M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jorz+mwvExozi2VwCCwUPgxTk/XFgPpXw6JVD5u4xbFzAakGMMrS+oSmJgkFGPnuZ
         dlBu64IGTydWCpIWXvG8H+oMdAcHCYkyAC5zbnhPi7KPgcq3nayA1xUdhZRXgxojfs
         tZFDs1vePpkJoY1x0CCliXGO3I5HLrh0wFI75fx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.215.94]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1llJb343kS-00C7ji; Wed, 21
 Apr 2021 14:38:10 +0200
Date:   Wed, 21 Apr 2021 14:38:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
In-Reply-To: <xmqqzgxs4sed.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104211437040.54@tvgsbejvaqbjf.bet>
References: <xmqqmttt7q8f.fsf@gitster.g> <nycvar.QRO.7.76.6.2104201748400.54@tvgsbejvaqbjf.bet> <xmqqzgxs4sed.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WDaDoZwS1NVAagINAI6/qCj7nSXjOPf3eT9hHFDZMG8To4dsUVo
 owgKthQbTTMJ4cLy/fRFVA4Y1DR6jHGxnEeBibHHLQoHjE0dbsll0ZptMT3LZdRz4t/yYn0
 uJTdsySenVjsggapFd0zP8yl3LBMzHZq3GvsUxlWcW+UG8+0h+eGPrqR0myJafFnYSlskzO
 xjb7656B3Xr8vi/D4n+qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OzgRUREqyt8=:iSCi1uTi67PGMqQD58Wodh
 UzTcKhEdpSek5e+Q2qN/jkeKikz1/NOJ4Z8SH1QVeU6IxQ/VrxhHUJojGAIosf0CNPAY048e/
 iXZNLfd6TCCoaAgg/FNv1D/Vy2W6N7CE+CAThylrgCdzSPfE7N+3PctIpjVruwv2+DHONk5Lu
 bw2ZQYr7mmOAEO6hw2VLxLZp1GcTqXow8ib7JQVk2Rh6fbWMo+TsB9k0o2X6Ytx2atCcibAb2
 VXipnst+l00A5oEDxHsT6ZJ6ziFzF9ykKfY1ZwEq2ULsAmHI8obT/qkFFsg//Xs4ycn9L5MGf
 5B6s1eg6S3+Ou5zumLtv61STfcUklLJVSp7jviTMMGonlhm9YWLyWGgMRfgAF+9HePO93zUhY
 SjAgMJz0OE87EJQ3Okue9xQfWjRNQ2NSYpAodB4p4YH8SIyAmIUnJHoTx0Za+b9kf3mLiDBIg
 A079ZSBmU4KfesIu6bp88Un2gDYJ5GJ5+wJOLrHIOil0ifV1y2W+WImZhmXQjqy9Dmmugdyhd
 1ht4B3EIeLwGrIJIkWxmAtsDNHuKpbdTMhTFI1BCVnGzYXB0vABTSwWocxATdvhOP5ZDPFx9u
 q7iWbILLrbnf3yn3wHwpAwvH5Yim9TElSrRe/gDCwgjBFux6Df/e9n9+mw1PJzRSOqksrMN8T
 w/RohDov9IShdpA+GQShRghPR0ZLnpgCakqh/jjsgeM3KzgINIfQNCsqqZB+UmCZe4WBhRTvL
 ybkVTEfwvyQI+aYXMthE/00nOu5QAb9UaxoCeFRBlTdzvKmivpFsT+M1TZPiYSu+2FT2zE8yY
 fSp3nbeDaSjQVyHzhaZfuAzvwkN+gmo6ptkTm9G8/0/7OALb1L6QCMkOEv30JGiNJu+x0E4bk
 6xQDSfJ+MxFgY2gciJZahH12V3zWfux088+I/fjlK569zwvX0adQby9a6KhoGjpVbKVpy1+rB
 xD39ZD+oEkGRj0ZRT4XlK9hY3bj2VcUBrMyEtdY+5cMis6gtNRCJ/HTZUGfAldtKudl2NbMJf
 9ha6PELtlxn0eGFgDTARIrED+aVZXD4P0oI9PSn13edm1k2IriTD5DXAzGe+10DQDbMYPltWx
 h6TlEzMH8amPHipcLtVth3nGzSS/MhJUYT/gHZi8hICf83r+j38knGl0a9nUfOCoMGZH/g0FF
 50UiydchCLavgM0oY1IsSYBA/galQrNcEaSSe+w8ApxrHFVcI1zg6zU+vXmtrIaYImS4gGKK6
 NbbwiQML1yJ8EuXMC
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 20 Apr 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > If you click on one of them (such as above-mentioned "Codacy Security
> > Scan"), you will see that "This workflow run has been marked as
> > disruptive" (see for yourself at
> > https://github.com/git/git/actions/workflows/codacy-analysis.yml).
>
> Yes, I was the one who "manually disabled" some of them.  I did not
> find how to mark them "as disruptive", though.
>
> How well are our refs protected from these random "Actions"?  Can
> somebody spam us with a pull request with a new "workflow" that
> advances one of our integration branches ;-)?

The GITHUB_TOKEN that is used by the GitHub workflows is generated in two
ways, depending whether a PR originated from the same repository or from a
fork. If it came from a fork, the token has only read permissions.

So I'd say we're still safe.

Ciao,
Dscho
