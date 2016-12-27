Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739D0200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 23:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbcL0XnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 18:43:16 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36457 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbcL0XnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 18:43:15 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so149251409pgc.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 15:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CwHHauYSClcAE8ufdhqRQ2tuXcQOiorrsuX92bBQUQs=;
        b=EWxho+KXtDdlM8CGmSksgti+1kyKEozHJ54PSzf3UazPccPx1zmcN2MRE+mU1VFxis
         2dcnvFfD60Dpc4KmCDLK70Bl7jzewGLrsVgltSlzAxv9k0h7qus9mPk4/1pBTLPMAWut
         c1apQF02EuC/M3R0HRdv3U0dk8K9jEgGXOO8higuGnn3jK0UtYMw3xLNtsLYueUlzJSl
         +ERdFRW50hxeqL+oxiYbC+dJYgEp2WvvGPDB2EuyMcy4F3MPZRiGCkftrebdJD7l5uTr
         ObLzi6G+/7DCDSL61Oc8KDZK9CiYm+RDnuL25jIKVwaAlsYWC2BdeZGCmq96yc0W6OHz
         HqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CwHHauYSClcAE8ufdhqRQ2tuXcQOiorrsuX92bBQUQs=;
        b=P16iw3cZv2EBFWhdIJS0G9cA4FNE3gAXfbBwlKQU0c2M7/Y0Qv7lYWB1N9vHbE11KK
         x9mqMTRM7kz0OsUNMnVZjJndOiCEEtNmD7ItTPl1Qkhu6LLeXPorf/PNDwLbAsMr8haU
         0P3WO54z9n2Q+fJES5DTe0xSPJy7JNlaNshIvQRRBWyE8AXH6t5R+HZQTRTvo0tncQwh
         cUXgjlu/2ORa4O555xOhgJthMFbYxvMA1HJlmRsAvgystkjHwkqrwbJtIf+W3o4mIxwR
         rbAnVIC8YRCVXAc2h7hLk5jlvQEGStcQdXiJrod4aZ4XqeAnbKtG2NWrurvJki+YIM8I
         DiBQ==
X-Gm-Message-State: AIkVDXITmc2aQpTZcKoCpJfrjfY+pZUQsKkR709savAEv065y175OkN25JWCy7vUdauQGo6E
X-Received: by 10.99.107.4 with SMTP id g4mr63235862pgc.108.1482882194648;
        Tue, 27 Dec 2016 15:43:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id 64sm92026688pfu.17.2016.12.27.15.43.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 15:43:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Update submodule documentation
Date:   Tue, 27 Dec 2016 15:43:07 -0800
Message-Id: <20161227234310.13264-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.196.gee862f456e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I sent out the first 2 patches once upon a time, but the review
or me resending them stalled. They improve the man page for the git-submodule
command.

The third patch is RFC-ish and adds a background story to submodules
Similar to gitattributes, gitnamespaces, gittutorial it doesn't describe
a particular command but e.g. explains design.

Thanks,
Stefan

Stefan Beller (3):
  submodule documentation: add options to the subcommand
  submodule update documentation: don't repeat ourselves
  submodules: add a background story

 Documentation/git-submodule.txt |  93 +++++++--------------
 Documentation/gitsubmodules.txt | 176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/gitsubmodules.txt

-- 
2.11.0.196.gee862f456e.dirty

