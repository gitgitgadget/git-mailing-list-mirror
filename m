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
	by dcvr.yhbt.net (Postfix) with ESMTP id D74111F463
	for <e@80x24.org>; Wed, 11 Sep 2019 21:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfIKVr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 17:47:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfIKVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 17:47:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id q18so5148838wmq.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uIFTGJ+pG9/qgUAgI/ZQw5/QAQF191zuCgSHXPg0LUo=;
        b=TohFNY/Pjs1eIwEpU6gwIkYMrl858BdNudPESQUp3TGXvOghYwjtno4zx2HHfMExIu
         L//Y57nTHqcAKIXVUPJau6vvNjPa37hO0q3F9gVvJimwVP2qlZI4ekZSPeNtfHTMStHQ
         NmACBKwV4d1Un9qO3qRYlvWgxAG1XwCdFH8LQ10WGvVw2tRohIa8ud+x7Fs26ndMC7KE
         ishJ7C85qEQ0FJTxt0I7muJHHnQfbinJ6WKQ5zMwN/H1PjaogduH2wJkAzDACnTeZkrw
         ZPskiomFeFv2Rz1Rez7PRhpSYohQlLRQsqXgHe6EL7B8ofxqtNgf91udAY7ViRxYUCgo
         r6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uIFTGJ+pG9/qgUAgI/ZQw5/QAQF191zuCgSHXPg0LUo=;
        b=WBI6imNR449kiT+ENrwLi7/JyiujsP0NwpgsNvqVkVGhQVAAOYRGghISPY2Y+1iqlc
         V5lJ3L+Mu67ddM3Ij2eg15n0Zebl+G9M3XWfbNwSE3jrjdu6eLCJhZUzXVk0g7h2fkK1
         jUVWe1ZjLeiUCrrDVd8sP83OXgsRwHbYaoPrx8qdqEfdCQCCM9gDOertEDqSHrY2xwTz
         SVrGmG/ypJ0KWcUWDBtnRtSyxr5QMbe62ynX5oLsB+NTIiDv2Ormpghtf6iEFNtdvbBl
         GkcIV9o3CROEvWTIQqgN7VggluBBHmqvaNWm0uQmuAEwquPwb2OPC+5KZ2pO8sAKxSxt
         5S1A==
X-Gm-Message-State: APjAAAXo44BsL2wRaFfEVNWyRNUct8KCQtC4fMiMUfCqw3CulZv1AMhW
        iF8y3CJVOs72Os23+hxw3D16vekR
X-Google-Smtp-Source: APXvYqzLu2AuAQQD46DJ0iEr9ledXcCO3DVUsCXIfeC0QcIW7wzXpd20lwLInlYDbOXIT4j1AKy1Kg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr5444430wmi.91.1568238441770;
        Wed, 11 Sep 2019 14:47:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25sm4669206wmj.22.2019.09.11.14.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 14:47:21 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:47:21 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 21:47:19 GMT
Message-Id: <pull.335.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.335.git.gitgitgadget@gmail.com>
References: <pull.335.git.gitgitgadget@gmail.com>
From:   "Dominic Winkler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Fix perl error "unescaped left brace in regex" for paranoid update hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A literal "{" should now be escaped in a pattern starting from perl versions
>= v5.26. In perl v5.22, using a literal { in a regular expression was
deprecated, and will emit a warning if it isn't escaped: {. In v5.26, this
won't just warn, it'll cause a syntax error.

(see https://metacpan.org/pod/release/RJBS/perl-5.22.0/pod/perldelta.pod)

Signed-off-by: Dominic Winkler d.winkler@flexarts.at [d.winkler@flexarts.at]

Dominic Winkler (1):
  contrib/hooks: escape left brace in regex in the paranoid update hook

 contrib/hooks/update-paranoid | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-335%2Fflexarts%2Fmaint-update-paranoid-perlv5.26-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-335/flexarts/maint-update-paranoid-perlv5.26-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/335

Range-diff vs v1:

 1:  2743caa22e ! 1:  0d762cfb50 Fix perl error "unescaped left brace in regex" for paranoid update hook
     @@ -1,6 +1,6 @@
      Author: Dominic Winkler <d.winkler@flexarts.at>
      
     -    Fix perl error "unescaped left brace in regex" for paranoid update hook
     +    contrib/hooks: escape left brace in regex in the paranoid update hook
      
          A literal "{" should now be escaped in a pattern starting from perl
          versions >= v5.26. In perl v5.22, using a literal { in a regular

-- 
gitgitgadget
