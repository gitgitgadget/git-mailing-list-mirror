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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A011F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 21:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKOVxt (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 16:53:49 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54002 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 16:53:48 -0500
Received: by mail-ua1-f74.google.com with SMTP id 49so2679432uad.20
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S7BryRTOTW4RlvXetMVX263lJ02Vg7RBDb/5SfnZ1r0=;
        b=msETovvn0AgVmOG1qf6m5GoELGxo89mwQdyExbuoygA0GygpfKxSCeaCZhhkMsdZh6
         FXkKUzKq0KGi+d4ALZ1N1+h9woKWdoxJDeMvwonPzHfkftR/zz3uAm+ZyDo5K63tkr2G
         4BTSdkjXK0kZGOl7Tv3ZrAOLCi1d2jF7Bz6fAWd41j49Ak3WwhDGqud1SYTPX4Uz0z/w
         QOsHURVBsoS8Y7jqk/baSlq6vEbRN0SjhuBdrLoxQ6QLdZjHPEKBPCWsPujlxalN5gwx
         142MXtW491rDDeDHi5wK72Pf66wWo1f8dLso6o2LjqmCm59xz73JAPuIHMyMBYHBpAUB
         7HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S7BryRTOTW4RlvXetMVX263lJ02Vg7RBDb/5SfnZ1r0=;
        b=Y+X9pcx+VEJqCNQmfcgGrX4RTgyvNXz1sP1WawcSDnaC06I0N8vzVGOQ9m+wJQbmQj
         NMVas+QRv9giB8p5/O71+nqZ2vHWtcSzDztts2etplW1Aei91jdBM8cpT1Nq8YraI/o4
         9pmQ+VFy3+of7QUeRsLjRZIyEVVI+3glUZvuV35/WG/+f3mq8akUDaD8uLsL3qOO5ON5
         P7ioffhTXGsgd4gpSozjQv5qIO/wuJohB6YojQfr0SLuTjC5N12yr7uZur7f/0KWfi/s
         Id5UANS1gw/Gp+lzesxA/oqg8SzWMnaQPbzdl4iU3WI6hdYD6aJ8WTNhpLgll5wurAOP
         Xa0w==
X-Gm-Message-State: APjAAAVBrMoZ5sNRibMJuNhPrP00bbZCt0bwAHo/hVZ5S1V8qfPQXjj3
        64uUkV2JfcNozw8bvQROMVirkMj0IimrMPb4GlVT2KLcGTJ29mHdlsLvdhWTXzkKu7c4ORtwdKw
        Z9giZW26BychDHb5zYW9Odr+d+gfVYw4RFyjPmFmF+0YoZ2AYb42U7fBAWwljYWoYZzf9sXOgVg
        ==
X-Google-Smtp-Source: APXvYqxPQTBG+t0h3BscWpPHdU+4zuFpwP93c+m2LUd06cRK45oV4t3jSwZonFUnomEOhF4AWVMC/HO7FQHIFaZ7+kI=
X-Received: by 2002:ab0:661a:: with SMTP id r26mr10550948uam.59.1573854826158;
 Fri, 15 Nov 2019 13:53:46 -0800 (PST)
Date:   Fri, 15 Nov 2019 13:53:42 -0800
Message-Id: <20191115215342.37408-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] MyFirstContribution: add avenues for getting help
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we
now have a mentoring mailing list, to which we should direct new
contributors who have questions.

Since #git-devel's traffic is fairly low, it should be OK to direct some
questions there too. Mention some of the conventions in case folks are
unfamiliar with IRC.

Because the mentoring list and #git-devel are both a subset of Git
contributors, it's possible that no response is found on either forum,
so list the main mailing list as a fallback and mention some of the
conventions.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 5e9b808f5f..9fe197c98e 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -23,6 +23,38 @@ useful additional context:
 - `Documentation/SubmittingPatches`
 - `Documentation/howto/new-command.txt`
 
+[[getting-help]]
+=== Getting Help
+
+If you get stuck, you can seek help in the following places.
+
+==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
+
+This mailing list is targeted to new contributors and is a great place to post
+questions and receive kind, detailed answers from volunteers on the Git
+project. You must join the group to view messages or post.
+
+==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+
+This IRC channel is for conversations between Git contributors. If someone is
+currently online and knows the answer to your question, you can receive help
+in real time. Otherwise, you can read the
+https://colabti.org/irclogger//irclogger_logs/git-devel[scrollback] to see
+whether someone answered you. IRC does not allow offline private messaging, so
+if you try to private message someone and then log out of IRC, they cannot
+respond to you. It's better to ask your questions in the channel so that you
+can be answered if you disconnect and so that others can learn from the
+conversation.
+
+==== https://public-inbox.org/git[git@vger.kernel.org]
+
+This is the main Git project mailing list where code reviews, version
+announcements, design discussions, and more take place. If you fail to receive
+help via the channels above, you can ask your question here. You can join by
+sending an email to majordomo@vger.kernel.org with "subscribe git" in the body.
+The Git list requires plain-text-only emails and prefers inline and
+bottom-posting when replying to mail.
+
 [[getting-started]]
 == Getting Started
 
-- 
2.24.0.432.g9d3f5f5b63-goog

