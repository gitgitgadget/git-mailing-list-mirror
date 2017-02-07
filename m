Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7787C1FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdBGAYM (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:24:12 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34136 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGAYL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:24:11 -0500
Received: by mail-wr0-f196.google.com with SMTP id 89so4122530wrr.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 16:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=223gvfiGcmsTePZno3VNXR43/3YAr0zf4wR7S7Ck5dw=;
        b=vRi1j3de2eczj41aWAWCL5ZfeXmqvrJdYq7ouC7DkbdtNhGdzilyKxoazciBig45bC
         Zaj4pN0cXvNPwCGl8EWh6HiTwVYjiDv/ELUzIVdia3lyFQsjGhgfQ9L2kWLO09PmajSK
         W+qSlx9GTHiec1n6glPBzRFIiLeHg0uEz6jN16l37ubqMRqWXTvlYMcMhriSyEo97JJf
         mshV8BvSnLEnqf8+epbWW7MMcJtLBA/9X/3QXxdbvbttR51r9A2UyerVRSNzXfk3lPte
         MSTBNvKnuEQPxJhYn96UE+pJe/v33AkVyPN240qpoMoq6NMdQKzhB/EE90P/ENeJBGzx
         AV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=223gvfiGcmsTePZno3VNXR43/3YAr0zf4wR7S7Ck5dw=;
        b=IUurexCI/QImKEojNvI+M6sDE6M8qeJfxtRIw70v5E2fDQE08RgMkywiRWjrDT8/Gp
         skmlyu+Mp5Eyr3ICz78rvKM2q6zY0870sQa26r3AacbX7UCVn8UB302elclDUF6q9MOk
         8ifkYZ+ZQVYSX9mm/v7I9z2SK2yDh8AsIGc5DgFQJK1eBzm3Tm3o3FQZ2E9QLAnzrOuM
         LrszlsjzTVyKiBnzMriXGAW36CiarR22JqIxK8Xc9TL0c0ORxZHHyBRTwjPQKyrFYgMb
         KVAmtM5zD0vz4yye4pCu+3pSzSSNXhHb4FMDM40e+IWu8E9iHs/d+5qTlN5YVF/oGiDM
         PgFA==
X-Gm-Message-State: AIkVDXLBBSTbQi1ZyTknKiwArtX29UllRqbLCUxnBi83wVJBFdJb0MTN7L3W/+Lc7yM/EPBd9PRP7f7YWG9xKw==
X-Received: by 10.223.134.218 with SMTP id 26mr11087842wry.104.1486427050117;
 Mon, 06 Feb 2017 16:24:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Mon, 6 Feb 2017 16:24:09 -0800 (PST)
In-Reply-To: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 7 Feb 2017 01:24:09 +0100
Message-ID: <CAM0VKjmhO9NQLz9TDv5M3OhxSBt-JdjaouVT0pTA-a6mGaF4_A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
To:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sg/completion-refs-speedup (2017-02-06) 13 commits
>  - squash! completion: fill COMPREPLY directly when completing refs
>  - completion: fill COMPREPLY directly when completing refs
>  - completion: list only matching symbolic and pseudorefs when completing refs
>  - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
>  - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
>  - completion: let 'for-each-ref' strip the remote name from remote branches
>  - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
>  - completion: don't disambiguate short refs
>  - completion: don't disambiguate tags and branches
>  - completion: support excluding full refs
>  - completion: support completing full refs after '--option=refs/<TAB>'
>  - completion: wrap __git_refs() for better option parsing
>  - completion: remove redundant __gitcomp_nl() options from _git_commit()
>  (this branch uses sg/completion.)
>
>  Will hold.
>  This seems to break 9902 when merged to 'pu'.

All failing tests fail with the same error:

  fatal: unrecognized %(refname:strip=2) argument: strip=2

That's because of this topic:

> * kn/ref-filter-branch-list (2017-01-31) 20 commits
>   (merged to 'next' on 2017-01-31 at e7592a5461)
>  + branch: implement '--format' option
>  + branch: use ref-filter printing APIs
>  + branch, tag: use porcelain output
>  + ref-filter: allow porcelain to translate messages in the output
>  + ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
>  + ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
>  + ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
>  + ref-filter: rename the 'strip' option to 'lstrip'

And in particular this commit, which, well, does what it's subject
says it's doing, thus breaking backwards compatibility.


>  + ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
>  + ref-filter: introduce refname_atom_parser()
>  + ref-filter: introduce refname_atom_parser_internal()
>  + ref-filter: make "%(symref)" atom work with the ':short' modifier
>  + ref-filter: add support for %(upstream:track,nobracket)
>  + ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>  + ref-filter: introduce format_ref_array_item()
>  + ref-filter: move get_head_description() from branch.c
>  + ref-filter: modify "%(objectname:short)" to take length
>  + ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>  + ref-filter: include reference to 'used_atom' within 'atom_value'
>  + ref-filter: implement %(if), %(then), and %(else) atoms
>
>  The code to list branches in "git branch" has been consolidated
>  with the more generic ref-filter API.
>
>  Will cook in 'next'.
