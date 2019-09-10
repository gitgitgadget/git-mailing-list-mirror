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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7971F463
	for <e@80x24.org>; Tue, 10 Sep 2019 06:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbfIJGji (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 02:39:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfIJGjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 02:39:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so17048892wro.4
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n3cOxkkpbVT2W9WmXH7VKafoQ1pZ7DKAr49UHiKBAow=;
        b=irrtXa2KHT7O21saEQppY9+OS7d12Su2ZFi8KdfVdO3yNpjRYA1A0BK+/vfWbuE5zs
         zgAwtAPQ5etj8Jgc5ZeX83f/+9O1DmDY6cGDmJhyxtYo1n82hMQa6JfW8FcEJ1lqdUZZ
         1ybsoeeg9ngFEhZPOhN9N847ole+n/5F/avkXWvyVIIqSomFQmQs8OkBrgO68Z+Wc5SY
         DqsP4V7B+9ye2eHfGL2YVq51qCQ2nX/UopSMLvMpjE9nXT7qD+G+Kbdz3rpusGNiZyTD
         uFC88nvVhdta2SEDElGo4+cD1UCAYFYwK8yKLTTqZqV2BrN2xJTcAYgaUKCv83UzJ/3v
         RX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n3cOxkkpbVT2W9WmXH7VKafoQ1pZ7DKAr49UHiKBAow=;
        b=R44w3Chl/sc3iRQyc7SrNJ0SFtQLCxzbiRLR36FKmYhhHgua5r00F4giJ6mlK8ruJG
         lkJkPNmdnUxLoFHQRRKr2nvvEthndAjoXbioZA7SID2od+A0wSR1ZtmJCaJciFDME9el
         FPQOAcz+zB8mlxEmysIErAdglWbvNxNGT3JGWQQ7oHNO4ZoVV0UIsudBJaOLaXRnWH2E
         sGe0HgyHVSqoYG017Qlp9+B2bskTGIBTSalSkIojzKG21WQuIZR4Bk/w9YLKtOBLqrDz
         U0O5u/ng2ZQlNrfvE2vyKEB3sZwmc16dFfV0mbG8kMRwDrvMk8NIszPzUcvi3rL4uQY2
         nvQw==
X-Gm-Message-State: APjAAAVqtn0ZG3PbAxboSFrr/Oi9Ivw45emY76+ZSaGyG8fDwR/x1Vjw
        +OSbJxLgi5SLeR2vzsDjHtFzDYv6
X-Google-Smtp-Source: APXvYqyx+dObxMrhFzOkWTCGk7LW1VgvcGQQQLpAfEqgK/FqLqXFPqT5ekpA6q/NvEfIqo2EsZdcDQ==
X-Received: by 2002:adf:a382:: with SMTP id l2mr23052033wrb.194.1568097575444;
        Mon, 09 Sep 2019 23:39:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s22sm1561323wmc.7.2019.09.09.23.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 23:39:35 -0700 (PDT)
Date:   Mon, 09 Sep 2019 23:39:35 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 06:39:33 GMT
Message-Id: <2743caa22e60c5ddc04d388f21a04500d7bcac1f.1568097573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.335.git.gitgitgadget@gmail.com>
References: <pull.335.git.gitgitgadget@gmail.com>
From:   "Dominic Winkler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Fix perl error "unescaped left brace in regex" for
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
