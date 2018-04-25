Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4DA1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDYHqN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:46:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:37277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeDYHqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:46:10 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvEZe-1eCMpi2VYw-010MJs; Wed, 25
 Apr 2018 09:46:04 +0200
Date:   Wed, 25 Apr 2018 09:46:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
In-Reply-To: <xmqqr2n43wh5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804250944080.4978@tvgsbejvaqbjf.bet>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <cover.1524309209.git.johannes.schindelin@gmx.de> <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com> <xmqqvach74qe.fsf@gitster-ct.c.googlers.com> <xmqqa7tt72c9.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1804241646400.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqr2n43wh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lm1qVq60+i48JN7r3jCymWBqpgwQhv30K9cDizQplJ/neOlYumQ
 B9CVsfxZ1uE7qbeOphC3VcR4RPmdgT8L0DUzYscDSMyVwigs9QIphWT2MpDUq8PYSRclu1J
 TDpIb79vs4JzYscPKijufBCTZ/E4kOyPi1w9yIlpgPoNiAov+lAmoWfet1d3jifxfjC5obf
 8Y2SL46+52JOZrD9/hl+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hu7/wCPuZzo=:97CwuGey4tJH7qmcIXtDbC
 zSPBIHGK8QOLd0Pa1M6kbCFWHWjzkVm/tOSM/wiP/ixDJxOQVT9vQ6Q7IlcbI4y5KdXmlre/0
 5ZWjib1Grj/3MW3XY7vONfNzVYKOp6BPsYaIbs8LJ3UZ+QK8ufffIlcd2wp+/F/aDmmAQzt2u
 F8nuxaVwsyYsI1J6a2gD1gD3kRx98ngkRcZaq+NIT4UaSQJC3KPjyxYIvQDZp7h2S+8lkwzBB
 g0h+sv3vzAsAQSPJ2ZukioFx7O1PymOLGiyzUIWLTyYWNqfEQhaPT8gev2yJEZM6taPnkfvia
 U+P/6YEjPHu+WlEhI2ee8gZ8V4iHPV/wLg8vz2C9Eb3Oycn7kG+z9eqGy9FqlyiQ8O1FOphRa
 ZzE8M8Qq+iJWtFf7NBxL2tuBkCu1PzUE6r9ktYlpeY4/58X4Dy717KiqKxSVqPsLBsgLZf8qO
 uUNDR/V1JkVHuRkaMIfUe1n1mNwtLk1AoP7NgdXovYEvOjVueHHkUp9/8AKUwQIK0MPp6QKqS
 EAsK26e3mIwCc9SONV7lsfWnP30sgxQQV73oVzT6anJKhMgMxRI8FDcd+6980fy6aHGa4GKVi
 iOItmwCNnZ7+Nqm3vKZDhCMgbM396/3dp5UtV2o5y05WrHsGydsNJMYMzy5ndp0AwH+DR8kj2
 RNb3wM9L8CPRtLJEvNufZFMqvPJ2va7T1y8DBHgGycqwC/ALVm8ViLd7TXEU5nuSCt8lCf+kK
 gqr+jcBsmTUL1m/extN2w0em1q+NCbtBD5Ov4NxYOKj63itmow0f3qG95xheE+MB2HlJnkN0Q
 jpwkTeF0p95mFhOb60uIRMQ2Y2h8wBkf3Fv6kPGeI/cxHvP3Wk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Apr 2018, Junio C Hamano wrote:

> I really want to see that the runtime prefix stuff mature enough during
> this cycle, so these follow-up patches are all very much appreciated.

FWIW I merged these patches (including my touch-ups) into Git for Windows'
`master` branch early.

(I should actually not say that I merged it, because that would have
merged way too much, as Git for Windows' `master` is still based on
v2.17.0. So I cherry-picked instead.)

That should help mature those patches in one big hurry. If they're not yet
perfect, that is.

Ciao,
Dscho
