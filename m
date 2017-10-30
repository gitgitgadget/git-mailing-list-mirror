Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4CA1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbdJ3RUW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:20:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:62699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbdJ3RUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:20:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY3Ho-1deN3G0CgK-00Ut31; Mon, 30
 Oct 2017 18:20:06 +0100
Date:   Mon, 30 Oct 2017 18:20:04 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/2] wincred: learn to handle "empty credentials"
Message-ID: <cover.1509383993.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-633129972-1509384006=:6482"
X-Provags-ID: V03:K0:gLjt1tmcZSPSMVdKrL7snw2T0cxvVnmFDppjqgVDGycWk1sUwAd
 kCaLLdLm3+spgX0P3tXJ6Xh33UUZX7tHgEuMRlmFP6dcjss3o4f9HOwlK8h496M2DkThKqk
 wcRIZD6LGsw8y5zyAzxCPH2xxQm3lXewk42BI1foWzlvnXu/2EPZ2lerbM5oaZVwSuRxKop
 oyt9ni6LvPW1DpnWeHcaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cl2ZSjhp5vs=:Cgo2KS5z7J2rp951I2eACU
 lvZOkUXN76fFP0qXv1jMAcoUQj7tU2Kh3ehkkC2UOgJX6rx6MTc4snxNyJnGI1qhHhP6QWhfX
 488bNa5yHu/UIy0TpTkC6hATtKBl0TJVdXaPoAMH3Jb18FqOtmWNz+o7ljYi9pxbBZhK/LbWq
 X9U3hUrURmlh3sdsModpWSmJclMkuiueerd039EaVESdlqiCtrxJ62ljJK1y3qZhx86q6qlBg
 9tfnUoZVRW4vqZb/+DhOePlU7wdVnDB3GJxfxLoAh8mH5YG5KzyW0QLLlPElqMe5gnsb+ubpi
 fsjjx16P+mVlHv9jXctx6w5VvyBoVG3ERZe+4pP8qfzVuRG8UCN6AmcjLiB9skoAcmZ9j/KFj
 kJ0s9KjZmgRVqn8Ed96oytFDC12Y/U4Uk37LadMMwOteuFQCa+rIB0AliC9a4xm+bslfksTWi
 WHq+eQ7YFU47xIUY7sIHS6SOuIFdejBSODK7E8ngykpjzhNfXu5X3jd0ZaG8cFr2UiAo4nQsm
 CwkRhvKccwJLSQTCUdqT/seHD0IYgIdtvXLHT4oZ0KAhHK55a0DwAcCWYkQ4/YEyAQkspohVq
 96jikVFCoolAT2W9T4uP4IpGEG4G5jWbbquxTUo7yRDSUSf7/cJ5J9GP81K3FYt3+PrOgFktN
 K4rZ607IWh9ieSqHIT/u7AP3bMdzcsFa6eddgBIjbFw+L+GmKUXA6DxxGnOzSSm/anMjF4u/u
 767pARSG0+Q+sZJ1K+3Vtc57ZqmOrNrCnlAYzQfCr9LC4+oGWHRNnFZwkeYmcqXoQmLmh/pZP
 BeR75MOIaEOVoNQh3vB3yeWdFz2bUuY/eirAhGE9Hak6LuTFRvdDqLZtY2FzM3Efxglkn2N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-633129972-1509384006=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

As we learned some time ago, NTLM authentication happens by passing
"empty credentials", i.e. 0-length usernames and passwords.

However, when saved in the Windows Credential Manager, such usernames
and passwords come back as null when reading the credential. Let's
handle this.

This patch series is a tender four years old and has been simmering in
Git for Windows since version v1.8.4, so it is most likely mature enough
(even at that young age) to enter core Git.

Note: these days, Git for Windows prefers to use the Git Credential
Manager for Windows instead, but the wincred code is still carried in
Git's contrib/ and should be fixed there, too.


Jakub Bere=C5=BCa=C5=84ski (2):
  t0302: check helper can handle empty credentials
  wincred: handle empty username/password correctly

 contrib/credential/wincred/git-credential-wincred.c | 10 ++++++++--
 t/lib-credential.sh                                 | 19 +++++++++++++++++=
++
 2 files changed, 27 insertions(+), 2 deletions(-)


base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
Published-As: https://github.com/dscho/git/releases/tag/jberezanski/wincred=
-sso-r2-v1
Fetch-It-Via: git fetch https://github.com/dscho/git jberezanski/wincred-ss=
o-r2-v1
--=20
2.15.0.windows.1

--8323329-633129972-1509384006=:6482--
