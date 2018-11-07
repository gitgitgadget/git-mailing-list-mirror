Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C641F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKGWkO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 17:40:14 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36839 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKGWkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 17:40:14 -0500
Received: by mail-wm1-f42.google.com with SMTP id a8-v6so15659372wmf.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 05:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cl/uZEUDKxbBTpehCcU3dz9i+eugTigGEfkRI32l2Pw=;
        b=u86+6Z2DrbGJ/dDTb8N7G9ykZmGs1EgWP+Hass3CLNJCpkQm0Nk4wBLnc0Yu6ks7vx
         jhBBBAv905kO1xiHiE2SZ9U708WGSMK58/vXQMVwnZczzYuRqn11tu+l5CO2MwcdFIx7
         DlCWQzSKwqbXtdTMzmYFroPfku7AKL0Q1dlDmFiPNW3XmiRfwggcKebSUOLfrz9j9jZr
         2NwsdzcCx3DkH8a/RMfH02lI8vsQC/gIvpX2Nw7qHdlkn92/mwlA5rt7WehL6CSBqc7I
         tNYDNIbIWfQkwQ7L+uyqhmEwYi4nZ2z19Pg9siTvSfx3nj73BcAxCsb7cqAE9fqgmGb/
         PjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cl/uZEUDKxbBTpehCcU3dz9i+eugTigGEfkRI32l2Pw=;
        b=UjHbSqPtWt3dm/wbs+qBXsOnA7etWlUzqT1tgG8He2NAOuJJV64l7p1vJvdRpU0T8n
         gwmfBJih0PmIGdLcK2okFvP3iy9PkaR+pVLuCSNIXOtnOFvHkm4G1xTlvElA61lBcAEV
         UhQLcWXAAC2JSAuGBoSURdsj9TQYsbmqy5OOxJZGoLfLtb0QEX+C3UgcxSn7zkvCJlbt
         PXDZWwwEfDWrstPD6z4NL1Waf7K66hvpdbgVIm/BBB4LvvMkYh3qHX8jmsw+Kws7Puhu
         mqEExv9owHW+wf9ZX078GBy1CMJr+VETfTVtfpCdg1FYvT95E6deP7IrBDgMjEGSKclA
         IKbg==
X-Gm-Message-State: AGRZ1gJj3YU2vYnPEAjGcZmpmOD+X+vMmArFYdnYolUhjVud46rynnrz
        kAmDISSgkh+09fhVqJf0lDMYoNU7Ars=
X-Google-Smtp-Source: AJdET5c4km/b3XKJ0QURWH+Z9lEShXxicFK7M/ZkZXAz8Tux0f8GldyCA41AHyHbIyOmxc5ckgxfnQ==
X-Received: by 2002:a1c:930d:: with SMTP id v13-v6mr163611wmd.26.1541596193737;
        Wed, 07 Nov 2018 05:09:53 -0800 (PST)
Received: from szeder.dev (x4db280ce.dyn.telefonica.de. [77.178.128.206])
        by smtp.gmail.com with ESMTPSA id g1-v6sm1427283wmg.2.2018.11.07.05.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:09:52 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:09:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
Message-ID: <20181107130950.GA30222@szeder.dev>
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 06:41:45PM +0900, Junio C Hamano wrote:
> * nd/i18n (2018-11-06) 16 commits
>  - fsck: mark strings for translation
>  - fsck: reduce word legos to help i18n
>  - parse-options.c: mark more strings for translation
>  - parse-options.c: turn some die() to BUG()
>  - parse-options: replace opterror() with optname()
>  - repack: mark more strings for translation
>  - remote.c: mark messages for translation
>  - remote.c: turn some error() or die() to BUG()
>  - reflog: mark strings for translation
>  - read-cache.c: add missing colon separators
>  - read-cache.c: mark more strings for translation
>  - read-cache.c: turn die("internal error") to BUG()
>  - attr.c: mark more string for translation
>  - archive.c: mark more strings for translation
>  - alias.c: mark split_cmdline_strerror() strings for translation
>  - git.c: mark more strings for translation
> 
>  More _("i18n") markings.

When this patch is merged into 'pu' all four tests added to
't1450-fsck.sh' in b29759d89a (fsck: check HEAD and reflog from other
worktrees, 2018-10-21) as part of 'nd/per-worktree-ref-iteration'
below fail when run with GETTEXT_POISON=y.  The test suite passes in
both of these topics on their own, even with GETTEXT_POISON, it's
their merge that is somehow problematic.

> * nd/per-worktree-ref-iteration (2018-11-05) 9 commits
>   (merged to 'next' on 2018-11-06 at 53803cedf3)
>  + git-worktree.txt: correct linkgit command name
>   (merged to 'next' on 2018-11-03 at 4cbe49a704)
>  + reflog expire: cover reflog from all worktrees
>  + fsck: check HEAD and reflog from other worktrees
>  + fsck: move fsck_head_link() to get_default_heads() to avoid some globals
>  + revision.c: better error reporting on ref from different worktrees
>  + revision.c: correct a parameter name
>  + refs: new ref types to make per-worktree refs visible to all worktrees
>  + Add a place for (not) sharing stuff between worktrees
>  + refs.c: indent with tabs, not spaces
> 
>  The code to traverse objects for reachability, used to decide what
>  objects are unreferenced and expendable, have been taught to also
>  consider per-worktree refs of other worktrees as starting points to
>  prevent data loss.
> 
>  Will merge to 'master'.
