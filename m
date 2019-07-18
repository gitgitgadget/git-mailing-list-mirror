Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517BA1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfGRTIr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:08:47 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:33412 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:08:47 -0400
Received: by mail-wm1-f42.google.com with SMTP id h19so22155242wme.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qBodtc+nQsKkrkX7XijlUHkOPgV73AO+9pay6OBsVgg=;
        b=gAoahqanNjRh7WOaBMsRkL7KcNUbEcO+qnh5nJ7m1jhHGhfNrkZK7+yaQVyGcnHoBe
         w9lxAp96N0Iu5KzG9A83fm0/YHVddZB908nZ2aiRaxHdHeg9fUT+B/tSSi0itG2oh63i
         oS3dNPtt+Tb7RBh1K80xcibZB0+SKF72eFfONygyYsf+nosypNJKXYtd3oiWEX2lk7PD
         sBfkfzzVyea1KuMGeN4B9caPfVoQKo2EuEO2ECGZLw3yk+egMAC5enaqK1M4R+9QZ/E8
         Sdw9br3ifFkHO5/hK/s55+hAJ+1YX2c2fTHQoZVfZUT/9OZFAB/UwCG1vC4ZH7MLEygO
         EJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qBodtc+nQsKkrkX7XijlUHkOPgV73AO+9pay6OBsVgg=;
        b=J6EW8py3nvorp1xhv7A6yVBASBNyq0sAr9q2vk8D/omuHX6a3jXShzk2h8AjTwicea
         AfoC1hJ2NKFunSd34HAraGWHkDW2r2tNBLfVfKTlm8ly2bRT0h1w6w+ZeJmPi/VRP/mZ
         RZs9mAMdHWgJrbo11nOdL9ljjr14H1nAADltIe5nQF/lLPmzVbxGK+CBM84QSb9wP6dY
         VWS79+esrxZhbTj4XXqlQv0Pd+jt4kUf4/ZHYSHFnaKvESaUY5dUS7e9M8ySJ0cBPgnn
         2b/D4irGZaz+iTPNejtFDdoW+R72GtJzcp3OhG3OcsqEaVLhENEDaK46SKOJNdzs4j9U
         gvBw==
X-Gm-Message-State: APjAAAVkRJNJR6Q2ZzhD50pL8oJsDYiK2rMg5o279UlDcbR8moBLbMC+
        FRsszh3UtSXE0ZB0OisWkYjARne0
X-Google-Smtp-Source: APXvYqxzhBsQQR3NeKZD5oGk3z7UixpAR0grbT1Mv6+CBfL9NlzgQFV9at/YXyx04NFhFnfHMsQQzw==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr32186729wmh.136.1563476926174;
        Thu, 18 Jul 2019 12:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x83sm28850997wmb.42.2019.07.18.12.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 12:08:45 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:08:45 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 19:08:44 GMT
Message-Id: <439190dd3a24ac4c9d6300e68cc15c45e3d0fea8.1563476924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.289.git.gitgitgadget@gmail.com>
References: <pull.289.git.gitgitgadget@gmail.com>
From:   "Doug Ilijev via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] README: fix rendering of text in angle brackets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Doug Ilijev <doug.ilijev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Doug Ilijev <doug.ilijev@gmail.com>

Markdown incorrectly interpreted `<commandname>` as an HTML tag;
use backticks to escape `Documentation/git-<commandname>.txt` to ensure
that it renders the text as intended.

Signed-off-by: Doug Ilijev <doug.ilijev@gmail.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 88f126184c..e1d2b82209 100644
--- a/README.md
+++ b/README.md
@@ -19,7 +19,7 @@ including full documentation and Git related tools.
 
 See [Documentation/gittutorial.txt][] to get started, then see
 [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
-Documentation/git-<commandname>.txt for documentation of each command.
+`Documentation/git-<commandname>.txt` for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with `man gittutorial` or `git help tutorial`, and the
 documentation of each command with `man git-<commandname>` or `git help
-- 
gitgitgadget
