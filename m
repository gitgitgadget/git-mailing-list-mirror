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
	by dcvr.yhbt.net (Postfix) with ESMTP id E68081F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKOXGn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 18:06:43 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55821 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfKOXGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 18:06:43 -0500
Received: by mail-pg1-f202.google.com with SMTP id a12so8348148pgl.22
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=OaUi/9Ozv94H3tPHM7WvaIyJ5Ykoh6+We2kHITEnpds=;
        b=bErXA+V/RgaxSH2hXvDFJ+1IvGoZRtSH1bEM2MgXOXg3tknrCcQwPaMORw3JnyYIIJ
         Lv3gv8fRz4m0WR8zi/iSQTiMFEG5xzDOsh3ypKTj1v1+CQ/fvk91bJz97dvj1cQBR+nj
         7ISwBkrR03gC+0Nx8zZyQbXejWJKxLzHiXAr/0dn5ooBszt/cIw4+TE1o6rYNB7yrXr2
         QGRFk6lqxFMO/lVf1xzGuVNvyivZlzb6bT0KNaiglWkXulW4/esGqgFD30sAw/WNMyeX
         40/LzhinzSYetkn5HiyEGXLCauYzhGtpsOY09RwFs+woqhhyJcQRuNXorxogomFBj7ty
         Rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=OaUi/9Ozv94H3tPHM7WvaIyJ5Ykoh6+We2kHITEnpds=;
        b=YoJIZTYQEVCAgZDmLY5ST1xVikIgoilSel8ncgwzV3zEnDU+hYAP8fo+aO8eNrpDNb
         uWTlbvGpP5CdynbeLNfdluQlzb3spdxABu+gqh45UscfwJ7bZMwskbh1nQCmU4XQKla7
         0eEibdracuRnkL5YBvnx0gjLpCofR/OUw7BnKdBebK55DLyN8iTMD+TegZvSwy72zTkn
         2dWcs6A60N+sd0awyj74cZBUs/vblOpxyzjONF92x5fxXu4Cqj4yKoR7SoDdcvb1ImDX
         TJ2plXzpNSXHixYFkgvJFcuU/oF5iW6I7aTeXAK/gPq7DA/tsEhHbEadQHodMebrSRoF
         21ZQ==
X-Gm-Message-State: APjAAAV9IJB359Ej7sCX6wnLyG2NqjK+ku9oGcA0+CGnPQGKZk7Ckit2
        rF4+3Q6sARvsKN9lWaTgybb3rlgp8jeD1JLH3qYpAyS696JLQhVqRKLiEi/LUT9RElDBtSaoTc1
        PQRlmbNi1MQTXxAoHEWAnei9AqHTqFTyVQL4fuMEl1wiewtnEe8Dxo1lXTJVEox14AFi7AqGGKw
        ==
X-Google-Smtp-Source: APXvYqy8wS3zFQiR/qnlVcVbj51mumqttITboUSfrnhiJADpq2Mv4yEq3TfpQaVKmpbny/mwBewxNULsCuYdson3IBc=
X-Received: by 2002:a63:dd51:: with SMTP id g17mr18699656pgj.388.1573859200990;
 Fri, 15 Nov 2019 15:06:40 -0800 (PST)
Date:   Fri, 15 Nov 2019 15:06:37 -0800
In-Reply-To: <20191115215342.37408-1-emilyshaffer@google.com>
Message-Id: <20191115230637.76877-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2] MyFirstContribution: add avenues for getting help
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Denton Liu <liu.denton@gmail.com>
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

Reworded the Git mailing list blurb per Denton's recommendation.

 Documentation/MyFirstContribution.txt | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 5e9b808f5f..90f45b387a 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -23,6 +23,39 @@ useful additional context:
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
+help via the channels above, you can ask your question here. The Git list
+requires plain-text-only emails and prefers inline and bottom-posting when
+replying to mail; you will be CC'd in all replies to you. Optionally, you can
+subscribe to the list by sending an email to majordomo@vger.kernel.org with
+"subscribe git" in the body.
+
 [[getting-started]]
 == Getting Started
 
-- 
2.24.0.432.g9d3f5f5b63-goog

