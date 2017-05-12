Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE60B20188
	for <e@80x24.org>; Fri, 12 May 2017 10:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756370AbdELKvC (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 06:51:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:57167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755543AbdELKvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 06:51:01 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWkep-1dXhCF0Cx1-00Xtjd; Fri, 12
 May 2017 12:50:56 +0200
Date:   Fri, 12 May 2017 12:50:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] fixup! log: add exhaustive tests for pattern style options
 & config
Message-ID: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gfE3eHL6rL25MKpkBjOVeaR7SDkEdV3sT3WTwwqnvhIhfDsy2z3
 OzeNHX8+SH3N0l6sFLqQj5520LVIS4VFXFFWACb6Mu63ISHvFuFGsiCwLV7WT3eQcZUJV6N
 +DUHSFriv9N5JLOcQP8XJJa+6wxQgzG5MUsL/01dNNOsxoKRra1HcMkwxGTI/QDlTQVC5zb
 WSYjyE8uE5QuYBbzola+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OicVUVL1r1E=:VTMpkytLaMXUMrPNtuUjiK
 fIWV7TVmSdpxdxyQyrZ3cG21BPQ8XKs3WjRhdywjw5ygRQY4XdH7CMLe8wVI6gOUvZBwB7gao
 W5x0D73qY/aT3tS2qP6D9vWJ459MJiJ+N5Z5vx8SD0ZfohGJYMvGkMMdW5KICBr9sxZbB3QWG
 i+4cHi6CQzya+utvoJP0acHV+LXtHKBMX4txcdCGBdKWF4TC72SBfQKwBW8LBooM0yWX/gH1C
 jTLKzdzzTDNzUqoDSFlxUMLbjbleqtOhXaymrw9ZQ2xE7UfGstHEJiMRia3ZheRa7XwKOCBan
 FrynrLbaOSHbppWVPnRKX5V4HQTTEaTo30btloVDL7KGblKcX93g9DowPqTQOMgo3fdu9kBO4
 RSewP2zl8h8B6ku1FClYARVovN1QrinVzL9//9PYfy3AoacRbTwhoLWTKtWhk7S1tkEd8rBb4
 fVfZhX+1JDf8Ff1h1kBcChnoFJaTBiTDZeSKd5U/eR2eUGoj9+N7z1F6fZ6ljn+hRwHM6ZK21
 sAgkpHLsKVCL+fbxode9Z05IGXNg3tFrkRAwMDcmFnbJYAEUBgUFeIrsFtMBpkuSyyVFi7hj7
 q+LBn/eakIEIH1vIIu8ZW/gPGUYS4HCv5kQ7cqq4n0JwzMkjFd0+tS2LUFY/C39HM4/a9DWmP
 WXd/j0jLIRoJrNZqJAoJXRxiF7/uyT3DK7PU7XCK6cFaYNieA1ZOA6MeDIgs2aw5N9A/Lt5w1
 xd6+E86vPEAKZTJlzoCPDB3W/ahnTzFc55LgPGJjI+2SAi5ffzF6siUJaFagy6ZHUPnB+q/i3
 DjpucWN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, `(1|2)` is not a valid file name, and therefore the tag
cannot be created as expected by the new test.

So simply skip this test on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/exhaustive-grep-tests-fixup-v1
Fetch-It-Via: git fetch https://github.com/dscho/git exhaustive-grep-tests-fixup-v1

 t/t4202-log.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 36321f19061..6f108e99b7b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -296,7 +296,7 @@ test_expect_success 'log with grep.patternType configuration and command line' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log with various grep.patternType configurations & command-lines' '
+test_expect_success !MINGW 'log with various grep.patternType configurations & command-lines' '
 	git init pattern-type &&
 	(
 		cd pattern-type &&

base-commit: 3760a479060228867a31eed443334b30124465b9
-- 
2.12.2.windows.2.800.gede8f145e06
