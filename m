Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55AF41F462
	for <e@80x24.org>; Wed, 19 Jun 2019 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFSU6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 16:58:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:60693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSU6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 16:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560977922;
        bh=lHKxgnKGMOVFBjvJaYz4l+T97ikz9uVelISczlIX5Os=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VOHMbhUBxascByyyFlkm6Oz0JEHyuQrpPIJicJSJsY4v768CJ8SGW2yE3CHwhYb/X
         7scZgntp2SRRcVuZVGl2oTGAuWEc96l2qREqoNhZWLJ9CtdN7kgyY7tN7EbmaOvBo0
         cQTc146e6RCW787IqME0m3+v1dg5YDuRaWRzWwao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1hoPzF2bRj-00GHIP; Wed, 19
 Jun 2019 22:58:42 +0200
Date:   Wed, 19 Jun 2019 22:58:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
In-Reply-To: <0841b134-0719-8bda-41ec-abd124157df6@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1906192257000.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com> <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com> <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
 <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com> <nycvar.QRO.7.76.6.1906191325130.44@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1906191329040.44@tvgsbejvaqbjf.bet> <0841b134-0719-8bda-41ec-abd124157df6@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ry+PLMVdS+iwYulkBrZGVc0WP/GF6iCMJ4zGEi8QBRymEAAEC1+
 WdARPBHqNAzZohxLebEEh0vhBMaBWUMHbaqdHPjQ0ePFraGxzPRVYC1UUKIXfOTDd5O+AAJ
 qnsLDbKFQa9/r44j8JLQZWIc1e9gxziI4AmC4RMEv2wvMsBa2HOMbEHRkta59n3yNHBSBae
 2osr3rB6JjDdUIChhdtmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:37mltchjI+o=:G4L9YJQslToM1fQOxkoJTf
 fFl8wXFeXwIC73hXXAuc4i1qlp2FUS2ZQAbG7r8e+lYH72J1mRg+RC9mWAyC5+SL7xubmx+yz
 sO4iCNikYvFG9DNqtnqopSjlu7eGVYD+2Ist+S5zilk+f9xzpgUP2Gyo1IXMxT+tGIDVFsJVm
 /DDIEJRywKQIK1LwuhyvCphkXfeU8atTDM+qywPBpV7Wcp9ydqUYmYPnGqQPEkOviwQFZstag
 rIFSgNg44xEi6cSF5Dw6yS6aQ+HnYM0sm9r0xGwyWnbP8DFK6jFJMwKk3l60vCVHMe7iEDg95
 VeWBzIPB8Bl5u+eimQnBcQ7k4BlOF0ARwfpL308jGryxQ4iVbVK9f0MfpKd9ZKQh3C9aBHYGR
 LZC7EbwYPLEayE7mZ8g2RLWW5I+wqQjNIIDT0cvTHc46pHBAnaGqKcoBBVkI/F6cQ/7HhvUok
 mgr2DEIi4NGglBy1i/JxFropeUcrECs2eLa2vrOKSp/uiQJF1wmBrgk+Fle/xTP/2jDiw66+l
 IaaPQrW7rnj7pyVeZSj4qwUCmoySF15FkXRDhgAF5Asx0c977yeOIUlJQ1ImD3XR5OgdICGC1
 PATFS7BDWuTrzJHhR9BzqmRiJFDZpFMOqn3tZoJd+trqDOnc9nFtuGGOtr3aDBgA8mZ8epn66
 MzfOJ7n1h5zSJGS2Ikp8dHTWF4gx7bgsJlD1ApnHHPVzGrIFjEo0dZ2DLzZ88nxXBu0Uo2V4D
 xPGp9mftCBr8NGYLPX3MrdcJJ4uv00sm8su6TSKcNs3bk1K712DB1lnjGx5H3v1BSm/0o7OFQ
 cVc2OrnfbOww4AQb4yPMR5LGSiS9GSKsHY9y7PIgWJbPZp9PCeiAGZ3fiV/xZLGUHBFt4cvoV
 kGnomi1Kgv3mKe7ktBgOX/72VJ8NRcE1qA6W3hhnJ3vZMoRbul64nLYM4ZjmNyW1RTG5DoPR1
 WkRJnx6Dw624U2fBvjoC07GNPOQA8lKoXpuJ6u+mg10JbrYbr5neg
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 19 Jun 2019, Johannes Sixt wrote:

> Am 19.06.19 um 13:30 schrieb Johannes Schindelin:
> > Interesting side note: I just realized that t6050-replace.sh does inde=
ed
> > contain
> >
> > 	test_i18ngrep "Needed a single revision" err
> >
> > so I wonder why that works.
>
> Why should it not work? If GIT_TEST_GETTEXT_POISON is on, it pretends
> success; otherwise, it does a regular grep.

Ah, right, I vaguely remembered that Duy offered patches to do something
funny with a pseudo locale (I never understood why not go for the much
simpler ROT-13), and I guess that effort never went anywhere.

So essentially the test case in t6050 will succeed under GETTEXT_POISON
for the wrong reasons.

Thanks for explaining this to me!

Ciao,
Dscho
