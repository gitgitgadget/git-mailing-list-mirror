Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C8A1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeDSITd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:19:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:37465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeDSITc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:19:32 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgc0l-1eovF23WWl-00O2qS; Thu, 19
 Apr 2018 10:19:27 +0200
Date:   Thu, 19 Apr 2018 10:19:11 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 6/7] technical/shallow: describe the relationship with
 replace refs
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <f7fc83a745cda61f975f3d3330c91b8714fd4fcb.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yUFhC3kdAgJBZRvEmFov2vZPHVH4TsJeIFqiYfoWsg8BmrKCU5Q
 YUplFbCmmEplmy5KH6Sz69jepKxxE+VVo4DuO3C98rwakAEX5tp4aPjExtjUxp7X18nBtOd
 j4nrUfdgv14vv1FyZ0R6lmTvgdbd7t+rwOvGYjjKggs4gCLnxkyvXntnpq+lIsc724PHD8E
 JRXBpyXpT/TMcc1ha0DmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TREHDr+JPU=:Z5kBM8c12pCf5HduNRqjBA
 fSy9BT/ymyKV7jAux8CNXOOKhboi3/MUDTj9Xmyk7TLuE+ABi/zmj4F7iLEAjw8p4la7wZ+Bf
 3X4bak/HV4Ly8qn08AqU6o2QqqUPYuKVf8/ru6l6vCblN9PBCh42hboWEXsAWc03NEzOYIlvg
 0a5Xw5zj9w3nk1msbiuFssEv4D0TRKgA4M1+GosgQdB+ucYU+hggVu6w6Zvj1o6ecC6HbOiNh
 /ncr5Yrk0zfhL1+LR+vEuXGZKTzCibqSSZXoCZ7UKzA6duqtaOVm6wHKTHeSyTvA58y/M9fOO
 a6+tML/tMBiVxuMmS5QaS2820BuLSbZcV4ubYxwMV6jtOgc45nO9dKfSBkTgmd8+7KeomeO+K
 Ydqr00un0ySdIJLJHVBtVG3KtLchKpYq+2OcbthIIOkFQClbBgUDdAK+FtGYki2ir04oBAAV6
 aMywp3f4rlQGDUTM28BBo8KcRUZ6GtTIvd+680o3JezCdRj1JdET6q3z54sWiAfikDg6Q/J0W
 +2NBVK2jMUuVbO0jBbzqp2WrwCN2g4hvJuGFF2tlbCfZUjIoYDwmnYbbpq0DaADiSCMC+GShx
 XNO72FIpXiGIIvJrqocSG34AJCAKk5vCMy9lyLivyiY6YYfCI0K9YUiJTRjEYH0ESnumf9EGU
 90wpjWWVT0h+k4pLbeDuyfSxWNMgfJo7NnrConuCGMM0qRHNubdjKuozZJbl31AcN9UsrLVYP
 kvjsmFZVyW9qDOGKTA9MeiimSPkewQbnpxzCqobQrCG8Xe2zV6mOq60A9R764Nqw7vwgVh5vT
 2RXinj0xQgHhN9khYR9KDM5rq2b39gjDCgWa8/kbN/UbsbNVl0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to describe the
"shallow" feature in terms of replace refs.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..b3ff23c25f6 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -9,14 +9,17 @@ these commits have no parents.
 *********************************************************
 
 The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow, and handle its contents similar to replace
+refs (with the difference that shallow does not actually
+create those replace refs) and very much like the deprecated
+graft file (with the difference that shallow commits will
+always have their parents grafted away, not replaced by
+different parents).
+
+This information is stored in a special-purpose file because the
+user should not touch that file at all (even throughout
+development of the shallow clone, it was never manually
+edited!).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.4.g7e4058d72e3


