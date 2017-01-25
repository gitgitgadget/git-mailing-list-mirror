Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2C01F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdAYV7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:59:45 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34192 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdAYV7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:59:44 -0500
Received: by mail-pg0-f45.google.com with SMTP id 14so67603384pgg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PU1QUki3tVS6Oz/eoJccdCQpWdXaNurcJICjwqZ2+w=;
        b=dDqKEimh8MCX5nZKIthKxBtB/F9IzMOIIRIliUGIq+kAW2ezrJ8j6UmjgHlV+HoYY0
         XRc8KvsJ3UOT6PBR+s2zfXyJU05p1v8uXzgZuMuIuIrUF2rxF2NuSKXj8GcMuHeQ4woz
         5ft4jMd+AoJ3DElUxLejJtiyf5D2PJl7LlvyxQ2hwpfhwTD5sGyncqvGo+eWMxWwyye9
         3OfWmKisuAEddYvBQblj+NJNEr53WW9l35FOlw2uIl0uhXyAVgaSWmPvkiJjshqqTj9/
         PoXn5l6f0BnDKKcGDA6U4kL22nGmF5nMUoMvxKwz7ikL51KVpgjm23ar68o5uuAAcQcE
         mKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PU1QUki3tVS6Oz/eoJccdCQpWdXaNurcJICjwqZ2+w=;
        b=LKqQWcONADh6Ei4CX3rUKeO5G4vXFZqHfqPqd9p0JMS9yIKXfoGp7z+6yUxIaD6/Lw
         6MgNJURDD5O7H0fJb80DiIuaS46DPcc18NmbiaFYhyyyS2aW1gL0Ja6bI0/QZ7Pgo+P4
         8GArUq4qu1KxijsncvH0OvsvlptkhkAOU5wSFmEJ7msCclCqTv7mRfBk0x2gSsd+wKqU
         ICovxP5E6eGdy51oIFHJ4BGJ2aYaF/GATn/VX2D54NnBqSudTpBBMNhW8+AXOgL8wFGM
         xBKsXVmU1QYVo8p2yLhWmQt5XJIMEyG0RboGnOkkNe2gNOqooBoQPI6fiXLyPP4YnL+x
         Ob/Q==
X-Gm-Message-State: AIkVDXKcj519DAFpq7A0WeKPUNiYO7RZ1KgEz8cMzs8xFGiYXGOsPmtHfgmmntzZmxPP2Sja
X-Received: by 10.99.101.4 with SMTP id z4mr1619580pgb.208.1485381583707;
        Wed, 25 Jan 2017 13:59:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3993:32c0:4ba2:a648])
        by smtp.gmail.com with ESMTPSA id j128sm3333239pfg.73.2017.01.25.13.59.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 13:59:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Add more proposals to SoC 2017 ideas page. (lots of submodule stuff)
Date:   Wed, 25 Jan 2017 13:59:31 -0800
Message-Id: <20170125215931.26339-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  Peff,
  
  This applies to the repo at https://github.com/git/git.github.io
  
  If you're looking for a co-admin/mentors, I can help out.
  
  Thanks,
  Stefan

 SoC-2017-Ideas.md | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/SoC-2017-Ideas.md b/SoC-2017-Ideas.md
index df98919..6d554b8 100644
--- a/SoC-2017-Ideas.md
+++ b/SoC-2017-Ideas.md
@@ -162,3 +162,60 @@ See discussion in:
 The goal is to better format object related information as discussed in:
 
 [https://public-inbox.org/git/CA+P7+xr4ZNCCJkS0=yR-FNu+MrL60YX-+Wsz9L_5LCNhnY_d=A@mail.gmail.com/](https://public-inbox.org/git/CA+P7+xr4ZNCCJkS0=yR-FNu+MrL60YX-+Wsz9L_5LCNhnY_d=A@mail.gmail.com/)
+
+### Submodule related work:
+
+* Cleanup our test suite.  Do not use a repo itself as a submodule for itself
+  (Search for "git submodule add ./. <name>")
+
+* Fix the ./ bug for submodule URL handling.
+  (c.f. https://public-inbox.org/git/20161021235939.20792-4-sbeller@google.com/)
+
+* Teach "git -C <submodule-path> status" in an un-populated submodule
+  to report the submodule being un-populated, do not fall back to the
+  superproject.
+
+* "git -C sub add ." might behave just like "git add sub"
+
+* Teach "git log -- <path/into/submodule/and/further>" to behave
+  like "git -C <path/into/submodule> log -- <and/further>
+
+* git archive(/bundle) to have a --recurse-submodules flag to
+  include the submodule contents.
+
+* Convert a submodule subcommand to C (c.f. 3604242f080a8,
+  submodule: port init from shell to C, 2016-04-15)
+  I'd propose to go for "foreach" first, as that will
+  have most performance impact and is one of the shortest
+
+* (Advanced datastructure knowledge required?)
+  Protect submodule from gc-ing interesting HEADS.
+  Given that the the modules file has a ‘branch’ field, we may want checkout
+  to have the ability to checkout the branch specified in this ‘branch’ field.
+  This can be especially useful when making a brand new branch in the
+  superproject which can then make corresponding branches in the submodules.
+  Or if we are tracking a particular branch, we can checkout that branch
+  (given HEAD of that branch is pointing to the same SHA1 that is checked
+  into the superproject).  This may be needed to avoid unintended garbage
+  collection of commits in the submodules which aren’t reachable by the
+  standard refs/branches.
+
+* (Advanced understanding of usability:)
+  Design and implement an "overlay" for .gitmodules as a ref.
+  To get submodules to usable state, you need to configure a lot. To aid with
+  this the file ".gitmodules" in the repository provides some defaults that
+  are copied to the actual config e.g. in "git submodule init".
+  These defaults are not always the right choice (e.g. when working in a
+  large organisation, you may have an internal git mirror site, that
+  you rather want to clone/fetch from; This can be helped with by configuring
+  e.g. url."<pattern>".insteadOf; But generally this is a pain for users; this
+  large organisation could provide such a configuration as a ref as well,
+  which has higher priority than the .gitmodules file, but lower priority
+  than the .git/config file.)
+
+### Discourage pushing annotated tag to a branch ref
+  If I run
+
+    git push origin v1.0:refs/heads/master
+
+  and v1.0 is an annotated tag, then I probably meant v1.0^{commit}, not ^{tag}.
-- 
2.11.0.495.g04f60290a0.dirty

