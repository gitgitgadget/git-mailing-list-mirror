Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34247C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154A960FBF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhINLe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:34:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:34319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232079AbhINLeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 07:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631619161;
        bh=oAzeG6vdxzpoVmw12vn8kCMx6fxE0S0U8VDsBXV5UTU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i4Jg24kZkDqjf3EZlP829jF+OHoTPtR/a63wGiYZTjv9b0z3o3N2Fy0f5W41qQvhd
         JEvmkGPKTlfv3VJmuYp8Ktszew9c+o6m6yFtaDn0OpgR+LJlBEgfGWHZGVmEXSoadr
         7lurCNdhyfT9xlV6khSenzmY1tiVtMdaXUoV7HjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.53.103] ([89.1.214.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1mO1CK3bSq-00X7BZ; Tue, 14
 Sep 2021 13:32:41 +0200
Date:   Tue, 14 Sep 2021 13:32:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
cc:     git-contributors-summit@googlegroups.com
Subject: =?UTF-8?Q?Dates_for_the_Virtual_Summit=2C_was_Re=3A_The_2?=
 =?UTF-8?Q?nd_Virtual_Git_Contributors=E2=80=99_Summit?=
In-Reply-To: <nycvar.QRO.7.76.6.2109100149410.59@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2109141322060.59@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2109100149410.59@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1207272072-1631619161=:59"
X-Provags-ID: V03:K1:HEL5aRXocT6xMYy4iJpq9Q3W9n/u/MRAXLtwhIEUvAJpcIxF5fa
 fkyfUggfC0k3Uf02bRALVbRJcjbt0MukWFjcafk1X70EN83SCBMFRA3UO6fIUOUbF1GSNBD
 b5uOeFwO+43d5o5LdL/2s+KuETz3LBRDTNKa3RTTr+gk6PLJj/oieF8d/mykC7sSsCgcVmR
 sbm9rj1i5pqVcg8rqa/yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P/QpYUsGuVk=:nGR8qy5hOSuzbQw1BMRpQA
 jGaXfP6c/f3OIBh/8Mu7deN4OTRb7WOU3+146HVfIyeK+AUa8lhlmBkrdC6TjGpOta1ORIYZj
 1k7vtq7kT6sTBaxsp0VN520Wd+GbDF0pQTGX7YLARe0FefbfxMdsrdblh//t2h2vNXUpS5khA
 dA5avjhg9oTonZCEGaEQQ7M7Yw6Y1omfSjEX8+rc4feSxhhs/Bw80N6e3p7H08fvUJwJmj2V/
 6QgUI3bE5IY+YcpJH0m/2/UpyZ76DSjMV/3Z4JiqMA08LDwu3sBmhLFp9vWdJMu+xJwatre/0
 NTLnwC5lwaQagNFwiz2OOivmpIDECTO+V4pUqVbXNZ8MUk5zHTzO303LJC1EgJkbkrac2UWs/
 /bU30RM7P4UI8DH1M1gFt+M93xBfAhxM/W+HV74m4N8f7SYY8AMeiPY08hMcZfB8v9X77xXP7
 LQVrNzDc0tNguls3fEqDG1QMYm3OoByhzQL/IlR5iTvv3tHB9d2VCg4z4wzVL1msQr+88flqF
 UtxeS/+ruj2xTSKYpVUYg3+mqxgdowafAP+hIWH9XTtgPY34ayj+qUSkWCkO0bmKAR1RvwRFW
 FM2UjGqmZ9f7nchSFcAiXfxrE+QMK0xU+jhKj84dXzAMRmWzjj7frOdD1xCEipogXAaMPSXic
 Eq+k/mWa2Hnnz27AYJO1VRPu7cCtVZ6A4Jc8B5TkscUazD28gPvSFlAmVHRvoQoBwc2PgmL8E
 1pIAiIfhsDkegletyultA1fqa/bfF75vz15druwI0PI4IUbLrC3s4Y+2YJcX5LYB7CvwJMuL7
 /4hYpb53ggqQa9rzZ73cmGJsZZi3c+4U9rw4Hwx5k29Tf2Ghy8mT8IBS7YLiw8G2EsqDaYM1H
 p90GZdJ53C1RGQpggCYfI7A0ZYXIO77KJqltwPgw6Se5rtsDvhWuRF49+RDO2sM4QKzm85Meg
 MLpcUQ7uFPq9OO8tYMDxcQoZmIRzHNd6KsRrtJGxN/YHiO6PspvtfzkcOKlWAQNOh48WyRZXV
 icieb/ZoZ3pO35SxSDsW1qbdJnqISyOPCClyZ5WiMCdQErZ/9X0gominFVh0CTFkpOb1H96el
 Jlp2PxmqYSVyUI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1207272072-1631619161=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Team,

On Fri, 10 Sep 2021, Johannes Schindelin wrote:

> We haven=E2=80=99t had a technology-focused summit since March 2020, and=
 a lot
> is going on that would be good to talk about. Let=E2=80=99s have another=
 Virtual
> Summit.
>
> Just like the Virtual Summit =E2=80=9819, we can use Zoom (thanks GitHub=
, for
> letting us use your company license!), spread it out over two days,
> during the most timezone friendly range of  15:00-19:00 UTC/17:00-21:00
> CEST/11am-3pm EST/8am-noon PST.

I would like to thank the people who registered already (already 20 people
so far, Bcc:ed!).

Since I will be taking time off for the remainder of September, and since
I don't want to leave y'all gentle people hanging, I tallied up the
available dates, and we got a winner: October 19th/20th 2021, 15:00-19:00
UTC it is!

As announced earlier, it will be run Unconference style via Zoom, with
October 20th being the "spill-over day".

All of you who want to contribute to the Virtual Git Contributors' Summit
but haven't registered yet, please do not hesitate to reach out to
git-contributors-summit@googlegroups.com to get a link to the Google
Spreadsheet (on which you can also propose topics).

This is going to be fun!

Ciao,
Dscho

--8323328-1207272072-1631619161=:59--
