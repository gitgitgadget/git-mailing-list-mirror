Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FCC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbdCXX1I (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:27:08 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37049 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754764AbdCXX1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:27:06 -0400
Received: by mail-it0-f48.google.com with SMTP id 190so5041104itm.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mxB7X2a2e4/axI0oRMb3lnUiDWSwGmUr6CmgK9ALMvc=;
        b=Yt76wcERkhQSVHeHuZ7FXlmq9kaNNCzxsvcpBT7t8+XFD4GRAlXp0NQTspAq2ZBLla
         IbM0KjoBET28Y8BNfT1XnDlPo+7iBsJX49PFmvW8X2dlkXbBc3Zru+ehsiXvxkRmXR3G
         jeJA4oEIxUjz9CrIcuK0+2d3z3k4JDk1eBYHF5KiKCvEt2XE2ZF0YJC8u2GbXrhRT0Cf
         EJNhLVJgV2sofjGYpegVy75Mim+pOxVMt2QnRA/NyqIzesYkXpBFS3xs6AaLChkOldS4
         /AAQVrRBIZEU39YeBcA3IZMdmRz7ss2F6pRbi6gZalx8DcNRM7PMJbV5Dk8kWi0CUONW
         rH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mxB7X2a2e4/axI0oRMb3lnUiDWSwGmUr6CmgK9ALMvc=;
        b=RWHtFsWf87FrU2hBske1pcX1G/L18c1StzVdoEkZMnwtZQeS34fDMiJjkIP9gBGcyK
         kpbpNxBI5KRU6F3hSB7IuYkAAae9jOVSXtKmmN2Sls4sl0M2IkdQFU6eKVfVTBOaq1bT
         wuHPFSarlRKe9YFe+9AWhC/BliAMwu2o0xpH1XWOHp9fcGqCDoJAN99vEsHLAGCnkWgZ
         iS5Rpee3jR4QxIzW2gJPryjAds01zfiERA+bLLABBw/W1HSVYfhVMhtRcvp1iXjulvg4
         d4BhjfYWvXqmTCjzY4JtZPqRm3cR94/Uw4ccDufmxboEyi08Xb7d9bSXT5PGIctZAga/
         y3xw==
X-Gm-Message-State: AFeK/H2lrWl2gDJM1AljFQxFTE+N9VcAOo4EA2kQtQwYS3KIVys5WbISFuBDv8DL4dOx9IHSFyKs/j6K8+x6yQ==
X-Received: by 10.36.116.71 with SMTP id o68mr5986818itc.60.1490398025400;
 Fri, 24 Mar 2017 16:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 24 Mar 2017 16:26:44 -0700 (PDT)
In-Reply-To: <xmqq4lyi74lw.fsf@gitster.mtv.corp.google.com>
References: <xmqq4lyi74lw.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 00:26:44 +0100
Message-ID: <CACBZZX4DH8V7cCC9JDRai4ZFTLNHUyO-Kn5hrRFo3m9UipvWkw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2017, #10; Fri, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 10:21 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * ab/test-readme-updates (2017-03-23) 4 commits
>  - SQUASH???
>  - t/README: clarify the test_have_prereq documentation
>  - t/README: change "Inside <X> part" to "Inside the <X> part"
>  - t/README: link to metacpan.org, not search.cpan.org
>
>  Doc updates.
>
>  Waiting for a reaction to SQUASH???

Sorry about the late reply. That squash looks good to me, please squash it in.

> * ab/doc-submitting (2017-03-21) 3 commits
>  - SQUASH??? remove "alias" thing
>  - doc/SubmittingPatches: show how to get a CLI commit summary
>  - doc/SubmittingPatches: clarify the casing convention for "area: change..."
>
>  Doc update.
>
>  Any further comments?

Squashing that in looks good.

> * ab/ref-filter-no-contains (2017-03-24) 16 commits
>  - tag: add tests for --with and --without
>  - ref-filter: reflow recently changed branch/tag/for-each-ref docs
>  - ref-filter: add --no-contains option to tag/branch/for-each-ref
>  - tag: change --point-at to default to HEAD
>  - tag: implicitly supply --list given another list-like option
>  - tag: change misleading --list <pattern> documentation
>  - parse-options: add OPT_NONEG to the "contains" option
>  - tag: add more incompatibles mode tests
>  - for-each-ref: partly change <object> to <commit> in help
>  - tag tests: fix a typo in a test description
>  - tag: remove a TODO item from the test suite
>  - ref-filter: add test for --contains on a non-commit
>  - ref-filter: make combining --merged & --no-merged an error
>  - tag doc: reword --[no-]merged to talk about commits, not tips
>  - tag doc: split up the --[no-]merged documentation
>  - tag doc: move the description of --[no-]merged earlier
>
>  "git tag/branch/for-each-ref" family of commands long allowed to
>  filter the refs by "--contains X" (show only the refs that are
>  descendants of X), "--merged X" (show only the refs that are
>  ancestors of X), "--no-merged X" (show only the refs that are not
>  ancestors of X).  One curious omission, "--no-contains X" (show
>  only the refs that are not descendants of X) has been added to
>  them.
>
>  This looks ready for 'next'.  Any comments?

Looks good to me, although I would say that wouldn't I? :)
