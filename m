Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C932055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754907AbdKARKv (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:10:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:58027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754818AbdKARKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:10:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1e3vSR1exy-008Lc7; Wed, 01
 Nov 2017 18:10:41 +0100
Date:   Wed, 1 Nov 2017 18:10:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/3] mingw: document the standard handle redirection
In-Reply-To: <cover.1509556153.git.johannes.schindelin@gmx.de>
Message-ID: <80b58f364375a72d7efd547a90f284accfeab877.1509556153.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <cover.1509556153.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pEZ9YNTRA2Loj3pCLaMjFdzy4D8u/KWk9sIVk2vfY/g+t7tjWvo
 FWvs5PknFQy6MfnH8Ir6JI+6i+rjtjqqz6Rb7hJsnMNDudHI+Fh0ZnIyfUk4TQ9fCmeh14R
 9MQKV6ToKMDxMbXbmlJNOTAoton8c96u6vgw5L6bYE+Xim197q2RYmsZNQt8vOOjKQ/TIuu
 5r8vutGpg4SSGC+36eI3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qWFzPWS5ZJM=:5Y9p6CgQRVdxyfQvwzrTkd
 Y7CGLlS0BhuBKNodXa7CPV7h32aFGi9AM8tYT71y3kRlEbNKnSBHr4pLCX6aggr40fI2lglv8
 YX2Rmsi0criL27lSE/V59eVlYTPgpIX1Zp/7+ZcI/x0wC977A9d5LMX7RRTinzejYtha+/zQX
 YcPC/cTjRM1l2nD4K1WrU8ORxz08Yt+CRAeg56d1czRvKJRhxP68+hhJ1OzSEpfGKghnnLjKP
 T97cJ130oTxMpFrAYxxP0YQBirWEYIWM5Yg0r6Kt+pCpy43WRV3n+rmkN/ecXTJrSIJDrHiWj
 aSn5IvRC4s3JXkOpe5ghiGwTG8yxNxVoms063Tz9vLh76d+chff6NTQ652hCg49Mo7ySFoxb1
 WazKQMLVM8sl5nf7HPi0TNEHI15drSjyitut63/YScz2OBynmu8AM4+YP/GAAQPl+M7AKcVrl
 sM1/YXhLdc4ndXYYDYtQhtCpFxaPuAg1/3h7I4OKhyA9aQLuySt4RPRV6al8Zzx9GZwrEka3c
 EuF0lVfYsDM1zw8yahFPmvQ0XhNCKcYrwaQtnU8eiafksogdsTvmLDW/VkZCUONOB3DpjmJCB
 nSJ+dSrmPWA/pRCdAbZw9+Nz8+1f2EoTr9j9h4hOIc7nbhkFx2kNz1Ayj0WdJ4vc9JXqE5F5S
 BhXEvqqAK7V9cUC3XgAt8P6K6rH01qUEQRnelp74ot9Jp1z25Qe0s4Xin+c7MkcaHb1JQrUPG
 eRCwHnX6QotW4BJt62uYojwJzEzreNKXE7Tjet4k0M0foOqy/DHCjupL8bkWGBi3KtlK7N81S
 scrfds/fWr0ZwDbZgc/HMBNIvUgc2Z+T8m24I3RAjE/W3ExhvOrQEl7EY8fXJ+s9n0qZOrI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature has been in Git for Windows since v2.11.0(2), as an
experimental option. Now it is considered mature, and it is high time to
document it properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7a1d629ca06..463b0eb0f5c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -709,6 +709,24 @@ of clones and fetches.
 	the background which do not want to cause lock contention with
 	other operations on the repository.  Defaults to `1`.
 
+`GIT_REDIRECT_STDIN`::
+`GIT_REDIRECT_STDOUT`::
+`GIT_REDIRECT_STDERR`::
+	Windows-only: allow redirecting the standard input/output/error
+	handles to paths specified by the environment variables. This is
+	particularly useful in multi-threaded applications where the
+	canonical way to pass standard handles via `CreateProcess()` is
+	not an option because it would require the handles to be marked
+	inheritable (and consequently *every* spawned process would
+	inherit them, possibly blocking regular Git operations). The
+	primary intended use case is to use named pipes for communication
+	(e.g. `\\.\pipe\my-git-stdin-123`).
++
+Two special values are supported: `off` will simply close the
+corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
+`2>&1`, standard error will be redirected to the same handle as
+standard output.
+
 Discussion[[Discussion]]
 ------------------------
 
-- 
2.15.0.windows.1
