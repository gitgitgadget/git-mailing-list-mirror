Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659A31F45F
	for <e@80x24.org>; Thu,  9 May 2019 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEIUqR (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 16:46:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:43893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfEIUqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 16:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557434770;
        bh=EVquBM4ipucH84dZl13UumgxWPtP5Yjm5z+YhtDJbPc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZQw2ngKf8RqJdwMo868oWbUxaSMSsSHaQLoEWA+uPCwp6HtJDIvSg7sQUbqKlCiEA
         Wm20OrkhOIZZY4nCwimrLE8++uwRPz7NRpKwuKbZMiRfpM8H3wCY6sXZ5wlk47+iL0
         VWjVFAC4dO0E4fJxZhtKRkR1SsQtTKr2gX3Ot+Ls=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8pKi-1hYmdC2DfQ-00CDoi; Thu, 09
 May 2019 22:46:10 +0200
Date:   Thu, 9 May 2019 22:45:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: en/fast-export-encoding, was Re: What's cooking in git.git (May
 2019, #01; Thu, 9)
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905092243080.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kkMScXFJ5t79b9s1OY/cCTGNx5E3dFWBlNk2GYAUdtQpRbTOE0m
 YfahuNcKsQFlztq4+2sjDo3xXdI26fAO/qiQh9f6D67Hm4nl1KNi72Km0s/Ui03gRdwBp4D
 kgu9kbbY8uPkAkIUEYU83PzHzhjwbsReV/Qt3tqpQ4Gf/vEfH1qfYsLy3pozp70c9KlGw1R
 VyOl9bQRs8DljEDLO+p/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUuIZXaYdnM=:CDYpNPGsixVoKZ43hRQ/jl
 c+0vLikv8/vfOUJvDYVkcuuWzTMwzpbVYDVeE59nFDHLIRoQ7psGQ5ohvvLPR5OrRU6MINdqY
 G9EoWCS10L2V7s/17oakMEaQ/ExtEvTOv6iPglQ2Z86uv59C7q9Ba5EzKtX/lotS0wY5mYZEW
 rH27oZ8YiVlW6JGayOHvGX27gd1jdquecRJR3cpniwan2g5yJiggwekRIeVriitcP1AaimYDX
 X1VbgTVCU2KUF51/2wY+mfQFbUfqg62tR/tkPdV+VaSKy5wBEpyFdXcSfseKmR8DRqOJR5PL1
 cMOazGa8VmO2BsrehIII04vGAhC6KHwiXSlWgHX2+TRpse4WfUaCnlZqRvIIRBS9oK3+a1z/h
 AWn1bmGW/R8pOa4Jbq3risZHbBWrPb6GZFiDiLe6Pv21ocWV6fhtxtYlX3xiw3DsA0TtQbq8O
 QAXFnAhIZiWkbaDGKiFj5S4TkiXPbdc/0uasPgSqQ1JVggmd1PgGLxFZ7aHw36A17IwV0CwTD
 ROzKdPDewQdKBRiadVu1kv5cZscR7fDjJERv4XwXUH6zM8GQf5S1qvtuwpSaQVSzqEFPVAhmN
 t22deHCRflbC87WhUdxLvmfajNM7XqeSr68hDhOHSrqFQ1HysOhmLDPDdt2v6IpnuE1C6/nRd
 23xOhwR1Am0IFFofdeAStWKZ5JMecSmqLH/+/hHjxFAI9pxZPQmIqwQgD2sBTxF8qxTLo51Gh
 zNp3+rVI8BkMxG6PrEK5PTbxrQikxgatRQWis20C/XqqMIjzIGikanTCSXUJJ0cMO9+Zs9hEt
 +gF8cOLPL6Wwrm3rtBXv6EKmTAT8q5VtfwtLy7ku0Hu5wL+wROwMxbHMfcUxxTIK5Z+yBav+/
 IuUEjYJhduNwT0/C02tdZHdlloaOIWnjhWIuePa/z6mAUhscqHb1IPCR0VoAZW4GeQapI1dLT
 iZJ25JazJkw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Elijah,

On Thu, 9 May 2019, Junio C Hamano wrote:

> * en/fast-export-encoding (2019-05-07) 5 commits
>  - fast-export: do automatic reencoding of commit messages only if reque=
sted
>  - fast-export: differentiate between explicitly utf-8 and implicitly ut=
f-8
>  - fast-export: avoid stripping encoding header if we cannot reencode
>  - fast-import: support 'encoding' commit header
>  - t9350: fix encoding test to actually test reencoding
>
>  The "git fast-export/import" pair has been taught to handle commits
>  with log messages in encoding other than UTF-8 better.

This breaks on Windows, see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D8298&view=
=3Dms.vss-test-web.build-test-results-tab

Sadly, I ran out of time looking at it in detail.

Ciao,
Dscho
