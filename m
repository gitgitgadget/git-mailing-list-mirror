Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1D91F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJNUCR (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 16:02:17 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:41251 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeJNUCR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 16:02:17 -0400
Received: by mail-io1-f51.google.com with SMTP id q4-v6so12325782iob.8
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVlQSKmrJ5gl8PA1r5OBZq0/4ct68sl7IrQjoz7+ac8=;
        b=I+eqAgEPZL/kbhoN6cGVMyOF/RxJm1qSG6z7kLpK/kyXJOPpymBxqId+bzDtlQLaEP
         mNJhVTOcgr45z9/PCCbsDhp1EkC+csJud4XayRfq9dmx9dlh7pfsXrvm1n8+3ZEGY7aH
         nE4Si7e2D3w4GTTG64/PrAPOc6w8e70tFASG4zMdciheNBpMnkzYnGXgZE43eCZ9F8hR
         vIRU5+C65kzVKu4rIg/mi6oyCQ80Rhu2IYzD9xz0nG53IAq/F4yb1nxAzBcuzkzhTgWK
         9l/qRIPfGKABdkoN+UB1/o693+SsJDOFMA5DVAxGRUYyg1pan6vcFfC01Kc8q1cD85+a
         CTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVlQSKmrJ5gl8PA1r5OBZq0/4ct68sl7IrQjoz7+ac8=;
        b=GYxTtF2euF3pCIAYbVJDMVX8rCFefU9E1l0PHhEy7HDkDkyhiSvDQHWi91EpJ/HyTH
         alYg7szaQtSXldd6+CJFz+kqnCk9xAtVHw8cHOQzswYmLD/jsT+Le+a83Qvskqwp9OWl
         5iWS3R14ng/d7I9licFDQR3krZDv0sVFd/sCqDH06CyTATM4Dl10i/eBV9aullR3+kMV
         ho/07o+Gt5XorUhSSkqXAn0/8e6Hlr0m67vx8e8ef4MoYh3RG8fcsdoQRyKJ3W2C5nLG
         tYyJG6g9YUIuOEEssjrdk/E7MMc8cSlJUvcXpPTAI0vcqSnEDz8+JhTScYzbe82WKj8M
         ILkQ==
X-Gm-Message-State: ABuFfog/GhV0XCTLxd4QwwnYNxrGtHXHhBDoZYEU/nrVUJR6kZ3W+543
        Dj/SbgtSV6kIi7mDdEtASyuxmRtYiH245o5hrns=
X-Google-Smtp-Source: ACcGV639ReCk0g8UGwQquqfZCN0uScrvxUbft/+SYPi4pdVbpj0QF0AC88G2XnFOrBtio2PXsTN6CswHfC8/vv3xj10=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr7705539iod.282.1539519686690;
 Sun, 14 Oct 2018 05:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Oct 2018 14:21:00 +0200
Message-ID: <CACsJy8DNHCxz1cL+6rFxnWvQQz3T7_j8+=5u8=CxjraRzM89mw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 7:43 AM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/per-worktree-ref-iteration (2018-10-07) 9 commits
>  - SQUASH???
>  - reflog expire: cover reflog from all worktrees
>  - fsck: check HEAD and reflog from other worktrees
>  - fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
>  - revision.c: better error reporting on ref from different worktrees
>  - revision.c: correct a parameter name
>  - refs: new ref types to make per-worktree refs visible to all worktrees
>  - Add a place for (not) sharing stuff between worktrees
>  - refs.c: indent with tabs, not spaces
>
>  What's the status of this topic?

There's one bug spotted by Eric and a few test cases to be added in
the reflog patch.
--
Duy
