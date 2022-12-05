Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7FC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 18:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiLESWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiLESWH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 13:22:07 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC8165B6
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 10:22:05 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id n3so7944106pfq.10
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 10:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D46PRNwHwd/So4WRylP5ciK5Qw33RtBsESRHJuK8H6w=;
        b=2iS57INqCQ/mMsl6MFf9tTRezYUhnrofCX+OY/kTqdiJfiBdHP4++FtIH7x8XnY8Q+
         dCckEj/sWTbkWSl9YIy3dRRbKql+RPQTy9ZREB0aMGSPz6TPC+T+3h7v2zkKyUp4q9Da
         15w+8JtwjO7XN10sdEX+R1OIEprRqhQflp5HISLdqZN4RWQvUmPdXQa72dfU/iQcXp7g
         eaSBCYr2VRbTDNNa0nX2YJKC18xNJczjR0UbjW8fosxx223MUVEV1eNmeefs20BE1IrQ
         tDtQhM7OCxzT93ONyGzetdfXfcsHiNhwzqTxXS1m1w0lkyIRYRdKZLNlW016w9mV7CKH
         VZtA==
X-Gm-Message-State: ANoB5pl5Ie1tfbKSMP7rbutTul4c1onbuqWd/4GdvmhULVeT2iD6NLrQ
        AZQCljSbNi/sr+ICHXZ6tW/YabA7NvUNju5OY7twV3Le
X-Google-Smtp-Source: AA0mqf6sbqtzv4KVwgVaE9AKR/VUIZvADfXS0u4oVT2C0UqCBXvAR9u37n0ThbTDXPP53FNrfOj6nvwJHgc1TtjFuvc=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr55801446pgj.268.1670264525113; Mon, 05
 Dec 2022 10:22:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
In-Reply-To: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Dec 2022 13:21:54 -0500
Message-ID: <CAPig+cT6z5kzM8suwqxJ0wrzHjnj9ChROVBiQO3AR1rJ11pkNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix t1509-root-work-tree failure
To:     git@vger.kernel.org
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 10:00 PM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The t1509-root-work-tree script started failing earlier this year but went
> unnoticed because the script is rarely run since it requires setting up a
> chroot environment or a sacrificial virtual machine. This patch series fixes
> the failure and makes it a bit easier to run the script repeatedly without
> it tripping over itself.
>
> Eric Sunshine (3):
>   t1509: fix failing "root work tree" test due to owner-check
>   t1509: make "setup" test more robust
>   t1509: facilitate repeated script invocations

Ping?
