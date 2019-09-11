Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D061F463
	for <e@80x24.org>; Wed, 11 Sep 2019 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfIKVrZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 17:47:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41570 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbfIKVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 17:47:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so25199557wrw.8
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n3cOxkkpbVT2W9WmXH7VKafoQ1pZ7DKAr49UHiKBAow=;
        b=a2cPtPZCLKcMH8ICSOQIEfX6kcF5yLlMewYTbQS2bDA/1Cdg8GRl8Amt0VDo2qhdRb
         Q/5uwbvdpPoWH4uTsOr4YLjwU1BQxyZqdJ4gRBbVpmob4s+ltrgyh0Gky3fwAoDu9tsj
         rshQxu8bz9PgM1J4YPEKg9Uj7KugISnMY/3FSoXUwZ0tdUk32HGwXmseS4lFViJk06x3
         fpwEaRaLOWPRdIl09ff9AhvtmAltjKASyUzDMMWEOz4aX6I+RH2WCUwxeyqh4CtFZ/AT
         ain3lthI+ECJUBLdGC3cZ3Tf/tH0lm+U38QAB0LHiBHmT5q873d0fSz+W7+MuBqrGIfT
         89Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n3cOxkkpbVT2W9WmXH7VKafoQ1pZ7DKAr49UHiKBAow=;
        b=nrsuClXms03o8vYuqRoG2Sllb9wSw6kS6lVajeDDVlrEctjbtpf0aLWIfcdu7PH2EN
         94g1z/KcmawMt3LM+iv7QiO04HxVSl5gVg6Ea2spBYq4UcFeWIOR7BFnmHd30LCtvnvF
         fD+MlCwkY0XaWTrKUOCWqsFjlJzWHmITQWIwZMbZeWXyEg0UycJdvTTVU6aVC2qJSokR
         C1J4awBf/M55PCrGt4/1/cS6Mu8JsGOUPY8iLOd5cqBQr88TyvBr8OKdkhpF4EsOTGIB
         Oxp1cNaAwf67kfn1ZnoNjTK4I2P8bZe07jAM3GsjiRyEF6ffNGtCpynOAL+K+yxCp3X1
         ujww==
X-Gm-Message-State: APjAAAUGLXm6/heYZeBYqxwhqeD3GPkWBKDQF1hc9EiGAkzjkIqmqeGD
        mi/g1x7tTDPqhBVNfgxVSc+D8oXR
X-Google-Smtp-Source: APXvYqwa/MpOg4wKdaaGlie7RdF+Qllu+SsOoWiE87FHV1oLMQN7QuL29WFz2rKLCHls1qICuz0sfw==
X-Received: by 2002:adf:f801:: with SMTP id s1mr2832869wrp.320.1568238442486;
        Wed, 11 Sep 2019 14:47:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i73sm4190907wmg.33.2019.09.11.14.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 14:47:22 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:47:22 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 21:47:20 GMT
Message-Id: <0d762cfb503fef081af9aa3cb0fe373863237745.1568238440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.335.v2.git.gitgitgadget@gmail.com>
References: <pull.335.git.gitgitgadget@gmail.com>
        <pull.335.v2.git.gitgitgadget@gmail.com>
From:   "Dominic Winkler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] contrib/hooks: escape left brace in regex in the
 paranoid update hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dominic Winkler <d.winkler@flexarts.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dominic Winkler <d.winkler@flexarts.at>

A literal "{" should now be escaped in a pattern starting from perl
versions >= v5.26. In perl v5.22, using a literal { in a regular
expression was deprecated, and will emit a warning if it isn't escaped: \{.
In v5.26, this won't just warn, it'll cause a syntax error.

(see https://metacpan.org/pod/release/RJBS/perl-5.22.0/pod/perldelta.pod)

Signed-off-by: Dominic Winkler <d.winkler@flexarts.at>
---
 contrib/hooks/update-paranoid | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index d18b317b2f..fc0a242a4e 100755
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -302,13 +302,13 @@ $op = 'U' if ($op eq 'R'
 
 RULE:
 	foreach (@$rules) {
-		while (/\${user\.([a-z][a-zA-Z0-9]+)}/) {
+		while (/\$\{user\.([a-z][a-zA-Z0-9]+)}/) {
 			my $k = lc $1;
 			my $v = $data{"user.$k"};
 			next RULE unless defined $v;
 			next RULE if @$v != 1;
 			next RULE unless defined $v->[0];
-			s/\${user\.$k}/$v->[0]/g;
+			s/\$\{user\.$k}/$v->[0]/g;
 		}
 
 		if (/^([AMD ]+)\s+of\s+([^\s]+)\s+for\s+([^\s]+)\s+diff\s+([^\s]+)$/) {
-- 
gitgitgadget
