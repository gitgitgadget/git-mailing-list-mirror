Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5783D1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfA0X1K (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:10 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41898 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfA0X1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:04 -0500
Received: by mail-ed1-f46.google.com with SMTP id a20so11582213edc.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=SkljJnS0roBWhd4KGIqMrxsH4wUTuCyfrkL7ML0w3jEKg++xgzasF+4aGl/xJdXPMw
         u6Amx6LQUbD7Hhq8wN/0O0VAJwAA2084PZ7HjKWw1AuPwzRrKuYiqBUA8qWN/ZmWGJLn
         HnXvBwwI07su7EFoZyC0TAl6ZSjR+reyUjFKi/psfQCp035p+lCikaD5hm6D5sr/Cjor
         emdMZSCYepjPxXNQ5auRXCUN4Z8qFBTcwxGo5j+ux/TILGz2AvrSLPsWuKLl2kKnVJCp
         izqueroejHf4O1L72eiQ9eMwg0yKUpp10MJdny9JaelXB9hz1o0XmP2Vood1UmxzTQqc
         QZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=gR0u+XWRg5fMqCuP1CJ/dfBw7DeRcKvz/4xCBH0e7GZ0iOssLBIzwDChIo5WL2x+v6
         Ac4djVGjUKCRJOpGXEKSddCtldKcTTi2mdNJSRcNIvHU6T5rtvgkAMDq9kbVxha7k+3C
         zbmk/geO8nIT48fZbd8CT17FwXQLUE9Y6/rQwrFu6+M7O5qVTTLRE4DiknVLHbLhld4Z
         7AykWPHK+0VT+B7CiLuG4XiH6H1rgaAW2lZZggc96xcCEGrL6ijfVt2jN07lyoOWcULA
         A/U29C5FB5/luRB52yceNYPwZyi1CmPFaECroe9SJjX3cRVCk7LvoevcVRLkpoC/7sDI
         Pqxg==
X-Gm-Message-State: AJcUukekmCyb4CSln62G9PaZAUT4wN662cSB/fZgypsBGo2IeVNrdlG4
        RUrdIgDj6Vr87ZTMu8w3ua1AJ4kL
X-Google-Smtp-Source: ALg8bN7EDwCRUoAWUFqyI5PbB0fNV7zQE2uYE007ZOyuLfRbaucXnT5NnW2VuPc5KA+EEYQilijosg==
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr12560278eju.77.1548631622752;
        Sun, 27 Jan 2019 15:27:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm2401794eja.64.2019.01.27.15.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:02 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:02 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:42 GMT
Message-Id: <9984c6d17bc09fc96c627a7c7fe5ecf83070dffe.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 16/21] mingw: try to work around issues with the test
 cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It seems that every once in a while in the Git for Windows SDK, there
are some transient file locking issues preventing the test clean up to
delete the trash directory. Let's be gentle and try again five seconds
later, and only error out if it still fails the second time.

This change helps Windows, and does not hurt any other platform
(normally, it is highly unlikely that said deletion fails, and if it
does, normally it will fail again even 5 seconds later).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f31a1c8f79..9c0ca5effb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,7 +1104,11 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" ||
+			rm -fr "$TRASH_DIRECTORY" || {
+				# try again in a bit
+				sleep 5;
+				rm -fr "$TRASH_DIRECTORY"
+			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 		test_at_end_hook_
-- 
gitgitgadget

