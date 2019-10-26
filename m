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
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C1C1F4C1
	for <e@80x24.org>; Sat, 26 Oct 2019 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfJZAyD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 20:54:03 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52497 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJZAyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 20:54:03 -0400
Received: by mail-qk1-f202.google.com with SMTP id g65so4023696qkf.19
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ekzWq15KoliSwRkEP09dQJ8f/viev/bnsz15KmGlyY=;
        b=XqwadOnsQFIUaAWynwFWC3ctDdIioUW0KOvSTH6OVNf53dOIkLUPY+zdQlfzIaco8F
         jgMWK3a8OngnpXOFz/qmO43e21v7n+a/8fiBnuUs1kRwG9QT9xcDFCS3BCp+ImGjbhHJ
         hdEwCMvz1pWzJwLG7d9HC5rS+lo1D9eKmq6RjXspU+bEMXYFHCqh0wbI+2AwH2TBsA1U
         bMRwQXqlx9lmcmcCS6YfNehOPpreRNeGr7SVLHR7wneHApQ2w34gK37b3fGu4EoV5ZIg
         AuF1OVN6EdW9gtG84PY+7sWtkblvKCClBTUB1s4k34a+HY1psD2RuAMuVx4lHoaeK6W9
         r2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ekzWq15KoliSwRkEP09dQJ8f/viev/bnsz15KmGlyY=;
        b=sOaQlxndgxS030FQ3FwaFVgPYfLmvVOOUtKmds/Y5/DaM9zYArJHECxoCQY7AgjTCC
         4sY4TFKk21UZ8kHul7PypY8sY0hRhnLfYmjvhjx1OJq18R42XE2qsNikeZSMyrdYWiOB
         acMTkA70TMUVuon8f7u0E9A48cBG3z6jwvQ6feIkN6f4M9LeWtGoEwZkXRdmbPgmFY3B
         ab7LKrIDZKEgTYv4IoBDM0Daj/7qqhRj7l+cmq0ku/Lnd3bIsDGgOhcWLYU9bTWtbAjF
         uJwiZOOLVEuX6QaONF+qfQK5TnUHylpt4kueXliWT+cyKG4GS6+V+X0hMnHPf8Z9dYqN
         F8yQ==
X-Gm-Message-State: APjAAAWAiOHpwbcWBrdY8nhlRWVAcd4NuTWVY3Z8kHH0qzagyee09QkS
        TvTyNzxHXA31a6SvN3prDCXOetslHjlZj34/ohFoQ2v+E5oAQm0om7tFiQP/qTzTeEKzAa+ZpX3
        hPrIP2m9tWb3PwnKFGMcgewlDHa6lD0gzJX3TZlqWA3/X40D/JYZl0+RjGaTvJvcPfbG4/sBmkA
        ==
X-Google-Smtp-Source: APXvYqzltHCz/0Kj+Sx58JBZbTqS+A+SRf23UMKjD7IeTwcd7fKVYqVzo70nHujImVHT6GBm+7hIoTFqqiQwEcGFJ4k=
X-Received: by 2002:a0c:e70b:: with SMTP id d11mr6388561qvn.51.1572051242063;
 Fri, 25 Oct 2019 17:54:02 -0700 (PDT)
Date:   Fri, 25 Oct 2019 17:51:57 -0700
In-Reply-To: <20191026005159.98405-1-emilyshaffer@google.com>
Message-Id: <20191026005159.98405-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191026005159.98405-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 5e9b808f5f..12b7256454 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -534,6 +534,28 @@ you want to pass as a parameter something which would usually be interpreted as
 a flag.) `parse_options()` will terminate parsing when it reaches `--` and give
 you the rest of the options afterwards, untouched.
 
+Now that you have a usage hint, you can teach Git how to show it in the general
+command list shown by `git help git` or `git help -a`, which is generated from
+`command-list.txt`. Find the line for 'git-pull' so you can add your 'git-psuh'
+line above it in alphabetical order. Now, we can add some attributes about the
+command which impacts where it shows up in the aforementioned help commands. The
+top of `command-list.txt` shares some information about what each attribute
+means; in those help pages, the commands are sorted according to these
+attributes. `git psuh` is user-facing, or porcelain - so we will mark it as
+"mainporcelain". For "mainporcelain" commands, the comments at the top of
+`command-list.txt` indicate we can also optionally add an attribute from another
+list; since `git psuh` shows some information about the user's workspace but
+doesn't modify anything, let's mark it as "info". Make sure to keep your
+attributes in the same style as the rest of `command-list.txt` using spaces to
+align and delineate them:
+
+----
+git-prune-packed                        plumbingmanipulators
+git-psuh                                mainporcelain		info
+git-pull                                mainporcelain           remote
+git-push                                mainporcelain           remote
+----
+
 Build again. Now, when you run with `-h`, you should see your usage printed and
 your command terminated before anything else interesting happens. Great!
 
-- 
2.24.0.rc0.303.g954a862665-goog

