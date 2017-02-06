Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913B41FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdBFUth (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 15:49:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35966 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdBFUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 15:49:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so7603832pfo.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Hd1rvr1e6Hiqg/nsUzpD0EEAq0lRuV19SKB+jz2WfaQ=;
        b=VPR2BZTWR5nv6PGGF4Pc/S315Q68qz7Kc3bf/nD0jYJbXwkOAV3fRPZ0j3xDi3Igqe
         8nVC5/O2GPmUbbW9tNSDioOEgSs6winalD7eyszNtrT3GZxNffQ9QMZXZ+pCEvgoxTQi
         c7y+OlorkB9Lw6UUHnNU33gVyHR9f70TxY6xpNDPxicoDynT/+EXvdEBOXNlJSYqOJNw
         bPIycs1VnDif/SC8UFkux5V21fMq3dO5HsZfdsNii1Y80jYNSJekFSR8d725ShsKz38f
         YcCkLHW7SAwWLPgZ8zkBIIEDWNF1v0Yu3vXBF8rywhlBdsQ45z7/yggnnEz9echT6EXf
         c0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Hd1rvr1e6Hiqg/nsUzpD0EEAq0lRuV19SKB+jz2WfaQ=;
        b=Hc1M7LmvjQ/kW56wwEQcaAswAOQ1+HydajziE6NqY++xUKMt+ar00NxZu9MEd/hHT4
         Ls8cQep0FJA4e/5U/UJbedGKgfO8J82ObjINWz7SasOi/Cp/EsQOu1/Iz88QVhLf5NSx
         n8st2IRj4Fl8g+YlytNK+t7nw2kegrhMrjk8YCNgPDqw6oSweE6J1COyPpd97OW1UXHu
         p3aXNnhbdGGmJahWM3CDe4Wz0/d1ii8q0G/claxfc23V7dBTXGi7Ss0PV7rql6Of1ee5
         ntZ11mMbDdLjtEV+CEd/2+gfZdPkcJo+bYbKxtgEnaXyEokgwC4ns8vY3L8wm7l/roxu
         AbwQ==
X-Gm-Message-State: AIkVDXK8xqyN9+jX2zEAvU8pQqW4Zq8KugiKjstHZEUpg6FLm9b/29IcIaf3HXMOAlIURA==
X-Received: by 10.84.179.99 with SMTP id a90mr20262598plc.139.1486414175889;
        Mon, 06 Feb 2017 12:49:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id s8sm4890157pfj.30.2017.02.06.12.49.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 12:49:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Samuel Lijin <sxlijin@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git/git-scm.com GH Issue Tracker
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
        <CACsJy8BCTY=T9f2ac7HUuHA-_RzjaxPHZNPQs9ecBhmsnDuRVQ@mail.gmail.com>
        <20170206184951.vwq6ib2qzxc542i4@sigill.intra.peff.net>
Date:   Mon, 06 Feb 2017 12:49:34 -0800
In-Reply-To: <20170206184951.vwq6ib2qzxc542i4@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 6 Feb 2017 19:49:51 +0100")
Message-ID: <xmqqlgtj11up.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [1] If we had a more permissive set of defaults, it would probably make
>     sense to turn on fsckObjects by default. Some of the checks are
>     security-relevant, like disallowing trees with ".GIT",
>     "../../etc/passwd", etc. Those _should_ be handled sanely by the
>     rest of Git, but it serves as a belt-and-suspenders check, and also
>     protects anybody with a buggy Git downstream from you.

Yeah, we really should encourage people to turn it on.  Turning it
on by default is one way to do so, of course.

I think the reason why the transfer side is stricter than the local
checking [*1*] is because the problem in the local history is
already done and there is not much the user can do to fix it, while
objects that originate from outside world could be rejected to keep
the receiving repository clean.


>     GitHub has had the feature turned on for ages, with a few caveats:
>
>       - we loosened the zero-padded mode warning, because it was causing
> 	too many false positives
>
>       - we loosened the timezone checks for the same reason; we've seen
> 	time zones that aren't exactly 4 characters before
>
>       - we occasionally get complaints from people trying to push old
> 	histories with bogus committer idents. Usually a missing name or
> 	similar.

As long as we are sure that modern Git and its reimplementations no
longer create objects with this problems, I think loosening these
checks is perfectly sensible, as the only objects that trigger the
check will be the ones buried deep in the history made back when Git
was young.

Of course, that will make it easier to let broken objects created by
newer reimplementations of Git (and bugs in our code that cause us
to create such broken objects) go unnoticed, so we would want to
keep them at warn (not ignore) for the end-users.

>      So those are the ones we'd probably need to loosen off the bat, and
>      they're all pretty harmless. But it would be a potential irritating
>      regression for somebody if they have a history with other minor
>      flaws, and Git suddenly starts refusing to clone it.

[Footnote]

*1* ... which is what Jonathan Nieder originally wondered at
    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=743227
