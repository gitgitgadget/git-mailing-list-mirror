Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36611FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 09:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755314AbcH1J6k (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 05:58:40 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33740 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbcH1J6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 05:58:39 -0400
Received: by mail-oi0-f51.google.com with SMTP id c15so162964759oig.0
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=lEtmCMK0xEBsM35OSDFnSPfk8Lm6J5dBbSE2lgDdwl4=;
        b=ioeMciFLXi7oImEvQ9EexTJPPbq0PVELsxTdC+xRowzrY/bY4EhaGcVV5I7vQ6QHZb
         BrPT311hP1yXllRm7idnr6SUfkEa7l0mM9ko/zefGKtaJcww5m+OVjPsQ0r9ClMK8gwZ
         Eu5RxJAxJ5Na4OwXUfMjJYHyO+0PvTXZyTxnL5wziOk5Jmfp31QMNSuvVPpjR04GJX7H
         +lgOduIRJeaByTRs0G4EhxM5UoEk2Tew/0WYn71lgY6pGnmEOzRt3gIR+EWz41dfmZfH
         WdjxiRNnXjVdBxEHH+p4FG4NFAvgQQBIb1aH8cefKj2JfPtAcG2f8n0CQIT3VGE3sY+E
         uNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lEtmCMK0xEBsM35OSDFnSPfk8Lm6J5dBbSE2lgDdwl4=;
        b=Qp3hO0MjWL+pzahrpCu7da05c20VWgJ8IkiyT8xVFYi42mLCqW87wxbuTBY6ZzVe9p
         KvAuQj3Rs7kwUcboaBaqjmDsCyJ2FQfdgVEHOXNHKQ3zQjwk708ST5wh4MJ7Shum6Xzn
         j2b1Ex36lVQUFk7sgGs9ErvkgX/w8wZG5QKGNfOWOYFDsKkLx9a6JrWtCwA7/s6XjnZA
         I7KIDYnzve9iLVumKqgfootRRmFblh7Am/iQfHkwTBfUHRGTWNmFFf9cxRC/CN6d7i55
         M95WGeRkos0DX2RQah7V1fERVKLPsCDMy/SoUmcaSXG8DuMQrY5Y36t1mAkOTpPVXXxh
         jNOw==
X-Gm-Message-State: AE9vXwP7VVfzvohNOEV6T7PmI/6ZCPJbu1tHcjxuZ5dX6kuOjJhQXO1SsUq91OOioZ42+91T+XQdio2dFucNcQ==
X-Received: by 10.202.63.67 with SMTP id m64mr8496184oia.30.1472378318508;
 Sun, 28 Aug 2016 02:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.245.203 with HTTP; Sun, 28 Aug 2016 02:58:18 -0700 (PDT)
From:   ryenus <ryenus@gmail.com>
Date:   Sun, 28 Aug 2016 17:58:18 +0800
Message-ID: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
Subject: Notation for current branch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder if there's an easy to use notation to refer to the current branch?
which is expected be friendly to scripting.

For HEAD, there's @, which is short and concise.

But for the current branch, it seems one has to either use a not so friendly
plumbing command, or grep/parse the output of `git branch`, since the latter
doesn't even has any option to only print the plain name of the current branch,
or maybe an option can be added to `git branch`?

Thoughts?
