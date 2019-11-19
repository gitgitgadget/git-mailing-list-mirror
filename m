Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1921BC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C5B20674
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TD2zmeSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSXcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:32:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:39983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfKSXcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574206318;
        bh=rsgG7wKDJrjYQAQ+NYP3VtNzRlmSr2m2FXyfo8r/sTg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TD2zmeSsPHRqMwACPYFr6quAVPnLmtXJ6lfEms3EkwDfrtz4ewEH4PSV8FhjILJL7
         avSdAaeUq/sw6N7sXEZ7521mjWLpINXNoEAofybSGljtEMrNwCAY7VOJyIV2+JTOSy
         sTbfT/dx4uuIFLaIxVxkHBFq9GDL0wphyVhj79qM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlGk-1htjQb3XsG-00drJH; Wed, 20
 Nov 2019 00:31:57 +0100
Date:   Wed, 20 Nov 2019 00:31:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
In-Reply-To: <20191119202542.GB36377@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-2-emilyshaffer@google.com> <xmqqr2284is5.fsf@gitster-ct.c.googlers.com> <20191119202542.GB36377@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F0loPKy+b5q2bGz51+KFNPQrH/T7/iD6MYC1crEBhY4w7bmI3Y3
 lD5YTZqHjYu1msls2c0wC/Lw1cuvkTLDxkO0a58Csy5BLBatnHgoeHHJBbpwV9I/ym4LxUe
 3ykEHA7/A05w+vcAbwJwlsWIsBl5AEInIYD5iFybSNI9jbcZteDKFDqccpq0ajcZIyBlzDE
 3kTD5ugbCExeYbFoNLkdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EeqPQZu1afw=:2BEpcvL1s/KeClMtL3iI8S
 rfBki6uVFMb6b9YW8yfuUJ10Ek1RON4QgjiZfVsNKGYcKABqZzOtTV7S9Y0GUlei3kBDVE89K
 sL6dzo4i4QgvEvRC0K4baOg8O8CgUuVt9IUrBe8qTD17PDUqNjx4IXMOUS7MwonWCf9GZIJfD
 C1SqGdhMilVX0XeIzC9h/eUjI+f93vIXInK44X9NVn4ddGqxBX3NdVVgBIcnue+Cet0ftmoD3
 41NZvCODxUIuEZe0YoLrW6Ywhf3PGyCgrb3Z+gSzT7Gq67Vb70Beg05ANju/IQ+nX6VjmgaUR
 U34J8vnBDQ2JTrDXL6hprX6Gx1MCJg6RciUUmzRwuln0aX0PQndJ3WTaoqCid8/kycXXEDHMM
 K4A3CsginvA9Xdudt8ktXulr465YyXxb4lLSsSttTa1Bb0UhL9HUNlKP/4bDLiRDtt5ZBfxzm
 aKpxVonmp0YdqrCY5N6sLYAQE0Lm38Ge5KsG4XUTREBX0Tpf1L+zLrERq8b26pxkDI9gyAQoK
 8KwqZzx95RYQq1kFcvQbQgv2BuYnrSk9eQ4tkT3hGq8pvJ9ApL2bJncdKH33TSAeDikBtBRFy
 GK315h0Nr7Pssej0T4fLRmglHHll9XKO91J7jBft7z5n74KgyJjwgKcqGAL4HVCGjx57DK04H
 xX7tcOn/WDbnNbD7OTbLp5DUXIQ/iTt+Fxkm9ex8UzuLfBHUBXI31L7QwUY46uCUmacmsIjje
 HqlglOuvh24PhssDQAzx6w6eAri01Znay5jZw60D5DcKSuxwvr2XwnybnA/rSEH1Q/7FdpcNv
 IHhIaDPWx6hDDcduzEebRgzbQ8uee4FeLw4eMKkKkNwonoUYpoGUsG9qisErdpPIAiW83ociH
 oMSL5X0jKoKEYZSHLcGMp3Pbp/BcoOhQIe851sQbYWLmTp5D0xmnK5pDBE27BPpLfXGP5TvNc
 ueZJd81aRv/Es+fwDO21Ba4ca4INb0wzA9WeThtA2/UxJdrDsWAd4Qepc9zvc5FXY1iqwWGds
 gg3X7Awsdn98MHBCWMWfAEXSMQKIb6lRM0xiF8KxltudYExca+KXQn8EtMNL8pu7U5ahEbkPi
 TQjRxNE8Wf4ff1SE2ZJg83e+xx5VvDSb4Xjrxk3yGHBwGjnkjRwfDAuGUnjHKaOwKPVl5TN3Y
 wtOeF39m05VViaPuUDL6d/5qUMFhva1TfsArmDdPmzBXvYnsYZW4Jyvp7XjBhtijFY/BHWz3X
 a6dA/IFSTfaER8NFV2ft6kixupiJoENkMgtuF2B2Qg1YlBD+UouOruzqYbCU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 19 Nov 2019, Emily Shaffer wrote:

> [...] some other issues (needing to link against curl to get the curl
> version, which is exactly what you implied) [...]

I did suggest on IRC to teach `git-remote-https` an option where it prints
the cURL version (and build options) and exits.

This would have the further advantage of making sure that the correct
information is included. If you have two separate binaries that both link
to cURL, they could still be linked statically, to different versions of
cURL (this could happen e.g. if you have a `git-remote-https` from a
different build in your path).

In short: I still think that it would make for a much better idea to query
the `git-remote-https` executable for the version information than to link
`bugreport` to libcurl.

Ciao,
Dscho
