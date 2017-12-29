Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D147D1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbdL2WF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 17:05:56 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36805 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdL2WFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 17:05:55 -0500
Received: by mail-wr0-f172.google.com with SMTP id u19so36184929wrc.3
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=i6RZeECzx+K+wrWu1nJCftIqjxirblYQz0vBezlwNlA=;
        b=lwVKojRXHg7HiiB7d72uuhVPCscuet8Le87tbcaiN+H76RhcGydYJeiyB+kCdjQdPn
         8KMx6ry3k+d7fqDq5Lf51xJEy35SjmPgTbi2AppRskSzRpkjPNiemaYmqGz1ZuFf7MwG
         hUgT/NjgyAorJrOCzYAHYa5h/0fhwXAqvh08JadggitJ3SpbAiu4hoJQp61bdWjXtwG/
         P2HeoXSN3zBmEW2tOxFQ5BpZ62rXD68deDkGRe0K+5gL5LaR64h0kLPOrOQs3CHEQ0N1
         +/QZhIYc4fdN3R/uxEqLmCyO59bGPVnD+drniWONgBOgPdIH+jq/DvGWB0DaCpe1Xu0Q
         khSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=i6RZeECzx+K+wrWu1nJCftIqjxirblYQz0vBezlwNlA=;
        b=aMYgXWn2TL7R+axW1d1Gcxm8p+8AoWefehJbvJE8LToy3FzSRJTge8QSBfcHSifUbD
         Z7avuKE4ucsiht90cAENbSgnFr+Mu9KRuGjW7JS1THD++8adRYbiezSrROXnmp7+Xsdb
         xhz1X/oZwAZY/6rWJM/QwTyrTu01DWw07vUZn80ux8HpQDieRT/vWf528h1H0gF8yYnI
         A5wfzuSlKaen4psZnLoYq6+RwfaImdqGocIktY8FYsDYWMCix9Tlvfyat7GNLRM4YQXe
         0yFI5OYv5KVBAUM4gd2KoT4YPx2bimp3znofXyhdvPFluEX+FshHX1SVSIXgcfJbr96Z
         UOrw==
X-Gm-Message-State: AKGB3mJcBVvkAS/GY1miElhQ9xL6VnEn5X783scrSAkffOl75NKUjpBL
        XTJDIDZ8/oNNydtX94i7LXYMdS1m
X-Google-Smtp-Source: ACJfBovO9ZOFmdi2vqj0Z1HhDkb7+HjSnsBxL8wqrvx5Q3hoj1ZQ9p5OjiHLiWygt/ox8azRo/R2sw==
X-Received: by 10.223.136.184 with SMTP id f53mr34648296wrf.143.1514585154054;
        Fri, 29 Dec 2017 14:05:54 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id t61sm56717098wrc.21.2017.12.29.14.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Dec 2017 14:05:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Zefram <zefram@fysh.org>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git bisect colour output contrary to configuration
References: <20171229194712.GA15930@fysh.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171229194712.GA15930@fysh.org>
Date:   Fri, 29 Dec 2017 23:05:52 +0100
Message-ID: <87zi616vgf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 29 2017, zefram@fysh.org jotted:

> My ~/.gitconfig sets color.ui=never, which should prevent attempts
> at colouring output from all git commands.  I do not have any git
> configuration enabling colour in any situation (such as for specific
> commands).  But when a git bisect completes, the output identifying
> the first bad commit includes escape sequences to colour the "commit
> 3e6..." line yellow.  Excerpt of strace output (with many irrelevant
> lines omitted):
>
> 23851 write(1, "3e6fc602e433dbd76941ac0ef7a438a77fbe9a05 is the first bad commit\n", 65) = 65
> 23851 open("/home/zefram/.gitconfig", O_RDONLY) = 3
> 23851 read(3, "[user]\n\tname = Zefram\n\temail = zefram@fysh.org\n\tsigningkey = 0x8E1E1EC1\n\n[color]\n\tui = never\n", 4096) = 93
> 23851 write(1, "\33[33mcommit 3e6fc602e433dbd76941ac0ef7a438a77fbe9a05\33[m\n", 56) = 56
>
> Given the configuration, that line should be free of escape sequences.
>
> I'm mainly using git 2.1.4 via Debian, but I've also
> reproduced this problem with the latest from git.git (commit
> 1eaabe34fc6f486367a176207420378f587d3b48, tagged v2.16.0-rc0).

This issue is a bug, but has nothing do do with bisect per-se, but is a
bug in diff-tree, compare these two:

    git -c color.ui=never diff-tree --pretty --stat HEAD
    git -c color.ui=never show --pretty --stat HEAD

diff-tree will incorrectly show colored output here despite
ui.color=never.
