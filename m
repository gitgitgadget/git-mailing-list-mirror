Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B0420136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbdBQQAw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:00:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:58166 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934037AbdBQQAv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:00:51 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDFB2-1cbSdV3XBc-00Gc9U; Fri, 17
 Feb 2017 17:00:37 +0100
Date:   Fri, 17 Feb 2017 17:00:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
In-Reply-To: <xmqqlgt7110q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702171626160.3496@virtualbox>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de> <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702141545380.3496@virtualbox> <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702151332540.3496@virtualbox> <xmqqbmu32iyb.fsf@gitster.mtv.corp.google.com> <xmqqlgt7110q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UAjX6VBWlKDlPbpnOXAvgW+i4VsR2RtbAhQd/xeZE2W5LU0uZCt
 BTlJSyHiSkc2jvoj14az1zv8cvpiY8tmCJ6PxGZAdJU1kV9QV03YS9huY9NoMYDVjfXk8m4
 oK4oeGDMIjxrXtHlW8Q2EqJeY6ba7OzSq/qoFwjBCMWVFkhxHZSIweD20qeiE2c9yqSjAUl
 PkuCgUYVWsEv+8PW6wt9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EmwID2CzI9c=:w/nObMTbj8We01Od1UyJFX
 knoLWzTYU+jELVutoXHhouUER+s2s8/WzHjZuoMyNG6neuZyfbLwNIQRfTw/6TL8Plvs/lqEA
 K1kI2vE04GnCtPgCAvty5PgFuPOJsJQoYzCGrJHKkF4Y11U/iL9m3rGlZljogOMYtrjTgvvYy
 0+VJZtIYu+KZLQpJJYdg4WyD5xypoA794oSOGfCQBQaNWIy9gZiJBPKbgrt5y8pTn81V5gska
 5ePoNWPnrrAE1Ds/EExUwr+z9b6N+rKyxYXum688AFzDa6r0659YXYri4BDb8myW/Gm49jHcN
 DEVraABURN/gE6n9hXa6zwENM0L0QezX2r5PEdFdY8X3KhTS3r2QfCMo5WyD+OtkeZ5H5ouJm
 HI2qdvnAOte/+s6qu7OXf3Pi2+2kThoI1z1sg+1w1lywlM8O5DmFMlWzLtIYPfr9ClhLri/VX
 LlDXWhoOoJsGrY82sJUBPZ/BL9tPvTTbeGYvvpw7+1AiSk8Q0JFGC+BGwY+LX5RudW2JNkTLR
 1tRS6NAI41++B8O3veFEqrYtXD0HQuGspm4iqt+2cpH9XIEkvQ7VYofkal2JXhmg6azwzeT5K
 x212mxEzXeWkx2p5C66311BbkycKDhgBJ/AElxaAdMfi9MMoqKVAoX9CN2NJq70C8q4JQh0AR
 8hx2ntKHdZAb/lfijWxj58VBYCUTzLMTQBKG7Du3fhWPptkuwOPYmctGUAsKCw8sY0UUQ7Ebl
 T8MzlNA4rzFepjpuKa91ogouK2Il2exTg0Z6YKcSZuQ8xAWTA+3YUQ4a9eRL7QAtkG/90n/9Z
 vE/KWceX+LLvE/CnqGtq2CuvEt3py4DKz/QAsMXmwOGQdPE7DojlNtqgh9VamnnAINB8t4QUz
 x9AoucNLJc9BNBhz0tkNkbdKeJmPu1aC1ydPX9VlgeAw4HpEEz596i01FisT0yMeOQv+2DOJ2
 c2XBE3GbRoOB9pCwo7JluAaWL9NH8OrmkhE7JUXVli0U3AHqOerXNWeVFmV5JWX4qi1nzYwzp
 05uFsNb/86v7IXe+EuaojcKMnRzq8pZn/4VTY1o2tAR6HPy+9f0DQaGdqhw9wmOHiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 Feb 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> FWIW I wish it were different, that git.git's `master` reflected more
> >> closely what the current Git for Windows version has.
> >
> > Well, we two wishing the same thing together without doing anything
> > else would make it happen.
> 
> ehh, would *not* make it happen, of course.

That is the reason why set aside a substantial part of my maintainer time
to upstream those patches. You may not see how much time it costs me, say,
to get the putty-w-args stuff upstream, but rest assured that I would not
be able to do this were it not for a company paying me to do exactly that.

> > As an experiment to see if our process can be improved, I've been
> > meaning to suggest (which is what was behind my "question at a bit
> > higher level" to Hannes [*1*]) asking you to throw me occasional
> > pull requests for changes that are only about Windows specific
> > issues, bypassing "patches on the list" for things like a hotfix to
> > js/mingw-isatty [*2*] and use of OpenSSL SHA-1 on Windows [*3*],
> > essentially treating Windows specific changes as "a sub-maintainer
> > makes pull requests" we already do with Paul, Eric and Pat.

The problem here is that Git for Windows is not a subsystem. It touches
pretty much all of Git. That is very different from the Tcl/Tk code, or
from git-svn (whose code is not shared by anything else in Git's source
code, despite the fact that it is written in Perl).

And even if you were to accept the occasional Pull Request from me, it
would not solve the even bigger problem that we essentially reject so much
expertise out there, so many potential contributions by very competent
developers who just have no desire to fight the contribution process.

> While this may ease the flow of upstreaming windows specific
> changes, we need a separate thing to address the on-going issue you
> raised in your message.  A Windows-less person would not know his

... or her...

> change to a generic code that is innocuous-looking has fallouts on
> Windows (read this sentence with "Windows" replaced with any
> specific platform name).  When somebody writes c == '/' that should
> have been written as is_dir_sep(c), you or Hannes often finds it
> during the review here, and after repeatedly seeing such reviews,
> that (slowly) rubs off on other Window-less folks.  A new code may
> still hit 'next' and 'master' with such an issue if it goes
> unnoticed during the review.

Apart from the fact that we have no prayer at coming up with a system that
keeps track of open issues (because we do not use any tracker, but instead
rely on people to remember that some thing still may not have been
addressed), there is a different problem here: you stated very explicitly
that it is okay for `pu` to be broken [*1*]. If it were different, if any
breakage would imply that a fix is really, really required lest the patch
series be evicted from `pu`, we could easily modify my Continuous Testing
setup to report more visibly what is broken. But since it is okay for `pu`
to be broken, that would just annoy everybody and people would learn to
ignore/procmail those reports.

> The CI you are setting up [*1*]

which *1*?

And... I already set it up. I just did not bother to make it more public
because the builds were broken more often than not. IIRC the entire month
of October was a solid red.

> may certainly be a step in the good direction. Having more people like
> Hannes working off of upstream may also be a great way to help the
> "forget 'next' and upstream in general" issue. Any other ideas?

The Continuous Integration is actually not so much a Continuous
Integration as it is a Continuous Testing. If it became more of a CI, that
would certainly reduce the impression that Git's bleeding edge only ever
works on Linux.

Ciao,
Johannes

Footnote *1*: You probably read between the lines that this is
unfortunate, in my opinion. It sets the mood that lets experimental (if
useful) features such as worktrees be broken for the better part of a
year.
