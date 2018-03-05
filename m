Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E337A1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCEOe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:34:26 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53512 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbeCEOeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:34:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id t74so16340644wme.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oyzSBlPnRZ1URrr+LtpDTFwzGJq0SsP6xoz5jMxYkIY=;
        b=ke4My6Lyh0qPIexcp7VJVMUt89S2HkpN/s83RZiyAz/VeagrBC8/A3KNUYDjUPNEhZ
         OYxgcmuk11LPKmX760mf5awwuLc97bjTACP4l1Ey+/ZDerxuEixxtz/r5iJrjOWWP9UF
         mvZC1DN4yOoynDSShldW1eX0GzGiPMtvT6cGixVh6aXKbHHoT6rB8xvlnTj9nAt+3sLW
         zizy1egoIYA7MHUOk7WmuIzAk168tR1DDegpEDYQEHvDldORQqAMOcS9Cqj1gB7KXrXL
         HfORAETQVnzdBsAYhhCyuwufylerCXdbWLRx9Afhfcooa5V3LdDSApEGrYXQeAAgifRu
         gb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oyzSBlPnRZ1URrr+LtpDTFwzGJq0SsP6xoz5jMxYkIY=;
        b=H3aBdfBnJ8L5JheERo29ybNhrWliwjw9E2Aly31L4tV++APhrmaQou68/PqtrkivmI
         lKFNejiL8vrF0m59blKlxqtSRcSpijgDPrLL64TOzdImZkyul42G1cs9gKojaxP+DBgN
         DjpC0RMTmWqgtgTVF4SZIS5GN82gSENJ6VVieXGPRMMng1gQlHaMOvX8I+dbmqVNKksB
         VtFTAM49Q0oXhaHrx+/5BZwpSzc4kf6QHMsHyIljzGP0XB+viV96UHFnrZ+ArrC5xn3v
         yl5n2xJcLIfSz939eGiekBoSJYIMqZ/tv4K8zrMAl9aKD/kfgEo9kFt73OeEAgarMW6o
         nsAw==
X-Gm-Message-State: APf1xPBvLZHIoMYJDNCWcGizml+D0RlsksQ6c4DKYmv9OG55KdmSU653
        YUdQv/D1LuZGMC7R8k6fJZ+O3EZ4
X-Google-Smtp-Source: AG47ELuBQF4n2J5tVqvzw3Dn55lUsaFTpeLFD8nMcxc5wn75mwDGL/UfNUeEhZdUh45Zb82g6XrcHA==
X-Received: by 10.80.218.204 with SMTP id s12mr18470385edj.171.1520260463105;
        Mon, 05 Mar 2018 06:34:23 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c9sm1147298edl.16.2018.03.05.06.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 06:34:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
References: <20180303103010.GA21068@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180303103010.GA21068@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 15:34:21 +0100
Message-ID: <87a7vmoaky.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 03 2018, Jeff King jotted:

> Feel free to reply to this thread if you want to make plans or discuss
> any proposed topics before the summit. Input or questions from
> non-attendees is welcome here.

1)

Last year we discussed the general topic of performance. That's of
course very general, and can touch multiple unrelated areas of git
(worktree 'status' performance, all things protocol, storing big
objects, graph traversal, etc.).

No doubt others will propose other topics we'd want to carve out into
their own discussions (e.g. I'm expecting the v2 protocol to be one such
topic), but it'll be nice to have something that brings everyone
up-to-date on what the status is for purposes of coordination &
collaboration.

2)

I doubt many are interested in these as topics during the contributor
summit (but will propose them on the board if others care), but I have a
couple of things that touch quite a lot of things that I'm going to get
around to working on (or have in some WIP state):

 - PCRE-ification & PCRE convert:

   a) Use the interface recently added to PCRE to use it also for basic &
      extended POSIX regexps. This speeds things up a lot

   b) See if we can use PCRE (or at least extended regexp) consistently in
      the rest of git via single interface. Relevant code:

      git grep '\b(regcomp|regexec)\b' -- '*.[ch]'

   c) Maybe if we like a) && b) enough for performance reasons we'd be
     happy to make PCRE a hard dependency, and would then ship with a
     compat/pcre2 (~80k lines) instead of the current ancient (and hard
     to update) compat/regex/* (~10k lines).

 - Adding the ability to optionally read a .gitconfig shipped with the
   repo, see
   https://public-inbox.org/git/87zi6eakkt.fsf@evledraar.gmail.com/
