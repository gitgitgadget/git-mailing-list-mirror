Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD8A1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIZWCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 18:02:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55091 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeIZWCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 18:02:49 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so3595110ita.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+59yQy2+Nh7l2e9vdQC2l8jpsy9XSXhFVaOr6mkr4NU=;
        b=AxZ9SXy79vyUItnJTKuyUAadvBBZUCugV6iVK0WdqhvZWPOc8AmKqgAqy2S1yG82Ip
         Tthd3t0Ueph09vBU8wgS2oQdidYSFtsi+oyHmseBlaoS12Ur0gI/95J8rt7kRkuNI76x
         k9SnFzXVBVj/e2RIeTQVQX42pTKB+jxtPtIMamG/cfclGCLoyaA1iZqP6mmw3dJKUC4Q
         08kNdxx3kfiO3f56rqPWCxp8wYlsK7j8wdWvSgXTv0PtlVFlz2hA+h129cCQokjxGL+Z
         ZoJ7DiXi+yAE8BeHjqGLvTl5GDCFnz+s6NuLFr/EAPFVzbWUiEyBt9DVLFe/aoRcgXiB
         AXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+59yQy2+Nh7l2e9vdQC2l8jpsy9XSXhFVaOr6mkr4NU=;
        b=jzWyb2+H8YGlKoovPd45DkVz4ts4S6FD3PRsYHfFAYt3S/oTObWMIYkEmR9+jX3nq/
         +GhH5Gy68yF/NL+PqTlmeLaA/l4K2OKbTTA9MLBgf+rCuNQE19U7O0Ji9V4ahSqCyi8i
         XVNnUseb0T31XvoC6kRU6d3fGOkGDIQOyNKF0jACpt4/39V3yxVxSzwB5+MrUwUwQhC+
         XDx8sPjq6FuRY3N/i79+BxXu9iOijvMn+iI0UNUaSeDYaf5OQwzf6CGh45bRf2P4As7A
         hCI06KDjB9YUp07M+9g0+gS+VIxMkhijmxu0eHKUPcCOIphHLiVKFNzn11CbkBjYd3zB
         I3Cw==
X-Gm-Message-State: ABuFfohtvn53bLVLArENnfPs1wwOMkhWs18bq67o5DKTDPCRRJzm8+3/
        kcjmriUbqgMhqMYWoWgmEAcGjD/yxdFvoblAWu0T6jEr
X-Google-Smtp-Source: ACcGV60bFiCaYYd+KpYA++OSbGmgNg5JF9TEmbtgrUQShw3hvWV3zSXJn6bV7c1sYH4WyvW7Bl5RcjyD68RJxEBs8Zs=
X-Received: by 2002:a02:95c7:: with SMTP id b65-v6mr6159987jai.61.1537976954866;
 Wed, 26 Sep 2018 08:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 17:48:48 +0200
Message-ID: <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 11:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> Warning: devil's advocate mode on.

Oh good. I need to a good dose of sanity anyway.

> Done in either way, this will confuse the users.  What is the reason
> why people are led to think it is a good idea to use multiple
> worktrees, even when they need different settings?  What do they
> want out of "multiple worktrees linked to a single repository" as
> opposed to just a simple "as many clones as necessary"?  Reduced
> disk footprint?

I believe the main selling point of multiple worktrees is sharing
refs. You could easily avoid expensive clones with --local, but
synchronizing between different clones is not very convenient. Other
than that, different worktrees tend to behave like separate clones.

This leaves a gray area where other things should be shared or not. I
think the preference (or default mode) is still _not_ shared (*).
Sharing more things (besides refs and object database) is just a new
opportunity popping up when we implement multiple worktrees. Since
multiple worktrees (or clones before its time) are grouped together,
sometimes you would like to share common configuration. We could sort
of achieve this already with includeIf but again not as convenient.

(*) real life is not that simple. Since refs are shared, including
_remotes_ refs, so configuration related to remotes should also be
shared, or it will be a maintenance nightmare. Which is why
$GIT_DIR/config so far has been shared besides the two exceptions that
are core.bare and core.worktree. And I really like to get rid of these
exceptions.

> Is there a better way to achieve that without the
> downside of multiple worktrees (e.g. configuration need to be
> uniform)?

Is there a better way to achieve sharing refs between clones? I gave
it a minute but couldn't come up with a good answer :(

> > (*) "git config --worktree" points back to "config" file when this
> >     extension is not present so that it works in any setup.
>
> Shouldn't it barf and error out instead?

The intention is a uniform interface/api that works with both single
and multiple worktrees configurations. Otherwise in your scripts you
would need to write "if single worktree, do this, else do that". If
"git config --worktree" works with both, the existing scripts can be
audited and updated just a bit, adding "--worktree" where the config
should not be shared, and we're done.

> A user who hasn't enabled
> the extension uses --worktree option and misled to believe that the
> setting affects only a single worktree, even though the change is
> made globally---that does not sound like a great end-user experience.

I was talking about a single worktree. But I think here you meant the
user has multiple worktrees, but the extension is not enabled. I'm
probably not clear in the commit message, but "git config" can detect
that the extension has not been enabled, automatically enable it (and
move core.bare and core.worktree (if present) to the main worktree's
private config), so "git config --worktree" will never share the
change.

But perhaps the user should be made aware of this situation and asked
to explicitly enable the extension instead? It's certainly a more
conservative approach.
-- 
Duy
