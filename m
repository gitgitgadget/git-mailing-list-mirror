Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB181F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeHCC2H (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 22:28:07 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:41490 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCC2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 22:28:07 -0400
Received: by mail-vk0-f74.google.com with SMTP id d189-v6so1543369vka.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eUwTpYKraUbi2FJP8AH1UbRuqE2dllUr5XpHtVIXjMM=;
        b=dAwFHQ3ktm8NX7Z+7KC7FRDJfBaR8WuWdWH9Yf7p4I/bXhZz+6xhKRMIE9QX1QwW7+
         GOv8PdKcx6u3DT3N+xQdQfLTstV9t7a0Kdx0dAtAX2sKckLsHwcAs0vjYCT2stzNTkrl
         67kMU17hXqtl16iujoGWFrrMVGnx1asUzM5zWdQ6cip96jCI8LvOEm3lsBoYmAb4ByEP
         cwFv5qDjmttLiyxzXH882YKsuORA/Rl3rL9Hx4CadPfkxEHBeaBc2s0p+6pL5HtZPzWO
         PFH188xz4YKo+aBRDaHCBgVr9sa3DIDw0YWrjYPE0m30+TBmXSFcZxhy3dJMW948Sb9e
         KgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eUwTpYKraUbi2FJP8AH1UbRuqE2dllUr5XpHtVIXjMM=;
        b=i8DKJkE2Vr5pX8r59kb7Yy1OkK9JmFbGfGFKunGNIgtkPejEphlWwvbGcW4aSyAJho
         822CeR3+kmxVerCRMeqznh37Y6v+JQKA1rDh49dJQoXZOXcurW24Fvx0Qldhs2nbQ8go
         2zT/18qIJXKu2KCpo7r3G+RUAt9kNvzkvvAnavyYA1BPNVhGfH67nCeM8YDu1NkbyRYI
         b1WFTVSiDmhHe67bSMqMT3m2pYQH/YGODBiHyC4IOuY34J+lhkB7S0UFYzDg5fO5DFKx
         Iy6i60GB2ic4l43/bJD80Vo41hPdK3CegAqvcN36urv0Wq321igjWNEpvKk40bbghKUH
         lpfg==
X-Gm-Message-State: AOUpUlHWcy1aX3onFrX0h2N37k0NFwDtZU8tYsmtN8yed94RRBGjvGEk
        gExqH/7BBQy43/tQU05mOSRklBu7efb0
X-Google-Smtp-Source: AAOMgpdriByQGt53c5M4eTe70Xo6NjNPYgl9hVo/JNYCkFdm1jtBs47FfRY6aOE3o3YehMO5YaKY2+KR9dz/
MIME-Version: 1.0
X-Received: by 2002:ab0:53cc:: with SMTP id l12-v6mr2366972uaa.82.1533256468400;
 Thu, 02 Aug 2018 17:34:28 -0700 (PDT)
Date:   Thu,  2 Aug 2018 17:34:14 -0700
In-Reply-To: <20180801193413.146994-1-sbeller@google.com>
Message-Id: <20180803003417.76153-1-sbeller@google.com>
References: <20180801193413.146994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 0/3] Reroll of sb/config-write-fix
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only fix was in the commit message of the second patch:

2:  c667e555066 ! 1749:  38e5f6f335d config: fix case sensitive subsection names on writing
    @@ -2,8 +2,8 @@
     
         config: fix case sensitive subsection names on writing
     
    -    A use reported a submodule issue regarding strange case indentation
    -    issues, but it could be boiled down to the following test case:
    +    A user reported a submodule issue regarding a section mix-up,
    +    but it could be boiled down to the following test case:

previous version at
https://public-inbox.org/git/20180801193413.146994-1-sbeller@google.com/

Stefan Beller (3):
  t1300: document current behavior of setting options
  config: fix case sensitive subsection names on writing
  git-config: document accidental multi-line setting in deprecated
    syntax

 Documentation/git-config.txt | 21 +++++++++
 config.c                     | 12 ++++-
 t/t1300-config.sh            | 87 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)

-- 
2.18.0.132.g195c49a2227

