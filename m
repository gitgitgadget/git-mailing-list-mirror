Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEAF1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfJVOpl (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 10:45:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVOpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 10:45:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so18399020wrm.8
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AmB+IJa0iryVkW5Wicv+ZPaXCMFvV4ZViRCNEUbMMJI=;
        b=DFD0Ps+oOMol8BW1vnNvpyDI5ufnSHlxjC61WJm1X3r0bf4lZXN9DQqMannPvnTWP3
         2OzldvOkEGV3kHbgDBWQ6fMsJ/+BBJGOEvXb7cdyFGp/OW5Mi2P9zS6CaAxvKeOWKy9X
         cUIXCfP5+lI27bnGf0R8palU/TPcF1Di9nYgCTvgXPL2bBZS1JVAI4covz3T+uWPxjpy
         ZY3d9V+ZN5ZIy+OnlcVYyIMycJlnL+rpalaujgDuKH2av03sAjhsK8VUGiOGUDhh2q6v
         gidi4D0z/IBawU/RQ2SZM4E+T3GZa+qxzkCxuxGnYTpOWQJ2wPwzNz0P0JbNILF/rrwv
         H/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AmB+IJa0iryVkW5Wicv+ZPaXCMFvV4ZViRCNEUbMMJI=;
        b=W2ZSUuC2RwicPFtc2VlV5DXDfWNfzhNyarTsy9nh5dABD48q28IABc8nQuwMBLMK9V
         xbRYo6XeJoPArsJIGUpC6Nk1H7MJR6VyXG1/bih4KGTGPbtwJJfTa/fIVuGbZLr3mdPO
         Ew+gY1OFVexKfI1Z+XKRVrAvSuoB/HVRp+WheirgEZDWzHOjjHx8LLcprz8wAGH0RXV9
         wzOS4G4xooP9G9iEIAfwA53ReKo+obpkP4RMj4a1LqtAaJMTy5ANgOVrNPPniwTZB0aA
         u9yuwE7wSqUg4LA7nwj3x8k5QZXlsUVstlmTcBJ1Zg9eYE1JH2iC/wwWh1FMauB855Kc
         0L7g==
X-Gm-Message-State: APjAAAV+IdEY+3aFrSjkl+lMfRhdr5l67m0DUsgGcl1XjWZSA2AZO4Zo
        aFf+QlWeEIJq8XKyEisUvAP7tsMD
X-Google-Smtp-Source: APXvYqwW71OP1SqSoqvVhzqmRS+qLBWbAFuJ2q0FvHehlpUTAuPoN4HRnCLERIRQNCbvKDNAkP78lg==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr3834957wrq.180.1571755538843;
        Tue, 22 Oct 2019 07:45:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a71sm17200420wme.11.2019.10.22.07.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:45:38 -0700 (PDT)
Message-Id: <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
In-Reply-To: <pull.407.git.1571755147.gitgitgadget@gmail.com>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 14:45:36 +0000
Subject: [PATCH v2 0/1] vreportf: Fix interleaving issues, remove 4096 limitation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes t5516 on Windows. For detailed explanation please refer to code
comments in this commit.

There was a lot of back-and-forth already in vreportf(): d048a96e
(2007-11-09) - 'char msg[256]' is introduced to avoid interleaving 389d1767
(2009-03-25) - Buffer size increased to 1024 to avoid truncation 625a860c
(2009-11-22) - Buffer size increased to 4096 to avoid truncation f4c3edc0
(2015-08-11) - Buffer removed to avoid truncation b5a9e435 (2017-01-11) -
Reverts f4c3edc0 to be able to replace control chars before sending to
stderr

This fix attempts to solve all issues:

1) avoid multiple fprintf() interleaving 2) avoid truncation 3) avoid char
interleaving in fprintf() on some platforms 4) avoid buffer block
interleaving when output is large 5) avoid Out-of-order messages 6) replace
control characters in output

Other commits worthy of notice: 9ac13ec9 (2006-10-11) - Another attempt to
solve interleaving. This is seemingly related to d048a96e. 137a0d0e
(2007-11-19) - Addresses out-of-order for display() 34df8aba (2009-03-10) -
Switches xwrite() to fprintf() in recv_sideband() to support UTF-8 emulation
eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
so it's safe to use xwrite() again 5e5be9e2 (2016-06-28) - recv_sideband()
uses xwrite() again

Signed-off-by: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
[alexandr.miloslavskiy@syntevo.com]

Alexandr Miloslavskiy (1):
  vreportf: Fix interleaving issues, remove 4096 limitation

 usage.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 6 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-407%2FSyntevoAlex%2F%230194_t5516_fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-407/SyntevoAlex/#0194_t5516_fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/407

Range-diff vs v1:

 1:  5fd06fa881 ! 1:  54f0d6f6b5 vreportf: Fix interleaving issues, remove 4096 limitation
     @@ -23,12 +23,12 @@
      
          Other commits worthy of notice:
          9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
     -                                                    This is seemingly related to d048a96e.
     +                            This is seemingly related to d048a96e.
          137a0d0e (2007-11-19) - Addresses out-of-order for display()
          34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband()
     -                                                    to support UTF-8 emulation
     +                            to support UTF-8 emulation
          eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulation,
     -                                                    so it's safe to use xwrite() again
     +                            so it's safe to use xwrite() again
          5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

-- 
gitgitgadget
