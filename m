Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6485820A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 18:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeLXSym (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 13:54:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:48849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeLXSym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 13:54:42 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1hVnsn0e0i-00uMKs; Mon, 24
 Dec 2018 19:54:37 +0100
Date:   Mon, 24 Dec 2018 19:54:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] abspath_part_inside_repo: respect core.fileMode
In-Reply-To: <CAPUEspjJSHfNtu8CyLjfRJ3JSzvP2WYcQ8f7Dp5L9vRaXvf0=g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812241954210.45@tvgsbejvaqbjf.bet>
References: <pull.104.git.gitgitgadget@gmail.com> <4fb5de504e9b48a35075cb87f4158149055f1a13.1545391939.git.gitgitgadget@gmail.com> <CAPUEspjJSHfNtu8CyLjfRJ3JSzvP2WYcQ8f7Dp5L9vRaXvf0=g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pYCsNJUCqlQrENSB1xRE/P8AkRIZeAd7P09WGHErPqxXXgmIbnj
 M+qfVq19OenIf11fmIdOU/RVjFUitE8qIVkSrro/Yv0FCAa0uYsaQzlcCoHrwOZQLNpZXN4
 5uw/uffCiv0LFgW+xCRfxol7qcxWslXcp5XyGzNCDme/JGjvrM0uVMc6MirIPzo+hUAhG8K
 pArOjoPpXZm/XUuecZZ4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f6etkQL/1a8=:wby5swm20K2qSZPpzfNU0S
 Q1RlIjRNI1Y9g4SUlTxOZxyHetJo6BY+hvYL0NbHpczoeNrc4sgWWPEI8HDpBPH/x1unqDNr0
 8LDR8QS/g6rnVdOeaVePnx8lBCLnQACMG7MJtEj6y3E3TjpOQws+l3hQgpZpKmUvHAkGOtsKv
 NFyUeoqOxFC/7cly3hI8P4Gva4CMiWp6AV4K+ZN0kLZE1urFa0L3YtOQYwUAEbfohI+qgCpUI
 hIPNZi8p+mHlPjoFinlq2JkhGaj56Pzdj4Mkas+8f7MJjGTB0DhnROjQLdYstyXYOhRoCqhJR
 Q7Xvydmb2qg3tQJa3tVk199o3WAlsQAn89UnsyIwpEyK5FygRr4BgxxkhSwP89JROhEMPNviq
 xfPFCvXBcRV9+4h5QUB+Ayc/aGCUscLpVq/AS2DQ8ljF6qmEHeSheRsn3xjxVhAMjw6QZzFMu
 QbV/nt1hu9bCyjMmf+2skPpJTy0noPpYO0CavgNwd8AEOtKfT7hMdpWJUF8lMeZGU0HuqtGit
 sm5kSmlxmK2H57RfFfqXnuegmSaD6+JaK4axtAGmxe1SGdr7eiYY9OqrpOH7j7AQo/sEYSNZZ
 gN7CNMmrckBlRjJN40eX3dMxkGBaoZ6xJ8U3FMPySfEWe5Aaxkj1oTn43BjAgo3AUZU4lzo0J
 DWRGXATjHNdT4TQZ9nVpEdrTgdnZ0/CaP0Iu/wr7IPdXEoGY73OxmZRARK7vP9u+UlnYnQ9rT
 lCkMZdab27t4Byu4UstpR2XYtKaMmGm3K7uUQS/1z+hxQ13D1MnzTJvZA1Zw1IDXrk05m9aNO
 ocRNJJE1BQB+wm14UYi4AF/os3IQeFAmPWJog769/PVHJF0KHIozKkFgnWGQTwuFsPs8nXQuD
 dx+NOCiov3GYCp7P3vCSeWED7bQBGz84It+2l3jdzs1VaxJMzIakwXHGKNAClOleuAaHCjfad
 ZrPosZwSGdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Sat, 22 Dec 2018, Carlo Arenas wrote:

> On Fri, Dec 21, 2018 at 8:34 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > +test_expect_success MINGW 'path is case-insensitive' '
> 
> CASE_INSENSITIVE_FS might be a better prereq

You're right, the path that I downcase in the test contains an upper case
"BLUB" component.

Will fix,
Johannes
