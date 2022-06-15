Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2720BC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 14:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiFOOuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiFOOup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 10:50:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D823AA6D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655304642;
        bh=4YBvYV/eSSNskqEig+sa3Yuoz6RQ0TCSbJ7ZOY7Dx00=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bwl0d5fvpT+FT0yuXQ2a+V+8Y40wjkoPZI/7XwSMgL01iFfhY4jV+9TLAzRqmAkly
         6l9CA1ZYCd4NMBfvTTo4csH7RsObh5qTZw/3N0oPJU0zUCwFoccr9g/VxvJg9B4JbE
         z2WStaOmxqkszle+2LrE/Tf8PcLeSs0eoehBnM4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1nQEnJ1zhr-00cMWd; Wed, 15
 Jun 2022 16:50:42 +0200
Date:   Wed, 15 Jun 2022 16:50:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t3701: two subtests are fixed
In-Reply-To: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
Message-ID: <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SyZUde8n6AzYc6Uyuiqpl96Jxch853uq26w5aXUACK4Qh+WTpjQ
 7poFKT/2pF15Z+MqwsQgZEe8tv0+xj3PQm8xa8eQ+BMf52xugE4Xu+N1dhXU9CEE7wPvP6c
 K234XyG82zzZnNWnorgbl4Nr22euiFU1L/uBZraboncmvslrRCimRmhc0nAS/j6x5cMAo7r
 7Utd3nn/SYVsH9Dw0COjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PYMAxvD62PQ=:D+g4LTOLX0DCYSKNdujxAH
 aoUZYKlkzCAEX/KliflwTlGv3hexQCSWY2OffnBFoNzz2jnmIjmAp6uhBJCi3SLhn9dKOg75i
 chO37bdZZMIouaPp3208skRhpTJoQZQGV7x3OA6Ajv9CDnjhoOKxy3k1BFtNQ8RuTdeK8PCzA
 d0mSnRcj6tzZsNTJpg5D67wDN0HifhOAC6PhV+mpv4Xjaxrxi6M/27/ZaLEBMp/dAUd/ue9zq
 xDPcKLC6z2FYZorM2rdbFZulyWIvPdm6fvgt/crwpqFkykxXKmvlx2gobBtzwQUx+P1xlk6zv
 vjUBF9tLctoROJJC9ANA0OpKuPVKabA2pTdTlDLwFwfnq/+OzPw7xnMLzrM5BENLbgvn7DeMg
 yAkb/rKGCuadoNbsP1mq7zWR85GlL3ccUsftKbC7yOYXZEThviTpnUiPelEHXX/4iOw/Ktat7
 WYSNj0Gvsl/ctJNW/hzNx5gYwZMfl2z9XyGu3V892QuSluww9wKhC35dEZ2pv8qBRma9g0Dy9
 catvI8iVHsZ0CsUBtL09DARPX1sgjAbMBjIpzufWiAoGImoYMsYbciYni3eWAb0JqdhZAEjzq
 pYxho85UoztT8iKYMJYijTluDahAgBsFqfWpS6ckTqxsPRqfdBedBMfOcwaP/zuPxEVvY6puW
 QMGR5qIiIHIKXN563dqrXOZ3PMYCrCtKzlHHMbLK1e7jh269B9pVJ2z3Be/bUInTjAfCjpmOO
 DmN/cxzL9OWxJnzC3YW85TdcrZTXBSR6hUrSS8iBFg6+vXo/osXxHTm9YUVtGuWgB8BSC7Pvf
 s2JRQ9WSMx3QjJwpM2TxStyYtjNQ59HkdPkzhwUzKFs8W5ikD9XR3XyxHUg74NA5ud8QwY1fE
 5r3SW8++dZIC/UPQYbv0YX3AR5pmKIp86mJIz9HBp1jHTrgX3uMhH2zoTIMxZv7ONEUDVgirL
 /vdyKVnzYgBt6KTlyciCxVL7bCrdSqilvHgJUyvj04MJLzE1QYCAP4CHthHNk8nj5tFfQdUEB
 kzMHpElym1TekvifuY8+2vaae5Dp5HiD69/LsG4bEUYroGhd6N1FONrLxCD47ZEyh+ShiMwyV
 U+PU8+Pe9Ozxl6q7Za+uN7OX9aAhalde2shwD3SooLX2okJKgypmemmxQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 14 Jun 2022, Michael J Gruber wrote:

> 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> switched to the implementation which fixed to subtest. Mark them as
> expect_success now.

Good catch!

However... that commit specifically contains this change:

	diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
	index cc62616d806..660ebe8d108 100755
	--- a/ci/run-build-and-tests.sh
	+++ b/ci/run-build-and-tests.sh
	@@ -29,7 +29,7 @@ linux-gcc)
		export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
		export GIT_TEST_MULTI_PACK_INDEX=1
		export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
	-       export GIT_TEST_ADD_I_USE_BUILTIN=1
	+       export GIT_TEST_ADD_I_USE_BUILTIN=0
		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
		export GIT_TEST_WRITE_REV_INDEX=1
		export GIT_TEST_CHECKOUT_WORKERS=2

The intention is to have t3701 be run with the non-built-in version of
`git add -i` in the `linux-gcc` job, and I am surprised that those two
tests do not fail for you in that case.

Did you run this through the CI builds?

Thank you,
Dscho
