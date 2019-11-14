Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1FD1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNUF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:05:57 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37647 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNUF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:05:57 -0500
Received: by mail-pg1-f202.google.com with SMTP id u20so5383552pga.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JyI7YnTaYD6P/VA/J4zPit5otOc6mk/vytbWXC4fT4M=;
        b=bk1QhK1C+X3clyEWk/etoI/pQtZCFrQgJ+CpX5MAUUkQlzeQURJXT5boFrAxlB333+
         HZIpkQXPndwSQioto4ftLlXQgN45Q794yG29U58QXul3ChlGt/0DOqbU30EQvLI09xlo
         0ULwdhOyOmAOFbDzN+8HYs1qsb5CEmQUovtTuVugsmPEnVSmOpbU2NamyNTqg0IOYa9R
         v8pyyglOMWYIjdKCqkooHjKMcBdlkT0yrtwbzXzNs6b5Wpx9aCPATLCr0zSzokP4UG4P
         VAGRHviVEBb98YtzROvXbOx/Ieiw6+BPq9QRmnmGFm5k9EVzOj+ojupy5HH/FlZ+BpVw
         BK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JyI7YnTaYD6P/VA/J4zPit5otOc6mk/vytbWXC4fT4M=;
        b=sMksDb1fHITBbkRf09ruPwiNR3ROES/4rRxw3RAlKv6ORxzcQqpO7dGdjRBl9OGmZf
         aKUEktG+TX81woQ8FhJi8LroAYHN6gm9lWvHMkLiSbtxnudyZwwChrfVJiibPhOwb0mM
         QdH5oSFvCBMX0BVG7CAb8P5PLF9fKQck45XAqh+ePzZjnXWEj+MPtSlIKWnuATApZV+w
         KEFarVdZhwGjMX6zQucfyMWMkGzpkNs3HTn11CGV8y8uDMCFxhCv0Ecty/Oan8DUy2FD
         +alOseK3Ixxj1Um4Te3fayvwqnAsmt/Lv6IhQdfujaUNdalvZC4Xfm9+aLxOt1mUni+q
         03EQ==
X-Gm-Message-State: APjAAAUHxx7nJjkS2+B04JAVyImYOghz/YievMfpcEZ5UUJs9p5k1F/O
        1FUrowSomBvAjHQQyayBB04yWfvv71+7AlsXlh3F
X-Google-Smtp-Source: APXvYqzydYKNwlqpq3gN2ECqq/sk4Ksjp/EhQxbaIXGQQzE73RoP1l+BDjY9pd5vq/O+FehwB7lgEkXtKMwR4/UQ/566
X-Received: by 2002:a63:dd11:: with SMTP id t17mr2310421pgg.242.1573761956497;
 Thu, 14 Nov 2019 12:05:56 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:05:53 -0800
In-Reply-To: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
Message-Id: <20191114200553.166098-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: Feature Request: Check if commit is existent via http-protocol
From:   Jonathan Tan <jonathantanmy@google.com>
To:     mariusraht@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 1) You can request a specific list of commits of a branch by index (e.g. 
> "1 to 30 <sha1 of branch>" would send the first 30 commits from the 
> server to the client of the branch "master"

If your Git server supports it, a partial solution is to do a partial
clone, e.g.:

  git clone --filter=tree:0 --bare \
    https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux

And you can add --depth=10 if you want the last 10 commits in that
branch too:

  git clone --filter=tree:0 --bare --depth=10 \
    https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux

This creates a partial clone with no local trees or blobs. If you're
just doing ancestry checks with "git merge-base", that should be
sufficient. (If you're doing anything else, trees and blobs will be
downloaded as Git needs them.)
