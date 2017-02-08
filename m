Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D4E1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 00:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932288AbdBHAy0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 19:54:26 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33508 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbdBHAy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 19:54:26 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so10327114pfg.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 16:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MkvZAwKGnr2Z+2yxrml2tRLKJHRO+Js9Yc2ZHNKFUOI=;
        b=HGBII1eY0aEaf35l6juLqqux3SyRYOGWXOGyQtbKj09qHjG3C2LWTvgJ66tvv6CgRP
         nh1a6qSc3nQmHYHiqSqsTvZkESUpCHG1pwUvwFZDjpQUEUfTlew9lzGUaX4PQ98ibqrq
         rjEPP63p9YcKN+qQs1veYbk6WXaNYjtOVMO8ZiO6NwwL/sqmgNl6Igsoj18i+wD0WleX
         5LkuRDnuK9iNlpZ+U3PTVjUxjsCvQbQYpm/tiOg2vB3HxpWR+nESx9tU4Amgn+hSYrOS
         iT0Mt8Zre3MgUzfe8ti6Qvr9lmhQzOfViwm3nXPXIHAYvQfx0WrIdoYVXbLecSytI+Vi
         Natg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MkvZAwKGnr2Z+2yxrml2tRLKJHRO+Js9Yc2ZHNKFUOI=;
        b=IDnA6Yr0wFAVOr4AesHCSPONmE7YmpufRJ16d3rUllHuAJ5eEbchlxRB4LcdkLZQu8
         uiXPzteP/mU8DrmSsm+qdWvIx6KR4DQCX9+V16RaRKMK98gOInDlTaOietebTq+uYj1r
         uh0UIYxCD/I40mHDju347bFDQDWCrM0e7yxVt172WwslXqUTvfQPFaLOSeHI1LtvyGBd
         w6Jp/fhTHYLZCvPFHfBsjXjefcgr4rb8e4Ao8M8u7qBNTvKCJbY0J3PYNZxJQMFaNaYo
         2BELjB2CmlH1qYE/hlOsURbJNRNoowvZrEpTnFGg0yRLCCeim1IKpUeZUi8WAFZb2tGb
         tGXw==
X-Gm-Message-State: AMke39l8SLT5vKTrYHO93iYgQ9QRyLObG/xaJo0DVraReAj+q39aFN7WZfgLHLhImGXj7Q==
X-Received: by 10.84.248.11 with SMTP id p11mr611072pll.72.1486515260110;
        Tue, 07 Feb 2017 16:54:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id 88sm14420598pfr.41.2017.02.07.16.54.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 16:54:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
Date:   Tue, 07 Feb 2017 16:54:18 -0800
In-Reply-To: <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 7 Feb 2017 15:12:33 -0800")
Message-ID: <xmqqinoly01x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Duh, I sent this just to Junio initially due to a brainfart. Here
> goes the list also ]

And my earlier response goes to the list ;-)

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Most of the time when I use pathspecs, I just use the bog-standard
> normal ones, and everything works wonderfully.

It is, I think, a no-brainer to lift the "you must have at least one
positive".  If the user says "not this and that", it is reasonable
to assume that "but include everything else" is implied.

As to "!" that triggers history substitution without quoting, it may
be annoying and I think it is probably OK to pick a synonym letter,
perhaps "^", now that the set of pathspec magics do not seem to be
growing rapidly and there may not be any other existing magic that
the natural meaning of "^" would match better than "negate".  The
primary reason why we used ! is, I think, to match patterns in the
exclude files.

As to the leading ":", that is shared between the ":(long form)" and
the short form, I am a bit hesitant to lose it.  It allows the users
to be trained only once, i.e. "if you want to match a path without
magic in your working tree, you need to watch out for an unusual
path that begins with a colon, which may be quite minority to begin
with.  You just prefix ./ in front to defeat it.  Everything else
you can type as-is, modulo wildcard metacharacters, but you know
that already." and their brains need no upgrading.  Once we start
accepting short forms without the ":", every time we add a short
form magic, the users need to be retrained.

In short, this

> Or even just allowing ^ in addition to ! for negation, and otherwise
> keeping the current syntax.

in addition to "no positives?  let's pretend you also said '.' as a
positive", would not be too bad, methinks.  And that allows this

>     git diff -M --dirstat .. -- ':!drivers' ':!arch' .

to become

    git diff -M --dirstat .. -- :^{drivers,arch}

which is a bit shorter.  I personally am perfectly fine without ^, i.e.

    git diff -M --dirstat .. -- :\!{drivers,arch}

though.

By the way, I am wondering why this is private, not cc'ed to the
mailing list.  As messages addressed to gitster@ without git@vger
bypass my Inbox and gets thrown into spam box, which I only
occasionally scan to resurrect messages worth responding, and this
is one of those cases ;-)

