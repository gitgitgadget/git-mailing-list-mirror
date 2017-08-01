Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0003020899
	for <e@80x24.org>; Tue,  1 Aug 2017 09:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdHAJDv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 05:03:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35907 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdHAJDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 05:03:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so828867wrb.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i3vQJVqV2wQHP8UGGA5XJhpg8KGyKIsxcRZnbzci0SU=;
        b=QXjsPmvh16hO040ddz+eaFA4B83cOEDbOf72YNhFo6yc0rHkriCHa8Xiy2CT7JIHYZ
         fatjdt4L6RXept78ZjpXC0gAln/d8h+JWptW06T1CcEbXsu7wvrvGV7Quj7ucoWsWoCt
         8IMM0yuSIMQNBWZ6ozB5PaWZc5tJ8ZPrwlpbpLskVF2d1n9Bm6/Tc4oLZ47Q2K3luVtY
         GvEWLr05kDMJ91IHwL13/UNJs9tgbSEJOzpttzo2Zbj8TpjDtMJvFns+PQSSoa0wlYdV
         GscqnOZXh8sETyi9r1JKFhyaOoJNlmFK/NuQ8mUWMdg5pg0z1mOtt+Qt1bcY2aGp7Hvi
         KG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=i3vQJVqV2wQHP8UGGA5XJhpg8KGyKIsxcRZnbzci0SU=;
        b=HGXN0hp0O5lOhHWnjK3Yac+j5jd1ze9oXJrv6sYrWKue8EcnxHVC+AMCMS8WM6Wn3p
         F7bo8cQ8nYB9m+Z7TIcb9Pg09TpINbWh2qblO6cGd7gE+HEsgv2LjXLYnQNoB86tG/dt
         lbqVpreEtdCwPsMwbAaKDgPXoCW5pxOpXuQeCBMFIUrF4MEwisxDKLPACL6vTdx3/LnE
         s0UGYZes7gFUZnnGVkoxc1c24ggZaT3s0S9Xhhne+P+CIRA/+zzpAcW8lVOhdSRnQseg
         zc8afEThTe2/Rrj9eQnfr14f0sqNJoMfGGX1/YpI/+ZGm2W+ISFR5y028QHnhCr0r+TC
         Mxrw==
X-Gm-Message-State: AIVw113xKNHhqYcOVGHYqiWq2dDSc8wGBmBKCwyHg1elXdkMAofop0r4
        E4CHBkr5x9riNGG08yw=
X-Received: by 10.223.150.108 with SMTP id c41mr13936987wra.115.1501578221499;
        Tue, 01 Aug 2017 02:03:41 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.gmail.com with ESMTPSA id 91sm29947237wrg.83.2017.08.01.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 02:03:40 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 4/4] interpret-trailers: fix documentation typo
Date:   Tue,  1 Aug 2017 11:03:33 +0200
Message-Id: <20170801090333.32642-5-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170801090333.32642-1-bonzini@gnu.org>
References: <20170801090333.32642-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Self-explanatory... trailer.ifexists is documented with the
right name, but after a while it switches to ifexist.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 76d5fdfaf..0ef93204f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -193,8 +193,8 @@ trailer.<token>.where::
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
-trailer.<token>.ifexist::
-	This option takes the same values as the 'trailer.ifexist'
+trailer.<token>.ifexists::
+	This option takes the same values as the 'trailer.ifexists'
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
-- 
2.13.3

