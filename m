Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928FCC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0D2231B
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgJSSV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:21:57 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:42242 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgJSSV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 14:21:57 -0400
Received: by mail-ej1-f53.google.com with SMTP id h24so389711ejg.9
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 11:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Spep6EQObC/fKZX7XT8ejJXYngI6JJX/kL95/Qa5OBI=;
        b=C1GXLoIyw6OwpS571v5BQAv2Uq4XEhOU2ou01U2uTMJz5Fm5iA/7YZt5ePs0aRT9Nd
         f40XD+USb7im+h08+83AxSqjARok9BI5S6tPn7RvXNol6F+1MQ8eG+MKb6cbhYRbSb5A
         M8+AOUhICBUfmMmKzchmPKp4ZPfVisDWB1Yf6zi4YRCr8idwKBl+hUrkf/RxtvuUDSae
         iObARsz1Lmsq7Td0aDBB2MclGkkVSnNsjvRo3o2l/HRQcjeh085kpBAWYyGe7eQdm8pL
         FmyHJETvFuS9Sly7lVFcMFk/V24HHyfNGaPAtUAj/Wje/BVucnazvfqY7iGO9jq39Jx9
         mFpw==
X-Gm-Message-State: AOAM531BrLiRr+Net+0ecOfShD3udsOdd3rJRGMbo4wk381EHXQ5hhgG
        pYmHVvUpq6ZNyHRPJZbC3EJX7p0ozekjSgiMcOk=
X-Google-Smtp-Source: ABdhPJzEI6kAXfGfnLv1SYSVTezyuuKZwAM2B1g23o4sWTug+DrIeJqFczS8xf8XapfnfIjT2cM/e/lxTV3upQcP4Ns=
X-Received: by 2002:a17:907:68c:: with SMTP id wn12mr1192855ejb.202.1603131715490;
 Mon, 19 Oct 2020 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1put77h.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Oct 2020 14:21:44 -0400
Message-ID: <CAPig+cS_3NBCSgOMpKHeoJAftAxvGXU1BSe-_3Jii8NrqJRphA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 2:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/test-cmp-typocatcher (2020-10-16) 1 commit
>  - Revert "test_cmp: diagnose incorrect arguments"

This commit lacks the author's sign-off.

Also, for what it's worth, this commit is:

    Acked-by: Eric Sunshine <sunshine@sunshineco.com>
