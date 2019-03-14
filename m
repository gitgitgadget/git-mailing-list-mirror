Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8387B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 22:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCNWpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 18:45:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:36581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfCNWpf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 18:45:35 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfYqz-1ggVln04i1-00p8uK; Thu, 14
 Mar 2019 23:45:26 +0100
Date:   Thu, 14 Mar 2019 23:45:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: regression in new built-in stash + fsmonitor (was Re: [PATCH
 v13 11/27] stash: convert apply to builtin)
In-Reply-To: <87d0mtbh1w.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903142058130.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-12-t.gummerer@gmail.com> <87ftrpbnkg.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
 <87d0mtbh1w.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2128955567-1552599805=:41"
Content-ID: <nycvar.QRO.7.76.6.1903142341160.41@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:PAASw7daiUIwRw6v2CSMxwwCsfeKSAne3UQgvZiQVOu8+cibZto
 jcMqxJZRCdqri0M2dA26ln0GbQ4UKhXMbhOIYC65IU/Il+rjE4H1MCWhLlCIHTd68QUwU5e
 2WQWQ8zToXcQsfkpaaPrYjVsU4cqfa/c+2YPU2TQ5K+mmTg2Vqn6lTlN6+Da062Bc+1KuLo
 IiINmPm7+r/77GA6hsySQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cp3bPDmrL1U=:J5mkkm4hgDXiOBhVQ5IdPG
 NAXtgCuOdEvObE0jKAa8PzXpXwqnLmkgYMbZVyWfNnsHsZeGh+OgQs1ZyiN+ZzAAti56/9K+M
 h3I0OXdQRK8lv39aiRdAFvuolgJCr3wkBqo9Zmo2W/NYVCcomM8+MIlEf5V6U+hNybwk+yBc7
 fg2bJVqi9/uBh7qeVeai0nuXtOJhRTVBLwsbFhxDBTbIxuRoBrD/232NqP10LYnSIgJL/JcoX
 K2MmEWWGjM/N2pTWOYvanQCIgdhqGCVXeJtZY+nhYMnKW/zXrdX8pBJItGr+1XzoCCyij8gG7
 ly9Gco7AbdtCqiuPArPInVdtQYVZgx17/Qlu8+qdMp4BPwDoxK3rAHciptOKAe/tT9AIoLQwn
 AouUSYBii3uEio6eJOGSA8LtXuuZ84T3V1NDek5cBcyCB5ekyUDGsZM5qpjwf01R5SkTbe+bR
 LnvVOFr4emoXR2ex8Rq3inL+1xNmWukzomdmMAKT/Nol1k+suEIF/N6fX62eyrnXejeXSerwR
 noB4NqNbQsXxxPkBVUWtOjZAHCnjdono839Zzy5kkA5xTyc2/doQ7SRnnmifEh8UgLD+1R9b4
 WaVsQkHfkPN7mHt3bQfRNDPkiF54MjdlG30xA+8V4QFfiJ7/6EIl0UsiTSfnkfMjYRV0JAJdn
 VxwilYWTI8Rv5RhHEdmdV1jlDcxfF8yLZU7fedU1XZkKt5VfS2vfK3kXahNhdCioNRx/9daCx
 GMbHl40kDrX29p93tHOIGxyEYgn1PUYRpbSAHjOuRmv9sfVyh/DF5K2bZZK+vZPe29BmjUJW1
 +Aj4Cjn2DH53E90GVd98FlP7g1yvhFKORK6Y2sqaDaoecCMnxVEYwEucWAeGXyx96tgNHduS7
 m3eNgXaed4tFOysspwi/tGuG9Ek80Pg5WE8z0pgDaMpxlp0hRDENaRy91HBsrPi2mv78r14R1
 gPRfNzJtIBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2128955567-1552599805=:41
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.QRO.7.76.6.1903142341161.41@tvgsbejvaqbjf.bet>

Hi Ævar,

