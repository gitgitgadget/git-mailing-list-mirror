Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAB51FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761309AbcLUR5m (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:57:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:62162 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761214AbcLUR5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:57:42 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lta9E-1cl5dX0yCC-010xcE; Wed, 21
 Dec 2016 18:57:31 +0100
Date:   Wed, 21 Dec 2016 18:57:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
In-Reply-To: <3f06ea33-b4de-48b4-593e-239eb6e87dd4@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612211857000.155951@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de> <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de> <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org> <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org> <d661dbf1-9852-965a-2ca9-67d763115b9e@kdbg.org> <3f06ea33-b4de-48b4-593e-239eb6e87dd4@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4jSKuI96A5e0J20/eQTJcFpyAifxSNQque2GZcCCxKEhep/k2Qa
 XMiNMqGoHFYRU/XHEc7OKV81dKDDzdXmTLDog1SowqVWAqClDCdnvy9n1qFy15JVBrxw9YK
 p+sXBwk8JTsKkO2R2KR6nDvK+T4aKEVqM4OZCBIcvrJW7E42rsLXQdkrXkCZVgQBgLO8ZsS
 VLlWin0KZDA7Wp0QG6iYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zDWVTUlLXAw=:JMJt8vpnxvm+ptJ5us4BL6
 69IzSlwZj/9ZZoMedmTF5X50qydPitb6AlKv7h+ZfKgYgn1MwmOdlKZNEth5D6cTnawMLqRlE
 ngmNs1ohgm9XM1ORRC7zxIgHB9fayyocMPnRxEmft4s0PdTJpsjGN2Dw9JQlf6KxV8hEYatYK
 suuaqESdp4l/BjZ8kYgazTd6d+brXRmo11NiU6hZtEWALkse+sgcsv4HCuBiY5NziD2bFMYCu
 AZCS5ptm4rn/Jd6KT/zbS5DkSop+zBPG17IK2JvhQMZfcBS6gPhyvX/BNp71RCmpio12ysX7+
 zdDRQN6TsEAGWYvjyF33Du8qnS+BtOSk4GFnO12NPMSOCN3H4/VFLVN06FtEinibgulUH36bT
 mZgMN5tbPxhqRUvmgBUFg6C76AYQZS51ia0egCn5tAtkpTQh+B1bBiSZOHnaf1gRxQ7Rfliqj
 hVS09hs6Sxx8U/kXehnkBLBAAsZ6Rna8jWOh3g4eVWTfbpHkWVxPSmndExJNK8h6N9d+GFqVZ
 uBbf2te/mRumrfvH0fPD/XRPeroOWf1HGkgGhrdSa7rCPbr+pUrTw7NfEkFZ8Q2EL4xZ+mzFF
 5urBJeQTXyW+OC+v0xMu4CJ9Qo4g5+rv77T4RY9gEXILLH5iJjo7xgqF62mZEhOowuK9OlXsl
 sMwyDjjtyGAQG/q0LnEINbbenaUHlyEBhqWBjgUWXQNkpN6q+tKWBlQYWnyqSbLi8eSlylxRf
 H75oLMfsTQIAIrbzF2qmcAjuvZdWtAFArj0ZTWcfCMz5VJXLbyxditrVuYwM5u/M15EXByu6e
 vmH99/L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 19 Dec 2016, Johannes Sixt wrote:

> Am 18.12.2016 um 16:37 schrieb Johannes Sixt:
> > winansi.c is all about overriding MSVCRT's console handling. If we are
> > connected to a console, then by the time isatty() is called (from
> > outside the emulation layer), all handling of file descriptors 1 and 2
> > is already outside MSVCRT's control. In particular, we have determined
> > unambiguously whether a terminal is connected (see is_console()). I
> > suggest to have the implementation below (on top of the patch I'm
> > responding to).
> >
> > What do you think?
> 
> I thought a bit more about this approach, and I retract it. I think it
> does not work when Git is connected to an MSYS TTY, i.e., when the
> "console" is in reality the pipe that is detected in detect_msys_tty().
> 
> At the same time I wonder how your original winansi_isatty() could have
> worked: In this case, MSVCRT's isatty() would return 1 (because
> detect_msys_tty() has set things up that this happens), but then
> winansi_isatty() checks whether the handle underlying fd 0, 1 or 2 is a real
> Windows console. But it is not: it is a pipe. Am I missing something?

You did not miss anything. I did. I broke everything.

Very sorry for that!
Dscho
