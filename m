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
	by dcvr.yhbt.net (Postfix) with ESMTP id 065511F461
	for <e@80x24.org>; Sat,  6 Jul 2019 20:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfGFUrF (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 16:47:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38519 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfGFUrF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 16:47:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so6196647ple.5
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGrMglmE4VaCW11mI1OoYrIprbr74IOHcJDK8FnTOkI=;
        b=FFuLboos1hsnX1mxnQZYyLVN4sHE8bhIYEE+8NtB1sYl+N5Qjn4ZnYp7H6/fw+e9rw
         bUOk2WGxzkyuygs5gra8XmbLqUHnWuYqhkl25UEbqK0WNlKhcG32SKNQMSbBCQMIUFiX
         8p2DEIUfty3Lc6c3rZFIn/MvYkhGW+Nq+VcT8eYevt++Zzf4lqulpO5Rh8xp1xJdjx+L
         PhA611tbL746EV3nXGR9IudIEbK41lPI2Q0t4jCb5CraMGABSpQ7PVoljwe1cHpuOYrN
         nwHQ1qFVD6g57IgDk6hsyikZGf4evsiVeT1sfnmL3oWO3UAOvH9WLuUeQKVYp9YGHMft
         +QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGrMglmE4VaCW11mI1OoYrIprbr74IOHcJDK8FnTOkI=;
        b=dvMf7OX/ekCd3t+kTWRoeLcOoeE4pOTc/MtdrLLXnXbNtnHRFFndvYnyDGWjB6kO6p
         1jbK/p5MA8UQcgCifJjS0HaQT0N7Ji/Pdy1k4SxHgKBgN/EB2qPD7cYoCSObS6jDnL7o
         ngJoMUXK1vBG5QaeOFf2OepBBj6k7a3JYpJmgJy1s3N+n1RJ6BAjA5Om2bjhkt04er3R
         iQfzRbU4L06H2Fzljhvd14XulJhxUodfbKnloLmJcKQ3+osgJMCFpaEDgkHLaNwVrpgv
         dkOJB0WO8F2FEOXDU/hzIbiJEVLAM05c0pSbjuR3PhA02eECOafs7DxwSXOblM0uw+vY
         oGbg==
X-Gm-Message-State: APjAAAUNf64pPjOdOs1/q8D9VFE5EBQbI8OG45cI3VcuyjjU1QPQH9w4
        NdSqBzhNEiRLzQ+iQ4mQ6E8=
X-Google-Smtp-Source: APXvYqxIPOsdgDRPx2dfkg0sBVLGixGtdKkHn84UAqDteHSKpiwJGB11Qzj4IjLZEsvk5ey3vyqUIQ==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4mr13478726plb.57.1562446024401;
        Sat, 06 Jul 2019 13:47:04 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.221])
        by smtp.gmail.com with ESMTPSA id i124sm31869841pfe.61.2019.07.06.13.47.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 13:47:03 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: [GSoC] Blogging with Rohit
Date:   Sun,  7 Jul 2019 02:14:28 +0530
Message-Id: <20190706204428.23078-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

Here is the update about the last week[1]. I'm about to complete all
the code needed to support --committer-date-is-author-date for the
interactive rebase. Also, I'll be sending one more patch about the
flag that I implemented last week, "--ignore-whitespace", also for
the rebase -i.

Thanks
Rohit

[1]: https://rashiwal.me/2019/a-lie/

