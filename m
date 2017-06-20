Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523CB1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 03:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdFTDMq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 23:12:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34901 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdFTDMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 23:12:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so20502436pfs.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+fGO7bO7+ycsgBlhMfcoHxjZXeMeXUcEHmSAP2lJLw=;
        b=a5EynJRgC1ClaEr6pDZAJH9IcpCeutCbNYeLmkTLTWCrjhgAYEk9bIDwrnIYY4noHS
         0tmdpgLzE0ZjDAcM9wpDOIPalVXWV4VLgFfpFJD+2DolkMEt12AJhBJT35dc0kdaX979
         fjlXyNsa3msr7Vs5iaKkfTrQZns8ddQA8KWiFNJMeLzPITCyXNRn5cK6mMHCbuweHRLx
         VOI1Sh0EpTAFVIGxbCs6AMrL1fN0NCB52wldpk35T2lDwM2UCY+gR1XiY7dfrb7UiYfM
         m5kfaJU+EP7CE+axEqf3BNWg3US3qkyQuVrQ1Bhc4KV7odFRuJQHTfJe1DqwcImuzEtk
         99mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+fGO7bO7+ycsgBlhMfcoHxjZXeMeXUcEHmSAP2lJLw=;
        b=fqQeT8c+FWNa0jhi76Q42YScuQ+pvdrps0AafZd4X07PmQJt/OmygJchMMU6rBApEU
         pCeiXtvPQJ/XLtgRvwU9m8JcuclpvXIcVQSo6MFghAht9G/x/qzB5mxMyLCcsJtSH+8t
         sZGANOpyAc3qMkEDlewPzO1srmp73mcevkVkZ/DPGx3wO5IuaL0aVs8dzlaCQXhSYMDT
         TNnmMtVfOBqPMwTWAvFxrL/EVz5v2trV7lNaDt11GqyO1hZI84kh4WxYEik5Di8fNzKa
         92lnHvMfoyULKCXTf7Afnxu5dpwJ0X5lYcTvczYiQgvdndrI7r/vJtA7dysRFwnFqfjw
         cPEQ==
X-Gm-Message-State: AKS2vOzvchkXHrbuwIVMOXn7yCZuxNU5KvehuhuTo1Pjme3+OjpUio9B
        C6zjEDzBfpMuByx8r3WORw==
X-Received: by 10.99.65.7 with SMTP id o7mr30090181pga.90.1497928364913;
        Mon, 19 Jun 2017 20:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:3652:1086:ad92:af48:f1cf])
        by smtp.gmail.com with ESMTPSA id z69sm25921432pff.0.2017.06.19.20.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 20:12:44 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH/RFC] Cleanup Documentation
Date:   Tue, 20 Jun 2017 08:42:14 +0530
Message-Id: <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make following changes to the git-submodule
documentation:

* Remove redundancy
* Remove unclear back reference
* Use more appropriate word
* Quote important word

Suggestions-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Currently used the word "canonical" instead of "humanish". If that word
 sounds more suitable then this is a [PATCH] and not a [PATCH/RFC].


 Documentation/git-submodule.txt | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d..045fef417 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-This requires at least one argument: <repository>. The optional
-argument <path> is the relative location for the cloned submodule
-to exist in the superproject. If <path> is not given, the
-"humanish" part of the source repository is used ("repo" for
-"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
-The <path> is also used as the submodule's logical name in its
-configuration entries unless `--name` is used to specify a logical name.
-+
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's default remote
@@ -87,21 +79,22 @@ If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-<path> is the relative location for the cloned submodule to
-exist in the superproject. If <path> does not exist, then the
-submodule is created by cloning from the named URL. If <path> does
-exist and is already a valid Git repository, then this is added
-to the changeset without cloning. This second form is provided
-to ease creating a new submodule from scratch, and presumes
-the user will later push the submodule to the given URL.
+The optional argument <path> is the relative location for the cloned
+submodule to exist in the superproject. If <path> is not given, the
+canonical part of the source repository is used ("repo" for
+"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
+exists and is already a valid Git repository, then this is added
+to the changeset without cloning. The <path> is also used as the
+submodule's logical name in its configuration entries unless `--name`
+is used to specify a logical name.
 +
-In either case, the given URL is recorded into .gitmodules for
-use by subsequent users cloning the superproject. If the URL is
-given relative to the superproject's repository, the presumption
-is the superproject and submodule repositories will be kept
-together in the same relative location, and only the
-superproject's URL needs to be provided: git-submodule will correctly
-locate the submodule using the relative URL in .gitmodules.
+The given URL is recorded into `.gitmodules` for use by subsequent users
+cloning the superproject. If the URL is given relative to the
+superproject's repository, the presumption is the superproject and
+submodule repositories will be kept together in the same relative
+location, and only the superproject's URL needs to be provided.
+git-submodule will correctly locate the submodule using the relative
+URL in .gitmodules.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
-- 
2.11.0

