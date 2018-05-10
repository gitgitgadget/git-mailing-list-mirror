Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BD91F406
	for <e@80x24.org>; Thu, 10 May 2018 13:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757185AbeEJNQa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:16:30 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:41210 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757063AbeEJNQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:16:29 -0400
Received: by mail-wr0-f170.google.com with SMTP id g21-v6so1979267wrb.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyQR4q25C8uJRHp9fZUy7kXCv3mMwKcB8SGctq4O2Xo=;
        b=CilGPPLcXLmm9ZGVx8bj/YceyLd2/7Ha/83sDdR2TcRpqOiP+q910/hv/zvU7qumBl
         vjNxTSnNqUyVJvkn9NvZfyH3wrmnjYaLXXHwhtk+JHa0jzhFpOf2tfErzCXWLhIHCQTX
         GzRWbEH/19a8O3nuBDPHSWu0hrdt6tRnddHDT7sT2+10Oe2qfnAM3Xu3LrgfwxCkI0th
         AetN0LC4WLfvqbOSk0G52Go25LewECEuArAFbjFNJ6bVPuHt+NY3/jqZtazfTVynbErA
         5WZ5i1rPp5UiTKbghwAyCsOkisohDIqEcs4irM+BiyeJhvftF4Yxiurx96s4SRut0scN
         HpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyQR4q25C8uJRHp9fZUy7kXCv3mMwKcB8SGctq4O2Xo=;
        b=GI4qsEoGn2vAhYf7T1G5Ma94/6VZHKNTNqQRANRKLTptzOq0SQ6XyWLXSvF5GIydFH
         OvVHSnNe+spcj0GBJgALfNkFSDUBJhD2/zqd90bVYFVk3xgJW9/nsnCr4z2PjJKZP0AP
         5Nwh2AFhPFsaH9mpH2bWHwl/h1JqS74ryjJG0tl/UQ6got9lfvXMRgW2ERqDXRkps+ar
         R2AjmloiY+vE+YffTHe8hpkA9qw7bwaigJZSNWrHJ1KhTwmF/Qg9UIYziGq9MrTaCn3S
         rxkimyfYjRSquOba/MJli2rSbUiQhwEN/+dnhqPVlJeHx/f85lR3dbOgv30HRthakBG1
         pTRQ==
X-Gm-Message-State: ALKqPweBSd7r0VJNdb+3jtY4NzkaEdZJ6kgMZzhLMwQVRpH7/DFjM73T
        iYMmF8xKyOKRzuLazZ2PmIk=
X-Google-Smtp-Source: AB8JxZqSnxZmi2Nq/WrGQsDimbdvqQzM65puVSNZWQ0xUWJ4lKaJ9TTv+7fzZKUueeCaZpMgXHMU6Q==
X-Received: by 2002:adf:86ed:: with SMTP id 42-v6mr1412468wry.158.1525958188711;
        Thu, 10 May 2018 06:16:28 -0700 (PDT)
Received: from localhost.localdomain ([94.10.164.188])
        by smtp.gmail.com with ESMTPSA id o15-v6sm823185wrj.13.2018.05.10.06.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 06:16:27 -0700 (PDT)
From:   Oliver Joseph Ash <oliverjash@gmail.com>
To:     martin.agren@gmail.com
Cc:     git@vger.kernel.org, mqudsi@neosmart.net, oliverjash@gmail.com
Subject: Re: Regression in patch add?
Date:   Thu, 10 May 2018 14:16:26 +0100
Message-Id: <20180510131626.17859-1-oliverjash@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
References: <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Apologies, I accidentally sent this as a reply to the original post, instead of your email. I'm new to this!)

> does your test involve unusual file systems, funny characters in filenames, ..? You are on some sort of Linux, right?

I'm running macOS 10.13.4. I don't have any unusual file system setup, as far as I'm aware. The filename in my test case is simply `foo`.

I tried the steps you suggested: on git 2.17.0, saving the patch, editing it, and applying it, and it succeeded.

> should now show bar2 in the first hunk and bar1 in the second hunk, just like your edited test.patch.

That was the case, although I had to remove the `--check` flag from `git apply`.

> How comfortable are you with building Git from the sources?

I've never done it before, but I assume it's well documented, so I'm willing to give it a shot!

Happy to try any steps to debug this! Although I'm a bit surprised no-one else can reproduce it with the same version of Git, which makes it seem less likely this could be a bug, and more likely it's something in my setup.
