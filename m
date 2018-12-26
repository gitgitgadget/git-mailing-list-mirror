Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B574211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeLZXF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 18:05:58 -0500
Received: from sonic312-24.consmr.mail.bf2.yahoo.com ([74.6.128.86]:37941 "EHLO
        sonic312-24.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbeLZXF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 18:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545865556; bh=QkjIuD26Pm9qNz2/fZxqtL/P4r36+Yk+uixs0aJZiPw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ie7OZuhbV0Ro1qmkcoRlp2DhfLgInv/6ihaVJXz1bzpa647Z6P5Y8iJOf5r2rOlpa8BWJ3oex1RW7XR+uU+ShqNtu1o4ke1o7hc4wzpNfhCKBYfLeC6lg6/PIEb4Q6uksyD0yUkt+s3sVNFdrWDtr0Z21sfxiX2b80vENg8nCDX63daLmfgviZVumIuBNvdBy04K81r5jrNnx82/kS7VAyqIfD8rY/mjbcxGlZF2JAC//uFPXJ+c4d8AO5xduc6WkYQ82rpniLikjv5m1IP0m1Il31k6nt+2/l9eFWtsmGAZ2vPPU90Dn5SR0121Yp/CzQLuDaXi8gvB2Pfj3upYSg==
X-YMail-OSG: 08XXQi0VM1lNuKaNFch2qP3FfDIdW.7DZ1qb5fQr2uiijUXES7imWkjoffipBOJ
 LchB11V8J4t8bAFIzp9B1unBNFFiQ7ks27JuV2pmtEPi4FwLA1d1c7fed3ETd2FRbPJitxYlZ2ZR
 GTvAA7fer2XKnT4IVnhDGh72MhR1OxKbfZDqE.roSMthGglxW8HjSOE1CzRkjMFILVvO4YA3bj8O
 _KXKAsW3nUYFMVWwjDLaxiuu_xFlcDD3KioVPtld8VYmtWg_YVph7iHWQWKnmCwsW4C0RqZhYXlt
 RDmSfqON5MRRNYAY6AYgmLvbOvh7t4IRb4L6mdOyd_Y7Bu2BeK6H3IoDPCgxOqIzJ6840..LTlQJ
 .2pz2EulO3utwrF4OUa6RkNGhaSWGiZpuMLA1990c.dUXbREytI2fDRpX9h2ir5D.V1RuO088Zri
 AqxrJeRTZ94.xcX2tt9BH2uuCpZNSf9AqbSILqTNAR9JzSXE.iTnK2J.ShPKS.spBWiyUgsoREhS
 sGBjV5otf6frPPVb6p1tCTnYUDMvDDa18j3U6nm3Q_46.aldgANLDXmd0NGV9S2R.cKGIqsiu52r
 MBvPzG6gadFghbNg8kuDW1bVRnDMl1XU5Tjkcz42VgF.KvPWGydOWdfy_IlrMQnKTTfGpcxe2FfQ
 fKbT4VaVQrwCJkdqiuE4XHzmf9ocbNjZOz40fRnpejrl_kYCheSrsdNoOh7O.4UTJnv7B.Uci9RF
 fozhelVQ66aPf9QU3.NXhCDd4egI_aQ2Fe5lZnNevJ1VkbqSkFzeMaCB3wyuXf.04NYl1MHMeMu3
 Op8py8gRZBh1ARvmqWKIhPw4NJBq2ZtiKMRoZudDCbgvaZYb2Bfk5Hs5667DSrphfHIqJGRjUrWg
 DsYTL0ZMBX6T5wngSefAANeTXyut3uGyQfM64ptfqqrhDA9ccJzfLbfFrKEVGU3Rkj1lLvM36Z.6
 7VjnNClP0yq5VkxjSxdLU1JCECYUpfq2W93oGi.Flhf3pSFODlYBrgnK3ICKvK1mVGm9nYxauwaV
 j5kizocvJQ1bOTm4vMT4fm1VkqSfyAXL11x19lYDsb.hub15P.CKO5p5XObErlKwfuSNamoe1VYX
 TrAVriAXk6AFL1LdY5oI79JVXHYo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Dec 2018 23:05:56 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98f6f8df7851f5cc32b027b3d2c09fa1;
          Wed, 26 Dec 2018 23:05:51 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
Date:   Wed, 26 Dec 2018 18:05:22 -0500
Message-Id: <20181226230523.16572-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181226230523.16572-1-randall.s.becker@rogers.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
using the FLOSS package supplied by HPE. The convenient location
for including the relevant headers is in this file.

The NSIG define is also not defined on __TANDEM, so we define it
here as 100 if it is not defined only for __TANDEM builds.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 git-compat-util.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..3f615f7ed8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -397,6 +397,21 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define query_user_email() NULL
 #endif
 
+#ifdef __TANDEM
+#if !defined(_THREAD_SUPPORT_FUNCTIONS) && !defined(_PUT_MODEL_)
+/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)> */
+/* #include <floss.h(floss_fork)> */
+#endif
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#if ! defined NSIG
+/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
+   known, by detective work using kill -l as a list is all signals
+   instead of signal.h where it should be. */
+# define NSIG 100
+#endif
+#endif
+
 #if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-- 
2.17.0.10.gb132f7033

