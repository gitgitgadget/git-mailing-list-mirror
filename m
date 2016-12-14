Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DF120451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbcLNBhl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:37:41 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35220 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbcLNBhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:37:40 -0500
Received: by mail-qt0-f173.google.com with SMTP id c47so4652720qtc.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ORVhJwjSvj/la0jxdwSCibCtRWF5uKmfEqmkFFR0+Rs=;
        b=oqfFpRkftteqYi1Zf8E8+2NTRGnG4yyOnAK9f56lh4X49PuZ18WDPAwCe74IfTOtJF
         5Zqo/vBuOVK3ZUrv/yy2opk7iRrL8KvA192qnJTAF9KgqVjyFWzDVTvcflIf1S6pXoun
         JqYf1RsfQNKfSk64fADHMzlSmSf3F32flIFbJbOq2emv69W4RM+tGbm+9zww1CXUYt2v
         uWPRl32cA2yTe9tPOBcrUf04a4n3MWoz8vRdiSni99/xqJsdjC4xaasJ4Nzz3vQZl2yT
         7jmvndgLalEvtabtCLJNDPI8aqGifVEFZdWKG4Ont0uHR0b0QGxoIL5pDuZSN6oQXGR1
         cElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ORVhJwjSvj/la0jxdwSCibCtRWF5uKmfEqmkFFR0+Rs=;
        b=WjrS/Npuh1m2ng7EkFTFiqAQ8TPJUCDR1hO3AeSB6vkvun+zC1TURHzKWsrSryqtOk
         Y8DSkoG3KWquRLa1jdMqKQr2K9dp0jp497J9qEqBjTao8wPwpIWj0JkXbhHiwYzTHxq4
         Q8t2bIIFUVRhhyujtWjYdi6ezfC1T2bmg4Cqba04X6kwaRqDI5q2lbtSV5QyMJ1rlAOf
         DPO2WlY9Wq0v4EsmAwec/AIIRUzzKSKzswn12iAurKdm0qSZ1fVs9C/EOWcJcDvx8il8
         WiY5e2TBnQjDQVaYKYSu17pGj4s+X87Ht2WFD4BE561DP9tIS7JiAUuvjWDTTK+KjUFW
         kRwg==
X-Gm-Message-State: AKaTC00OK/QU/3kOvhLwnMxZPDzKurMtbDtlxGCnOZ2RYxy2lwHOpEGWHyu3NoO1gRl6rNESgx9I8vq4o0TR17CP
X-Received: by 10.200.49.235 with SMTP id i40mr97026004qte.170.1481679459465;
 Tue, 13 Dec 2016 17:37:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 17:37:39 -0800 (PST)
In-Reply-To: <xmqqd1gvz4x3.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1gvz4x3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 17:37:39 -0800
Message-ID: <CAGZ79kagAvfVuYRhEqcDh0hSUV8HDi9DB9fH+PSRvWg=ev-_kQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #03; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-embed-gitdir (2016-12-12) 6 commits
>  - submodule: add absorb-git-dir function
>  - move connect_work_tree_and_git_dir to dir.h
>  - worktree: check if a submodule uses worktrees
>  - test-lib-functions.sh: teach test_commit -C <dir>
>  - submodule helper: support super prefix
>  - submodule: use absolute path for computing relative path connecting
>  (this branch uses nd/worktree-list-fixup; is tangled with nd/worktree-move.)
>
>  A new submodule helper "git submodule embedgitdirs" to make it
>  easier to move embedded .git/ directory for submodules in a
>  superproject to .git/modules/ (and point the latter with the former
>  that is turned into a "gitdir:" file) has been added.
>
>  Is this now pretty much done and ready for 'next'?

I consider it good and it had a fair amount of reviews already,
so I would think it is ready for next.
