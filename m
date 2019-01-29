Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419511F453
	for <e@80x24.org>; Tue, 29 Jan 2019 12:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfA2MzT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:55:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:53677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfA2MzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 07:55:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwrS8-1hCmBk1fI0-016SQA; Tue, 29
 Jan 2019 13:55:12 +0100
Date:   Tue, 29 Jan 2019 13:54:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pw/rebase-x-sanity-check, was Re: What's cooking in git.git (Jan
 2019, #04; Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291353340.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CqFNZ2z2UEiV94s5QS81NBjd3nS1q5aTlSPf2McIXcT3sMeEEQv
 IspEGeStW2Xr2x4Ey97zjvxgSm7cPb4C7TDDrofBoXYJlzGGuT2Rl4/cayI9rb5Ux+raw/f
 O2WmIos1g62N08k3TR7BGkAt2VVbKf3RTYAOfiz4absbALsXbhB5WqS4JqaU/8l5J+G4LrQ
 loR1wFA4ufQnRhz5/yemg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5sLi7vhXEA=:wrDo50Zr/2Xwtj8hommt7q
 R/GJWoyYK/E8xbPNIivdxxoDYVQ/aHqWUg/O9/lYYdaGXTkNb4P6DxBge4XDtU6PtVrkbLfWp
 18cOPY0x1LW8UiCBotYY/UnDq0r+KxM43allS+IlsKaE0cE5+AoPiYvZ9QAemAVlMnb/kPKCz
 2mgTbU8A6+ijCmPOf+s0yVLVCD+5wXM4vY9OUPRHPMPhZ7hxd19CuUbi13Jc7vOmc4kWtCKYh
 Zmx6CZ+43IDDMjviuMm5+kNoHMQUlYyBrVykas/0JL+p9M5STd0JCiqKc+uj2vxKsFcJos7LJ
 ZjXbJDiW+nK7KtPgONdHTlRYToFaeouObcnKwV9HyoOECAdCApo+Z1tmcNbVa400jcehBQfid
 5rhfZHh+zXX9yczRWdYQB2YeHQuE/JTQjwF38ERxTjNusQnJhT1pK7XBY/xzNt9qlpmtgdgFv
 vp/3JkwZa+bgJLWN0JKoF4dT2jkpHuqhrsJKAkWA8Sy2GnhzTzmzem1mfNpZrmMC1NRgC3+Tx
 oIXWZdt1zjp4BWNWhkxJBRoINQqdFY044aEbOo2tM0rry7pljdxgC6jx8kYEwEpfexDjfT0/j
 zomu7fMSaFu6pi3XPr2zEAdJrbSAs+xum8ST7GBq2jui7E2EnPNdc7g7DVZPcg4ipx1Gbm+RT
 FdDjSl4lXjs5TgKoaSJ3h63pyfS1ihFrhxAILdK2T82yWiVgPImuIuXynUy6SZ7MMF10q7WHR
 Wp6evjuueIpBnykMltqKU38jtGvemiXQMQHzDj+lA2sG9QmN+NSt92pgvpaL3UmN8NeFZ5nrQ
 gug0FZ3LNrBA1BWde4pkcnwPP44eQWcNOx0ADwZYaHneHCiW0c2bpnCpMGZ2BLuwlv+0Jz1Gv
 WBVBz+UnUNcDEUfsVlgnRWRWlJTrbtT79dEQYRGyRAFY50xs2BEyZD8InlowsimjDYAKh5bEH
 1Bsx3L2vHrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * pw/rebase-x-sanity-check (2019-01-28) 1 commit
>  - rebase -x: sanity check command
> 
>  "git rebase -x $cmd" did not reject multi-line command, even though
>  the command is incapable of handling such a command.  It now is
>  rejected upfront.
> 
>  Will merge to 'next'.

I offered two suggestions: to use a more readable `strchr()` check for the
forbidden embedded newlines, and to not bother with special-casing the
empty command but instead handling it the exact same way as an invalid
command-line would be handled.

Ciao,
Dscho
