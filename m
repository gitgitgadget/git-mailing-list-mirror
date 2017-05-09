Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A913C2018D
	for <e@80x24.org>; Tue,  9 May 2017 21:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdEIVCD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 17:02:03 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34622 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdEIVCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 17:02:02 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so5613100pgn.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XaxqwrUyXjRH2jrQ8wuknEIvaOGSWo+kKAB0pRei2Jk=;
        b=IwyOfgZhn05isvjU/uA3fo2kIXl9aG3+qvCrL5Qmub2H4oOoof2+K4i0XKvHgZFDGD
         nqURP7jUyxknrN7b8fcouaukdaBoKYHWY/S7NQE+55HjYMP/NgQ82i66axaQLmF6Vblf
         f09PP9HJFG3tbbMnnBB++LZSwinMqb6sy7eyfx9qgoqYM9pAPTVWWlhS75krT4qp/2os
         LAITRpw06i8/NHruEnkqMTsBDCIM4VQhriUA35nlZONov2413DdOMjrbp3Yot3eOet7X
         ztDaBc82pbsg1sVy+jc60bKWHlXsjGCoiGcw2dQnIxHKrhTpf7Eg9ISMa8iTXKv+fvrg
         vERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XaxqwrUyXjRH2jrQ8wuknEIvaOGSWo+kKAB0pRei2Jk=;
        b=AGusgkSrVtcb9djMyzvOMK8LvbkIdJcVKSuwEKLaYaWLNhcEeKF68ZMeS8xuy2yB//
         4D7YivP2ltYBO8G8eqQtgaR91k6sXK9DNKkiupLlBG3s8AQf5TIbgd8WyT0TtnmTzpkF
         LEmsrNVhY09NQxiwCis3lniayFZ4WK9lycXGV5gOflLicM1AdiabSVqbpZ+amQjY8mWn
         HOOSeINqvCBN7WH536S5nvjVPcsLBqJecK9ZJR8yphydKIXkkeY+Fa2looTM91TKfWK3
         gF84Vq/XYEpSeB7tFSqFC30LBJn4A9ycZIVIX68ahkm6u8sw5lNBiWLDf5TxU2/Ce/J3
         ODrQ==
X-Gm-Message-State: AODbwcArs1r9smTRFiOxQCrS12S9AHPLO1KoGueybTiq5mEP9mbXGbAU
        nJZzOYei7yt3OVulVq/fjg==
X-Received: by 10.98.86.74 with SMTP id k71mr2086196pfb.13.1494363721660;
        Tue, 09 May 2017 14:02:01 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 128sm1230142pgi.49.2017.05.09.14.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 14:02:01 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3] fixup! don't use perl -i because it's not portable
Date:   Tue,  9 May 2017 14:01:58 -0700
Message-Id: <20170509210158.17898-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <cover.1494357692.git.jonathantanmy@google.com>
References: <cover.1494357692.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Ah...thanks, Johannes, for spotting this. Here's a fixup.

 t/t5534-push-signed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 177b933a7..807267b7f 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -152,11 +152,11 @@ test_expect_success GPG,PERL 'inconsistent push options in signed push not allow
 	# Tweak the push output to make the push option outside the cert
 	# different, then replay it on a fresh dst, checking that ff is not
 	# deleted.
-	perl -pi -e "s/([^ ])bar/\$1baz/" push &&
+	perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
 	git -C dst config receive.advertisepushoptions 1 &&
-	git receive-pack dst <push >out &&
+	git receive-pack dst <push.tweak >out &&
 	git -C dst rev-parse ff &&
 	grep "inconsistent push options" out
 '
-- 
2.13.0.rc2.291.g57267f2277-goog

