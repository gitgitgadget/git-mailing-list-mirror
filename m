Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79CE1F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 23:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfANXEa (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 18:04:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45026 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfANXE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:04:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so1015602edd.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 15:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iK4yAdC4ky4jrJNtx4WR4rrtYXf4ZzPoj/O782xllbU=;
        b=OruHCD1uo1X/FGL4Zer5Tvj7rBqDMc4R/BJk2HbUG2g1PwKtUecoBrbvo1BS4DZWRd
         OBE1fHnETCX+KLKmRw0gcV6dBTEKGpd5ox22jpZqSs0L3QmYkkgq85iCIod9ScVZxi7r
         48zGOfD4CcNImWO38OOm5wHkfpLDbaMOcJeEwBXDeoX+Vx+RQ0M4RlLIdTOvB0pVGzEK
         rw+vbFpg4vZCbscSAUf2jkLUp/bgDs22yPHv0HTp/6VRH8K3ctjQYbPHwsGYYEFO9bZy
         sBuh14e7VVkpcgeAcRbkwvd2k8VhX7lzvx6m3Ozu+A2+dRtJ6KxaP7VVSGpIFC9c9ybZ
         JCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iK4yAdC4ky4jrJNtx4WR4rrtYXf4ZzPoj/O782xllbU=;
        b=Ga3KwF2bg3lqR9YPRYBjIgugJcnzulkWFH9Fiei5pvKketMFWv+A7QRh8BH4JlNPzq
         ixNHcjcFZ5YSFOryjtEQAKwgwUYwCT5y4kQmyjjWQQODBWeCUJtw6mQ28gpmsLJdqrav
         4yiIT38uMudEHfCd3X7Z9mNvSN1C4U2UKfcGBuERJ8FS8b2lVW9w3DCh24aVv4bNEJ39
         OblaTCulu2dLi5rf54WIu2aip1Q2O7qWJ3GEpAvWBgL+6Wc4h4+UGyfCTsUyTufs/GNc
         3zJ4a1b67FaeSHzdZ9618aVUJQsyJkuEbgaI4i6qee6VXHH+jGcwCd0j5Dx1UXEWkVpn
         NO6A==
X-Gm-Message-State: AJcUukfhrOFtIGOF40fBh+V/oJVRn7YGPwAGdIKJxXeWcHIC8WKnWIrL
        +beJSYUSEw8tvNzdbJEcap3sTyUf
X-Google-Smtp-Source: ALg8bN5Sk6JXMjJH+kb3ZfsYYkWfe1edO2DUjnipsU5jjAKqsaIoLOOa83RU//SpiDptUj7mbNhuQg==
X-Received: by 2002:a50:ac47:: with SMTP id w7mr1091427edc.260.1547507067368;
        Mon, 14 Jan 2019 15:04:27 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id e14sm4489020edb.79.2019.01.14.15.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:04:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org
Subject: Re: Students projects: looking for small and medium project ideas
References: <86fttvcehs.fsf@matthieu-moy.fr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <86fttvcehs.fsf@matthieu-moy.fr>
Date:   Tue, 15 Jan 2019 00:04:25 +0100
Message-ID: <87sgxu4z9i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 14 2019, Matthieu Moy wrote:

> I haven't been active for a while on this list, but for those who don't
> know me, I'm a CS teacher and I'm regularly offering my students to
> contribute to open-source projects as part of their school projects. A
> few nice features like "git rebase -i --exec" or many of the hints in
> "git status" were implemented as part of these projects.
>
> I'm starting another instance of such project next week.

Good to hear!

> Part of the work of students is to choose which feature they want to
> work on, but I try to prepare this for them. I'm keeping a list of ideas
> here:
>
>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
>
> (At some point, I should probably migrate this to git.github.io, since
> the wiki only seems half-alive these days).
>
> I'm looking for small to medium size projects (typically, a GSoC project
> is far too big in comparison, but we may expect more than just
> microprojects).
>
> You may suggest ideas by editting the wiki page, or just by replying to
> this email (I'll point my students to the thread). Don't hesitate to
> remove entries (or ask me to do so) on the wiki page if you think they
> are not relevant anymore.

Some #leftoverbits I've noted on-list before would qualify, some of
these (e.g. grep --only-matching) have been implemented, but others not:

https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/
https://public-inbox.org/git/87bmcyfh67.fsf@evledraar.gmail.com/
