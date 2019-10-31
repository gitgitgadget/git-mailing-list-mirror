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
	by dcvr.yhbt.net (Postfix) with ESMTP id CC44E1F454
	for <e@80x24.org>; Thu, 31 Oct 2019 21:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfJaVD7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 17:03:59 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44799 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfJaVD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 17:03:58 -0400
Received: by mail-pg1-f201.google.com with SMTP id k23so5324524pgl.11
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bByQXw8sQnhAjOpFcAxSjxw48OsUDkkfqFAKXfC9NWY=;
        b=tRne2+GE8sxiZRJVaclInknrlIHNndTt6KAUwgII0Dj45kL+DbDb3F1J5qRd4c9Eaf
         QDLs8YCi6s5wwn8V953iKlebHy6saR8CgTooncjcWw2OuR3zvwb3t+Xq4Ub0NxxYTxJT
         kOHi5xaa5Lslmkqe9F/KywHHJBuYuPJFWvJVEXmdYXJyVJfadMXNYDP6lkPvrF5QAoiZ
         iuVPHgW7LdPBg0srQhUOz9ap8oRIIqCQ+orYSs+zGs3t6sE8t6I8QC8ddqSE+aaEbYHr
         EIyXTCWbGuHq1+sqnojTWczPQbw6yPERS5r9nRUDHfUsAQBRMpetbUGBWuARkLLFVd4w
         wUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bByQXw8sQnhAjOpFcAxSjxw48OsUDkkfqFAKXfC9NWY=;
        b=p2kbJ2DO0hxs6aIxX+0RUrb4v5eus1q2G5IVbgcTJEnsi9TFhBKIsVoUTpmi80qKfi
         0WBHojX2dT962/EQHswyWbkBCn9R9tWxt89fsDuMSUPg0aT7JgL1pw4/DA+WLviiL0nd
         t2wXY7etRaJrut17nr6cZYMvLmD2zbmeDnRgzmXpjGr0gGYpurW8jxOtqyPUO+4CFmh3
         sh7pSabHbxwpPFLFCC85qecvOEgm8jiFBZXp0qzFLis5aUJT6WK0thIhPMldrnSOwvrK
         WlQJSyZ8wROW0QWZN5iam5G1/JhUvXd1XIAQNz4y8dMADtuc9rWNixGx8CzNt9u6PBJA
         DFVg==
X-Gm-Message-State: APjAAAUKBlW49KSRAbIb4ScvospnBHBjpU3H/iSjueWYwUZIrph7u5v9
        J5LMaxG7+klyDhkkxo7rULRZOhALsbA3egHq2XJ9qlNM5K/U6hkbReUUf4SKiGQXUezN1sSxZV4
        qJIQTGgx7H/5RFart8rtcnxXkPYYLdhkJTNuLfHo88WMQWdMlVm2Kvy+OujgurHxHSmlfLNAbnw
        ==
X-Google-Smtp-Source: APXvYqxGzJ9EZpOd+Wk5jJaCuHTF+nUph/KGjGQwZQjJ7MdiXmP8b9DaMFGI2pQF0842fsbnnibMXRBvDEhL+k9iAW4=
X-Received: by 2002:a65:434b:: with SMTP id k11mr9145481pgq.386.1572555837625;
 Thu, 31 Oct 2019 14:03:57 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:03:36 -0700
In-Reply-To: <20191031210338.152529-1-emilyshaffer@google.com>
Message-Id: <20191031210338.152529-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191031210338.152529-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 1/3] myfirstcontrib: add 'psuh' to command-list.txt
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users can discover commands and their brief usage by running 'git help
git' or 'git help -a'; both of these pages list all available commands
based on the contents of 'command-list.txt'. That means adding a new
command there is an important part of the new command process, and
therefore belongs in the new command tutorial.

Teach new users how to add their command, and include a brief overview
of how to discover which attributes to place on the command in the list.

Since 'git psuh' prints some workspace info, doesn't modify anything,
and is targeted as a user-facing porcelain command, list it as a
'mainporcelain' and 'info' command.

As the usage string is required to generate this documentation, don't
add the command to the list until after the usage string is added to the
tutorial.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstC=
ontribution.txt
index 5e9b808f5f..12b7256454 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -534,6 +534,28 @@ you want to pass as a parameter something which would =
usually be interpreted as
 a flag.) `parse_options()` will terminate parsing when it reaches `--` and=
 give
 you the rest of the options afterwards, untouched.
=20
+Now that you have a usage hint, you can teach Git how to show it in the ge=
neral
+command list shown by `git help git` or `git help -a`, which is generated =
from
+`command-list.txt`. Find the line for 'git-pull' so you can add your 'git-=
psuh'
+line above it in alphabetical order. Now, we can add some attributes about=
 the
+command which impacts where it shows up in the aforementioned help command=
s. The
+top of `command-list.txt` shares some information about what each attribut=
e
+means; in those help pages, the commands are sorted according to these
+attributes. `git psuh` is user-facing, or porcelain - so we will mark it a=
s
+"mainporcelain". For "mainporcelain" commands, the comments at the top of
+`command-list.txt` indicate we can also optionally add an attribute from a=
nother
+list; since `git psuh` shows some information about the user's workspace b=
ut
+doesn't modify anything, let's mark it as "info". Make sure to keep your
+attributes in the same style as the rest of `command-list.txt` using space=
s to
+align and delineate them:
+
+----
+git-prune-packed                        plumbingmanipulators
+git-psuh                                mainporcelain		info
+git-pull                                mainporcelain           remote
+git-push                                mainporcelain           remote
+----
+
 Build again. Now, when you run with `-h`, you should see your usage printe=
d and
 your command terminated before anything else interesting happens. Great!
=20
--=20
2.24.0.rc0.303.g954a862665-goog

