Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB38C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A356197D
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCSTcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSTcH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 15:32:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA35C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:32:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l5so9069253ilv.9
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UoYzIxYFONzeZgJReYCaGg+gEiitKhxNBFfTyIYo2CM=;
        b=fE2eBTsiwiW6m6J+FdBszsQTee35DCdEmZJlQGv8hdXa/5AkaBXgOy0tHcpFRqhN3L
         yWVTu1dsO0Ia2e+MivFWyeLnhQ4aVfGitPiZvPKK/24ALoWzr6+ja5q426d7slwJG26n
         KWECcfKdiD60as2jpX4fDc28Ng2l2TNLIvaYIwXmzOp19hdR0JMoq0UMdZ1Ru9aiTmnD
         Behd1JvcJT9ZGNOzMgOjw6h0jll4hflMLTqfeT7UdMn+WyDIoAuJmspR7f+8QEL8/WSQ
         flwzZ1nJZ958AVMQ6pUp55ECdu9vYDXnKW9DJFI/5jNGTVhkxV40uE19alq7lEPda/sc
         u1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UoYzIxYFONzeZgJReYCaGg+gEiitKhxNBFfTyIYo2CM=;
        b=d41bW4EkjA8Y+y1uDr4JrjWhNGTDd8cHrPd6T2f2XQd17tDhf+XyzfwT9qgJS6Y7WQ
         NrApSjDwX2+cn4oGldkhqB/ip3Oe+6t2y2OUVNDQ4ZruqaRcpsHigcZhK7PfGQ4JpCSo
         iILZc4R1F/TUgb1jHF1feyz7mGHd9ZowbIrauuvja21K6NaroHJfFdHaolCntm6zaRAv
         gv4LJxjUy/4C1qa8AqU0k8cUbVndUiVBDU1NaPX5VqjhgkeNepzI2mp7wXyJ+ukMV3wA
         DFoRtIFvpNbpmJdTn6jY9OR+7INwYo6cmcc0J4+7h293WbSYKD/e0Hesodo0zNnqJYuM
         gfeg==
X-Gm-Message-State: AOAM5336WvMkHs3eOsLWqJJphZ5U4jeHyLhCsYInWfXJQuI2IO1tk/OD
        nb+M70F9PknPlCXxdbpQEgtjvEX79D9Sb1KRngHBx+nzyj0=
X-Google-Smtp-Source: ABdhPJzC8jTTHFNrZffZg26vqk3LwTs6NVHT83h8ExSL3QK5b0GpX+iyPiMHkSRangoeFm7qG95/O4twRlFsggvMWT0=
X-Received: by 2002:a05:6e02:85:: with SMTP id l5mr1523544ilm.182.1616182326884;
 Fri, 19 Mar 2021 12:32:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Chavez <x10an14@gmail.com>
Date:   Fri, 19 Mar 2021 20:31:56 +0100
Message-ID: <CAF6oXFsnvvacvUY89s65us7-UprpvV-NaOQ3owGTF25xcJqnkg@mail.gmail.com>
Subject: Are there any publicly known funders (companies or otherwise) of git development?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Idle curiosity question - stemming from an argument with somewhat
inebriated co-worker(s):
> How is the Git development (being an open-source product) pro bono? Done for free?

Or is there any (publically known - not just an employee "randomly"
being told to upstream a bugfix) funded effort?
Such as with the Linux kernel project - where companies/organizations
put up money for X amount of time/efforts/projects?


--
Med vennlig hilsen/Kind regards,
x10an14
