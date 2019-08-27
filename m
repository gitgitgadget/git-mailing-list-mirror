Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC231F461
	for <e@80x24.org>; Tue, 27 Aug 2019 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfH0Q4h (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 12:56:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfH0Q4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 12:56:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so3844002wme.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Z77lJ2GoVkNSTq1KdH86wBedjf3F/B2E8C1jjhqskxY=;
        b=F1BifE3WIJmdElB/gGJfIzG+umPgp05FNoX1zZ+y6k2BTWzv3fJ/XAl67fOBblOBSU
         ajeL+xh1Z3icL8Xa+np2rx5N0EBSVApUCJj8dHlHiq/oqYLqiFB+8uOwrU26f3DlPXkk
         10GtEeNu6p6Kho08VKduCg6+diin0sXA+gWiTuib9LYrtsuqEuVKfxiyGdn0kzf7dlnd
         AG1TkceDqUhuqujbaGJv6DY6XUEJEAFDzTtodpF8KLHmLN9FnBeSbR7N21mHVUJrZx3Z
         MQ3XS3DWJeT39KPu54L3bE6A/SskAzSxiQJ5+4xq/9qVbtoglg1ERAaFCvS9t4g74oto
         pAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z77lJ2GoVkNSTq1KdH86wBedjf3F/B2E8C1jjhqskxY=;
        b=ClT3n0maoCsFi1rUuDOv2JNgh6j8OZxjKlcEyp3jFO7xd1ASUHHk/KPRvDMZKdiEMl
         De7ozSXwc2qjN3Tf3umOojgP8UpNnSB2UVPwmbftLiACJtCzxwiqaSvUBG5XlJ7pLIPG
         8a+X95eOkErPLPKkb7YU4TIbi28CDWiyisg8qFrWTM3yN/Vf4EanUqIU7aPtqsZBNm6E
         fqOp32f05dotqcFStqi8LZIM7dUdJt0TcCUdLP4TpLBfl6V2Ccn0Bkh3R0ZPWNz2a+f6
         pgxxiH9dC7bmHfmoqcQw7e23Q4aXuwDmrWiXrYlLl5igU6WQyTW1zrs4Fz/IKmD7YbPI
         6T7Q==
X-Gm-Message-State: APjAAAUFd3HKQ5vakIB9h3djiAWxlVwef97UpG76Eo0sKKUwKaxlhb2H
        kJXWZwGU/lCI8zG6fNHDKz8GVTmW
X-Google-Smtp-Source: APXvYqzklqxLnn7fiMKQOyzyG/u0KqwmSjUUP2IEqU/kKT456U5C2RNUheJyYt+aHjrNa3fkqf9DWQ==
X-Received: by 2002:a1c:c1c1:: with SMTP id r184mr29843312wmf.9.1566924994487;
        Tue, 27 Aug 2019 09:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm14078237wrr.14.2019.08.27.09.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:56:33 -0700 (PDT)
Date:   Tue, 27 Aug 2019 09:56:33 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 16:56:30 GMT
Message-Id: <pull.323.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] commit-graph: emit trace2 cmd_mode for each sub-command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emit trace2_cmd_mode() messages for each commit-graph sub-command.

The commit graph commands were in flux when trace2 was making it's way to
git. Now that we have enough sub-commands in commit-graph, we can label the
various modes within them. Distinguishing between read, write and verify is
a great start.

Signed-off-by: Garima Singh garima.singh@microsoft.com
[garima.singh@microsoft.com]

CC: jeffhost@microsoft.com, stolee@gmail.com, garimasigit@gmail.com, 
avarab@gmail.com

Garima Singh (1):
  commit-graph: emit trace2 cmd_mode for each sub-command

 builtin/commit-graph.c | 6 ++++++
 1 file changed, 6 insertions(+)


base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-323%2Fgarimasi514%2FcoreGit-commit-graph-trace2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-323/garimasi514/coreGit-commit-graph-trace2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/323
-- 
gitgitgadget
