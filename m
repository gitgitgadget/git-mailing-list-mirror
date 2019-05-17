Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9191F461
	for <e@80x24.org>; Fri, 17 May 2019 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfEQUsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 16:48:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50305 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEQUsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 16:48:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id u7so5246348pfh.17
        for <git@vger.kernel.org>; Fri, 17 May 2019 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xDte/byJN2yEv0f91TGdkiU7zR98je4wgJdsFOP/To8=;
        b=OhVcMkSnnavQzGjYu5Cv9tq2P+Wt0QE8KJp8Ui4f3XY0iDz9sLvnVNSHgdFr5Snsr3
         LteM5ZRlosnsEyCmikFZ8UW7z4FeHj2uyOokcSNsS+/q+RJcJQVzjiPpPSAX/OK22UB1
         MqSsvyVD7/fTcEiRW8DvHvVByuiBOKtWJDyF9MtAxd7sUlsgnlvH/fMdMTTyDPO0WaF9
         /V3aLxQcgi2YT2MNaJUIJVxqWRDixCCUUKPnlKX5YtcNg4YRosnjAbBd75vUA1RKL0sd
         +rKjAiwYbrQrnZB3GxYXEaHfDT6hrETaDaQtT2BYu4CQUbh1dOzaTgiHW1+U4SFjZ07G
         j+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xDte/byJN2yEv0f91TGdkiU7zR98je4wgJdsFOP/To8=;
        b=uMjydlpamujM2YCaRoINC7Odwup3A3/VvtIdsWthbY+o5Ktd9cR1CvoswXvntX07S2
         xro+0vGKvy3dY1MbTcZbmB6U9CIHEOw0xrSR9/7M/nsKyxcnUtwcRGP+XFmQHjvjRbtC
         g3d11E/C5RzwlOEV2mnoFOywoBhr//UWCiM/sJUEFu+Bqu7M92jZ02o+TWErZoj3/8uC
         PPolq8f7Y47EswajQjqS6cf3U76Qo6X8NkwY8ycS1f8L5v5MOTisH8oui95E/sRGRuHR
         x9ky8oJcTgrWSAbkeTlsJxnCOk8Vdkw6EXLDN6w4r/J/3Tjnyb3EGEh6s8aEHWJL0vnJ
         OT5g==
X-Gm-Message-State: APjAAAVptdPPaI6lBbF9aXvRiVspwKJlAqpA7d2QDKvcjOtnOokDbLYd
        bIV0ivnSDqbAbNqzAUkooWhRCQOUU/GPwL0ntosRoywxIUXwE1Vtin2gc0QktaOXaxwYALiecGN
        JsoQV2/HbW/xLL68Te+WD407x2YYxhSZRA+MReepvz1fgeYMVcDAW+xiyv0JII4vGIexyFwyTBA
        ==
X-Google-Smtp-Source: APXvYqz/lowBtSElZA0L2qW7kKM62C0aQB8QIn9zvT2otWxEblRY04vZGLkz515kPjaTUnI/z8m0ZXKhl8pKFBfh9kc=
X-Received: by 2002:a65:478a:: with SMTP id e10mr59112985pgs.310.1558126112067;
 Fri, 17 May 2019 13:48:32 -0700 (PDT)
Date:   Fri, 17 May 2019 13:48:26 -0700
Message-Id: <20190517204826.45308-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] doc: hint about GIT_DEBUGGER
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check for a handy environment variable GIT_DEBUGGER when running via
bin-wrappers/, but this feature is undocumented. Add a hint to how to
use it into the CodingGuidelines (which is where other useful
environment settings like DEVELOPER are documented).

It looks like you can use GIT_DEBUGGER to pick gdb by default, or you
can hand it your own debugger if you like to use something else (or if
you want custom flags for gdb). Hopefully document that intent within
CodingGuidelines.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Maybe this isn't the right place for this patch. But right now git grep
reveals that GIT_DEBUGGER is completely undocumented.

Alternatively, it might make sense to only add a short blurb about using
GIT_DEBUGGER flag to CodingGuidelines and then documenting how to use it
inside of wrap-for-bin.sh.

 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32210a4386..e17cd75b50 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -412,6 +412,11 @@ For C programs:
    must be declared with "extern" in header files. However, function
    declarations should not use "extern", as that is already the default.
 
+ - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
+   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
+   run `GIT_DEBUGGER=debugger-binary some-args ./bin-wrappers/git foo` to
+   use your own debugger and arguments. (See `wrap-for-bin.sh`.)
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.21.0.1020.gf2820cf01a-goog

