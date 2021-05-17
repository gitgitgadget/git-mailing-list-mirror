Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF2C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC21A61029
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhEQPLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 11:11:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:53957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241406AbhEQPHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621263949;
        bh=qtIXqYI2wvpXaXggMXfqqkPdvgSnOzcnPPKb1Q9avCs=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=gfEdsi8g4NwWMKt3bogr9WEI2g7YNGCjhbEKFxv9IWOtMTEg+oe+v4sjH4+0qkB4z
         6Yd2ETjlaR1GApIG+M6pSGGzgxxpoBf8vZN1aWvHeyfbkzKmodhuan9rqD20iUQsby
         sAdaonO7WTFPzyxz7+WvfI+sdv2G2E0inBDDPoB0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.216.183] ([89.1.215.198]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1m190E0GX9-00JcR1; Mon, 17
 May 2021 17:05:49 +0200
Date:   Mon, 17 May 2021 17:05:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.32.0-rc0
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MQe5k-1m5Hjv0XeY-00Nj2Y@mail.gmx.net>
X-Provags-ID: V03:K1:j87u5pcUrQU8wutJY4LCE9vR04XiNib18u13YlyIgvkigk2q922
 fdZ5UXAK+sNtofcYYeypZEkrQ0/ZucmDctsS3oxZzIj5YoITX011fY3wSdoT7eMk5oMwi26
 60p1oiYq/snbjg8RycvU5gOkRpkzc49i70nrexpRnFONEESNK7nZ7YavekWaXD/CkgdYLVv
 5xi6uNGKs97Ee3ahw3PXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jh1owFzxf58=:MGDiqEUngtbGoUiRcMtICG
 Zkk5VnMEUXh5CGoZvU/OLHOAywShIzztfd9195a081Jt3ewPjTH1Zckr6h27xR7J7NJZwLV2S
 Z+G9zLL8C3uzehxPRvtBxAn3ppz61DnZFyYdhsbrylCzdMluJvulRxhphfjOOiAsY7T8TSdqI
 JtcP3SqYLLXrQ9cJ0gSYLyCaM3k6NtEaTIGSdaa2ujOTCwMX+WOhW0vIg9OLzyWQjYlujbC/M
 ZBEomtMlfkdZlt0A/0uFSKnoYHjgASFduehDMeBoPRqeqhvQKqsdg8l+phHw/4Vxd5qB+CG7C
 V9TcsVk+ZhCoYhCjxakRNXOtGLHj4JB6QqA8sovtN2+VUYle0d5szeFLbmDbhF04D94RLVz+0
 9q6EZjHDk+tXWwj3RJwXg51uj7O4wKnfJ7R8KzeSI5tGyjcUpfkxHMBwoI7cLRC4aqMbefyxo
 Zku7NUgqcZG4AjslJGalYiiUaggkOZUQNTISP0t6D6FoAGc2gcG3V/16I2AhbLUD1m7F+ZGPc
 50pF0AnH6dJCBCc+C91qA0JvnmnadXO5k7Fc5p0iut50+pCQijR3HglJ1MuGyl4l+aikAiqhg
 A9wrbfA2jG2Ne/txokTqVsS1JwRNVO6n1j+xo1KfzzrAGDDzQ+zXf8OYfSTucCyxg1nZ14VdT
 kuPV+CMYILQXmQOaFRHlAx59/F+2uZ7/7YEpTPiLu/nXK5/+ks1sVDRbKdNRCTnQzI4jQdcFb
 q8BFBAr3eP6E/mN6gLNiOrKIHX5W9qbVgwVBhgBvrDMV3OyltCLU24zl2GejGC6ixPcduUhHW
 xnxDvm9kHfmuK7U0epj0XNUr0zUp6kcoqhLhWNyBjRQ+36d2tLD3zgtsoQ7I30XaeWsSJ3kS+
 E4nUCQbWCwLq6C/7N46fW3OKYzS506tIGN6YADF0zOk5eec2NIW057cV/hpU0YgtzQazkcri0
 IQ4lZHl4uRJlnGqcgRNsiug/dPT35iQx8Ta1RPacneP9JtiOwGNqSHv9mZbhViI54wUhFIf7H
 xGir7lYYXRobuAFzPSebV0/jVTpOfeY/H8SXEoOzNtlEJPv+6GULDbQZSh2+lNqcaIetWVrk3
 V0hkbsVq8JW8Fb/5v2QQqKQeN4q8dHVAK1f8yGrrR4ZttDukfdW+qLnkSTVheLoFG+4Svuv3R
 AgtIxPun21ooy/zgBuK7wo/dW6JC1Q8BJHm7JL/M8zRSEmlvgy4ZyajM77AXNIueA70VE4M6F
 bSkf8Z4iQS8bLwUL+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.32.0-rc0.windows.1

Changes since Git for Windows v2.31.1 (March 27th 2021)

New Features

  * Comes with Git v2.32.0-rc0.
  * Comes with cURL v7.76.1.
  * Comes with Git Credential Manager Core v2.0.435.9025.

Bug Fixes

  * When testing a custom editor in the installer, we now spawn it in
    non-elevated mode, fixing e.g. Atom when an instance is already
    running.

Git-2.32.0-rc0-64-bit.exe | fc8356260bad2a28fc3b89f71a51852be78818f6d0bab21f30f37a516dc5e22d
Git-2.32.0-rc0-32-bit.exe | 05ff80a9aca719279b58a73d2f3f035af859d4af12e6258e78a855b9709736c6
PortableGit-2.32.0-rc0-64-bit.7z.exe | 873ed9cf2220e6061096fa17b8715aa172bb92c4a468ea4313c772da7b1257e5
PortableGit-2.32.0-rc0-32-bit.7z.exe | 1add6bfd2247dbb47ada2951ba9ad11299c9ecce972346353041a5c3dffa57c2
MinGit-2.32.0-rc0-64-bit.zip | 5df5603a1a813bbf39d9f92b9203daefee1790829147621fb417ae7bb2735639
MinGit-2.32.0-rc0-32-bit.zip | 4bbb59f6eedcdba48b93321e4c09c3506b602eea74fe3cbdb16f96fd4f037f23
MinGit-2.32.0-rc0-busybox-64-bit.zip | 2e64e94f3229a49fd93f08cb3f8dc5e8419c178116ef9b4f258a5743b683dcc3
MinGit-2.32.0-rc0-busybox-32-bit.zip | b815c7d78a8e5379d97f9192dca6adef45eb281fafb458ba5b1243cf1bd74be6
Git-2.32.0-rc0-64-bit.tar.bz2 | e2e144a92ba99712de21bf7fb4f58f60bb6901022872b39bbba42a37d6fdf965
Git-2.32.0-rc0-32-bit.tar.bz2 | 8a18d84272dccab152b2ce9884d68310f2070606ee520bec6a48afb2530fd711

Ciao,
Johannes
