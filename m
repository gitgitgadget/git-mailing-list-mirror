Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8BA1F454
	for <e@80x24.org>; Thu, 31 Oct 2019 21:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfJaVEE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 17:04:04 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:41963 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfJaVEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 17:04:04 -0400
Received: by mail-yb1-f202.google.com with SMTP id w13so5541658ybj.8
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tPHhH/3Sacnd/5rzrQU5QmR0Tjkepp/0HDWoEcgyad0=;
        b=U5wCBeHDQkdupyJfmCo6REd8SOb+LTrBo3zQl8qOHi6eT0ohBUqxZu1zBXBWjMPq8u
         H79Fmr1+WGnNbe8XHsaM9Oqz1MEuAQ/S/fE98A6DKdcjo3npbeOlrjQ14s+qtHgsJAem
         CxMs5aDCNI5+SXkdus+y9bBUNeGGx4R3aJthI3XfoLLJm9dWxns0Eiz0o9F7p8bfq4Zu
         L8yCwGLKGFAbnagvpgZK9jSr27ozaWqkZR+r34+fswSyjjTjZZr4a7C6Y16wlKrZtN0R
         EUj9eWd/EV8/W//wm8xYdDss2l3uR8XT1XCCAJG4xNawm4wdAHugUNXxEeMgX72BdObs
         VQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPHhH/3Sacnd/5rzrQU5QmR0Tjkepp/0HDWoEcgyad0=;
        b=tDW0RTMvThd+3HghWUS82Bp82NB4OQc3YHvCIoRdY/KdXAxoKpcqj2JJ+vJK3BkpUv
         tJ7YaqolMlq5jClcas52OBUGAaAOL1vsZkFBRD3BiWUbm4rItFLx+BU1EI0079JFZ6zF
         yA5j52v5A9eUIwaCO+2jvU1JPsl8J+yFbMAucHMYN3qHau9gyxovRo0isRDdq3QXyse6
         uLWxvW2851GurRH+D5ZZEwiYZF9FbQvIEkRD9mzwFF3jHbdMZY5dXyzLFYhb1AmoxuwQ
         uvt61ACMo/3r2EqHvDafvZQOgadG9o+kM/t4ZUss6IPy4hDd220N+LrK5q1ROGSvB2uZ
         ylUg==
X-Gm-Message-State: APjAAAWN/SrRFwq3h+3SOVVWXhEzADduXrsHPj4xpFOJ7+c41P4JKh7i
        iRgXgI/PjMBxsxpZrzOrl6DDgyJnLkndakPYz56wjvvoCreId9Qm40aI30GkwYPoPDE61Bg2XTA
        Xd9v3QIYusbBTUmqQ8nsF98qZ7MywMhmyK6sg4OeFItVye/N5W2IljnCVDRjGvhcexe+W3NC42w
        ==
X-Google-Smtp-Source: APXvYqyGyyEO0xBYAcT+IOJhvrY/ESGQYtK8cohTc5oMHpb2zQqbfyedV1xnSKqp4oPmAM15i5uI9568llFAsyVReSo=
X-Received: by 2002:a81:5942:: with SMTP id n63mr5443419ywb.85.1572555843452;
 Thu, 31 Oct 2019 14:04:03 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:03:38 -0700
In-Reply-To: <20191031210338.152529-1-emilyshaffer@google.com>
Message-Id: <20191031210338.152529-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191031210338.152529-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 3/3] myfirstcontrib: hint to find gitgitgadget allower
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
index 5ce94e077c..b55837e646 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -785,6 +785,14 @@ will automatically run your PRs through the CI even without the permission given
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

