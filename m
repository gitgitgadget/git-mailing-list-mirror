Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6AE1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDIIbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:58251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeDIIbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:45 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBBl-1efyof0WH7-00jdF9; Mon, 09
 Apr 2018 10:31:36 +0200
Date:   Mon, 9 Apr 2018 10:31:36 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 04/15] config --replace-all: avoid extra line breaks
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <8264d7aa630a23167f8cffcb23462371f7511be8.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JDcuF8vthWtpB0f7uaUZYm0dlvWnSeNJ5Yq7tqWwQHQicP5Xw6i
 wZjmobHyv4QK3uXv0TeaotB4kgc+SmEFzzpkIW4SUAo41P+HUmNFon69U30U0jxhI/DqvVE
 EaLD1xxd43tXV605zOy2HCGsAhUERj8/1wr43onLiKKNwo12LvzZo90XFNnQ2GfE6PuK477
 TtNH+uEGczJmNrdn9aXAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jl1tpwmJdVI=:67NDAXnTQ1O78QGIE8bIG/
 56OqSXHF1mr1po3tmK/zYlKZ3vHF3XD3Xvx5EfHy+WkPZ/9qKAApaDmvYoIp9f7VfbNx5hs10
 A94dQ5S9OHWRhAG2DBgw9jTBNi+Yv2H/XCopZvCjsTuVWGpb5RDqFpbR8d7Jl9qDDA3kf4isI
 3IFbuewdEoSqoMJIdvE/c2gI1FlrTspfpcSk0IEDdU6n4KTT4YBf9cO5uCBelCh4ATNUrUhfz
 xYnr2jnE+5WF5b/KSBMiMRqkWVhmS20abbIAAA0jVQMjMuOp8jtDxzOKXVAOsZejtl4GmWR3c
 rEOkp8rt3nXFAPv+ODAExTd62wlUV2G3z4R9SjVxrGngRgYtsLhJ7hx0lJzUIfLmpOe0dvsOE
 oTWzyb65ZItzJLII86Rqnzfs2VByku40kVVvs3s2yeBtQ5yxUB4exR0QGJa55l4I8euZP/wom
 caYpuH7CuW1eFGTxphdEp4dxxM1TgtreLY7iASIbRldN1mHSHf6/PdjnwInL6zP/GTfkzE5HA
 9692Rvkn3sLlPEfRo2c2lXYWcaEuTTDhZT+6StNZemIaqFhc8BQD2PymbBC9CjKX3bMokrm2m
 GJ8y4SUYZKkx1uHop1B5w0DZWrlOOduD2Kq3u1U3SL9X6RBU9MnN22LrNNor1wf7znOMkCar6
 mr/nHpA/uU/vJvCK4Z4D/ULAjKdPnvPmqGpdphmBN9ToZu7OwqlK9LlXdFB03SmNphLnaaXPb
 srAcBCloni57nIaMspxMLspDctED2CAgtMMlhmeygN79zpDN/ZwxdnjMxm/oxN+WEvj2QYzQi
 Di+ZnnT9gcOeAUiwJ32oYVKc55VeulBLKcT2kGUjBZbtJ4RD7c=
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
2.17.0.windows.1.4.g7e4058d72e3


