Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34261FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 13:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbcLDNwk (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 08:52:40 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33929 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750804AbcLDNwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 08:52:39 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so35789255wjc.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+AHr0KxRRumIf8KDL4eY2G3ysWzKbuba9zRcx5Twhqk=;
        b=cnQZFszIPdBwI8a/RUA4tUoAPCIQP5pV4MQ6U06/kNsC7QDWTHFi6WSTUNzsZY+K7S
         TgW5Kuy6MZ7pGwNt3aynfy0Nzwsvz/9hAddK7Syujx+VoUnB9VtOZfo3ijMaf0G36iXX
         wG3Ftk6fDZ9WBdnZ4id14F6ygkwJ0+3bIBDyfVDeMHtV9IqGnD/YZf3Bl3SgFH+7/isA
         T8OQGEbMQY5xw9aaECRmtpUtMvblMY5GLWFwYa1QoECpsu26SfBPqfvTqbVbsRvBifPA
         uTIHjU1Of1tkfT7FF0Ng9Vpemp7TnpmNYx6+n7t62tK7ARjy83s4aYXiEN9OITBk0QJo
         3BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+AHr0KxRRumIf8KDL4eY2G3ysWzKbuba9zRcx5Twhqk=;
        b=V/ZmlaNLMxcBXPRldVL6QuIasFan8Js24UOj1UDMGnWXkPM4gqUCLLl2w73XFX9C3r
         mXPGzOoIj2LpMTPtuJgueqGZPsE/wCKhvMjVFb0WjFM9UYQbBU35+JCP5QwnsgxnkKoS
         SU+eAwIDGReMIUDQJ8IyMUO0sbW+JZRXHoRuhz4LlDmXqd22qaGUYEaf4xJGQPkGv6bK
         +6b2Tjoqzl66fL0lpC+oNxOHQNIkyEQD7sEsEM9n7srEgRyk31K0AntffFsApUJfAyIJ
         ZBajTGsspRdzw+esp0TaskSViRXw85vsHZZ4VKBEavCCM0VuZsV+21T0BFrM4WFbsO5w
         XMiw==
X-Gm-Message-State: AKaTC00Fry5KIzW8aPnDPg6pKdPMB/dad/71mFfysALwRRki75TofZsEgEY8IZij+ZN/sw==
X-Received: by 10.194.47.42 with SMTP id a10mr45966490wjn.216.1480859558454;
        Sun, 04 Dec 2016 05:52:38 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p508BA0CE.dip0.t-ipconnect.de. [80.139.160.206])
        by smtp.gmail.com with ESMTPSA id 63sm13162635wmg.2.2016.12.04.05.52.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 05:52:37 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] travis-ci: update P4 to 16.2 and GitLFS to 1.5.2 in Linux build
Date:   Sun,  4 Dec 2016 14:52:41 +0100
Message-Id: <20161204135241.25504-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Update Travis-CI dependencies to the latest available versions in
Linux build.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: 454cb6b (v2.11.0)
    Diff on Web: https://git.io/test_ls_travisci_dep-update-v1.diff
    Checkout:    git fetch https://github.com/larsxschneider/git travisci/dep-update-v1 && git checkout 421365c

 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0b2ea5c3e2..3843967a69 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -27,8 +27,8 @@ env:
     # The Linux build installs the defined dependency versions below.
     # The OS X build installs the latest available versions. Keep that
     # in mind when you encounter a broken OS X build!
-    - LINUX_P4_VERSION="16.1"
-    - LINUX_GIT_LFS_VERSION="1.2.0"
+    - LINUX_P4_VERSION="16.2"
+    - LINUX_GIT_LFS_VERSION="1.5.2"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose-log"
-- 
2.11.0

