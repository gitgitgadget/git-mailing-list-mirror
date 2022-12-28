Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D0EC3DA7A
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 05:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiL1FC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 00:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiL1FCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 00:02:24 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79915CE17
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 21:02:22 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso5424024pjc.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 21:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAXZt17Ob2VQIHXpZvfqqOViYpHFz1RMDB2yUussaNk=;
        b=f2pA1WyraZMPCJCccEzTpXrT0GgdEsu1kgcSoDdBtl0Vv8E88EqaVi9Bv7KFRZbRKj
         CybvrTz7tqnA+oCPK3MKV2KjWhzUT5gm12ME5cqXYc6uteImAUMdStBTYfchMhA5ayNy
         0ihtcphyTDFXZyRtr2tWCCmcJ0fVMz5F00kmxX73qFdoHL05IYuf6x/wBAXWN7M9kNuX
         9YFClOr0snDMVVYj8AeYhbsgqWZtAH9CjBYJkgS6CsA7Ns92qI+rhznR+05HCJqBUELh
         TrjwvHb2LLzd9SemY0A/rTjPrjhK0E/GXOdD9pcIa8iUUFd4oqZVlpIPzRAqiwSPUCu7
         bVIw==
X-Gm-Message-State: AFqh2kqaNv0ReoJs7QWim9DcpByA+tamJk0HHTTRjGo4Sm8jQEUJvcnI
        q1IJjgO2ofplAsD2yad2FZp/oBVcspwBXqhZxNTL8YrM1ZI=
X-Google-Smtp-Source: AMrXdXv/wx28SxqU90UXEMGf/1xFErRdmEwEI0rKl84/6inQ17zPGfoPGlqePK9+tmTFQHJEkmCDQHr3pPMCfvpKbaY=
X-Received: by 2002:a17:902:cf08:b0:191:34ee:a3fc with SMTP id
 i8-20020a170902cf0800b0019134eea3fcmr1512163plg.12.1672203741831; Tue, 27 Dec
 2022 21:02:21 -0800 (PST)
MIME-Version: 1.0
References: <CANqKdC9yJx+v025dWp9udfrdb3ZUug0WjJZJcKX6vR=wL-=Qew@mail.gmail.com>
In-Reply-To: <CANqKdC9yJx+v025dWp9udfrdb3ZUug0WjJZJcKX6vR=wL-=Qew@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Dec 2022 00:02:10 -0500
Message-ID: <CAPig+cSm3U8qx6fYrnQdjc+iebqNEYMa46KR4fP_qJpmj4v53g@mail.gmail.com>
Subject: Re: Bug report
To:     Jensen Bean <jensen.bean@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2022 at 10:09 PM Jensen Bean <jensen.bean@gmail.com> wrote:
> What did you expect to happen? (Expected behavior)
> CTRL button to work
> What happened instead? (Actual behavior)
> CTRL button stops working
> What's different between what you expected and what actually happened?
> the CTRL button doesn't work when I have git installed
>
> [System Info]
> git version:
> git version 2.38.1.windows.1

This sounds like a problem specific to Git for Windows, which is a
separate project. You may want to open a bug report with that
project's issue tracker[1].

[1]: https://github.com/git-for-windows/git/issues
