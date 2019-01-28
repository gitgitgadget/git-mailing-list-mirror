Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E0B1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 22:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfA1WpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 17:45:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:44187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1WpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 17:45:15 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkfii-1hMCtE35hU-00aRWM; Mon, 28
 Jan 2019 23:45:08 +0100
Date:   Mon, 28 Jan 2019 23:44:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 18/21] t0061: fix with --with-dashes and
 RUNTIME_PREFIX
In-Reply-To: <xmqq36pdcz3o.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901282337550.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <d613c79aff9c65ab9c3723a876c99e6f35a2f133.1548254412.git.gitgitgadget@gmail.com> <xmqq36pdcz3o.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mhMm+wYQPEPne91IqTK8r0PnFY4aDpag2HYFPfP3EsSUR9Y/eTJ
 fcJoO5MhSLZBcvnDEjx7jBLtRCjPWTY9QTmytwc2jCZvTZ770f2MUJRHXkETouhcH8s08rw
 sr5IIebWnEIr6Kinq9+uKd+qs/9ws4n6J5lRSorYmCqUo2hKTHXVsQYVqJo9qlKUQbRYl5h
 nZTcPixA0Uqgr7CU+reHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RP5fZjNtrpE=:gcwCP0wRDzji/Fm1+GkpNW
 EHQa/ajpbl+j4D4Wfck9nUzUVtd3ds26+RM7BEqEqyFQiHPva57mFV+01eXr1g6qlT5/L6ctN
 v0C5w8cxVuvOXBQEhk2Afd5tD3B8r34oCxxYuWmXOk0n3JTL12tRTMtKVBwDdbNAsXuk3YW6q
 epNahXKevkqiW+OFW/3eUyDlmqqK+mbppXatsqjB6m9uT2IpUyZdBGZfyA+JYvZrGQ0OlyrZ6
 bq/APu4+oiZn8bciwblNv+5EVcbBotmA8nj2jsWDjhyoobU+HVOUsV0Ta+nyrFhUR6fL6/39k
 a7OTuDdEoGL5gnnT67631u+zc4kIw3RNCH1yJ7rhs4qPFYtffAPKEvwsylu4uXD38j1eDcPyG
 4MahnewvpM6VxyBgT/Qy2Aa9cW21Nq9eH8PEvoJgmW5dUsbeCrTp0+TX4fe8DQV1AiCeTPiE3
 8NZO1C9HrnJ1a+OKJvsulk5+UbgvmCPUo1anAJqoAgpymQYA4rbCldBDIo4yZk2Lg0tt0pTcE
 8T5kH7iRht5utmKwV4Y0Jo9sGhDb4sQcLlVHEbU8rX9d0EvwXDuMKfEK+Mk6Ak8B48T9r2EfI
 kH8dzblNRUZ60J88mNeYIsptHMUQAXwPthI6d+AEWfuHddq0tGvE1hjJIB1as4hBfrfsr6NjJ
 MksWQmnk8PWwZfeSdCCwStlrR+XHOJ8ghgMaKfHKyyjFBZVJHxQh9sBNITY1tx3JvRXJvRyrz
 P+140vyYPso4+JcLwwsgrIkuRkr2QAKIsTw3EshqarsTYI3vTr9NdoAfS3GEJYVADqT8ZVOfY
 NHZBdqVXFsJ9HzsbIEzYAu7MH2Hs73fMPZAOkhlFyubddmYBAWvnsjjmxSz2/DRsGe6ySn7bA
 znUEIQPFqBtITR7nUiio23/YoGz5jKBjKaOUnuUS6VJJ7j1BKNEU4NPbWyNKV8DkknYVuDCCI
 wvFTIpQg3JA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 27 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When building Git with RUNTIME_PREFIX and starting a test helper from
> > t/helper/, it fails to detect the system prefix correctly.
> >
> > This is the reason that the warning
> >
> > 	RUNTIME_PREFIX requested, but prefix computation failed. [...]
> >
> > to be printed.
> >
> > In t0061, we did not expect that to happen, and it actually did not
> > happen in the normal case, because bin-wrappers/test-tool specifically
> > sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
> > to know about the runtime prefix).
> >
> > However, with --with-dashes, bin-wrappers/test-tool is no longer called,
> > but t/helper/test-tool is called directly.
> >
> > So let's just ignore the RUNTIME_PREFIX warning.
> 
> Two questions that would come to the readers' minds are
> 
>  - Why "it fails to detect the system prefix correctly"?  Is that a
>    bug waiting to hurt end users?

I recall explaining that already in a different thread (one that actually
*was* about the RUNTIME_PREFIX feature, where you asked why we cannot test
for it in the test suite): to verify that we are in a valid Git
installation location, we verify that the `git` executable is either in
`<PREFIX>/bin` or in `<PREFIX>/libexec/git-core` (we need to check that,
as the prefix is the parent directory in one case, and the grand parent
directory in the other).

And for Git's test suite, we simply do not control the name of the
directory in which the Git executable lives (think: `git clone
<git.git-url> junios-git`).

And even if we could control that name: it simply is not a valid
installation location. For example, it is unlikely that the translation
live in `../share/locale/de/LC_MESSAGES/git.mo` relative to the Git
executable.

>  - Why is it better not to bother fixing that failure?  Is it
>    because this happens only in the test helper and won't hurt end
>    users?
> 
> I do not mind this particular "sweeping it under the rug" if the
> rationale is "it only is the strange set-up of test-tool that causes
> it, and we shouldn't burden the code shared with the actual runtime
> to compute runtime prefix just to fix this bug".  I do think it is
> not productive to bend backwards if it is only done in order to work
> around unusual setup in the test helper binary and I do agree that
> ignoring the warning is the right solution.
> 
> I just do not like to see that our commits do not explain why we
> chose to ignore, instead of "fix", the issue.

But that was clarified already to your satisfaction in the RUNTIME_PREFIX
patches. Or do you want to reopen that case now?

Ciao,
Dscho

> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0061-run-command.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> > index 99a614bc7c..5a2d087bf0 100755
> > --- a/t/t0061-run-command.sh
> > +++ b/t/t0061-run-command.sh
> > @@ -166,7 +166,8 @@ test_trace () {
> >  	expect="$1"
> >  	shift
> >  	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
> > -		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
> > +		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
> > +			-e '/RUNTIME_PREFIX requested/d' >actual &&
> >  	echo "$expect true" >expect &&
> >  	test_cmp expect actual
> >  }
> 
