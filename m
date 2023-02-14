Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE4C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 20:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBNUo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNUo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 15:44:28 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378612B604
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 12:44:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o66so13755899ybc.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 12:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UP5mSExGZoaECUXMQH+r5HGdMLmvB3n54BDJ+eJFV0M=;
        b=G6H13n3bEG1fEHmeDvybj46Dx+Hl2ff1IIIA7SMBc75Yn//ykArecRecmzmuHypINw
         TVrtJrzohvToFqXcys5tu0UTijartJevBYI681PS7to78o4OKmP4VXLn47pgdIwc9wf2
         xjsus3vhzbHqSu4XbUAqU7sm+bYqZSf/z/icGv3r+LcaM2fMAV+0665VmWm635G3d5ZP
         qypODh2Z70wVzuJ8AUaJQq+2lSby9NEbhHh6u81Xz4cVRkfg8H2Cs9N1P4UzzyUqddFJ
         xT6a8xnJY5CHMW12Kz9nuNaWmXK075EIFLUq+HVRmxBhbCG9PgkmX0gE90fLmtxmTtTU
         CXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP5mSExGZoaECUXMQH+r5HGdMLmvB3n54BDJ+eJFV0M=;
        b=SWqTIZVj80ASVjFlwjCyYP8NNOCaaurcOLi+97KnuTDiiRSXQQ9J66HGXEwwOsIvF/
         7lroxsxVZ9Z6YOAfrylYaatHhohG6m68IEdY05iabZlogxVfX4nv4TYz+OaPUp8r2krD
         2hToHxtKbgQdhrh176IFr4h5J7vSG/V8aw23ej2lnN68B3kwAjlXm8IGWtKQ3pJi5/2t
         Z4JRm0N1+NN40Ugb4cd2Yj7NlR7stwXxXc8u7b18XTpYh1e0AcJjwGrluKigDqptExMr
         OqCYox5y9OXsewIkKBA27BdLJwUCJf0np6kpnY0qfcyLhj36dG4sXFrrWhgvw525vE0z
         LrpQ==
X-Gm-Message-State: AO0yUKUJbZ9JAnchEJxf1XAE2xi167anZFgaFJypJ74qydipsxl5gEto
        fBCKHRmtXb46FZMyxR36hJTvKl5xJi3K4PMbzM//AK7X/KAJQMGHDd4=
X-Google-Smtp-Source: AK7set+XRmLg7tqZz0vaoC8GfCMsI7ZVlxg9Tabe6+IShKi0vfvj/OO8Sk8GS1ZFc4YblLRehBLukNfwHn8ySVIbZwA=
X-Received: by 2002:a25:ed0d:0:b0:7ba:e354:5aaf with SMTP id
 k13-20020a25ed0d000000b007bae3545aafmr3358ybh.37.1676407467140; Tue, 14 Feb
 2023 12:44:27 -0800 (PST)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 14 Feb 2023 12:44:16 -0800
Message-ID: <CAFySSZBMtLSmGHrqb2KQ+QLZXGKQgQx=p+xAmYxE-oTzrYD9+Q@mail.gmail.com>
Subject: Join us for Review Club!
To:     Git Mailing List <git@vger.kernel.org>, mirth.hickford@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Mirth Hickford's new attribute flag for
git-credentials [3]. Let me know if you're interested and would
like to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/all/pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com/
