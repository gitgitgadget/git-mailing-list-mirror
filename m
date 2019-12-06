Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1402CC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690424675
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iJN8SaVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLFPUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:20:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:44183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfLFPUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 10:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575645635;
        bh=ymTCwcELebNdFAds3rrxZsEJNtc+DEzo2eyH4pfaQ30=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iJN8SaVDUt0rDiLvfW4CSllU4st7OvH8V1dhvQKE2WLhMYpPeYkb6G82uCF4X9B0C
         CUyCMOJfk2HUa68MRKYnMbSd5g2c2iIkx02zbAXBkN86PNXCIpwlXxOP7Se9Oft89H
         IpOcvR/xF1WNWOWJRa3/xBlLBIHGJmC+HEP5HHPI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1hf3zC2lTp-011Bwl; Fri, 06
 Dec 2019 16:20:35 +0100
Date:   Fri, 6 Dec 2019 16:20:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: am/pathspec-f-f-checkout, was Re: What's cooking in git.git (Dec
 2019, #02; Thu, 5)
In-Reply-To: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912061618440.31080@tvgsbejvaqbjf.bet>
References: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1466280882-1575645636=:31080"
X-Provags-ID: V03:K1:VmgIj8K+mEvSh9O6s0m2u+/Ep4y4UVA7xd/gRtNWkDR9RaHtuBa
 5vx4BFqDFWUyPDrbNhq0+jSSoon/4Qb3V0Z5qHFz5/Phm8cfBQimkG49I2s7L20lQBmEDcV
 dhxMiTD6QZSLPSnjs2qGpor3SKPIft+Mlbbh6wrL5c39LVMny87nBb+5XgvkRazqNEdcyhL
 D0VHu/cdD2yr+AIpZ8cvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dIw+1LmyMac=:h684zqN3W4SJRcJ5o95GtA
 v+K7u0a1GdVIMqF6P7m0DDAe/2GQFxS89kGCiQ0lLejpTWhb2Ip9WhGuinpEDx2Xwh+U3nMBz
 FA19bg2QYDk3v9Dep17t1hBeKZ453wsVKCb/dzSM6eCPOZk5VDw7uICWnQD0SdLfHh2JlTm28
 7/C0khNPJKYescqjGlxT3IRy58gF9wgk6rOGjqi9LyUo93TAaefJ0Y1ToWiVkAtf5m1Ye+b+b
 cnt22N17NETKxDbHKHE5G3feNXr5vLz+u+7Nc087Xh5dSGtnTmTfPy77MZLKfQsqmf/pGc/ry
 Vt88hsBUzXq/WtD0dql9OQjIgbWeRSsCaTBCpSz67jr58GrMvDta2yv1vU2n+0UsThi/piUBc
 Z2FeFd4f5SkPnH/SGuyM2LSQwLiffm6O28z/UNviZOB8W8jNZ2r1d+tYP2WXvQ2av8YscJ/3a
 yvD0XcWrCt3KLRh2/8NcsWU6gC8tLKQOZktV4VYdlyDA6urOWHwF53Ub4G64o/F3doHGrtNfK
 D1JjyHwajUeKQJoBUU4pXYs0i+gttcKgQ5fy+uIMzfKDDNjgo/DD6folPCo+dmDZuxlCuBHQ7
 env8RXPPByvVJp57SmI9xsZpAv0/X4IlUMaYm+FSb6877yLn0xI1awZlLiadreFPc/NzZqHBG
 5ON/E3TyaaNW5op2o8PFEab0h2yrOdiszcahtSWGn+YHJF6u9L0MamjIARou2COL43W1XqdEV
 E/JcwmZ5fCbQdS8G1ynP6ol+qsFSEiAbuT+6sBUXAaHVvlN5Kcl+HTgbaZys5SfW+lf0FqGmW
 TX+89P44ioXOyA2ZofyQUpr/Y11uKHm62ZUnYwWhkDrhljspTY8nn2BFNT4aWoQru8xsRz+tC
 mnLU2YKh52x4ZtkN74hhOfTDyYKwHYsSqma5/MOHxhzwFstcCviGjCRiA5mTfH64j+i90dGhi
 1fzCnSZh3jcicYMUOnlQbK1k5OxGTiqhBGQGqQt8QB6RvcQWNRMyxYf8UqlQPDpY7z4n4Eqh9
 av/EI8xtstI5OGdF2VDFTyRDDHNeq+JLDsUCJ8n/kiWBuKb7v+bHHZYqUYxa/U619Q9710hU4
 JEhXqxhEJscbny+8i+6NUGGmsfKucdpBl9RMeTE+So+Sq9P47M+LZ6O9Ronz9nKAevyEJpApH
 nURjJr6td8RxMNjHxAc1j5Q4aEaDCbmQT9ElOqMA/ajyWAeoN8THW0/CiLcVCYgAP4fiaL4JT
 jd7onXO4a1ArbhVUCPjozNyc/w2E6K+mke/POtjgvt3PpXWd8cHJdqUZu7LU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1466280882-1575645636=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Emily,

On Thu, 5 Dec 2019, Junio C Hamano wrote:

> * am/pathspec-f-f-checkout (2019-12-04) 7 commits
>  - checkout, restore: support the --pathspec-from-file option
>  - doc: restore: synchronize <pathspec> description
>  - doc: checkout: synchronize <pathspec> description
>  - doc: checkout: fix broken text reference
>  - doc: checkout: remove duplicate synopsis
>  - add: support the --pathspec-from-file option
>  - cmd_add: prepare for next patch
>  (this branch uses am/pathspec-from-file; is tangled with es/pathspec-f-=
f-grep.)
>
>  A few more commands learned the "--pathspec-from-file" command line
>  option.
>
>  Will merge to 'next'.

G=C3=A1bor noticed that this breaks Travis, and I provided a patch that
initializes those new variables. Please squash that in before merging to
`next`.

Thanks,
Dscho

--8323328-1466280882-1575645636=:31080--
