Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F7B1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 07:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbfJWHXx (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 03:23:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34480 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbfJWHXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 03:23:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id b72so5981084edf.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJWWcpl9JUM2dr68PxHTT21acVCmpiqXF8TUse8SoZY=;
        b=Sy4f22XjKv2j3tSM28S8TKo5OR1LXh6p1H1/hD2tVUNpghEz/pyLcvhEj24llIPaJz
         M7o8PGqLR1MzVW6aKhEyRuDJCgJjdYsfMl1GHV48oq8re4SrCEkxXZtNjdo1WVoUQz/p
         DGMNaeFLLWMYQjF3czj+baGiV9629wJfluYYowXpMJ0yMgpI83VRKziaujaFEozbR79u
         dByvNjPa0kOuqTgEZxutZIjHEA9pqgJQDILWUgelYPeU8B8Zf4GKuG5s9wicTw0eHNLE
         +BEptYfWOjpHvgNZ2mdb9Wip4XmxNS2vAwEqHxEMLyywG2FAz1uR772cQkW9nawdpBYe
         SGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJWWcpl9JUM2dr68PxHTT21acVCmpiqXF8TUse8SoZY=;
        b=SelcxrZn0ehzwZFt0dFbbMZkI/NzppIGvN7a/BzmAdlpbxohLJwGvthGvdBV94hAGD
         UQ7l/0p33c3h1mJtICNluQBxQ1gM3blmXdzu2BWyjStUeNq0+KSzCVrn7IlQt+WlrRw7
         1MIgAxDnopRMWEsTlh21SnYxtG56W7K6AZA8aWviHxHDmTwQHEaplbgqA8mzQn3wFNiR
         uX5QFErAOyVu5xscv9zpK4ayCoqPe4szGN6psQ7/b26YAOEyoPBMd4lk3SzC/GHNl+ql
         dqttEdg/HakQqbx6QIapfpPRvTT+6GJ+H0r0GQ3ZVvTqC7Fqdhpgvja8k6LU0xcDOIQq
         cKSQ==
X-Gm-Message-State: APjAAAXM7U2Ra3yM29KR1Ar1WhWQo8eDpR8NWLLa0rOObJMaEglGVuSO
        22KazFjZYxdHPelIKJtHdo67DBPjievT4Onn7PU=
X-Google-Smtp-Source: APXvYqyDx66ZMQJb4aYGu+2QKeJ+sB2cdFP/PLi3GWCoQDmUWh/SJRSiE9/qOVVMokBNCvONp9Z5VdhH9sN5ZTNjCyQ=
X-Received: by 2002:a17:906:7c57:: with SMTP id g23mr31379131ejp.116.1571815431344;
 Wed, 23 Oct 2019 00:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
 <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
 <20191022210458.GE9323@google.com> <xmqqtv80jq3n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv80jq3n.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 23 Oct 2019 20:23:40 +1300
Message-ID: <CACg5j25ANmBAUP8B+noRprqb3tgRanEyWQK8dx+QJGhKHZke6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] documentation: remove empty doc files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > As for the content of this change, I absolutely approve. I've stumbled
> > across some of these empty docs while looking for answers before and
> > found it really demoralizing - the community is so interested in
> > teaching me how to contribute that they've sat on a TODO for 12 years?
> > :( I even held up api-grep.txt as a (bad) example in a talk I gave this
> > year. I'm happy to see these files go.
>
> I'd approve this move, too, especially if we accompanied deletion
> with addition (or verification of existence) of necessary docs
> elsewhere (perhaps in *.h headers).
Good point, although not all corresponding header files are
documented, but I'll include that in the commit message.

Thanks