On Thu, 14 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Mar 14 2019, Johannes Schindelin wrote:
> 
> > On Thu, 14 Mar 2019, Ævar Arnfjörð Bjarmason wrote:
> >
> >> On Tue, Feb 26 2019, Thomas Gummerer wrote:
> >>
> >> > From: Joel Teichroeb <joel@teichroeb.net>
> >> >
> >> > Add a builtin helper for performing stash commands. Converting
> >> > all at once proved hard to review, so starting with just apply
> >> > lets conversion get started without the other commands being
> >> > finished.
> >> >
> >> > The helper is being implemented as a drop in replacement for
> >> > stash so that when it is complete it can simply be renamed and
> >> > the shell script deleted.
> >> >
> >> > Delete the contents of the apply_stash shell function and replace
> >> > it with a call to stash--helper apply until pop is also
> >> > converted.
> >>
> >> This
> >>
> >>     GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all ./t3420-rebase-autostash.sh
> >>
> >> Now fails, which bisects to 8a0fc8d19d ("stash: convert apply to
> >> builtin", 2019-02-25).
> >>
> >> Tested on both a CentOS 6 & modern Debian testing machine:
> >>
> >>     + git rebase -i --autostash HEAD^
> >>     Created autostash: 5cd734b
> >>     HEAD is now at 0c4d2f1 third commit
> >>     hint: Waiting for your editor to close the file...
> >>     error: There was a problem with the editor '"$FAKE_EDITOR"'.
> >>     Applied autostash.
> >>     + exit_code=1
> >>     + test 1 -eq 0
> >>     + test_match_signal 13 1
> >>     + test 1 = 141
> >>     + test 1 = 269
> >>     + return 1
> >>     + test 1 -gt 129
> >>     + test 1 -eq 127
> >>     + test 1 -eq 126
> >>     + return 0
> >>     + rm -f abort-editor.sh
> >>     + echo conflicting-content
> >>     + test_cmp expected file0
> >>     + diff -u expected file0
> >>     --- expected    2019-03-14 13:19:08.212215263 +0000
> >>     +++ file0       2019-03-14 13:19:08.196215250 +0000
> >>     @@ -1 +1 @@
> >>     -conflicting-content
> >>     +uncommitted-content
> >>     error: last command exited with $?=1
> >>     not ok 36 - autostash is saved on editor failure with conflict
> >>
> >> Are you able to reproduce this? And if so I suggest running the test
> >> suite with some of the other GIT_TEST_* modes documented in
> >> t/README. Maybe it'll turn up something else...
> >
> > Yep, totally can reproduce it :-(

Well, isn't this exciting: we found not a bug in the built-in stash (even
if Junio probably expected yet another one), but an fsmonitor one! Even
better, I think this might be the bug that Alex Vandiver was chasing and
that he talked about at the Contributors' Summit last year in Barcelona.

The symptom is that cache entries are sometimes considered up to date,
when they really are not.

And the reason is that the fsmonitor has this honking global flag
`has_run_once` (it is not really global, it is `static` to
`refresh_fsmonitor()`, but that's the same for all practical purposes, as
it is *not* specific to one `struct index_state`), which was kind of okay
as long as `the_index` was used implicitly by everything.

Except it was not okay when `discard_index()` (or `discard_cache()`) was
called: in that case, the flag was not re-set. And re-set it needs to be,
in that case, otherwise the fsmonitor is not asked which entries need to
be updated.

I saw this pretty early on in my investigation and marked it up for a
follow-up task, wasting hours of investigation by not believing that this
could be the culprit of the bug you described. I did not believe it
because `git stash apply` is *spawned*, so there is not even an index that
needs to be discarded (I thought; more on that one later).

It is quite curious that this is the only occasion that our test suite
covers that particular part of the fsmonitor...

I do not really want to rely on implementation details of the rebase to verify
that the fsmonitor is queried again (and, crucially, resets the
FSMONITOR_VALID flag of the file(s) indicated as out of date) after the index
is discarded and re-read.

I guess the best bet is to extend `t/helper/test-read-cache.c` to optionally
output information about a specific cache entry, then refresh it, and then run
that test helper with fsmonitor-all (which should mark anything as modified,
all the time). That should verify that the fix works.

I did exactly that, and pushed the result to https://github.com/dscho/git
as `fix-fsmonitor` branch.

Could I ask you to test that one (it is based off of Git for Windows'
`master`, but that should compile cleanly for you)?

For now, I am a bit spent, so I'll leave the rest for tomorrow.

> In the meantime I did a build with "next" (so stash-in-C) using the
> standard test mode and these:
> 
>     (cd t && GIT_TEST_GETTEXT_POISON=true /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS="t3404.8 t3420.36" /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_SPLIT_INDEX=true /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_FULL_IN_PACK_ARRAY=true GIT_TEST_OE_SIZE=10 /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_COMMIT_GRAPH=true /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_MULTI_PACK_INDEX=true /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_STASH_USE_BUILTIN=false /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
>     (cd t && GIT_TEST_CHECK_COLLISIONS=false /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
> 
> Only this specific test failed.

Well, good!

Thank you for getting the ball rolling!
Dscho
--8323328-2128955567-1552599805=:41--
