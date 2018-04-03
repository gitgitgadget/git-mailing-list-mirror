Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF81B1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDCQ21 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:48667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbeDCQ2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:24 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lvkwm-1eT0j51PyO-017W20; Tue, 03 Apr 2018 18:28:15 +0200
Date:   Tue, 3 Apr 2018 18:28:14 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 04/15] config --replace-all: avoid extra line breaks
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <8264d7aa630a23167f8cffcb23462371f7511be8.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NhlvUyPPDneCO04T+xFg7bjJcMUzeGzY/I/eRBOlLgr+g/fqOu5
 I8xM0TxsEngFNb1XXDp7uAApb77+u8TIj659zMy1JrurCwPY6NwkgupWdk+j2+tirfP1Rhb
 +PW7lGWiZVQVmExJULPXiUW0Oy+wuZEG3aSfOswqttmp0qnB1ythjX8j6JzcYLVuKPz9anH
 xApApRT7beQ17iBFwWJzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YLX4YYBEzAA=:KIAbJ9dvRhbMNTbggXgfc+
 mcvkWhpuDvoOmJm7UgcyZCfH9xYWxFXHTM63/ccxKR/NfQ/mqu2Kl9LSHbFE8ED8VrfVJa8dr
 gk/P9kaFHj+DoPPworefUeNumENa0mxDcnDG3eP8fRiDU835h3Wvdp+3DFSh4EQgiL2PicjfL
 KvXB1UIGYzZ8gBcrcUClHj3la5hi//25xpFRkBbwQ9rMrnlbBuAD5Pw9OE18Z2Hxhl8Ls1kXc
 avfDzTvZWneIkwaUG71reFUCw4GitJKsunAe0spTkFNlIRMeD1CugmEwQY98ruoTpVToZd2qp
 /EsYjDHZnWQu9CLrfj6WU00e3Lfx0UnKNFOP5g1K/cGJSlQrjdiZVPuJGoq8U03u1AUqkylQ7
 Zcmm/BIh1Wc4tDtoKCKVXjw+pgR9YX51lH/yGa61/jZpgP3ZE5RcEMwyBFAeMhZNYCK5mV2zD
 VtN7DE7ZgYSNTUp9QyYNubBTPJTbX5kJ6w+8qzKA482cB0Nm3e0UqEHBHLOKzbeuUzLiGYE4o
 HGzaJO7LGFW0pGfmDS67uYgEPOIf2ZofGYRxqt4ruBMNR/2YRhC6Oypd93HNJCihR+2XLhau8
 2o8UAD9K9g0btIDkfBphgJtLCT4q5BhVTH9NS/GJeuygv1HfVdRiIGwsIgeHawF1ozUEecjYB
 aQ3luYzkkSxqh//2hfh6mJg6x9u4XmWR9+3wqRex6rTYd6LS953+monSN88GP7p03sCGir0p3
 LkVHoT9AshQoj5BNPlAVMLDx5pNkZef66ysC59sFxQ6si9qlzoW86pKZDNIQNtWM5gYYXnjy5
 JnT4A9yKhPMMwWCJKCilVNARyETidaGJaKMWq2QOlK1ev604rUVLeFz7xqmbZ7vNz7avRGb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When replacing multiple config entries at once, we did not re-set the
flag that indicates whether we need to insert a new-line before the new
entry. As a consequence, an extra new-line was inserted under certain
circumstances.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 1 +
 t/t1300-config.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 5cc049aaef0..f10f8c6f52f 100644
--- a/config.c
+++ b/config.c
@@ -2625,6 +2625,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			store.seen = 1;
 
 		for (i = 0, copy_begin = 0; i < store.seen; i++) {
+			new_line = 0;
 			if (store.offset[i] == 0) {
 				store.offset[i] = copy_end = contents_sz;
 			} else if (store.state != KEY_SEEN) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index cc417687e8d..aed12be492f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1611,7 +1611,7 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
-test_expect_failure '--replace-all does not invent newlines' '
+test_expect_success '--replace-all does not invent newlines' '
 	q_to_tab >.git/config <<-\EOF &&
 	[abc]key
 	QkeepSection
-- 
2.16.2.windows.1.26.g2cc3565eb4b


