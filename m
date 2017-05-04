Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995E4207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdEDJrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:47:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:58137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdEDJr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:47:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MS5QA-1dTkmC3D5O-00TFOI; Thu, 04
 May 2017 11:47:18 +0200
Date:   Thu, 4 May 2017 11:47:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
In-Reply-To: <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705041129170.4905@virtualbox>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SBCy1JO3f0A/ztzOa4+rLC2j1Ty6OXeAFUn0scLZUd7QMI/Js2S
 xdFwkAzEYBM+2/USrr/HH9seO+bLI/5jXtoU/t3fdrHv/wyTgRLzXJl3CdXOmoyjb/TtXDG
 DKB7Ezxf93VNL7s7qOyKoUaHu/Tpz3sHVviHi3U33iIzusPcqnSa7WtzkZW6ZzoB23cJyZV
 767NstpX6bjZJF0WikF5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UWI6nyT4Xlg=:7KLuEoR4XSDwWIWUl4YH9i
 3tx4bRzZCmL+ShkNzrPbSK7Krzl0Ly5x0txcbJziW476KKmECoemDvjMp2E8v+auYjdqri03N
 um2z4skveCemvTJUdVDr6JIIzRozbk8MhfunDUxJA2Ytsoje4ZAsV7DhkqBrb2Jx10h/Nkqmn
 zN14EyJHB+nRu+0tUjObMwaO3VaAtFMT6MkxooWCRSLPqnNVXYtRQ+ZDGwmMnFexKJOASOkrk
 ci8PvDEpFwyV+MNzWrF05ZDXnP+dtLF0fb1VlMnZcQOPL3MiKUZa0UFsUDQZ40sTdooSa2DKu
 V6YZQeWmsBEuM/IsX+DKlqcib0PFqWU9q3a82/gwOuynQyOHfh+AJgAC43mpIV7EuNDrNRWiz
 ICInIfUc1rQ/hFc9sMjj32vfBSWACbMZFW9pNam417O6ed5cBVHtcck8bpR8t1jmA8uUFRXrR
 ZTbNpIXExGwwJINGqNjFs6elW4HUaeyVxPPV1tyIshh615kzIJEalxefkSA3Qyinnh+jRBS0i
 XlbtNsSGanReM6FVpQB/XngNejl7+rpe7wEo02jPIonezmKb0AxUpbshkb/LCGpptB8EcU40u
 xbax+Ub4EBDOZO9F3yHyJklL6B4/MRiY0pwxXZyD6qph9yfUxcLMFi7yDYxf6eMjMhQoZGt/M
 HUB/zHGru5cHbAZOwGkjz0GXvUEmFn1G1Gf9zmGg3GxvcJHMXCa3DcCFcYc6gwkiyX82snza/
 hxktAZBUI+WS3Qv3Ek2LrFROdjQ/jAkcbpsMFRyKAjV7FJacZAr/KitoLQGduJI5bTRVKRgLZ
 ebRgr9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > For starters, those files include shell scripts: the most prevalent
> > shell interpreter in use (and certainly used in Git for Windows) is
> > Bash, and Bash does not handle CR/LF line endings gracefully.
> 
> Good to know.  I am not sure if it is OK for shell scripts not to honor
> the platform convention, though.

Well, a couple of comments about your comment:

- we say "shell scripts", but we're sloppy there: they are "Unix shell
  scripts", as they are executed by Unix shells. As such, it is pretty
  obvious that they favor Unix line endings, right? And that they do not
  really handle anything else well, right?

- You try to say that it is not okay for shell scripts to be checked
  out as LF-only when the platform convention for *text* files is CR/LF,
  right? Please note that if you follow through on this thought, you are
  very close to recommending to render shell scripts dysfunctional by
  checking them out with CR/LF endings.

That latter point, to recommend to break shell scripts, is something I
really fail to understand...

> Stated from the opposite angle, I would not be surprised if your
> shell scripts do not work on Linux if you set core.autocrlf to true.
> Git may honor it, but shells on Linux (or BSD for that matter) do
> not pay attention to core.autocrlf and they are within their rights
> to complain on an extra CR at the end of the line.  IOW, I would
> doubt that it should be our goal to set core.autocrlf on a platform
> whose native line endings is LF and make the tests to pass.

See? I *knew* it was a mistake to follow Jonathan's recommendation to make
this "you can reproduce this even on Linux" comment part of the commit
message.

I *never* asked to make core.autocrlf=true the default on Linux.

All I did was to point out that you do not need Windows to reproduce the
problems.

That is really a far cry from trying to convince anybody that it makes
sense to require Git to pass the build & tests with core.autocrlf=true *on
Linux*.

I want to make it pass on Windows, yes, and I do not want to force anybody
with a Linux setup to get a (free) Windows VM to test this. I want it to
pass on Windows, and to make it easier for you Linux-only folks, I tried
to give you a way to start validating my claims that core.autocrlf=true
was introduced by Git without even bothering to let Git itself build and
pass the test suite with that setting.

> > Related to shell scripts: when generating common-cmds.h, we use tools
> > that generally operate on the assumption that input and output
> > deliminate their lines using LF-only line endings. Consequently, they
> > would happily copy the CR byte verbatim into the strings in
> > common-cmds.h, which in turn makes the C preprocessor barf (that
> > interprets them as MacOS-style line endings).
> 
> This indeed is a problem.  "add\r" is not a name of a common
> command, obviously,

Please note that it is not "add\r" that is part of the common-cmds.h file
as generated by current git.git's `master` with core.autocrlf=true. I.e.
it is not the sequence containing a backslash followed by an `r`.

It is actually "add<CR>", which the GNU C preprocessor interprets as a
line break in the middle of the string constant (most likely for
backwards-compatibility with MacOS, where line breaks were indicated by
Carriage Returns *without* Line Feeds).

> regardless of how the text file that lists the names of the commands is
> encoded.  I am undecided if it is a problem in the source text (i.e.
> command-list.txt is not a platform neutral "text" but has to be encoded
> with LF endings) or the bug in the tools used in the generate-cmdlist.sh
> script, though.  Shouldn't the tools be aware of the platform convention
> of what text files are and how their eol looks like?

I wonder why we spend so much time on discussing this issue, really.

Clearly, command-list.txt is *intended* as input for scripts. We do not
ship the file verbatim to the end user, we only pass it through sed to
generate common-cmds.h, we pass it through sed to verify the completeness
of the docs, and we pass it through the Perl script
Documentation/cmd-list.perl to generate certain command lists intended for
inclusion in the man page.

In all cases, we expect to feed the contents of this file to Unix shell
scripts and/or Unix tools.

Is it so unobvious that the input should be crafted to fulfill that role
as best as it can by catering to Unix tools?

And if you truly think that we should use different tools based on the
platform, then you will have to swallow the rather large pill that Git's
own very heavy use of Unix shell scripting was a big, big mistake from the
beginning.

I doubt you are ready to accept that yet...

Ciao,
Dscho
