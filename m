Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BB71F462
	for <e@80x24.org>; Tue, 11 Jun 2019 19:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405100AbfFKT2Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 15:28:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:48309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404970AbfFKT2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 15:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560281299;
        bh=VitvhYXbZXb97ubgX7HVqCVR5HdnFApMPTLBzkBzKhY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CTCpK4ZI5fXye3G8wrzsdVAb72WZRAxQ2z/DnGgljmqVstiAclZA0q81+MaA9EtZP
         0wUTdG7WjCMtwuqZSJwhgM8UeT2glg6rmpoPaWBmDd8JR0XtcwmzTr4H3lMKElDRFG
         wL0HOYDemfXj2qH+c4lP4vMSPd6LKYrGaTPWMycc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.215.76.8] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcOw-1hkANN2wPy-009OXi; Tue, 11
 Jun 2019 21:28:19 +0200
Date:   Tue, 11 Jun 2019 21:28:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     Espen Antonsen <espen@inspired.no>
cc:     git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
In-Reply-To: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1036789024-1560281300=:789"
X-Provags-ID: V03:K1:gSFLen+eax4o0n0c5plFHILK9Bp91eKnIdJxR+hKZdzOj2wu3wl
 CdRGUfcPyR3SmCKtk9tvg/9zyFO8tvCBUyqrS0NTbe2pyCvD4F6c0j0QpKXrVh5auYyff5o
 NdYYDeMZa4Y6pVJrTUS3G6uMvwAkNpKFj1QyO9fXKujX65GO8B91KeIMg9nAbnogUkn2LNS
 sTp0ZsVCGUmSGfq4TkJdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNGjs1Il7+E=:G8ftjfYhS7kWDKQz8+Z+0L
 H9IOaZV7mhsKO2wyLYUSk/V3CUTIexSDX7mudTxxS4qsI6ug//+O9UPYO53wibilAX0i6vWmw
 2I9icmuHR0/z6az/6qX5RFvXsV/Ti3jLLfgz+lYA7tUePQUnixK9lmyx1Ywd18HTaBjo6jNme
 eWDCfDrJpMaGpseL/KN8We1loPnqRT9agPT/w9nYL1OBC/0R79U2fpPtJ9OENh4QLY4JohwZN
 e/Sxi3jBeJfKtsoAXQiRvD/GL2kaW60nUR/8fncBy/uPHb8UwVuifMICogh0/H+3pgt5BFdvc
 ry+fwYEdIts+D9olfOqEN95qGwzn35t8sgUg+KfXNZShpGjnyaYBxKu4cVBipHnqgMoFK73wx
 mQZ4/cAEgrajQyk3zrhPX1uxybQoEbK150yyMVWqZB8VUafYBPhn0wG3jEksi0ZnJylleFGW6
 NSyNqLmA1ZCE3nYxirVkJ40ouKRZL/pCwUw+VooaUaO6xWx7FxU7h8F4yu8B1qXcTPeQ+kawL
 CycKIuOA1hE+SHEvhMYhunWaRTZbJUkIt/nOSHy798e3ysdW/AP0le/cw8F3UkhS/zlzwbmpP
 4fVuSlPTbOG6DY0ii6YhXmTF6jn+ZPjgJi9TBf++jWLqjLqbj10/cxE6C1qWFLgHStj5UvKqZ
 enE6J5UcDvj/e0akehQ1tKIvPoGU85pSMDPk3dDlzdEZqd0E+/JXgNTRzuKiGfZc0SETaNwxa
 yyIDRDNl7MIELEZB3t7F/hr/uWBDhHKWuLxlZLtB4sipFCvy7rQXZDbbVG84EydPKP9iRIpMA
 vPvVbHLa8b3TNM4uSji6qLb276scKHtMrK0sMxz7htf5bmoTDEa7ym9++zleveHrH1OUqEhaz
 /QjXA8tXgv9VlawpC/mnCBoz1rvEEJd/cyUXt9eoEf1+Zb8ckAvQkPyW4Zaou6PG1z5PdlEfK
 vpkipgLiAoADFQQtVfSMyrE/laj8twXfw+JSIwgGBMdyoHFrMFK/P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1036789024-1560281300=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Espen,

On Tue, 11 Jun 2019, Espen Antonsen wrote:

> Seeing an error after upgrading to git v2.22.0.
>
> git status shows =E2=80=9Cerror: could not parse =E2=80=98*a commit mess=
age from 2012*=E2=80=99=E2=80=9D
>
> Downgrading to v.2.21.0 does not yield this message for git status.
>
> I can only replicate this in a private repo I have so far. Unable to
> share the repo but can debug if you need more info.

Sounds like a hook gone haywire. Find out more by setting `GIT_TRACE=3D1`
before repeating the command.

Ciao,
Johannes

--8323329-1036789024-1560281300=:789--
