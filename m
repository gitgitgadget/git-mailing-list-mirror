Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F82C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330B060F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhHPXpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 19:45:04 -0400
Received: from mta-05-3.privateemail.com ([68.65.122.15]:2664 "EHLO
        MTA-05-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhHPXpD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 19:45:03 -0400
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 625FF18000AA
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 19:44:31 -0400 (EDT)
Received: from mail-ot1-f46.google.com (unknown [10.20.151.227])
        by mta-05.privateemail.com (Postfix) with ESMTPA id 49F3F18000A3
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 19:44:31 -0400 (EDT)
Received: by mail-ot1-f46.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so22984373otu.5
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:44:31 -0700 (PDT)
X-Gm-Message-State: AOAM533y2MEjQzmgVOstICbmYA6nJWKHPw99IBDLxjvbg4fmCAVxHgmy
        Ppzzqxjq3v9z5RD0edq8zcPgwDBJZ4+lfj3RSyM=
X-Google-Smtp-Source: ABdhPJw6cE1yVIc/JchWycbe40RllMsGQTXykOV4Uppx82pKefIDAgBEhUbyW81v6CKEtjaF+w8s7tqT6SvyCv+DoeA=
X-Received: by 2002:a9d:4e96:: with SMTP id v22mr447321otk.110.1629157470821;
 Mon, 16 Aug 2021 16:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv945ng61.fsf@gitster.g>
In-Reply-To: <xmqqv945ng61.fsf@gitster.g>
From:   Azeem Bande-Ali <me@azeemba.com>
Date:   Mon, 16 Aug 2021 19:43:58 -0400
X-Gmail-Original-Message-ID: <CABye914RbBQEhSmdT+9oC_AYBpn-sfGySXqhV7uamry1Bs0tpQ@mail.gmail.com>
Message-ID: <CABye914RbBQEhSmdT+9oC_AYBpn-sfGySXqhV7uamry1Bs0tpQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 7:06 PM Junio C Hamano <gitster@pobox.com> wrote:

> * ab/help-autocorrect-prompt (2021-08-14) 1 commit
>  - help.c: help.autocorrect=prompt waits for user action
>
>  The logic for auto-correction of misspelt subcommands learned to go
>  interactive when the help.autocorrect configuration variable is set
>  to true.

Just a minor correction, the help.autocorrect configuration variable
has to be set to "prompt" for this behavior.

I wasn't sure if this description is propagated further (like in a
changelog) so thought it was better to point it out.
