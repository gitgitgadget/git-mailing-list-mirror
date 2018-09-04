Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCDA1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIDVPk (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:15:40 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:40957 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIDVPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:15:37 -0400
Received: by mail-it0-f53.google.com with SMTP id h23-v6so5658753ita.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngSDrxrGfoHID6WAUeRbjnxjNJMjot+l2XCx9SZP9KU=;
        b=JSN/+F9nNyR5Hv8HBj0sp3oat5Mr/9+jE6fFNoeSIt3/hFHB4QuCzFn0fM4/t3uaab
         YjlkH3O3aSqGjmwAE90/TR5aAZJdl4gbiyZSH1ZqlySBOgyjonCC8/j49bufydv5lYU8
         iDR8zScmL1/lcPNxw7O5TaE2zHZDy5Yh6eVSVkSAezsQ7r3G2ZbfP68bsrC7gp3W2Avr
         D/j6sWxr7OLE3LeyFF2zOAqPhPneqK3DnXCsE3CqNjDPW+c7d1kfVFjaWm08D0TSi5Sx
         kIiukNZH0oRN0OdZVxHXUHCx+STdYd96GVkjAodI6QrOKU5ANVBMZIKMsnswYMSQ3zzE
         gq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngSDrxrGfoHID6WAUeRbjnxjNJMjot+l2XCx9SZP9KU=;
        b=np1lCldsEtBOY3LAPXlnbjz2lE9kw4tySJYmKStyHYYX30g+Br8yt+PTq6W3M6DGQA
         1AMnSjq8V+Xe9mH1OqxhI5grSPzsf9mn0JQvIg2wQT2+g6W19edN+p/jiURNs9UzAHC6
         Omgr5Ee6Gy8QhU0zGSy9wfUdoOUZCv0mKyPxTZDXf+5vZPpXjqqgVlhEv3XilofhLlvH
         OARdb6a07pMR6FPDsmMMak+1167ACmRoufy021t548iMZIWTcMjJ+DPP18PqxFXe6uQi
         du0wM/VNplkwHR2H0fNim7IU2KIM8oIUTW9bdd8toBYM7p42kFzCyjmqTWbqt/a2VYpf
         pM+w==
X-Gm-Message-State: APzg51AKjyOag+gNTVe3E9k63SS2SnQ57acvatuWMTHjKJr+STZgBuTm
        MSLVMjLHo9VoWpPuW5vRyKz1AkQ5DQmQrnwUi3mMTg==
X-Google-Smtp-Source: ANB0VdY7go4RKOEEVEeGZYTXNFA+8xByUrq+venI6JGDk75fkTPN7OLJgaHrkdj0kHK7nwbcH1w5XQxawux/6E2gOMs=
X-Received: by 2002:a24:2c13:: with SMTP id i19-v6mr8104498iti.68.1536079781371;
 Tue, 04 Sep 2018 09:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.26.git.gitgitgadget@gmail.com> <pull.26.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.26.v2.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Sep 2018 18:49:15 +0200
Message-ID: <CACsJy8DRzhnxJHXr+zRpBX+rfGPakgbVHYWRDb-XiatFsstfpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test coverage
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 2:49 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The commit-graph (and multi-pack-index) features are optional data
> structures that can make Git operations faster. Since they are optional, we
> do not enable them in most Git tests. The commit-graph is tested in
> t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
> one script cannot cover the data shapes present in the rest of the test
> suite.
>
> This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
> . Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
> with every git commit command. Thanks, Duy, for pointing out this direction
> [1].

Any reason to not add this new flag in ci/run-build-and-tests.sh
(which is used by Travis)? I see your note about VSTS but I don't see
why it has to be exclusive to VSTS.

> A few tests needed to be modified. These are the same tests that were
> mentioned in my previous example patch [2]. Thanks, Eric, for providing the
> correct way to override the settings [3].
>
> When this merges down, I'll create a CI build in VSTS that runs the test
> suite with this option enabled.
-- 
Duy
