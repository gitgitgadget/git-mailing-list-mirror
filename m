Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD1A20954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdK1OJ0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 09:09:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:62463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbdK1OJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:09:23 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhfZR-1ex88b1t3Z-00mq8a; Tue, 28
 Nov 2017 15:09:16 +0100
Date:   Tue, 28 Nov 2017 15:08:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dan Jacques <dnj@google.com>
cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
In-Reply-To: <20171128032538.98071-1-dnj@google.com>
Message-ID: <alpine.DEB.2.21.1.1711281330150.6482@virtualbox>
References: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox> <20171128032538.98071-1-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x0JX8T+Qvyds0P3N4hWU6dsxW3YG8AePuFqm9IsWcjEnVsa7QTk
 j9pWPy6nCZGbTsvLJPwaY+OYBmHXArlYJL+Pzfe/h1w9hrE4QY7ygXJGN7VPq2RgVF6PCyj
 Q9InHOB6aR3b44U9OhwVyFAc+nUGftcuCCjy9DN1H+fapWGe+s8BhJE56f9FguIq/ZDTUtL
 +7NXjyGQn9YwBbz5KVe1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MnNdUAA92m0=:M9g3ot1RMCYVqGe4lq5Cqm
 a7U9Ry3y3Wmib/NJU/jxIfGJjt2Fcc17CJW2OdJKo1LRo3pbqdM2YyKgoKex+teqZrcX4zsEj
 3LdhRZvWlxyFJP6CEcjHIy4DSniYCibUcE6B4XTMmBvgZbOrl4X9OVGnZfw1QSZ4TYGMUt7Fc
 3Ys3pnqfM45fXG6p7zHbdhyrKvUK1IrvribwCg3mxXVPAvhBZ3mzbyFMLXRUUiz70Ny4dtDbv
 15XNXrkPTCEWXWPxDpWdH5Gfme+KzcqYsTbHr0LJr9PcB9QBb/DAJdIhz9x9hEyFn8J8bDN3C
 jKYSThBwCL2c6Oucsm8LD+gnNb+1Kt5xahqsBx4FQP88rzk2tjARfx2j3b2OxftjSZdxLllFb
 yYbQ7cHdzxC3jdL/87TtKCxqrAqQuiwh7ofAU9P4oeToRH/2QhROUmvbpHEd50TT9rfuVAkpW
 rYkyVRtnvupz+J85BJHDPgskOdriBq33jSGeazbCUJFLWkluMWiyO3g1VduxHmLAGTv8BUP1M
 USsaxzTQxxgvcgCZ3lP7dbgnBXweVte4VKW+jLL2gpMP64U5Kci9EzuvvONRzRKPye9d6CpWn
 wiGmAlvFXPzWplDZH1LqldpTzO6oXWpp64BmsC2Qn7dgGWloLYJ9bR18/ba15Fc7h2bWoqHeO
 SJ6PQe9A0kUe2VWn3tPTHQHifJOToGqq/7KRPhE3yZnue5hLBzHFUnVaL9HK03rt2l82rJaGU
 ZuMP0VyRyNW5Fjcu57OFjKhG5hcUrakYJDU0xkcamuXCP6LYdJSAEOHPLKfed8PMtnYjFcneP
 mjQZ84rQ4pn85XVe1MH/xQbU84f7sWmYjtZ0Jz9lj6ZbrHkJssJNJm9cKEX4FWfJlQTQgAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dan, and (based on the timezone recorded in your mail:) good morning!

On Mon, 27 Nov 2017, Dan Jacques wrote:

> > In Git for Windows, we have an almost identical patch:
> >
> > https://github.com/git-for-windows/git/commit/bdd739bb2b0b
> >
> > We just guard the call to system_path() behind a test whether podir is
> > already absolute, but these days, system_path() does that itself.
> >
> > I am too little of a Perl expert to be helpful with the other patches, but
> > I would gladly runa build & test on Windows if you direct me to an
> > easily-pullable branch.
> 
> Oh interesting - I've only peripherally looked at Git-for-Windows code,
> since Chromium uses its packages verbatim (thanks, BTW!). I think you're
> correct though - this patch set seems to be doing the same thing.

Excellent, thanks for confirming.

> I've been force-pushing my changes to the "runtime-prefix" branch of my
> Git fork for travis.ci testing. The latest commit on that branch adds a
> "config.mak" for testing, so one commit from the branch head will
> contain the sum set of this patch series applied at (or near) Git's
> master branch:
> 
> https://github.com/danjacques/git/tree/runtime-prefix~1
> 
> Let me know if this is what you are looking for, and if I can offer any
> help with Windows testing. Thanks!

Thank you, that was exactly what I was looking for.

BTW I think that your config.mak settings are partially unnecessary: the
gitexecdir and template_dir should be identical, and sysconfdir, too (at
least unless you override prefix).

I triggered a build (with the config.mak commit, because it does not
really matter), and it failed immediately due to a quoting issue: the path
separator is a semicolon on Windows and therefore must be quoted (so that
it is not misinterpreted as ending the command). There were a couple of
other issues, too, and I opened a PR here:

	https://github.com/danjacques/git/pull/1

Ciao,
Dscho
