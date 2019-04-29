Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E133D1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfD2WUR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:20:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:40709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556576410;
        bh=ygl4KSeYTEcYmCVZpYYXwteFPfDJa/Q8bz33CZDFYJo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H1WOO8GkY0l5+fysbgWMED5O5wSEMT9ObtAS35FjyGWfKconYOBBkH57nxiUHAhXd
         dUXl3iiUFenB61u59RmmNftZFW9VmNFw3+ikhqX5ELx7bhnkO+Rm4dWHP+muOK1dYL
         ZMXed/BHwymOaD53r3mejcoIZbRIZADBMTyZHB8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKu9E-1hLEd81lLs-0000XK; Tue, 30
 Apr 2019 00:20:10 +0200
Date:   Mon, 29 Apr 2019 18:20:13 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/macos-gettext-build, was Re: What's cooking in git.git (Apr 2019,
 #05; Thu, 25)
In-Reply-To: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904291818530.45@tvgsbejvaqbjf.bet>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZTKNc7/U94+aWLRW7reBFl/FXr8I1LRxrORK1CPpBy9vaoyLkUy
 eziYeD7zk+06wvw8fAZ1KE1GPOf5DEY7S3/fdnuCwneUYahYIvD7JT7WM9FZQUWkxeYTseC
 R5L6qJUdFkHVcIdvvN3aSJdUnUmv6N91n0jY9CuM5EeBbLaHBQGvLTQsd2C+2c08Kf8AH31
 ffzBXQ2UT4mf0/0h7yKPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jFAcr7yqcVk=:BHMqODBu22ZYyQMz1M191b
 DvEFjQ4cpapofXBcJicGCr1UwE4RYkSFdGqOpXQuY2MZWSqLANbhh+Nfswjh4JEZ/K9DcMd0w
 tkLF+5KdtqWpOFb5qQk7ZtOauiaSVYSvjCp1oDtsB7mKj+TiNgTxHJFyeJy4YEk7GlnPTXgpv
 V9UUKKlDHwYeVSiULvyB/TL+DdZXoGoU68d9WX19+qfyporFd0UbObp/+bpMofpWaWNCDtxUY
 IPs7d7hlTU+vApP3UFjfqgP5mvx+ACXujbC7VyNF+2zp0M1TrvxwP+x75Yus5vuMpfK5SxhOS
 IhfCJhOLNe/QYVP51FaNMgkAEziPUKi1fCLQ+l64QAVCYET5q27iEM5FkUvtNr3F6a4/Pp8ZZ
 KtpF/5xZTQ0Gz7mqezZ9mugdrEoXQU5hAR9bsHaxAvlmbkshSZkAdovfKH4cl2Ia+rfSq0peC
 lzn2JZNql8rBUGd+OQl205Vtq+59Wer4PPzbw9y89tyzPcjh60EME8fHotaeoP1BDagvjjLMR
 jykEIN0baSw+OH0wwKxrg1+sWLEDoHr6uz5TdL0tD75dD2Up5ZzUdERr6ub5HZ2uxz7zm8pfb
 8HQ6cCUqXbstvicJ6oj5Bkui+wWGnUnR0gb4t8UDYEKrMrcSPjSoXVbPLf/UrOY2Z2Spx/rkF
 s4ro5dNTRpKisXRNOdvqgdEdHJv1h4zpHDPrmFOTRHRB6Ice8XV6pdgNYyNfNsvD+IbMBr0Xn
 PHQvkpxtsEDOdFt5G1glnojwh3sDFgmsiFMJpPPWAOV164xBMIOZ7SwwOSWka6YG4WdxwlKx9
 SsjT3ujYytaMdNlAEQeXBTMSMrSFOhLHPfx7d4GbRapCvaCi/70Dve/c9Qc31xJ90/QNdlemy
 w0B6O6f6N/dNHW5N3rTxeREqDM46aWH29Srkf/BxT6mSRrJtg8E11H16xpSRrdq08Asa+i8hz
 H+Wf62AmGow==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Apr 2019, Junio C Hamano wrote:

> * js/macos-gettext-build (2019-04-15) 1 commit
>   (merged to 'next' on 2019-04-22 at de4cbb1431)
>  + macOS: make sure that gettext is found
>
>  Build with gettext breaks on recent macOS w/ Homebrew when
>  /usr/local/bin is not on PATH, which has been corrected.

This description is almost correct: the problem fixed in this patch is
that `/usr/local/include` seems not to be in the header search path of
Homebrew's `gcc` on Mojave.

The `PATH` does contain `/usr/local/bin` alright.

Ciao,
Dscho
