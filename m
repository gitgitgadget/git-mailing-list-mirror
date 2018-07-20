Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FDE1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGTTrl (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:47:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:38187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbeGTTrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:47:40 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1fmJkY41Lx-00Eheq; Fri, 20
 Jul 2018 20:58:00 +0200
Date:   Fri, 20 Jul 2018 20:57:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit
 pairs
In-Reply-To: <CAGZ79kaft-8pHGwyqAK0yNL3p5sP0VyKNn29dxoZ0wFGWGEHPA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807202052350.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com> <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet> <CAGZ79kaft-8pHGwyqAK0yNL3p5sP0VyKNn29dxoZ0wFGWGEHPA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2070311408-1532113080=:71"
X-Provags-ID: V03:K1:69davifo1Cgwnn8B9DUbsq/QrWsnWnquuyfT62tiSiI4NL0RGzA
 Xn+MQssV3sbTyjPcesj2r2j7KLuJrJtT6AQeNC9Q3G9G8a5Kql+jU+yxzLc4HlF/9NDNJt0
 v2avRUSTwi75LwYhZzwJ9j1bViceL/i+fp1uMZngoztVnuyBEfvZnnKXHBpk0zIqkOECT93
 WWjWtvz4vTYr7r18alPjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pTR+2ekhNCE=:mZOu/bINkKx144abqCmb+q
 Vy8C6PRR6QDzB+UTW8f+Fu3q6TJbzaHtMxlOTnvSji8PiLNN140WwXQEDOUneVpDOVnwQEH8P
 EjMk3PMyPq3sBsBnYx5z4qIxt4Yy9fN3BLpfQeLbVx+XGAzn5IZqN8uHRh/wA78+PiDZEGnBK
 RyLwYOGV0sDKAJVQSB1TbAkaqcGHSqwck66Hgfjn/3rLpENyRLW379yYQyJbRS9wVdijRIGOt
 QsByxs7qs4MUpZphYAVFSy0JGOt1b48RCDxzlUsfkO3hIotfuhOeHKZtjkOlX149JSDtaB18U
 oSgAujDSHl9OI/aS900tD5lr4uN31IdWhxyKPbOSsei/uCcL4ogLos+sFh6EJ1oKWaSWMJXMB
 I9xst6GHvgJ2yIt32BhGiv8vf4z7O+lo3WI6Ps/h6ypbEoFL2dxDiU+Ro3T8gNKLEtXW4qDkp
 wPVq0VV9w+d74AxUGJKPtcI1Tcw/OrRmUDZ1D6w4kN+m7AyaEQaZcSQ1DS+2VD9A2QaCy3BlN
 oFJSA+el3ofR9drXTG1GMNPpc/cwLhiSApABCrCo6vloiSK0vf0wNYZItIwt1zc4a6HagBlWL
 A61zgxa0/frQurKRMCSTrsGuMKi9RM+mM2RCw3NLlQJ/NWXffjyQ3xXaIh4VuOh9GIVhzBJOE
 wGsNE9Lue0bvEn0X9J/kK/ZuUdesN4VBOEyyNRV1E0nsOBImYKBFbhywAp/74FxxKPGHSP0uk
 EWLEKo8ijghUgRQi/BEstjQVx0a5sJosDTxFcNEFZFQw0DWKMGaoQqVIrdZeu40xG19fMcQWx
 Zg8qbYE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2070311408-1532113080=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan,

On Tue, 17 Jul 2018, Stefan Beller wrote:

> > > It's nice to see that the bulk of the range-diff functionality has
> > > been libified in this re-roll (residing in range-diff.c rather than
> >
> > Can we *please* stop calling it "re-roll"? Thanks.
>=20
> Fun fact of the day:
>=20
> First appearance of "reroll" in the public archive is (09 Dec 2007)
> https://public-inbox.org/git/7vy7c3ogu2.fsf@gitster.siamese.dyndns.org/
> which is predated by "re-roll" (05 May 2006)
> https://public-inbox.org/git/7vr738w8t4.fsf@assigned-by-dhcp.cox.net/

Real fun fact of the day:

https://en.wiktionary.org/wiki/reroll says

Verb

reroll (third-person singular simple present rerolls, present participle
rerolling, simple past and past participle rerolled)

    1. To roll again.

        A player who rolls two sixes can reroll the dice for an additional
=09turn.

    2. (programming) To convert (an unrolled instruction sequence) back int=
o
       a loop. quotations =E2=96=BC

Noun

reroll (plural rerolls)

    (dice games) A situation in the rules of certain dice games where a
    player is given the option to reroll an undesirable roll of the dice.


You will notice how this does not list *any* hint at referring to
something that Junio calls "reroll".

Likewise, I have to admit that Wiktionary's idea of an "iteration"
disagrees with *my* use of the term.

The correct term would be "revision"
(https://en.wiktionary.org/wiki/revision). But we, the core Git
contributors, in our collective infinite wisdom, chose to use that term
as yet another way to refer to a commit [*1*].

So we got it all wrong, believe it or not.

Ciao,
Dscho

Footnote *1*: https://en.wiktionary.org/wiki/commit#Noun does not even
bother to acknowledge our use of referring to a snapshot of a source code
base as a "commit".
--8323328-2070311408-1532113080=:71--
