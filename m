Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BEA1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeJLWfR (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 18:35:17 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:50272 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbeJLWfR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 18:35:17 -0400
Received: by mail-wm1-f54.google.com with SMTP id i8-v6so12550667wmg.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=E0KuvVgscy1sMGDg3tnek6+6ENbrX8k9s5LcbezYdPI=;
        b=riKViSdzPU2eyoismIGEfyRT+t8r23lU25cT/pghDmp5OUYMweY8hBtT/8pxlUYj+d
         5UK6iFnM5/wTBJS90Pt8G91VVuRauILoreOFYObZZ9O2sX1JBEDl39gal9tno/JbESM/
         qkz8MsLHDa9O57c2gPTgfI8LfWnviqnDfoMT46D462LErOOlrY02hgRu7wP183aFCyBH
         7f8iaYrqYxDbABpyfYWLovEx3ahxtCech5C5/yzjLA5pwjZ/u73MMb72gQDKQcv5bRPQ
         vd17eCdO6sZ974v1PFT36WOlxmrOgUOPnAYOvhcD3VfjmW7hfIeE5fHRGhaayoijUIR+
         dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=E0KuvVgscy1sMGDg3tnek6+6ENbrX8k9s5LcbezYdPI=;
        b=pGR/u0WOg9ZYalCAzxNXfB0GHc20Cj+5fnEpFKfeQbUkNW03Jdu4bsfn9i87+mbC68
         K43g48vsFsW+aHJqKpCtieEviVQ+hmF4THa00TRKCHRJ7mcwhW0Y6cUMT0XV0fgvXh/W
         FOW9lcyOt/yCbp+6N5aFuE4XFZ6p29JG49iExIzxnwFSwGrudCCb5M9QF4A6o1s3386h
         118jm1qXAQGLTJzDzgUT5qPgT0BOgOlR389+euSbViqc7qlGxqVAuxfIYA5QUlj43qIn
         yI2v74pvGDPozw6naoApDO0DOCOA7exA2bSNwk9axQRaNEzYk5cweqDq/FwgWAfZhDEF
         CsVg==
X-Gm-Message-State: ABuFfoiGJJ0JByfOXTyx5qjI4ZiS1Hf/ddKVbxtrsmviqsdceNKN5lXq
        DBjXvZxxl5t9RHAcV4hazSw=
X-Google-Smtp-Source: ACcGV63Ar3Jt6kz8L0aBvZItK7HZaGGER7eQggcbgyvTAEtByue1imEryhDd+yKir2+8/Bkl4ewA8Q==
X-Received: by 2002:a1c:2846:: with SMTP id o67-v6mr5334369wmo.60.1539356543919;
        Fri, 12 Oct 2018 08:02:23 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b139-v6sm2598482wmd.36.2018.10.12.08.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:02:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Oct 2018 17:02:21 +0200
Message-ID: <878t33dx8i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 12 2018, Junio C Hamano wrote:

> * ab/gc-doc-update (2018-10-11) 1 commit
>  - gc doc: mention the commit-graph in the intro
>
>  The documentation of "git gc" has been updated to mention that it
>  is no longer limited to "pruning away crufts" but also updates
>  ancillary files like commit-graph as a part of repository
>  optimization.
>
>  Waiting for reactions.
>  cf. <20181010193818.20399-1-avarab@gmail.com>
>  The author seems to feel that this might be controversial.

Probably shouldn't have mentioned that. SZEDER I think had more issues
with the "that's not GC" parts of what git-gc is doing, so I'll let him
chime in. I'm working on a more general update to gc.c which might bring
it more in the "not really GC anymore" direction.

But this patch is just describing the status quo, so I think it should
be uncontroversial to merge it, or at least we can have the discussion
about what we should do in a different venue than a doc fixup for
accurately describing what we're doing now.

Another topic: As noted in <20181010193235.17359-1-avarab@gmail.com> and
this follow-up
https://public-inbox.org/git/87h8hsexdm.fsf@evledraar.gmail.com/ it
would be great if you could pick up the "gc: remove redundant check for
gc_auto_threshold" patch. A small change that makes later refactoring a
tiny bit smaller and easier to understand.

