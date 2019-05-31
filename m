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
	by dcvr.yhbt.net (Postfix) with ESMTP id 370421F462
	for <e@80x24.org>; Fri, 31 May 2019 11:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaLju (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 07:39:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:45257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfEaLju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 07:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559302785;
        bh=ZZvjRvWs3uXpWOA7nGs5+Rjd3iqA1gxDz7Ds6viISQQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PxODlqiRDAsCUdyJizisSxmb8hyUHd9FYSSW9rB5bUAQy6AvOAewFy3KexMEkO8zs
         j3JfZUdmF1WgwrlZEPyDiMyJW9DICx4BrVU9Bo8w3uPKgh4Vbi5vyk7a/iy+mg+fUW
         evQPdn5uYlrum/iruIqJMyIQr/bZbJDKnJeNIY3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1gpgAe38lx-00jdJc; Fri, 31
 May 2019 13:39:45 +0200
Date:   Fri, 31 May 2019 13:39:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
In-Reply-To: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905311337270.44@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lM0q9H4mJtPxIMYvqr+AmtLhgdj7OwTZvkNJ8Od9kjt1BRd+5jJ
 QptQ+Jzjpi3jnJk05vh4Su9E9rKwIqZmBxKspjBose1ZS5hG4bvWVHyelzc9KqSAEAZZ+da
 ytTBcClmR3gB2yyQrr8H5oG/p2ivWWE+0vzMlpjYyePEk6OB+2sCTE7+CAHs9wO5p+uqIbm
 K8uywUPFTVRVlBFTI3KSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xU2k+yUstU0=:gEYFuXmXbqQxMHwndzmG3g
 Wnw/7oI5Lw+rQJBwQTwCf//ynU5xUbw8W+XJGS7ZrklczZCm9jgm+SHx4rcuNsO6P8oE+KY5U
 oaDLvNfgJSpnH+plz9E7JR0ChaLJfIDv/4t9kIr1uZRLjY72znksG4WaFT9vMYS7umf1+2JxB
 sPBOBZDGUqFNmANwGh7DWpZGidlotSdXIJZ6wI3j4rzekp43pXuH3Ap4SMOcrF7IzCt29iTIf
 SUTYuPaozuhAqTdaDZPGSc2KoVLYh/lWSV2QE8WX3RHbiFgpLi1byy559n7Jxv6VIouvUqZz+
 hPOZKJrVdesOngtbpZUtTVUDGlaiA+u1EhJy5em2BGR0/F8OZfaw3OxOSl5u0wTmVBU2VspWA
 vwMRi3XnblStg31dtsi6FwWSS7yAFkBuT5rf2i9YlENLqtJecJJIM12k8HIiI+6RqMltWOMkp
 5LOqJfFJdHXrM6g8NWiuEFaBPBhdqMZRWcgJE2vvr665BBEXSZQvRaADYbQlgcVnqJoQrcSpU
 6oV22ggMTNPVE8OsySCPqpNjWeDFky9hdWnltN7GU1lB2yGAtH0oh+CY9syZ7iCS/UU4QLUpx
 w1XU+A2QnW3onqruJVwgpks0z2yEsOe1gcPtZ6mrXyIj4s2ng0ATXemLqhEQu60xWtt+T6cFc
 Kh+kyAFFypIBVQuJ5uiHTaI664XQUPVzz3E7pvBNW0n34q0DGvnKb7MZY7X4D/GnX4GC1srTU
 88tChD5zi69Bgs1uuKgNwrrsGMWZ+beZynZrgGsU3F22FIK6S4r/OmQRMjN133QBm20hjmdIV
 0bEoC5VJv6QaWtM7JfQCH8yhMA/AkPBEb8BmyMgDap0A2gBPL1D93+O/87QZyKj1ke+RFkkhV
 etuI9Htx+9NJKPfXBEw9X+nZf0leWWPj5sua/RvrQXkdU/roIkcgay65TQy1SV5hrLadtv6bO
 2IroDYKDwD1mU9rjXMTLq7ytgNxWCCeQN+sfpcyNYIQmWpRxvHRRz
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 May 2019, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The second round of release candidate has been tagged, after
> slipping for several days to merge a handful of last-minute
> regression fixes.

You hinted in an earlier "What's cooking" that you'd maybe go for an -rc3.
Is that still the case?

Or for that matter: do you plan on releasing a v2.21.1 before v2.22.0?

Ciao,
Dscho

P.S.: As you might have guessed, I would like to know in order to
determine how to proceed with Git for Windows' `master`: whether to hop on
the v2.22.x train or whether to stay on the v2.21.x train just a little
longer.
