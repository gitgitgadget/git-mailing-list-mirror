Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AAF1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBHLcq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:32:46 -0500
Received: from sonic304-14.consmr.mail.bf2.yahoo.com ([74.6.128.37]:45314 "EHLO
        sonic304-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfBHLcq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 06:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549625565; bh=6IFS2FEybu6Deuj8YLoYYw65HWWJkXRNwApghVxAL9g=; h=From:To:Cc:Subject:Date:From:Subject; b=R6cs4ml5AaCjZpikOBunczmz+00qicliLCfKGJeruFrucJ5I24j2e5EsOkT6TLAPGOz2g6GULT6edAVG/fFhnmWAShMJO3b/u3NKTW+mU/L1c17fQ6PW7ITV0M4qVBgQhbgxMcgOx47Cl03IFNr3akRmoQXnOmgCEARgvvj8sxJqXU5xtV+Kt+9Wu9REZ78AB+muLncTN00aG9kKVr6SsnMcn7JlvNVnAJ0tXaWXMGV9mj9FnMEGkLSL16FQ7wDBT1rH6rehFVEMvIze+kbEdFkm1yW67QbL+L77PlPMnCN/CSSERjZt77m9DblOekf84Bo4VZfdPCOzABU6H5+OJQ==
X-YMail-OSG: 1NJ_yfQVM1na8Oggl.wpew1gOeTMnIqxay0CwaaFhux4TzHBEMFmm74rsaPdSGl
 Lp2zZzN4BJ5Cot9qtV6B6.eXv.joLVetkCR.bBn4PL6yfzSDdcNYQZIjSb6XGgOH31AVktSmVuAC
 KmSDYB29ZZTuIwpf3rDdQKR8A4bOEoVyAdoiaOtX_TdQkhtKWn8QSvIBj0mnXGwxEjgCCRgmybGw
 UH_yiyIkt58j6d4pDEZfIxVK9Ib4rAy5KJyfhq5s81q4cccbl92LLfzb7cNPhgdszojJpS8wiR5T
 s08Y22CEMgMdvkRKPMdr37JQeYZYs767pwYATvLq1Kt5ELOaQlMFf_5GJOoTWfKpQ6RlvRXBop73
 3kKE1lEUOrfTw8Wfz9sEJ9qyj02LOprGbdpVVB1G.ME2msHE8..rWGlVkKRK7FN0MmeaptJP3cn7
 NQhDGfiYsurfvBeFeMgmuOE3osIzmECGjUOlSeNDQtvGxUZAzhBonPuNtdKNjIMspQqqLqLyiLql
 lXq3Idm_zsKY65eJ1Uhk.S9CjwdykPdPkwMC_qq4cnANueuEpC8AwOkHwp8k_AwriZxYxC32bAsd
 dnMtZwGwtzszJHQspPc4ieAUWqRs7C0JorhYpORd2DEns9UujWP50r8_KRed8wPAaXzUoKHLiMa.
 NFz5JKhQ2BPra8VNE163gdpDeNXZb6gYTDMk6pGaJIgI.YTrZ5ZRCUx.psuXUy7n8xv8rKBinowc
 l8bumgL7AtjnvyK.11qOcqUkq9gEmhBhX5s1Ak5n3mYv10mVJAdzGM2vrG6jX.8A6U1oc_gJotH0
 B6.BoXpJ8e1_WBE5WrG4dLK3aiiOVAtAAvQLgCqzVO0Ww0xWoSGlRMi4gqkMDRgrpCLj752A1Iie
 n.SsRb9HsTsz4vKiNj2Fe_qOllahJo0jCRSPf.Q9DpxVUWF5yPURv7ArTbdoRtROsKTi.eIQDKLU
 ouCMgs6G98.o0AuZ6j5LhPQTuRikswnrkQGoRvi1JGj3Cuog2m.HgMTFHM65M0SMxo4xNRcYsxNL
 VeNvfys.NZIq39VaQvPnbnHDhvqmalnXne_.zRrzBjIQZ7.JjLplB98YGAqBFdWYOXMc6.R7Xxqe
 P4GeFd4WMoUfjMaCypEiV4eM6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 8 Feb 2019 11:32:45 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 504cd9d39616da7753eddd440dd16bee;
          Fri, 08 Feb 2019 11:32:44 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v1] t5403: correct bash ambiguous redirect error in subtest 8 by quoting $GIT_DIR
Date:   Fri,  8 Feb 2019 06:32:33 -0500
Message-Id: <20190208113233.14544-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The embedded blanks in the full path of the test git repository cased bash
to generate an ambugious redirect error.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5403-post-checkout-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index a539ffc08..a39b3b5c7 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -67,7 +67,7 @@ test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
 test_expect_success 'post-checkout hook is triggered by clone' '
 	mkdir -p templates/hooks &&
 	write_script templates/hooks/post-checkout <<-\EOF &&
-	echo "$@" >$GIT_DIR/post-checkout.args
+	echo "$@" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
 	test -f clone3/.git/post-checkout.args
-- 
2.12.3

