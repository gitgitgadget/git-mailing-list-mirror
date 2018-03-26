Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB921F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCZN6w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:58:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:52337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZN6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:58:52 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lp3Qu-1eNnuB24lo-00esH6; Mon, 26
 Mar 2018 15:58:43 +0200
Date:   Mon, 26 Mar 2018 15:58:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <45d05a89-b10e-5035-7c5b-2981dba27d42@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261553190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com> <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com> <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com> <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com> <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com> <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <45d05a89-b10e-5035-7c5b-2981dba27d42@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sVFldAZQiwJ19u/ECbP5wHiXnc3Oo7TffNCOBt9l2wLnUO4f6f+
 bQ3dyRFDoKHWMjQQ/b2QeU/Obrv7oXbZouIBuqpehHLs+612bOgBnhSV7LGbB79arzr3MGf
 DfRR4aabuzoYtVRHcYYEHguqJkggD/G8XYOYT2Sj5E3JW48fFZzOAFHc3/liswbf5GshpX/
 F4LMkFKyauvVrOcS6oHZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w0q04aGH+kI=:iieLoX4qk440tHhpirjYUL
 ElYdKWSM8qj2T4BbU147pHm4vDiaVRZYSTXcrVpBG2O00I4frRTxTGsZDsmOI/kArStw/+Aja
 IvyXRX7Bs0UIVN6C9mPRb37zHYn9ycsUG8ZzJn3cU5Rwz/OXbSxwGj4MJ18bbfJ+5hGkL1++G
 7VVxfvWSZfEu3b4FDIkoJlw977/vtQqGpehBDC2kNkcXINJpB98/FlW7g2nuLW8vyAeCOPeEN
 MPOeGkYRLkhmNOsPiDcON3rjJS5wjZJURdCCCdIeNlWRgdK2QCvITUhPK9C5alYCKXOMAgmbc
 oBOrH58rHMZcWpmK/rAB0tFNP5bozlXrDAfJ20wbkstO+13wD3Qc/Hygwq6a7YmfQ5NAZVuGd
 OPCUl6I2tiTk3meX+G3Zte2TDggvq82O7+TqVQfw4Wm8rHQxmdm2ARk9Pd1vr/wytdfvj/WdA
 KJ4/NYUhfwqpwA+05d/+a7qu3Rpdu/7EL1nleVR7tpQ8CPNZ5N8RB+9Of6D37VJ1O6nJPi8m6
 Ygb9uQN2fxoklENYSQRuQ+4bXtvDYzxV8uzveFHFgWyUPAhiT5PjILF+uDsKekblhXZM9I4Pw
 LQea75yOjEt2ZsjPgZMSkBs9n2ajpsFJ70H0Xye49hpQnw0wgeqGrp+ggeFV95w4v85Nz35Wu
 XYiNMJGarvH4z7JvBNXVLMCCz1PXgRCPPTHZCX0rUkIcJGSnMGeIDonrpd4Z9uBV9BYJQGbgc
 Xn0mBokRJKaG/0OXgltN1qvNVpgp8/lqxoPWNRFSVirPFpsQK30wPebzKerSkieODETDPJFmd
 pcK3t4DapnpKSpS+4jpuX0eciZORQjSMEhqSf9/UgzB3nBEkjigmX2YdiT49DzI7BpIsixJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 13 Mar 2018, Igor Djordjevic wrote:

> On 12/03/2018 11:20, Johannes Schindelin wrote:
> > 
> > > > [...] and cannot introduce ambiguities when rebasing the
> > > > changes introduced by M (i.e. the "amendmendts" we talked about).
> > >
> > > Hmm, not following here, which ambiguities are we talking about?
> > 
> > U1' vs U2' of course. Those are two things that can be different, even if
> > they ideally would have identical trees.
> > 
> > Phillip's strategy does not leave that room for ambiguity.
> 
> Ehm, in Sergey`s approach, this is not an issue, but a feature :)

Well, in my use cases, this would not be a good feature. It would be
highly annoying, confusing, and cost me tons of time.

> If U1' != U2', it just means a more complex rebase happened, but it 
> doesn`t compromise the result (rebased merge) in any way.

No, it just means that your strategy failed to give a consistent answer to
the question "what would the rebased merge commit's tree look like".

> On the other hand, if U1' == U2', we can be pretty sure that merge
> rebasing went as clean as possible.

With the backsplanation I gave for Phillip's strategy, I can be as sure
that rebasing went as clean as possible if it does not produce merge
conflicts: it reconciles the changes introduced by 1) rebasing the merge
tips with the changes introduced by 2) the original merge commit relative
to its parents.

And even if it produces merge conflicts, I know at least that those are
conflicts between those two sets of changes.

Ciao,
Dscho
