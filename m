Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04EDA1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbeHIPPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 11:15:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:44951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHIPPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 11:15:10 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1fumnJ3lDV-012LA4; Thu, 09
 Aug 2018 14:50:17 +0200
Date:   Thu, 9 Aug 2018 14:50:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Andrei Rybak <rybak.a.v@gmail.com>, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] line-log: clarify [a,b) notation for ranges
In-Reply-To: <CAPig+cTVEq1AGvtxxonbU4PgqeG0fOy9CSDO7ThjVpfGoJaAJA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808091448260.71@tvgsbejvaqbjf.bet>
References: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com> <CAPig+cTVEq1AGvtxxonbU4PgqeG0fOy9CSDO7ThjVpfGoJaAJA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XoIeAaKS7AwXhuagYfPsilnlepJxn78M0XchPpU6KELwz6HhZUj
 EkYq2OXRkXue5VQXI/ZbwstkbST9/IgtmVdNteWNRGtZFkLZNFoEjANfOm8P0Nd4WTDIL7u
 5VotF5huGcZXdblJpLTX0k63WZYRz+vczS4GCs0ur399MMR9BjMPTX+Myg5j3lylHDWp5m8
 9HcwWRo/hUpMts2aaRORQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nY9si6dpkds=:rOiCpoWYaKGHIwLaX2HK+8
 D8IzvDyz6iO0JbUOr1gmhM1ZaC74RNrMhSCvc50LWufyXf8k3ZiyedG/XaZ73iObvGwpNOeIG
 Ohxr6t8E/4udQ4cTAiWkM1cOnFOgjkEsAUCVWPz7zj6n2OT3mOOLGddaZBOkikBDrjMv4uRFi
 IeS28ltFJHlfCJwZmmFH7eVfF4OZcUDz9k7rtwDsBeYwCdLC8j+EsKOYLSpmzhZL2swJerHJZ
 fIKkIhctC5Ccxie60ryMISNF6iU9Akl00WbMtUSHQ6jfqoLMuo91B+jRcEKPngDdmNQPu3ung
 oEesMPmLl7mHD+oaNyAqHzyQ9AMHdMWoOdQxJcS9M8La+w3xvXJb4euoJDN+G4RWrpq7DEoSR
 ziN5ctZBhg5lduHuUP23ELkwTkAMAouHRO4sjOXua7BBAaWZQmY/+wKFWb0AQhvsqA/rLlgdy
 SYO/MhlbMIspU/qQRmWbY6SaTrydE6SEd4+Q8Ud5DSFgwxRpjfb9HMxhirG22xzWMZnbd6Bqj
 t5InZav88SthcoZ9Fm6/5KIfm5moClNhsJbYOeBaEXnyUc+J4OyaEq6LHCbzr+9BlwmuVytXk
 mw5QGYL5YX1XCiueR+hNUDutzcrHy6ickhuOKMgoWkxLk2EweFpbOf2EIbflp55x99VXalmhc
 nMiMBoephZvFYEXi9J16rp3QetySwSGnGWUbylplLMHur4i93ZEOzjkFR2aVJhFRCSlYJy20C
 XBy+eDV8lpZ8dFaQsnOn4zdr2/X2MKIUKrndtGcnZS5cxrYLnYeelPPy4UU8K3zZd7S5iunpJ
 r/XUxj/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 7 Aug 2018, Eric Sunshine wrote:

> On Tue, Aug 7, 2018 at 9:54 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> > line-log.[ch] use left-closed, right-open interval logic. Change comment
> > and debug output to square brackets+parentheses notation to help
> > developers avoid off-by-one errors.
> > ---
> 
> This seems sensible. There might be some reviewers who suggest
> different notation since "[...)" is not universal (see [1]), but I
> think this is fine.

Indeed. When I started out studying mathematics, I learned the notation
[...[ (which makes a lot more sense, if you think about it).

Besides, it's not like we start from a fresh slate. Git is already over a
decade old. Our commit ranges are "half open", i.e. the exact thing that
is described here. There's gotta be some precedent in the documentation,
and introducing something willfully inconsistent is probably a pretty bad
idea.

Ciao,
Dscho
