Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEB71F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJZAyI (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 20:54:08 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40351 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJZAyI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 20:54:08 -0400
Received: by mail-qk1-f202.google.com with SMTP id m189so4035917qkc.7
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sl47+OCDMyQio8nohfNrcu7KZG4VsyZOurIm5I9NE7w=;
        b=nwObUygZGZkvvmf36/rTcRJKmHjk7vbSxzsxYUmaQ+Woy1zkMzATGxl4AmfIDh8+2c
         PPg3Cu0yXyk5YbpFCuXrfsNyI1OBzb232SJQoqGH13zSuz73iXOcOuWy4RXjF9Zf2uc3
         iNQqc+VXhp5iDLO6VAVOMBPpaG6mVTUTq2/37Od9lg9pT9nda+rdpKc4q8sZ7sqfQ5JO
         VoQQ5cug2Kwg16vcNCF4td3gvfjHMtslWkEM/V82/CUpYXoWaqEh0HRvAUu4dxJjxO0l
         WwYhfLZjIh4mZSHY5TVms/k1aRsF+Ee2IrgsbIkJEkXXYQdHDFFYXvm+DBWiL0pyoZHP
         OJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sl47+OCDMyQio8nohfNrcu7KZG4VsyZOurIm5I9NE7w=;
        b=eclX+ybl+MiKAA/wfJfrf42kRa75Dio4dShoxucGOYk+dEePsvmCzP5x42tXGeRZ+z
         fAx+qILcZ+vYtus10hHO+VaF1Wr7HQAFzrL4MWpReUfCEJ4uc9xn2N1DgxfPuxz2rqy1
         mnWLGrouJIG2bUO+UNokz38bpZJvkKJG/2ERSozepw23h7pEWuJ3a1EGflsppUkrOSUM
         rG/afrq6N0DmGIok+YWdAa/L+/qxAuGewgrkTUNzBNtNhZq2PlwzkofUBP09FLxBogF7
         SgTEZc60OIkT0JVu7vki8XkDSceMd5YD6IEVAuzhGu4fkjsM7xWURzIDeUyHoS/IdMX2
         xEnQ==
X-Gm-Message-State: APjAAAUR/lpmYlZuLYA2mLJej72fnRQFm006iBC59gHBBAyt34Yec57S
        fGpr9YTC/4BIFuHnrK5rzcB1SRfoiKg+tBDkO3i2GIN64SSEEC/IdqnO6ZhMRfTeiYTCN64sRpt
        J7CtX2b/j1AcGjGKQyqTlyWvN4Tp5/bNKLW1Kxrl8l0g2qTSgMtaJLDOCKXdVOFKnnFzaXcxB3Q
        ==
X-Google-Smtp-Source: APXvYqwgU7H6nN27jK6a7NBrUiqstxrDG5modJ81Klejr6HWTqSmE5LBFT5K0kl/jvPqXJBwdcp4gS1eEneUKOWIt3M=
X-Received: by 2002:a05:620a:148f:: with SMTP id w15mr5525579qkj.341.1572051247256;
 Fri, 25 Oct 2019 17:54:07 -0700 (PDT)
Date:   Fri, 25 Oct 2019 17:51:59 -0700
In-Reply-To: <20191026005159.98405-1-emilyshaffer@google.com>
Message-Id: <20191026005159.98405-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191026005159.98405-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 3/3] myfirstcontrib: hint to find gitgitgadget allower
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitGitGadget, a handy tool for converting pull requests against Git into
Git-mailing-list-friendly-patch-emails, requires as anti-spam that all
new users be "/allow"ed by an existing user once before it will do
anything for that new user. While this tutorial explained that
mechanism, it did not give much hint on how to go about finding someone
to allow your new pull request. So, teach our new GitGitGadget user
where to look for someone who can add their name to the list.

The advice in this patch is based on the advice proposed for
GitGitGadget: https://github.com/gitgitgadget/gitgitgadget/pull/138

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index b8ffeda07e..2de06de026 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -789,6 +789,14 @@ will automatically run your PRs through the CI even without the permission given
 but you will not be able to `/submit` your changes until someone allows you to
 use the tool.
 
+NOTE: You can typically find someone who can `/allow` you on GitGitGadget by
+either examining recent pull requests where someone has been granted `/allow`
+(https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
+is:pr is:open "/allow"]), in which case both the author and the person who
+granted the `/allow` can now `/allow` you, or by inquiring on the
+https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
+linking your pull request and asking for someone to `/allow` you.
+
 If the CI fails, you can update your changes with `git rebase -i` and push your
 branch again:
 
-- 
2.24.0.rc0.303.g954a862665-goog

