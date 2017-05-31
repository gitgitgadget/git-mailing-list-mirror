Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599872027C
	for <e@80x24.org>; Wed, 31 May 2017 03:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdEaDTC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 23:19:02 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36416 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdEaDTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 23:19:01 -0400
Received: by mail-lf0-f53.google.com with SMTP id h4so1892833lfj.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ky+0aXKsogYGoDkvxdC/y0ZGhUv165+6mOZM9qciHeM=;
        b=eZ7PsC8KD+uMEq9ZGf63B+DBMnzmEe4qtwtS8LmxKg2Ub868CXzFnlieY6w7eGqUCE
         YYNBMnzGmaRdPRHnikmDGeAi94JVBKs3plkHQJQ98eJkBg/nPxWEFKIQmISPDiMxpt1X
         kyG5G8Z46caHjNy8/3cUOLo3oFFZzK8gDziWpaFfcb48XwCQUOfYBVT2Oo8fQCRyBFSx
         HUBbtHQDpb4oUUWQg4B5QJTVWUHRyIDz/liLr3xlaIYvoVhJ7VJiJjxTnbajP7ydT65Z
         aAO6mDO8H8/xwHoy741nfklGkLt0cdVQ3S5FY0Jrh05rNc68mSgt256ln9CtYlxvibvX
         9NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ky+0aXKsogYGoDkvxdC/y0ZGhUv165+6mOZM9qciHeM=;
        b=OJeixLjoUb40t2PdZN8SY9++lMuxb7F0uxrY72UHqupnS0cXLupSzMtIcy3xRQr5uo
         CrZbWunslavZl554la52VSXzqQsEAJgYuv2YYq9ov9EK4X1ugLgVIqpmiZU3Bp+bUKob
         2HvPRXgFujo5yO5O1ZsuOw26F5iiyodT5AcMFw7Yeg3jWkq9FipTlXzO8620qTP0ftek
         OM6V1R6IgKTaC74jeDdTKBZDMqu8joNDkwBg52Chx4Lt7Nf+5iwlahNPi3QB0GWKxo6W
         i+uBM7VKqTWeaVUcKJTZYrOWcmWHpMzKvTeMuvXc4mTI0MvGUfns8AnC1xJPAJGxVntu
         U2ZA==
X-Gm-Message-State: AODbwcCfGhYqYli6n13L3wMciVQocQdOczl+R9xFv4AGXdQ+sok+4BSD
        jy/soESwpc68Vva2drLQSfZn2dmW3g==
X-Received: by 10.25.17.96 with SMTP id g93mr6124870lfi.129.1496200739750;
 Tue, 30 May 2017 20:18:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.229.213 with HTTP; Tue, 30 May 2017 20:18:29 -0700 (PDT)
In-Reply-To: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Wed, 31 May 2017 00:18:29 -0300
Message-ID: <CAEA2_RJWnjiqinoAhd9aEM=zx9K4MxYpsoDcgoVwf0RnChsnUQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 3:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * df/dir-iter-remove-subtree (2017-05-29) 5 commits
>  . remove_subtree(): reimplement using iterators
>  . dir_iterator: rewrite state machine model
>  . dir_iterator: refactor dir_iterator_advance
>  . remove_subtree(): test removing nested directories
>  . dir_iterator: add tests for dir_iterator API
>
>  Update the dir-iterator API and use it to reimplement
>  remove_subtree().
>
>  GSoC microproject.
>  Ejected as it conflicts with other topics in flight in a
>  non-trivial way.

I see this conflicts with Duy's
fa7e9c0c24637d6b041a2919a33956b68bfd0869 ("files-backend: make reflog
iterator go through per-worktree reflog", 2017-04-19) because his
commit creates a new dir_iterator whose NULL value means something
semantically. This would be perfectly OK with the old dir_iterator API
(where NULL was not a possible return value from dir_iterator_begin()
and could be "reserved" for this case), but will most probably
generate issues with the new API, where NULL can *also* mean we failed
to lstat() the directory we're trying to iterate over[1].

I'll try to address this issue playing with pu, but I'm just wondering
what would be the best way to send this upcoming not-based-on-master
patch to the list. Should I just send it normally and signal it
originates from pu rather than master?

Thanks,

[1]: https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/T/#m68286d783b5dfbad6921fbf012f685a629645c61
