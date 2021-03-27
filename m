Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D946C433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C2661A0A
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0K2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:28:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:54905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhC0K2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 06:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616840894;
        bh=UGAUC6npkAVM8dFMmno99eL1kk/eJMYQUe2q4gbDkiM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VAY0F6b0UnVrSm5I+CU6wShtjAGAvtF7eocWpSNVL+ffwkX3x2flbRcXVSTxaycBp
         sRRBER1b4i6nW4vyYYIFHpwu3Ku6DvQepiZ9AtZvtFnbrdnPWgVB0MDEaz1UQ54Y+c
         pTpnSfJdAETqsUpqn4/V5L9fj8kSnMjd2GgN6b4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az47-642.ff3z2rg2h4zubkhjibippcjctb.ex.internal.cloudapp.net
 ([52.162.33.163]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1N4hvR-1loot03T6N-011kil; Sat, 27 Mar 2021 11:28:14 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.31.1
Date:   Sat, 27 Mar 2021 10:28:11 +0000
Message-Id: <20210327102811.6951-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:e5ZFJDa60VEZ7PJ1ZYXu4Fl+GdjyL4QZ+jbsTHFcSB06o9OVh/Q
 QCuE75hI4bPbhQ/LdRSJ23O0mtGwvK8qhIg5yqrX0TkYTxlKlZD/y6qhHGIyKibhiYVVBUR
 t4XgNGOU3F4SXntLfglh0IHyqwXbLqTwNBYeK4UcSI4478Cmkfssm5qSr5DJhTnV/DFaPF5
 wxkIV7eSbgW0KIClHDyDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:360ls4JdXWs=:dUyf91aPEu1nwYQyDqc58s
 vBiq6iR+HbMxixUkxj/6uDojTl01nfc1UQ9nIdAVjrmkUDRF0eIY7Cgi/nvUgEoNTmWitAK0n
 7I40zDkffC0zmSeIWs/vm3COBpNbW/+YhE4Bn1bzYCzN5+dEyPwWC8Aik97tRp/IqT8/wGPXE
 dZ0fNTO/46qmfYG9M3GZsImOX5orHkSEtqSPDzc/ohkQDlzb/9FxfSQCuGz1IoVYwXwxmit+a
 qx7CRvG/Mb5tP2FCtD/qe6TW60ExEqJV8RkcRZXr+kg46TM1zpkay7Qg/sBS2zs6+7rXm7c/M
 bgadCAtpiXHNHWnltuovfxn1mRDuM9bDMqa6O4O92pBzN0ilinJfEpEWCBQfXLGF1beS0e8VI
 0iX223CKh5H1fLm8s0r5noLR2a0wP0kQKjMtKrLpZClcT/YWymFF9QHt96t/wBSukzbQN/Bd7
 9osv6rktdWSw6eLnVVrTvenkgl7U69jcaeXTSzfg36GahQqtzEUEV0514olivwzesTWr8c8ff
 sH7/YwVy5ECX6AeaSD1sP+SCUo+2La2VeRz0rZdvoHps3kQMuSmpVkY6NWZ6VMCjYkuhZkI2T
 H62rHiuJfE/9tzKZHwTqv+gtJ+1cJuKYeOES9xqm9mJFpO2A+ubuSPgwlpbGCd1Lg40WULNj8
 VAGkm8o9Eko7PdjJNQkOrL375Td/alJzlfMGaNmWBPxyrJax0N/y55936YxjV0fucGMT1yQl/
 aNwgLZG/G7b/bFtNKGo9Guv6Ryqmfxb65XBlqrAqnVzeSF1/pS37Ir0L+owJvBTCkStwupCpU
 dnJVgEhSUP+iEz04Q9vl9+yoFdI6v2JgFuVEUZj+NBeIMA4F/ICvou+fiNMoYutaZbzKrZ6Wv
 VQzxJaFgtNbqfar3YEDn3DyMlNohbhb8Tor4cAXeqFB6Ifjk0QAolkO8OnTHhbH/rB94Q6Fxr
 EF8jKvqZmUP943Agpbdhfx1PWD3rFbuBcNoiKYxvqbE+gd+EvFlkxlRAEUB1b3tFWC58HLqEw
 z5cxyqGZMiqK20NHGeHjLZsgu0Syj/q/DWgXVGbeZW/wlnl9ZwD2nN3i2f5QPXfAKJoq2M3lV
 1hELIVCgwQ3EzVrrG6KjE8do9lzHm+scGHK0HkFFa1CQKXELfQ0posJ191XfoGrpjXC22kpSu
 hcSW/GaRcfwmAhiiw6V+lcs9xxe97w4F57lnBiI2W9Knh+tRI44JyOB/ZlzFSbf9u8sV0v1Pj
 /oaIQsnWgI+HIH8tU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.31.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.31.0 (March 15th 2021)

New Features

  * Comes with Git v2.31.1.
  * Comes with GNU Privacy Guard v2.2.27.
  * Comes with OpenSSL v1.1.1k.
  * Comes with Git LFS v2.13.3.

Bug Fixes

  * It is now possible to execute the Windows Store version of
    python3.exe from Git Bash.

Git-2.31.1-64-bit.exe | c43611eb73ad1f17f5c8cc82ae51c3041a2e7279e0197ccf5f739e9129ce426e
Git-2.31.1-32-bit.exe | 6abc8c83945ee8046c7337d2376c4dcb1e4d63ed9614e161b42a30a5fe9dc6ec
PortableGit-2.31.1-64-bit.7z.exe | fce2161a8891c4deefdb8d215ab76498c245072f269843ef1a489c4312baef52
PortableGit-2.31.1-32-bit.7z.exe | d6d48e16e3f0ecbc0a45d410ad3ebae15e5618202855ebe72cd9757e4d35b880
MinGit-2.31.1-64-bit.zip | a07739b564ac37b9ac6267205a80af99d518b0d4b7520f1934e31c9fe7cfc599
MinGit-2.31.1-32-bit.zip | 871462ccd94315f490197163afe6903ba65b8460081579d8985c434b3531745d
MinGit-2.31.1-busybox-64-bit.zip | d97a2f116692e78266fbf10976183d57a4193868df1a94de7d40d371e358b6f3
MinGit-2.31.1-busybox-32-bit.zip | d3156def84d48bfacc6242f5386c3c7addc4d2752da078cab2da709f8820c9fc
Git-2.31.1-64-bit.tar.bz2 | c70934e84fd610cf8f492bdfe858d4738b8af09f5b5dc734795d2b40d99bcb53
Git-2.31.1-32-bit.tar.bz2 | ee941492fe76c6813edc054c637ce4af2c488e6b5ee220306916cd34956e2253

Ciao,
Johannes
