Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6B71F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeDKUT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:19:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37038 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933282AbeDKUT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:19:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id l16so2192267wmh.2
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UpeWPx9pHrdsPWGzfAWGAV1nAqPoURe9cOBiqOSkp+Y=;
        b=Qp5iRTsqZJ9u+Fl9yGcP6z5o0bCwxD90NGIESzsomzUKfjLZ9uBg/2Bqn06lIsIy/V
         2kMmItqIpOodx8CVHg9fs6hei9UQrsFbd8ja4cKdjpIPvFZN/6EH+v+zEBW4UcRvJHM6
         bd9D/4bCJZVqhtECLa50nNJVN4z8rYCA0USlJXwir0aNI+gdk96s64sqmgN7cHv6jHL3
         CXxgYDuIHYKmsdfpv1hH4hNqiSBps7562TM58womXzqHyRQSPML8uDKYOP7tU4V4kMpp
         CQ9OjgQhgpmDZ/dblFmipUdml6/vS6yzxxZ6wVjlgXB077bG1SzbxyfgO2Xrm6BhHpgM
         Zl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UpeWPx9pHrdsPWGzfAWGAV1nAqPoURe9cOBiqOSkp+Y=;
        b=NNRPRCBmBqz1/wbHGY5lUvD3WgTwj0mDcpWtOoGKfOp3sqE+S/xSOuEKHa+YXwuEIs
         +DA2qDZvmcmx+Oshjr+iW9gb5H6/1+MFE3z2jDleoL2wC7Hsl1bAaGzMknEM56tTrm+g
         qZzDnlDQrVVGmkKUyyPCXcy3birD2thEIaD4RIE5pHNoETMQwcTQln1b0gXMTk9+1n0+
         qPBfSMynG/UW2+YGQ48P59fOmDnx5XsUfcc8fkXHOsKO6WmkOknN5AqULROthwhK4yz7
         M460Y4A4vQuyTO6UuuREIWk2BipwKPkOflgCrxDwEuFvk/q0NCzI3XOFX3qNfY/pGOUJ
         Coaw==
X-Gm-Message-State: ALQs6tCBMe6myvozM7gjpPouLO3Hg9qYSFykEWrdBK52lJaTjNYQ57J4
        mBUy7zh56A+VOSBvXViIJ+w6cbwl
X-Google-Smtp-Source: AIpwx4/aV+WD0Fn4Gn+8Hx2TZh/0ySmQWEblPkM1Yhz0YcPbQFxfiC9r6jJSRtrM1nITbebvMGL0gg==
X-Received: by 10.28.18.206 with SMTP id 197mr3352922wms.22.1523477996539;
        Wed, 11 Apr 2018 13:19:56 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r28sm2156946wra.78.2018.04.11.13.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:19:55 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH resend] SubmittingPatches: mention the git contacts command
Date:   Wed, 11 Apr 2018 21:20:00 +0100
Message-Id: <20180411202000.31086-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of just mentioning 'git blame' and 'git shortlog', which make it
quite hard for new contributors to pick out the appropriate list of
people to cc on their patch series, mention the 'git contacts' utility,
which makes it much easier to get a reasonable list of contacts for a
change.

This should help new contributors pick out a reasonable cc list by
simply using a single command.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I've originally sent this at <20180316213323.GC2224@hank>, during an
the rc period.  Eric had some comments, which I interpreted as being
okay with the change (hope I'm not mistaken there :)).  As I still
think this would be an improvement for new contributors, I'm resending
it here.

 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a1d0feca36..945f8edb46 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -260,8 +260,8 @@ that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the output from
-`git blame $path` and `git shortlog --no-merges $path` would help to
+people who are involved in the area you are touching (the `git
+contacts` command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.
 
 :1: footnote:[The current maintainer: gitster@pobox.com]
-- 
2.16.2.804.g6dcf76e11

