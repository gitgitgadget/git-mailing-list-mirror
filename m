Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6C820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeLJUFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 15:05:24 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:34629 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeLJUFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 15:05:24 -0500
Received: by mail-vs1-f43.google.com with SMTP id y27so7462563vsi.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2tAIjcfMlcc0xtSmlk8mYuT76yWTDZCBoUViTUybJQ=;
        b=sERDJ9iZt/J/+PDqdvupEGZxXnx2k1b60dXDUZ3nFbP8VGNbksSmTFaoxNET9a9XS1
         2h+JCQWzjmSq1m/Rci6I6vMmXUNUETwkSlGszR6Nr0RHGbYFqe++BgXBIaH+m+4I9yBI
         HelVKDFHCW9/wwNw+Eq9oaqb3TpYZ60DAyI25vroOimZoSub2sTfctS5prJfmLo4PFap
         oYYCtidTZUW8M/KqVsW6Bkc7UOIn3yQ7La07WQHRih/YArMTu6p1XT0jjZO55cuiJwlh
         Sml2ON9ugOsHB0zaSa3Yju7LHHBcIVL+wBSotvdNKj1ljb3rGbbESFXC18D1afKDD3ay
         pS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2tAIjcfMlcc0xtSmlk8mYuT76yWTDZCBoUViTUybJQ=;
        b=N4ro/oVQKZcNp5VeHGZQNoEMOH0a+nyo40HWfE3gU4CcrYPhK2wK4zgy+ryimgj8aD
         CVZK5yWuDJemUJV/uYhvRDVYHOvpAYzNq8c8IcwLS+Bu6jhOo0mMPshkKLkUkXV1FUu6
         Y6Gb3vkn2FPzURkQ7FfxeDGaE5I+9AfpaDze+oKzT/a8BFoDOR/UbVcKO1IYfkWMbmTj
         1g1661tGXccUO7jzIclkCV6eQU+gt5vq81zrN0snPqZh++C0psRkd0bEusExYIJPxDPW
         8dIf3t+XYvZ3WiIfLraeePBJdH1jNAFeHrP9vYgGyb00G0WSJRV+AA/0yJxGFsXyeF7C
         TUfA==
X-Gm-Message-State: AA+aEWZY+Hm5DLAE71Ici515KfzKaMAJN+YTUKt76X25PFvJNYEhEISU
        RNp/FN0gAd508lTIP7rZxeogFSPtPEUFBcephaEkQA==
X-Google-Smtp-Source: AFSGD/WBwiTJgkFx/AeGUeMf+2wGUb8MT0nEuxyaEaRMlB4H1GS7I1eBQYb1YtT+m5IiZAUcw6ubchu6UXt9ZEj4S7E=
X-Received: by 2002:a67:f696:: with SMTP id n22mr6062279vso.175.1544472322833;
 Mon, 10 Dec 2018 12:05:22 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 12:05:10 -0800
Message-ID: <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:42 AM Junio C Hamano <gitster@pobox.com> wrote:

> Git 2.20 has been tagged.  I'd expect that we would slow down to see
> how stable it is and queue only the brown-paper-bag fixes for a week
> or so, before opening the tree for the next cycle, rewinding the tip
> of 'next', etc.

Does this mean you'd prefer we continue to wait a little longer before
sending in new series and re-rolls, or just that you are managing
expectations about when they might be queued?

(Just curious whether I should submit my rebase-merge-on-sequencer
re-roll or continue waiting.  I'm happy to do whatever is more
convenient for others.)
