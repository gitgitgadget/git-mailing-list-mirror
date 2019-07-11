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
	by dcvr.yhbt.net (Postfix) with ESMTP id 609121F461
	for <e@80x24.org>; Thu, 11 Jul 2019 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfGKJqw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 05:46:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:53831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKJqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 05:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562838403;
        bh=P1mNW8OEaxo/szrDFWulxpmnui7X/u/2s9OMfmqJ0/E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kj05MtFDb3cUnv1WxiemgsBOucq5wFf8I4RI5BA/ySggPIKCRKCLSeIzlaAJWJLni
         vyqgPAbuQAw08MQ2/B3xF4bIOFfeiqaN/4NWf6AVSGciOFMu3UJvIT8H3UZv2woSCx
         1Mu87Oy1wpjpwo4jxi6rZOLPM8LP/jPKWYKREfnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgeFd-1iF7GJ3oSz-00nurL; Thu, 11
 Jul 2019 11:46:43 +0200
Date:   Thu, 11 Jul 2019 11:46:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
In-Reply-To: <20190710233937.GG9224@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1907111141380.46@tvgsbejvaqbjf.bet>
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com> <20190710233937.GG9224@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A1FffStv8mOYDn4ONUcOvH0wedwvUCjm8xyx9PZbnUmIfKPlYQF
 e0K8rOMkAJ+9QbbTwtjgWcJf7bDJn5eEJo0grF4XbSXQ3LfcF9J+0E3muhq0Bct+f+aKQaX
 xswufdNAiX0FMK5x2bdVRlMwWLMYEYyttRmm2f2N5PrDcxK6i5gfgRk2tZ4WIe4xN9BM4iT
 O/SbnJArrbpVvrXqGODtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mBRKkM/N2jw=:YeOTuv5DQ2Qxk8CA2oTKn8
 /f22kVDhYuc7lqV6PB4FbODp+rmWwtkuN+l9Hl85DcEZwhK+/kNvzg3mWeeGtz9EhZhw3sdkH
 13ICMToAhgChJqhiIXXkDk3/E1bTDlveYHC6GyDmQnOnezZbH3v65+ZXRcDPLSZdu23hAxlca
 kDDqP5uN2IEa/P1dvje03XaFdXmsxbWEWjAi8WXffiQKTKcGJf9jt+ya6stGT3T8LGWphJNYX
 Y9DuIliF7mhdOQRtT+HPFhY93gUxhtWXiy8DmAQKa3OLuUVyKGA1MbabDtS8yjvLQqQuiMSWn
 zAx5p8e6xjvJT2w8R6M7ILlqYxMEB3UCFHofcTxo67oEqDC7aWL/yzn/tnEHNLDX6WhRjZcty
 EP9jmHBO2+aLU+e9PCbrltLmwaDxJ95fqbxkWl0k4+BHWnuydmiP2BtUxbcdDKJ3KERtmBM4I
 eq7mpqcwk+y/68BZDfZF7diTih2NZadyHglZCdxRpzH3IfVH10kY1DXsmjCyDyGPCcSGr3Y33
 4Md96jyAiMz7lJeNnJES05yzT3+fwnW8C/XSpUxRAh73aa7mXHxnZg0RuZI6hU6H5D2RUWT8d
 2QeeplEjEgdV7V5kqJ2oe3koAc9ggr6DPXjHBrsj8xJMTYXuctuNpsVJg94MJMZwBTXKKCoz+
 p32UNB3utjkrpw7SL13XLmRIbMkUUI3ArYxr65F0ZbOfY7+Nx7g4PQoYmPNcerBGSkjkHbEAq
 DUK/OHcUAVTz1IWO9Y7efCpFkXM4dRECxIrZn93SjS2qP2xUsW6VATMYWFCek2uiYhL2pm8mF
 nmRKLpT+lAMoH1BjY99pVZ2dDiUsWioqqqJURNttjktYojk6Q1vHybzHHwFxfLBcDyCOB+WlL
 cRv4rcmHrNs4xgJ8UBJz0UCoAruZE/CvBKJB2u2wPmPoHk2fEYLNZxpb8nP/Oi/sIfh8+YJp2
 sJmrzzl2FL9I6ZNhuo0ACpCUb+YUykpbVN0BZu9ko+bHUluGJ6GghASM6EeWT1Bal81X0CwqH
 IDBzJkQ16v+jBUlZu3nDD3ll7+61l8Wp2SC/ws1eZDJsWbu3kgeoH/xfFYRL+xeyLcMGqAfyd
 mUTmD3m1xKrePpnsCgMFk9X/G3FHbls3Yxw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 10 Jul 2019, brian m. carlson wrote:

> On 2019-07-10 at 05:06:08, Mark Florian wrote:
> >
> > I learned today that `@` is a shortcut for `HEAD`. From `git help reiv=
isions`:
> >
> >     @ alone is a shortcut for HEAD.
> >
> > However, when I tried to use it in a command I frequently use, I got a=
n error:
> >
> >     $ git push -u origin @
> >     fatal: invalid refspec '@'
> >
> > I'm running git version 2.22.0 on Linux.
> >
> > Is this a bug, or have I misunderstood how this is supposed to work?
>
> This is a bug. If the destination side of a refspec is omitted, and the
> source side resolves to a ref starting with "refs/heads/" or
> "refs/tags/" (which I expect it does here), then that ref is used as the
> destination.
>
> I submitted a patch at [0], but it was decided not to pick it up. If
> Junio and the list decide that it's wanted, I'm happy to resend or
> revise and resend.
>
> [0] https://public-inbox.org/git/20180729192803.1047050-1-sandals@crusty=
toothpaste.net/

After reading that thread, I come to the conclusion that it was not so
much a decision not to pick it up, but more like a falling between the
cracks.

I would be in favor of this patch.

Since I have your attention and since I am interested in a related issue
(when I wanted to propose a GSoC mini project to let `git fetch <remote>
@` expand the `@` to the current (local) branch name, Matthieu Moy
pointed out that `git fetch --current <remote>` might be a better UI):
what does your patch do with `git fetch`'s refspec arguments?

Ciao,
Dscho
