Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE74B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbeKNXXi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:23:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:59449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbeKNXXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:23:38 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNIi1-1gPQ3m0dth-006ybd; Wed, 14
 Nov 2018 14:20:19 +0100
Date:   Wed, 14 Nov 2018 14:20:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] tests: do not require Git to be built when testing
 an installed Git
In-Reply-To: <xmqqa7mcp80u.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811141417160.39@tvgsbejvaqbjf.bet>
References: <pull.73.git.gitgitgadget@gmail.com>        <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com> <xmqqa7mcp80u.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j/Av4Fs1sNqf7qkzjnmKU8IhPuNR+bqp/psH148130y1utcYJ67
 io0/ZgpC6PGuurRqjNDESSJIGbRqeQ1jJJp9jib+GC15zs/YYJ2vEOHtLkNZNYlt0AiKodw
 7dpGrO6oysXMsAtJBoSnok/ijFpR7wk7Kn172D6HonzA1PfiOe7Ejm/suqxL83jwRmGWf6C
 pmJNLbD6OPrl/bPDQ56Nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YjP4yHlXdNw=:QDX2YMaUXhgr25lqQ2gAjn
 ZYHPSWegGFZ6dpa/M2JzbjBnApuPE1mU+r/3pXDpHiGVGD+9Z7Zh3g8g6OtEkBBelFcK6xhpO
 wj/NF+blvnOa3Ryl+QBBtMHDwam6+f5LUfsqmwxfqGJr701w3dwyuzJm1rZN1owSDJ1PjYN25
 zcRjqJZCU/ZDr8TEzPGrPhK5KeldEGGn+QqPg1AlUpWbpt3JuANwEwkvKYBqrM+lJe5CEmtyV
 dwJCoioHHCKA8cT9UkObIEcmdpG0dlPSVMoMG6G74rwqXGLiPjd4lMw4h326dseOmKegTDjL/
 gs7nMGuC5TZSM9bXVy3Psgtvyry7DYVaOgnR00ibpgF1YBez1UG8rukJbOC9UFkXwqQSaLvnD
 eOEDvoDvUzP9NbRhzmQGRooxXfNVK5l9Vwk6t4YqmqPKxPyxg0f8bSzzTnyX3XXERtUkNfCwV
 yYOTV2EhMe/yQ8HSlQ47CxWy5p6Hxx2j5hmUiVJ4U1eS0yKHFfESKX3Fp8tSTu0h0XR/hK03z
 zEYQGuRYzx9DBLP3Igi+jCSoHsaYwcZSAsfTtYF7GHT17MwqdcuSyoojNu5f+47CXQx46AcWk
 YYgBmApg9jxjDt7hqJvh0qgAMfmWsyGdEmnbLitoPexGojYQD32ArpAUtrPokVCXe1VqAf2QC
 /x760AiM1VnA3R3DMoev+ux5xt3INuJjsi4Fg2j9WY8zJ424r6rZqFbInDxiQvlhMmB7jWISY
 37GIs2fnK6DVx+FmfZNKOqSsbnwvyLMcbqB5u/TAhc+smCgge7bWZdztHlKbbA391LsXdJuVx
 btBJ4+u3RJBdeDq1ql91Z1g9pxALLlLeqqfDxXV08qX5A8tFf1GNCRVDAn31U+/V6dpGLui9n
 4VihSUcdx9KGCt/TFHZRLxohStmT16axXTdBPtBAL3PukwcSfTjdMwc7oDGHMtN1ahK4LdWG/
 11VXdWLOxag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We really only need the test helpers in that case, but that is not what
> > we test for. So let's skip the test for now when we know that we want to
> > test an installed Git.
> 
> True, but...  hopefully we are making sure t/helpers/ has been built
> in some other ways, though, right?

We do it implicitly, in the test cases that use the helpers.

However, t/test-lib.sh does not particularly verify that the test helpers
have been built.

And I think that is a good thing: we do have several test scripts, I would
think, that do not require any test helper to begin with. These scripts
can work pretty well without having to build anything (read: on a machine
where there is not even a toolchain available to build things).

Besides, it is pretty much only t/helper/test-tool these days, and it is
unlikely that anybody has a `test-tool` in their `PATH`. If they do,
they'll find out soon enough iff they test with `GIT_TEST_INSTALLED` and
iff they do not have the test helper(s) in t/helper/ ;-)

Ciao,
Dscho

> I do not offhand see how tests would work in a pristine checkout with
> "cd t && sh t0000-*.sh" as t/test-lib.sh is not running $(MAKE) itself
> (and the design of the test-lib.sh, as can be seen in the check this
> part of it makes, is to just abort if we cannot test) with this patch
> (and PATCH 1/5) under the test-installed mode, though.
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/test-lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 832ede5099..1ea20dc2dc 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -51,7 +51,7 @@ export LSAN_OPTIONS
> >  
> >  ################################################################
> >  # It appears that people try to run tests without building...
> > -"$GIT_BUILD_DIR/git" >/dev/null
> > +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
> >  if test $? != 1
> >  then
> >  	echo >&2 'error: you do not seem to have built git yet.'
> 
