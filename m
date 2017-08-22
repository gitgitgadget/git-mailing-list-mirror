Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A01120899
	for <e@80x24.org>; Tue, 22 Aug 2017 08:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbdHVItp (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 04:49:45 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33058 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVItn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 04:49:43 -0400
Received: by mail-oi0-f52.google.com with SMTP id f11so179131106oic.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N+YeXt6YNmQTHceSi0rmRFvCnvPyez2XGkHipb+vj6Q=;
        b=lwNCUbjUE5BP6vmzdSQLt5V5whvU5Z4MrV2XkNexsU6esQZvIkHv6ZgMKwyW+0liYC
         Bn69YL9QKk+XLQDRGqL9INBOqb/CAAAZoEf8JxiUzi0BhjVZC5uFNwFLsQ24EJaVbMgk
         O+QHUa/Px9dMfOKJyh6kyzBIDgBMscR+2ASHbh5351E0NLH/JNZg91o7jZovIjVCkMat
         pmpI1+sonNgt1mhgGzOcRElgvC6pGE0n2uW6QQaoAiNgduQhTJwQ3z7xqBDL9l8MHIKr
         FUAt0mSZbSI54g8yf/pwR51kI8iFbc4j0Ky5cmdDZe1Pe1Gorarmf9dp8w7w4Vhl/uVX
         l6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N+YeXt6YNmQTHceSi0rmRFvCnvPyez2XGkHipb+vj6Q=;
        b=ea7xx8JAC9VQYTxH1Z29qCcVhel668hZowKRgm/P1znEe3f4ly5EItQ7B+xcvjW0K/
         JEYYbQBigpmMbAlu5hdp5TP+8WuiibMethtCSU7GDRM+tAAGSATpCAOI1Rmt9ZABdI70
         xfF6JkqOAWqfzquyk6e7Ky/Xcn2N519DzCK8Fizjhjmh+cZGb1gt+Uyslf3W26NRddhG
         YZpvf0OmjWroqe4mniKJ1IRXpMAD2MI1lSQXeReux1vJKAD8xhji3RlWbPNiu9BJfrfn
         LWTZxBzIitOM8LY9WT7RhO+UD/1uDycgXtkMil5eV9xAbX89TTduImwSJ57OUcOw3mmd
         W1pg==
X-Gm-Message-State: AHYfb5gYrExiSqz9fu55ukJ0aOdSGq2MfAra2P5mO4a7Ug0sn121A3Cq
        4LRCJLvqIzB80h09zuMUW+kciw4OsA==
X-Received: by 10.202.168.7 with SMTP id r7mr27045909oie.256.1503391782778;
 Tue, 22 Aug 2017 01:49:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Tue, 22 Aug 2017 01:49:12 -0700 (PDT)
In-Reply-To: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Aug 2017 15:49:12 +0700
Message-ID: <CACsJy8AM+dr_in_hW3y6APUo-cKsg+3sAZg9-7+02ZspSZcf=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [Discarded]
>
> * nd/prune-in-worktree (2017-04-24) 12 commits
>  . rev-list: expose and document --single-worktree
>  . revision.c: --reflog add HEAD reflog from all worktrees
>  . files-backend: make reflog iterator go through per-worktree reflog
>  . revision.c: --all adds HEAD from all worktrees
>  . refs: remove dead for_each_*_submodule()
>  . revision.c: use refs_for_each*() instead of for_each_*_submodule()
>  . refs: add refs_head_ref()
>  . refs: move submodule slash stripping code to get_submodule_ref_store
>  . refs.c: refactor get_submodule_ref_store(), share common free block
>  . revision.c: --indexed-objects add objects from all worktrees
>  . revision.c: refactor add_index_objects_to_pending()
>  . revision.h: new flag in struct rev_info wrt. worktree-related refs
>
>  "git gc" and friends when multiple worktrees are used off of a
>  single repository did not consider the index and per-worktree refs
>  of other worktrees as the root for reachability traversal, making
>  objects that are in use only in other worktrees to be subject to
>  garbage collection.

I'm back and will try to continue this. Is it discarded because of
lack of progress, or because the problem is already fixed some other
way? A quick "git log --oneline" on important files has not revealed
anything.
-- 
Duy
