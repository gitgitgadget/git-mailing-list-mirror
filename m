Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25DC0015E
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGQWOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQWOR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 18:14:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C17A4
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 15:14:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b9de3e7fb1so24707165ad.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689632055; x=1692224055;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/eUwin8Bxpk1rjyp7XyfwM1fPBff22ba8roFda/Cx4=;
        b=35yU304WxyLXh8tssH/08VhLohku6J29t31vBvYvIQLSp41Hlj8Jj8iTMUmZQ66N59
         ashN8tctTstddv+QENzAD6i+MOK18opDIXxNajTMYNb5yCocU0UygiWkwGNHukLdrI8y
         OEE3hOfmSQqq8Z5c+7Q+vxj4IA3z3GatHkOMDOyt8QimPXMf7gbX2XjC8Vv1bYebmA88
         k4kH3UPKUay7x5GiPKUdDNQX32wrQLhwlc5Ka59JytmOISXONnidWPzGRZj3SHYdqm/3
         EOd82kEhuOT9AHLM3cXdf11OEdM9wVnr1F04AUsKBrKMbGZJsjKeLBo5wbYw+LWaFa6R
         JD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632055; x=1692224055;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/eUwin8Bxpk1rjyp7XyfwM1fPBff22ba8roFda/Cx4=;
        b=cxdBVk/tMAVEIFo6YAOzDr+SfnkW2msJW2WS0Td6E1pM06uTEQoGNIWCTzeHQbKHUd
         ltJzcck+k8dDpQubGoRLwtu+Wp64kdWvIU4KlmzHOhKfEhXyh1pmTu61oPfZmjX++6L6
         qo9EkfDWisrNvF/yb2H6PqyyjlyBU9+YAaT+IEaY5912bH7qi4HUWXvECC5+9CmcYVER
         0gCEI2judBkNQsqHRRGR73lG9wWQ9zvh5C+UIFrFW7t3eoil5iMS+OmgwLV3p/71Jo5v
         +P363EVrXlGTvlnstTIpZfV/pQagKnCqw02XFDddCp/lQQcgxJgD32bfRbUvFA4oz+cC
         DLPA==
X-Gm-Message-State: ABy/qLY0sQiJurGfyNwTroV6OZ6KFggobDQ1rQUalFl80seeluR3atuJ
        ymJuQLvUHzNUT7oHE4WeE0a0WMYriUfbhLv1hLVmO042QdD02DxYsUcD7SKVvr8iLDqEmoF1z7o
        6SMHld1itc1sc2Nn+zyoSxQyXC45YWiJxrN0m6bk6NYEjbqav+v/l10xntTXsvfY=
X-Google-Smtp-Source: APBJJlHTNsxrqLC5WdPATeTVtPfdNjG94RHwK+5giDi1GwT4yhenNsW++PiAQA4iyKgipURfJ32pHV/4vtatuA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:e84e:b0:1b8:2055:fc1f with SMTP
 id t14-20020a170902e84e00b001b82055fc1fmr3505plg.2.1689632055281; Mon, 17 Jul
 2023 15:14:15 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:14:13 -0700
Mime-Version: 1.0
Message-ID: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday, 17 Jul, 16:30 UTC. You can find
more info at [1] and on gitcal [2]. We run a session every other week,
and you can find the full schedule on gitcal.

This week, we'll be discussing Andy Koppe's new ref format specifier to
pretty-formats [3]. Let me know if you're interested and would like to
join (off-list is fine), and I'll send you an invite.

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/20230712205608.1806-1-andy.koppe@gmail.com/
