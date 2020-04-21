Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A3BC54FD0
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 11:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BC02070B
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 11:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E/4yPgC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgDUL5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:57:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:53767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDUL5p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 07:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587470261;
        bh=9pSPro2zuNWSRY9B5rjFRSNbbhw9zBMtsYCoehrNnOc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E/4yPgC5X4KRjp21bdZnA7FGO26x+yE5nqd1OFGpSln3rdSLXVCmcSmcU/2a+gfWi
         +cJIEpaqpP/n/hMQPR5UPYgfuu7zBTfXzRs0uNYG9KO9SpTVhHBXEJaT9JhGtjOwlW
         3ZVzqUTVz22DX+tpH9iPFSjw/1LCONC17Y44Nflg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.57]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M89L1-1jMAQo1FWV-005HLM; Tue, 21 Apr 2020 13:57:41 +0200
Date:   Tue, 21 Apr 2020 13:57:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kelvin Wu <kelvin.wu@gmail.com>, git@vger.kernel.org
Subject: Re: Why the stand-alone installer for macOS hasn't been updated for
 8 months?
In-Reply-To: <xmqq4ktgt4xj.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004211354180.46@tvgsbejvaqbjf.bet>
References: <CAAxGxjXv+VvN6PqOK8WbxO6_eFrcBhiaj2xRWcUhCtO321JmOg@mail.gmail.com> <xmqq4ktgt4xj.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tOE02gIUo2G/eonGoFXR7ikycNU6xwoBKEnFq6iWLPeimhI4l/h
 h/wRuA7CemxKNRWTlN9SvRanCvfES85b0hJd3loEziYWbGzKRecy2FUsv3D+U0qZw6dt1eY
 9RyF3YjRG5g28/KDQsD3dIMMYHo5W2PSLgyxFFjTLvDAjTiOfCoPL3ZnCygeKFm1fnxme5Y
 MI48p2xPIp0P/jm31gdJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mi9dZpbSYas=:Hi+Q9uSdONG3YlY66RVSzZ
 KfkcH1rEDutdfmDaeBfaryMUNih4Hzr0gniiAFIl+ZnHkJlEwPMpTABm+32bOVqSR7nv4XJxB
 Qlph/XInwGviUxcUurR9KD7SNrBW1Dv+a5k+x/jVd01IJK2M62Ka388LwaVyFxn7rBNprjlVq
 MSDg06CfYiGtAJ7CjaeMArx2qRaikXg8qjL8/IW/Z3saL8qdCviGJExcWHCTjE0YQTPBq9PwM
 jRWpnffaHruqcSylyhuXILwft+vHmB0enRjJmHXjuk6+QOuILrH6DVzqbq5zFpChBLEql7S6l
 VWqR0jfsfKMMwQ9EH8E2mxqr+CjBXpvt+bpSduuaI0Bhw6P/JK080IObtL+uD6h7EX+IFBsA1
 D5tAHfiIOFIMMsET5gWVBmjtyBIi91KBk08CMt8kO0CWs7AZQBqQqKi3VEQ4s6oZktC85x2u3
 r3tdnRu+jEgrdVRhxUHI0OA1kLGHoy58Unuh4S8NlZTZ96RXQx/FAe5A1LrwioWyT8XqJF473
 MBg7ms1KKW1Qe/vl9J8Ql7G7n/5Dnw01YMMbnZUP68VuFQqPNMKUbRQvZr5IMU/UT/Rrz75D0
 ynQzF3X5EBr1h3ktFNvAVH03w6F9qg+DRK/reXXxJxHT/4O2pM00/gU6LhZrJ7G6sq/twRFM+
 EHJztKy9QWIDWtiEcvil5Wg+hkPD/hQsqu/XM2bnvEZ7d8GN/d2obQPl8Q+91YbDyF35nn/WX
 eGEqjRmCOKp86bIiZduggxshnka6YUehzakzSQ9x/Xl5Vp7yY/KfA9QR+rFaFB3nXc7DyGDXs
 /kboTA/cXsaoR0rQaxkTjqY3S7WHiHOeIo1mgTot/FiqK8K0C+fSpL6/hJltmLCAIB+qzOP2O
 2KhIPq6BD4D+uiMPFR4Vl1mDhRcr5Q20hn+OJjor+fYxbuoBNKTQ8d5ni5iWtbWfdw3F78tVf
 SBomC18mECiDdaG3ew7LJsy3keeM2ABdZIA1BlM7xJCKjxbx2g0jH0kGPKF2Eb3ZjPKARKf7Q
 D5DDN5DHirWyUQa9gf/tgsAuuoeMHzZk3NUAaXX/9oxsgyfVSvMpF7o5ibI80a59vRL+CEX/8
 hOW241Zp5n/mUnO1yGdSQtz+JuKk7gr1//B7XF1Cn9bdtmwfSMqWQpB2OhZ/QMDJxl6gHLK+U
 oxLF6FEOiTrnVTfcQ9zm4JsqDET9RGqWRlAsE7D4zPyS42LHYirigKofbBvwvJYfIYYrlxHoA
 Qa51/m6QTWgREill3
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kelvin & Junio,

On Sat, 18 Apr 2020, Junio C Hamano wrote:

> Kelvin Wu <kelvin.wu@gmail.com> writes:
>
> > As title says.
>
> Because nobody volunteers to make one?  You may be appreciated by
> your fellow Apple customers if you volunteer to ;-)

And it'll be easier than ever if you use
https://github.com/timcharper/git_osx_installer/pull/156

That Pull Request adds a GitHub Actions-based workflow to build a Git
installer for macOS. See the Pull Request discussion for more information.

Ciao,
Johannes
