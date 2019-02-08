Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390291F453
	for <e@80x24.org>; Fri,  8 Feb 2019 21:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBHV7m (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 16:59:42 -0500
Received: from sonic306-25.consmr.mail.ne1.yahoo.com ([66.163.189.87]:39127
        "EHLO sonic306-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfBHV7l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 16:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549663180; bh=lV9kseCUcEYvcayjRKNOBEvAWKgBAHTW4qv2f9b6tLc=; h=From:To:Cc:Subject:Date:From:Subject; b=I1D5hApnO5FwScnq+HL0OSNTYdEwIcLew0AygTLHFw/ul/KuRVrlZ3jPP5fYcH2nScJe0xuAMlLqZ/RQRN4mAeTdWpxh6ev3HD4ALHApdi2HoMltheeHwFCO+8vtiH6zPS8Y3P2osIoYYnCyvdMl1lRCsKwQGXzrROArysQO3pPIbo2RQNAfmR6DptHXuLthnq0my5uxMCjOCD3kiPpV3juVICaCAqhiGQX3e0rCk5k4sihuXyjJp6fdnprHiFRXhpRMElZQaR7FO/5A8jRkEkjEDAqrKf3ZatjrSoo9S//oJxsv4CbaS9ShEW7MDBdqrLQ7o97jfiwwQ3ZlGK0DJw==
X-YMail-OSG: vm9TRysVM1l3l7qirO1AdSX5XvOMCtJM__ct2zs9j4ni.V03T0YFJcO9NLisQhU
 MMxo4Nhz0RWc8uD4y0wApPoc4Bon9R3IiZoHZwhPQu_gxWwZDFYBMixIW5p1lXeyPE6O3sndkhdB
 tlPbdqlQi4xy.WFZhWsQ0Oi3OSJoEWtC2VJDTL5cSV23tt2HQzrEcL7ZtiGt46WFCbC4JrjS6vn3
 x3dQJRhH4umYwlwTlYtfpxqfcDsJXkxpmQH.vPiDErfa8pOA_bFMdA_v2D7WjrNdbtzHNA8gMhhJ
 TN6hw.nqbObSlqPTacJ6XRitCllx78CJ2gRtbWqrq9brFRFhP3QPWP7n4KtPFkDvMjQGQVMWBu2u
 lpgk0bmFeBnA0_kqS7ESDKmRcXKD5f8FbmVGUDT_1q4mpfq4ciB6uC_a7f9nfz3Wc4RfXlLq9Zgq
 rjdpbKvGsAh7sJSrYpvoDLfUsimyPZMezX3zvXRLye96KsRkUVpBd21FX9xj9FVPkiQkXOYJZ90f
 lVit5i_vie0S49gK3z6CsVxRVOGWFJoeXI6xz25lTLpaFRhPQ0OcmqNvanu6.U3OWne0yJMslNcJ
 ZwzA6WvwBsRrdtQy7h8Tq4YNXE3YgvtQK0hQlf5cCWihTGCxQ2Z_MiokP4Vu8ICTrICeJCjjhQL4
 ktHPBrmd2ULOfCpsPbEkqXECsiK3xhde4O3_ZxIL2LK6z3nJtYUxD4BVbWknaxRzLyxsoFWFmRcV
 Ue2JMNaHVZzUlSnOQP3UdRB7jJbxvvFnrOQY3Wy_Ay9iSfxSywwNJG2gUNomO3WgnvRvqdD5.U9Q
 DbtmP55b471gm0kAnA_kOU4..LWjIsAV4z5.EM8V.u5w7ofF3iUfClr1M24rF.exoHfFmcsR1kda
 0dORwnQHIsaycfUEcBumVXkWssjthlu15IPz8clXROC7DH9nE7LQH0ElnHEDF8Kzn5EivyrWMwoc
 87CLWdYwz6V8mY_wp8vMV1eU3uQ326ZvwYRuK.0NGgZKU0CzcqSMH6a9VsPL3IPNGoEhmvti26M9
 N2m7fkYOY8eJ2S4.bUBpQbS56UP_7DeOtIAXByMoocxQ9zBJa_1ZQw7ZoTmRlWW6B2PCDT1r0Zno
 daCs.ckqWl_FOcJJgNy05fhoqzPo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Feb 2019 21:59:40 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 229e69f4e2bd9251a968bb217882f18c;
          Fri, 08 Feb 2019 21:59:39 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v1] t5562: remove dependency on /dev/zero
Date:   Fri,  8 Feb 2019 16:59:26 -0500
Message-Id: <20190208215926.23600-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
with yes and a translation of its result to a stream of NULL. This is
a more portable solution.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5562-http-backend-content-length.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02..63f82cca2 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -143,14 +143,16 @@ test_expect_success GZIP 'push gzipped empty' '
 
 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
-	env \
+	yes | tr "y" "\\0" | env \
 		CONTENT_TYPE=application/x-git-upload-pack-request \
 		QUERY_STRING=/repo.git/git-upload-pack \
 		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
 		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
-		git http-backend </dev/zero >/dev/null 2>err &&
+		git http-backend >/dev/null 2>err &&
+	echo "Err is" &&
+	cat err &&
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
-- 
2.12.3

