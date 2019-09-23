Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A201F463
	for <e@80x24.org>; Mon, 23 Sep 2019 12:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfIWMrt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 08:47:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:54523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439554AbfIWMrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 08:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569242859;
        bh=IRxgxVEbdioAe7A9RYWsngXvNGyCE86zxQ4IUnkvxRo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YAGd5lxayYfABautK4t0zdVWI0IKhjVB7Q47aDjQY4k+ItpYoNrJjowp6lulRSNzU
         NJW9pa31xwPV8x9OHy8lQr135Gx1RAFV9qWs2fXYeekFstOhymQ5ZKb9htovlc4Sg0
         dbbv1i2W7rAPLIPPClkXm0j/Y6AdRQttlFZuIyEM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1i7ZXY1Jyp-018KJn; Mon, 23
 Sep 2019 14:47:39 +0200
Date:   Mon, 23 Sep 2019 14:47:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190917120230.GA27531@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1554641789-1569242859=:15067"
X-Provags-ID: V03:K1:OlzRZaKZ7MB4DEqZW8xuFQi2uc2tFvhpjYkuubBfvljq2YXZUI/
 O7PXG7fFr9gH2ild0OpTIhG/2z6gHY0Oe7mz3FWr6Hw0Q4TYz4c9u1caLVRoOjST8/QQhyl
 WSDAcGxlTpM/kODdGjU+tsi1IYlTQ72uZIER3y7s7v6n5HaJxexQV44jh/wXtTvZ1zbUhx2
 fy9Sn/ScH6+Q6nAO9m5gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4KGN97ppKs=:eTW3m40iIlMHlw18x+Ksp2
 0/tpm2r3rJX8DCPYElQ9q2rb1fHU7/I9/LkqcjUMMQoEQvF4sgeSEfQdxr2E/EsFjdsPsXtO8
 gytBLOZhWtFgtCOtKkv5tTLBUb3tYwgoBigKLLCaKGk8aoVnRx5rOtHIIHR7bI2llsPK8MOAF
 HVPsX0zV9zQqNRlI7+bQvLnMDJF1H8/8K/L1bC81K+VC0xV4G4EZswFz9o9XPmkjwt9ijLYX3
 Z2qKzdK4RvXfK6RSogQQ4qe2C5Qgzbe0aTqXEFwINTtEJ6c1tDl59ktHWaRrVD4TxplMSWuQv
 MGmYt8GOKz0AE0x7AB/HbmzopD6ZKlc75jcyaBauet4Vr81v4N+MbiD7sZ/DCfclpAdo+GigP
 aua6kvIEuMN6JsTbXjhbqk89TGkMsY+ZkPDHO4Ev6oj43XiZoGDDifYE/tXQ/7ZX+SjhvaYcd
 60G+99tFqIk4J+TkGvXn1ctHLDYvFYth53JkQvzeoE7cvZALyt0aVN+JFZ/5sUjJrSZPZbUi/
 0Uoy0/r6eyfTEYnzRt92vspu19yg+S/y57BbSJ5iBs4BSVFeK636VJ9Ck0erxAzpPWYKeQCRN
 FX3mt3zGrGo4qS1KtFAa8UaOitxwxBuIyDOdHJBSyRSHNmNAApQsWwsalGo/oo7m2EVCh9zVJ
 v1xb8cgvBipVQWbX0VGJBQAIOaFQ3/QvLzj6AoxXV2LHCuvFSG45GBj4+F7PuCUOxdDTa+Trr
 kUFlD+rleJNvlXcYiwC8QfO+y9znuYi1tpEQlefhjUgnPRhx9VR+DeCP4GgfuNKLXMTEzlL0R
 OHP0lWWX/WOtMW0Onqs+Q8L8ZhkqCkKtf9LUQPy7lLpBzJTvghPlR/0DiUEbDGy92mpVH2wbh
 jRbJRqSwgfZPQhT7ysBqfTvT3gk6gpQxSAOcbZ96FrguLEBJpaggS2dtDid3xV1o7Ks6b7D37
 XgRiVOWnpuOpIWIkXhAUC1NtGDEIm0L8cNld7EFPUBTW002+XSXnTY0oSsrAuFq76aIS1Ckvp
 Rz/RNciU4foCMC4PQbEZ5+KZTcLycg/VCPChI0A79WYw/cxqGRBEy+Eyg5hK+qjC56QnkbtXH
 JEepODyH9oN2RaFDc5YIePgq2Mo6Pjl4k2GV7eH+qUHmL+K8ug7+IyLV74mpY81TVqXS4Ot05
 fVdyGFfhfGhO+TE8MgnjamQuewsnymMe0wVBzaTTmyUDJ4gK+6+3ZxZNZEQxoetRzTWqtoF8O
 ZVglWB8YSRqZAvjTa20hcLQb+ChxIHBkRZqKnnhP2VP+Wr5V+LTIa637Vj3M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1554641789-1569242859=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 17 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:
> > Also, things like the code tracing via `-x` (which relies on Bash
> > functionality in order to work properly,
>
> Not really.

To work properly. What I meant was the trick we need to play with
`BASH_XTRACEFD`.

> > and which _still_ does not work as intended if your test case
> > evaluates a lazy prereq that has not been evaluated before
>
> I don't see any striking differences between the trace output of a test
> involving a lazy prereq from Bash or dash:
>
> [...]

The evaluation of the lazy prereq is indeed not different between Bash
or dash. It is nevertheless quite disruptive in the trace of a test
script, especially when it is evaluated for a test case that is skipped
explicitly via the `--run` option.

Ciao,
Dscho

--8323328-1554641789-1569242859=:15067--
