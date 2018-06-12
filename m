Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805391F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeFLU0w (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:26:52 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37506 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754302AbeFLU0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:26:51 -0400
Received: by mail-it0-f47.google.com with SMTP id l6-v6so1036196iti.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d1eSdz+QkoYI/PvEEnIPG+GIirNZqcK593jQgu699A8=;
        b=da2U1JLeHChJxgpNWjhns6pqFSMlkEV9HHfWgew9zf6w53OE+oDtfaPQjGuiQo7O3e
         ll2nHpji+4Hc7oyHrzPn3p0ydsJkz2p3JA1hz73EFsiO1bcccYV/st73rI9QH9LcNARl
         EX+Xw5CTGv6f+7FkdrLNmp6psxuXxVTFi8aR31cLwg4grzDkTuoL+HXOISp+Lgi7kAMI
         6+af+Wd1UfiqPe9n5oPRQz1xHLRgjOL4cI+jio/+SYLN26Ek8xPe8B974+hWx39BfgHZ
         TEmTDbL5Yvw7f6mLB9cCyXM59n70Qcs0Vo4raCgl2K8fwLSfI+BT8tB1eoiDm3cgE18u
         5VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d1eSdz+QkoYI/PvEEnIPG+GIirNZqcK593jQgu699A8=;
        b=mTy3/NcrS8eKXV+q+SvR31RHhNO0+rSF7+xEnVFiX9GgUXcyEqSJdxdW4su5gnocgS
         Dc73I67Wwm7vR4FaKkTD7RuPkOGVsKRRxYcVzfyZQJvRymDXVfqihNowIn9uxqcivcK1
         p3be+EhJK8Ur9urDu0kmHGUShO1C/h0Tg1oC6TBwxZBZF4FingDM0GHJTsu/m7h+Q12k
         BXu4RbnOcQdN7gQn5uXFZsuL7IHZcTOfdM8ucnsN9yB44hKFwCkK+raEWVxznwuent8W
         wxrHGXJoRTNwt+TgHIz9ohWWcjPFsKErEtMq6/OxljLVSdG8NOL76PbO2NC49cb5+QKq
         tfrQ==
X-Gm-Message-State: APt69E2yN8z9jq5ps84z9hfdVQNXmakIcWFOfjRbIQBjrRshKsf8m+EQ
        67e5VkSCQIcWBXfapN4ueBdVC+BNkwA/XaLneG5RpOu2
X-Google-Smtp-Source: ADUXVKJ45FDkeRi+Z9c285nd8vAX8D/eKwuvZMV5VHxAziFRig+Lj9C7oWn2ubtH1V2SaXZL3Lxe8dS7zqZwaVrDldQ=
X-Received: by 2002:a24:2908:: with SMTP id p8-v6mr1898905itp.96.1528835210937;
 Tue, 12 Jun 2018 13:26:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:26:50
 -0700 (PDT)
In-Reply-To: <20180612154413.3df64441@mydesk.domain.cxm>
References: <20180612154413.3df64441@mydesk.domain.cxm>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Jun 2018 22:26:50 +0200
Message-ID: <CAP8UFD38pLbAZce0bS=G62SCeTKvjn2Eao26Dkm5p72CAx3pYw@mail.gmail.com>
Subject: Re: How to delete files and directories from git commit history?
To:     Steve Litt <slitt@troubleshooters.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 9:44 PM, Steve Litt <slitt@troubleshooters.com> wrote:

> My project (call it myproject) had a directory (call it docs/propdir)
> that was unnecessary for the project, and I've decided I don't want to
> offer the files in that directory as free software. So I need to delete
> docs/propdir from all commits in the repository. I did the following,
> while in my working repository's myproject directory:
>
> git filter-branch --tree-filter 'rm -rf docs/propdir' HEAD

[...]

> What command do I do to remove all mention of doc/propdir and its
> files from my git history?

Did you check the "CHECKLIST FOR SHRINKING A REPOSITORY" section of
the filter-branch man/help page?

Best,
Christian.
