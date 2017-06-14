Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D562220282
	for <e@80x24.org>; Wed, 14 Jun 2017 12:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdFNMwI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 08:52:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:55041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNMwH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 08:52:07 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZG7-1dCdQr2NCl-00RL6n; Wed, 14
 Jun 2017 14:51:58 +0200
Date:   Wed, 14 Jun 2017 14:51:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
In-Reply-To: <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1706141446370.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:alBgpGhzxeztT0cL8PE0hFakuIq6nqu71Y9F8pZdKM1S3oUXNDy
 RH5/XjWl+f4yeb5mOVDlE4EwgD5AHgo/04Ef+dhPRyIr/J9zkyA59KJBufU0IsK+HguVuvQ
 y5crJKTKEz/kNFqwonMEyUwMflhFs24eP5HyxUZna3jC5uZHaYiPy62oyQgaQ/M3sMF0NW/
 15A3t5xR5YFQuU3KhPy1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gYfl/2rKPrU=:ODUJBQp+bEBcmNoVGwUDEP
 pDM6SJ7a9QeWTWQN5RTvVT2yzV8GvrfpmmzlLrhKGUf6QHK1iS8vBHZ2kn7lkj2xmkzB2/1WA
 5wkT6wkIDm1ObE9nATSkXHQyD7hzEZrOVFD2IgViGe2VcBnFK+4vICAlQXJF9UijhHfRgUJTG
 MQgn+575L39MWsBTJYIw/FBt7XFyGr/5R5k/iBLmXXC4PeiBDuQBlbcKsSVQOJowWtGvjsNAu
 iN2PU8dRKKRVu9MBXvonfJaLBxCQ6/r2+0a9Ql0mrMMdijBju06EsDjzKQznKhNS0KMXnCoMi
 zmzbO1mSMer15mubHVKQVtViZaoGpSxuycl5bN4bxKM4iLYLhB14pOqMbPWSl2O2XFCdy4bf5
 9vM60OwmAdecxydagDGRX77ffmjDPGanhLv+5bSO408EbGbDYBLb35gEIMJsQMriqIMFZmxfn
 L0nN7xlqtrL1yIf/wrC7kLBKRd704Vsz4QMZ8+1gFY7Dokl/6cgfCwboF4wzsqb7pbhVB++9A
 TGwTAmVlA1qXBsZeigEjVBRFO/szhrIIYecXT8OS8M6PGyGCEIf7Yi2BcYkiOFwuZ8mi6m/qF
 gi9qfcCaS2WMx6soqbwYoogSbf9QiA2tGeY7ghSYHMLI0G9lyKwkNMeeAqTzvRUZbS8KfxtD4
 ABnT5HBrUKtoUc5i04e3vkZM8D8zYY7Yyej6M6hf1NBtrhwiymxikD1ZLrcMqUAku24YCytg/
 Chhc7TnsUeZEYDngctUZwZDBw3N7L0UAPU2g8yoAZr76HFuxWReFLDT/LnbXQkn3iK81Udb3s
 akxHrCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 7 Jun 2017, Phillip Wood wrote:

> On 01/06/17 13:56, Johannes Schindelin wrote:
> > 
> > On Wed, 31 May 2017, Phillip Wood wrote:
> > 
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> Check the console output when using --autostash and the stash applies
> >> cleanly is what we expect. To avoid this test depending on commit and
> >> stash hashes it uses sed to replace them with XXX. The sed script also
> >> replaces carriage returns in the output with '\r' to avoid embedded
> >> '^M's in the expected output files. Unfortunately this means we still
> >> end up with an embedded '^M' in the sed script which may not be
> >> preserved when sending this. The last line of the sed script should be
> >> +s/^M/\\r/g
> > 
> > Like Junio pointed out, this sed script would not be portable. To
> > elaborate: there are two major variants of sed out there, GNU sed and BSD
> > sed. Typically GNU sed allows a little more powerful instructions, e.g. \t
> > and \r.
> 
> I'm confused by this as my script does not use the escape sequence "\r"
> out of portability concerns. It has a literal carriage return as you get
> from typing Ctrl-Q Ctrl-M in emacs or Ctrl-V Ctrl-M in bash which I
> think should be portable and replaces the carriage returns in git's
> output with the literal string '\r'. I did this so that the expected
> files don't have control characters in them that mess up the display
> when you cat them or read them in an email client

Junio elaborated elsewhere what my main concern is: while a literal
backslash followed by a lower-case r may be unportable, a plain CR byte is
almost certainly unportable.

> > Taking an additional step back, I wonder whether we have to hard-code
> > the commit IDs (or XXX) to begin with. Why not generate the `expect`
> > files with the information at hand? We can simply ask `git rev-parse
> > --short`.
> > 
> > For the stash's commit ID, there is no record in the ref space, of
> > course (because it was created with `git stash create`). But I think
> > in this case, it is legitimate to simply grep the output.
> 
> That's a good approach to handling the stash hash if we want to generate
> the expected files from the test script

I would strongly favor that, especially since it would make the transition
away from SHA-1 easier rather than more difficult.

> > That way, the test would be precise and resilient.
> > 
> > So for example instead of adding the t/t3420/expected-success-am verbatim,
> > you could generate the output via
> > 
> > 	cat >expect <<-EOF
> > 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\\$" output)
> > 	HEAD is now at $(git rev-parse --short HEAD~2) third commit
> > 	First, rewinding head to replay your work on top of it...
> > 	Applying: second commit
> > 	Applying: third commit
> > 	Applied autostash.
> > 	EOF
> 
> This approach works well for the cases where there aren't control
> characters embedded in git's output, but for the interactive tests there
> are so we'd end up with control characters in the test script which I
> wanted to avoid or doing $(printf '\r'). I steered clear of generating
> the expected file in the test as i) it was more work (both for me
> (rebase --merge has a few commit hashes in it's output) and when the
> script is running) and ii) it's a bit messy to implement given the way
> the tests are structured in a helper function that's called with a
> parameter indicating the type of rebase to test.
> 
> I can go ahead with generating the expected files from the script if you
> really want but I wonder if changing the test to generate the sed script
> with printf as below might be a simpler way to mitigate the carriage
> return problem, though it would be less strict than generating the real
> hashes with rev-parse.
> 
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -189,6 +189,16 @@ test_expect_success "rebase: noop rebase" '
>  	git checkout feature-branch
>  '
> 
> +test_expect_sucess 'rebase: create sed script to sanitize output' '
> +	printf "\
> +s/^\(Created autostash: \)[0-9a-f]\{6,\}$/\1XXX/
> +s/^\(HEAD is now at \)[0-9a-f]\{6,\}\( .* commit\)$/\1XXX\2/
> +s/^[0-9a-f]\{6,\}\( .* commit\)$/XXX\1/
> +s/\(detached HEAD \)[0-9a-f]\{6,\}/\1XXX/
> +s/\(could not apply \)[0-9a-f]\{6,\}/\1XXX/g
> +s/\\r/\\r/g" >$TEST_DIRECTORY/t4320/remove-ids.sed
> +'
> +
> 
> Let me know what you think,

I'd rather generate the expected output. If there are control characters
to be embedded anywhere, we have good prior art to do that: see the
q_to_nul(), q_to_cr() and q_to_tab() functions in test-lib-functions.

If you still think that it is too daunting, please point me to a branch
(you're on GitHub, right?) and I can try my hand at a PR.

Ciao,
Dscho
