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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB961F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJZAyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 20:54:02 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:40158 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJZAyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 20:54:02 -0400
Received: by mail-vs1-f74.google.com with SMTP id g126so658571vsg.7
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SGl5fzflk0IBuzYFRv90kNbG+0DG4HFlXr1TQAHDTdg=;
        b=wMx2CyqaiSirHLJlyC7c3CNGETRekusJfciYUnZEt0BZyqNTJthkhFFZt8MQZDriRP
         kcIYDV6wmpqTTy5uSVZeCTtM/viyS2x5TFqFX1v6guQkLXw8ACxV4WEKaUyL72kL6qbq
         uM0SfnBEbdtDkPsD1EPJ2+I8gO6ONLQLSqfEOSfi1pIFlLELt0XgNMI4taPatA1x4vED
         LmXFEf1HNaUuRpKE8dc84aUquaRmenOQzp1Z1hYILST2JmJMsclaafDB7kKdasq2jw0g
         cBFnQtoREXlxDl65oockkBl7WR/kaN82sz9JXzC0yZYOmQE2gErRfkdIX11jNnI+FvdM
         Xsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SGl5fzflk0IBuzYFRv90kNbG+0DG4HFlXr1TQAHDTdg=;
        b=eTe898+OQfVQCa8xKWXhqh+Vp6FY0TgBCYqWscqcWl7W63q/4cJrJCo3J/aU+mZPWL
         t+/rXn+QCjlbpiG9BalhHyzreYwlolyI6Vwj8LE9TPWIYnwDicBhCrnTtp7pX51QDt/t
         ZbUlE11FE30MfV9p01qUfWe0e458N0IGzI2yKx6oCxUrNkkAHQyw1I/B7A4+cflatpVg
         8uNF8p73goiQMn73YsUz6Gs1ovHWG1BNxaUKenvEtM031LUcUV5XTr4aBVAXQnBQJXVl
         xqT560fBu+xrYNmZeyjmq9m53kGdTS1TdbCb/BksjnMvIcwIWEWHw5yISDsrwZ7+st3j
         tCnw==
X-Gm-Message-State: APjAAAX2pqfIIPUxL/V3qyzw4D5Rl/TBl6GqYXp2ukN/N0VDP73Ka6AJ
        Q35j/oKzuj/6H7C+KZ2C+TJmMAoeQChjUikr8ZVHRQCD8yiOoGN572tfHgXZ1Wp8jzGueCirS77
        iyEQFKLC3v8F5mIqbyniEdjASfpok0b/8WCFN8yQxMYgStYuAOHtsIDyve2gw+CC5ZHX2NWbZDA
        ==
X-Google-Smtp-Source: APXvYqxOWcVu4Pq73XtZoT/YcEHMJLi9mPXC5HX2X+xDAtYVwQJFJxX8Mj5w5XII7rgmsd8Kq33fHc5PNeUa9I56WLo=
X-Received: by 2002:a1f:b40a:: with SMTP id d10mr3659292vkf.29.1572051239478;
 Fri, 25 Oct 2019 17:53:59 -0700 (PDT)
Date:   Fri, 25 Oct 2019 17:51:56 -0700
Message-Id: <20191026005159.98405-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 0/3] some clarifications to MyFirstContribution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

With the wave of Outreachy participants (hello! welcome!) a few
shortcomings in the MyFirstContribution tutorial have been noted; plus,
a comment from SZEDER (thanks!) sent along some weeks ago about a
missing step in the new command process.

[1/3] Per SZEDER's comment, we should be adding `git psuh` to the list
      of commands used by 'git help'.
[2/3] Outreachy applicant Heba Waly indicated that the tutorial doesn't
      cover dependencies needed to build Git. However, I don't have a
      good handle on what's needed for platforms besides Linux, so I
      really appreciate others suggesting dependency installation steps
      for other platforms (even if it is a link to another guide).
[3/3] Per some discussions in #git-devel this week, it's not apparent
      who to ask for the /allow comment to tell GitGitGadget that you
      can be trusted. So, add the same hint which is proposed to be
      shown in GitGitGadget's welcome message.

Emily Shaffer (3):
  myfirstcontrib: add 'psuh' to command-list.txt
  myfirstcontrib: add dependency installation step
  myfirstcontrib: hint to find gitgitgadget allower

 Documentation/MyFirstContribution.txt | 57 +++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

