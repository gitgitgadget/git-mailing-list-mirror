Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473E51F462
	for <e@80x24.org>; Thu, 30 May 2019 19:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3Tc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 15:32:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:35033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3Tc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 15:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559244776;
        bh=9CD2AFhVoo3vBdUopWV2ZzGSj82xUbS8hc/LCYQFcns=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject;
        b=UwjuPZ/kHXnh9NI7v83/HGeJNVNEZGaw7QMdeTjePp0p0oRGMHV3nktA9c7fMWVV1
         aBdLuIsKk8udS/4tT+naZ8k+5jy5Y6VVua+4CQL4lSiMkAo4wb96f1ex9/nuyiZ700
         WW2tk2c1RY20/9SQ9OnTWsJeeArPC38RnlETb9AI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MM0bQ-1hVKrs2RiO-007oXX; Thu, 30
 May 2019 21:32:56 +0200
Date:   Thu, 30 May 2019 21:32:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org
Subject: Travis not looking so good
Message-ID: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-837569515-1559244776=:44"
X-Provags-ID: V03:K1:dMPnBGWN9P2vjIxnzLRyabUNPyjqQPdfK7HU7CuKVvJ1ZiThS8G
 +20S66ky508Tbqd0J5y1ecHeDhQpr8t+SwiM0ISQO9FKKm88uzFTlOpy6KrIS3hZ2YBqkcR
 VLrMwoVCGrPoNkymaI/DC3X/jN4SjoPdNYuR1apHwTp9804OxgvLfXmnauIsGrgOBdOjn9k
 v1SIjZTsbUOaAkH5Qpxww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xJRZc2vUDOA=:w0O+UX7J9mspmw7apZYpKY
 KbsOQjhjZ6tvVFCkjNgqvSQyBnUhIWtzBE9acpUoIn/TaSVB7iterzYWfmgOmnmRJ7xT+RAcF
 ZKlLByQuU3fcWziu7S9lhOF50AAIQ6oDn3c6uU3/SYtaFDPWaRVFKLu2Xyicw+YTIZgnVfAUG
 LjnVT3vcuAvJ7f21ka5eO2uj4qWd39c6bqM6Li9WJq1Kefpy+6xdr+BegezfvNSwYBlimGVY6
 tXp+4/+MPIvGseVszrqyzHD7N0sAIlj+X9/lW74pZuXQ0/AZvTa/fPOlV1fAYlnjXBOkwHKig
 DcXkJcvtJ52lDp/sZhgPsOxrPpii6cOMJMMCuCCq+NsJROXRT3nAIxu1OYj8x8lAG7Fy1sle5
 BQ7UkLmAskMP18WKtqRBhfJ7vrDjomSXmrF1xNyVKIALLuglptKSEFOdKtMMeYAJzyi/8R3rg
 4JEAu/xvmXA8H7fscd3cIkLCFqs28395SOb7p1vbP0KL8UGHuWIOgt2vxTnnNpbw5kA+B9Vu/
 BjwaV65IrKTRoKq+h20boOWbLBDb8rAFS9pTj0bCQdmRhogEuvpi5f/Ikf1bdBzYnCDn+H7gX
 D2zGF/zrkCvVwIeEWPDiptBbvTQMJiqHEkLbaZ0EjyxMsFNllyYU/L95o2h0UQ/ZOmbyNFmWa
 RUL+MHzsn3pUGbj0cg2Rw+ZCubXofXoJZ+2skMmjCKcp1+j4dpcJKN1N7E+A+H0P6VjccrAri
 735oiPnsQLAUyNA+0/Brd00JjCNi0No9BW4LLY0lJ4bw1FVMUb7cCfjnd56JsB5XxW5kySrvo
 NCT9h+Tjw6H8DMpIerbvsF6rf3LnXJ0sy+VxRqcZZXLYtYfsEjLFNXUbcsHFK80v173bwNwsu
 3Swvy1k4eqfW9gIcZwB7Y7dkoQT0430cQLXsO5i21YRDwkUHVEapYHk2QRMpAXf48lYfxkCDd
 JlfNaye/dEA/l3X2Wkg/n1tMAK5UfjsC7A/QbgK6uerVq3bXDrcuS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-837569515-1559244776=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

do you have any idea why Travis is failing like this in the macOS/gcc
job?

> +case "$jobname" in
> +brew link gcc@8
> Error: No such keg: /usr/local/Cellar/gcc@8
> The command "ci/install-dependencies.sh" failed and exited with 1 during=
 .

I usually only look at the Azure Pipelines (which gives me plenty enough
to do, what with pu's individual branches being tested individually), but
couldn't fail to notice that *all* four branches (maint, master, next and
pu) fail in Travis' macOS/gcc job (and only there, the Azure Pipelines are
all green):

https://github.com/git/git/branches/all

What's going on?

Ciao,
Dscho

--8323328-837569515-1559244776=:44--
