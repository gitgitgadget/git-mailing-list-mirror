Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119791F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfJHTge (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:36:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:49453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfJHTgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 15:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570563388;
        bh=eSdW+/2Uym1h0CKxfkxoCugetole5GypmXXLi+TgN1c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YAmWx8DAhep6X9z780G1G5jgJ9Y8EN5sDHsx+27Tew8BDLGJRvSSgBsm8PJcff9nZ
         JVcQ5+aikhFp6IbsKA6pnO5iWz51CL0BqiaQe4PdweH0rP/Pl7r4TAqh0lSXugWmXl
         mWTcxinXd5YBs4TeZdnqwOwA0mM+VlNQCMfPMoMg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1iP34w1UiI-00Baac; Tue, 08
 Oct 2019 21:36:28 +0200
Date:   Tue, 8 Oct 2019 21:36:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jk/code-of-conduct, was Re: What's cooking in git.git (Oct 2019,
 #02; Mon, 7)
In-Reply-To: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-699048384-1570563389=:46"
X-Provags-ID: V03:K1:hnnUkCFrEwrfhIvjcDtrWROkmRgbH9VJj7vixXu6ZHoueBvIJYf
 ishPGlO4j163pyQ3p1GosT2DLY5lXY+8mamxQ2u5TEq6og4LZPjZf8MOlpVtmBs0l+TgJMY
 bAoMAYIqZYsWPAwUkx1Kzjm9pyZmaoF2fjZ1o+3mUohH+X0EMC0dJEQkPSMGxtKBaWeBXqS
 cKKenaX0L6UzFW8P077vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWz0Sf5+yis=:Mn40TUjcWPYbRPvrAp2+Zo
 XCCKdEaZrBeQMa7ryDVtCslcULMtu1KADy1lHNuIAU3gg6K9pwP9PuMRBSbKDtisuSlUcOiRM
 8w+Nw1vlnS1L/o9cOWS9chqKCs8Au5MLiVqat/NMNTBqrsJCqkWze2M4w+ERsLfy0FWoCr9N4
 gk749wV3uJu4IO5c2ld/V1DSAcAIMgia4DZ+MTDejSPxT1HBFt/Wj117W45yiJd1wSlPinCPg
 k6YzTqWB1CknEC9B4tLG4g0Y4Eb0f3S5+/bSdQTudv79fUWk9yuGbIVaPKeeMpljuIR8duOfd
 5RYHv7WkHkT3f1Dcot7KvUpZkkpcETCckTKffOjvAW7pYXeYDvPgG0SkaP8SiVdjJXffSas9Z
 Qj3dYrVMJZN3bH/Xr3n4m71CsQ5KRJ9FEdj5I4LSRYMH12BAgzSx5AfuthnRZ2F3GQWMOuq6B
 MDCvEbbSdVCqBds/dJ67KlZacWznaYe4Y6dkU587NhuA8IytSXbPD1t0503qThwbns7Ox64I6
 NlG8f+DV4CxGoGSbTdpF857LtYWT+wMken9itUy83jmImio/RTpOTQJrny1AY4dlM7HejLIdY
 zwo7UJgKEe//WRkuo5SQoyyQ0yzBMwMIp91e5eFnxVsdaPBtSim+L2AG9wWY4dS9fhSrq7Wth
 UXKKX5ZqytjXRxXEf9y1rIXjKv/FqvYQQRFK1gWPTLCzJiLqB+2cJpjqw15kGcrF1+SVtr92B
 7vfKHinwc9en6e+njMCUB34KmqJAYQQAA9Idpxxxk1XVsQjdS2DUt2XOaQz6ZFLoS6NQXnbyw
 WliLMgW+QHtqq3po+BvrJsQsK1Rrk8I3w73jan+wv3RyK2MMw1ukUrU2yWStIp9b42nVrkfQg
 /7ABHDOtdUa2tlOaEziLcGzJ/Dk9miRbLwU4G3+Pwzep4AcpnTqmEloOYLhJlusd0EJulhpGa
 D/O9VJWucS2eXc/LoHlMHDelr+5QSxFXH6DJ646UYXH80/yVVnsE7aq752eOcpqQ1J2nhBGZm
 dqe9B8+BamEs0iPtL5G93i6+rHVlJT/+GPRYslWxO7KizcrViBe9VfDDBIDI4i3BZhH/iYiva
 dBbyBwE1Min/uPsXepuTs5obXC/zAzBapxqdX+Jt1QvBbDDemXJLd4P4y6l3tB+mzzNA7NaE2
 LN1p9m6Wp3cF2FEV39DZL+HS5KxSEfuZQd4f8/p8CYhL92zhaWel+ovJTy34PYHD7vBEh1P9F
 UfEzmoynyYom3hi+2X8/V6PJbLIUhiFnxb9LedLzn8SRLOKDvXMqjFjzZftc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-699048384-1570563389=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 7 Oct 2019, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [...]
> [New Topics]
>
> [...]

I missed a well-ACKed contribution in here: the code of conduct Peff
kindly submitted, with the add-on that clarifies who is in that group of
potential mediators. See

https://public-inbox.org/git/20190924064454.GA30419@sigill.intra.peff.net/

and

https://public-inbox.org/git/20190926072046.GB20653@sigill.intra.peff.net/

As far as I can tell, there was only one critical voice, G=C3=A1bor, and w=
hen
I responded asking for clarifications which part of the code of conduct
exactly would require any change of behavior, there was no response,
which I took as a silent sign of acquiescence.

Ren=C3=A9 also offered concerns about a part of the code of conduct that t=
hey
considered to be too vague, but I think both Peff and I explained why it
should remain as-is (again, there was no response, which I, again, am
forced to interpret, and I interpret it as agreeing to the points made
in particular by Peff).

In contrast, the patch won support from the cURL maintainer
(https://public-inbox.org/git/alpine.DEB.2.20.1909250834220.4757@tvnag.unk=
k.fr/),
and endorsements (also known as ACKs) from myself
(https://public-inbox.org/git/nycvar.QRO.7.76.6.1909241426580.15067@tvgsbe=
jvaqbjf.bet/),
from Stolee
(https://public-inbox.org/git/6a9fb4c2-6c80-4475-03d3-89bdba73095b@gmail.c=
om/),
from Phillip Wood (although I don't dare to interpet this as a full ACK)
(https://public-inbox.org/git/cc8cc0b3-777c-6ef8-202f-ea1d0518bbd3@gmail.c=
om/),
from Garima
(https://public-inbox.org/git/133b46b2-b2e1-4673-820b-5a5ca6ec0269@gmail.c=
om/),
from Jonathan Tan
(https://public-inbox.org/git/20190924172324.104795-1-jonathantanmy@google=
.com/),
from Thomas Gummerer
(https://public-inbox.org/git/20190924174056.GA55104@cat/), from
brian
(https://public-inbox.org/git/20190924233728.6iueqaktlhhfwn7k@camp.crustyt=
oothpaste.net/),
and from Elijah
(https://public-inbox.org/git/CABPp-BERhEp2At-ABPrkCHcqLfb32t+S0hPHs=3Dd17=
QjcZR1wPA@mail.gmail.com/).

In other words, the commit message can be augmented by this:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Garima Singh <garimasigit@gmail.com>
Acked-by: Jonathan Tan <jonathantanmy@google.com>
Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
Acked-by: Elijah Newren <newren@gmail.com>

Junio, would you mind picking it up, please?

Ciao,
Dscho

--8323328-699048384-1570563389=:46--
