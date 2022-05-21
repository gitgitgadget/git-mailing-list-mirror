Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF2C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 21:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbiEUVnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiEUVnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 17:43:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB30369DA
        for <git@vger.kernel.org>; Sat, 21 May 2022 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653169379;
        bh=BSTR/7YFiH1VZ2oNybWA1hLfeMy/e73PWDSvliwBOBA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MREl8tKFDNlZFMbGjokGb6Dc4ohGDZVdJ22IMXzNgIz3Vid74YideQDVdqjiKFWlr
         6FSIP4RD6IlNy+sVLgK8q35M3x+f+5UFJhj8QBmZ54px4iVp2SCU5szCcXk871bdl5
         nAQIY4MDq4PVniNPMMVb5lte7d0Vj2R/fP5OQv3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1o7Zow21ov-00K6g3; Sat, 21
 May 2022 23:42:59 +0200
Date:   Sat, 21 May 2022 23:42:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Victoria Dye <vdye@github.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
Message-ID: <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1369221152-1653169379=:352"
X-Provags-ID: V03:K1:cfxBLY2fPMuak/7FB9F2PHoTBlXUXGcZiT+RytvSrITqcHBgQxM
 h/6sJwdfpR1r1stI/gJ4yzluZZ28zRGp5veiM06xjj+aRrIK2m3z6vsgssBFhIBM3Azno+w
 Cy4hah/kb0CMkjLXzmk8GXpFYyhzApGQxqhNu9pjuiCYQA5RpYKpaUFgKmaQCC7n6A5Ctnf
 6ejq5FCbUfDe0+boGdmmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KW8Pyd6HxZ8=:9BxH+R07phRP//9AjkSEwQ
 OyspUlxJhHRQUeVxwH3HcwIqhnw5Dg2TCMV3yWax6h4FGBAQVztWCvrj+U+IUlVMaQXyzxT6a
 8W+Tycs4UcykP+TLaURfQ9lt+9L4JfAimlXjmBSFQ7GLr3GeRsQ2XGZCVZ+QChpfwvNvDAYN2
 pV/OfrUdDZ0sedQFMJZvi9dmsEzkZQnKWerbJ25qHf6fBL554dQnoc7ZkHRCh18SpSVGqxhjt
 g+hudHyRI2tDbarTVSsgB9avfo3lyG6UetmhlEG88G4hrI/dLSqfaJUPNrvRvfmvMOgvwHlyL
 nT2vRld6/Q0PMo9HbfCIqRKn2mwjLP+kUDsVKiKk5ACjiKWRJPv9Nsej/znbq54FFI1AIlW0I
 hcf2GrzQiUyItRKdUYmuz3JXZ1YlPxA7i2dKbNWO92gvyRy5jFsFTlHrYEjGFKqCmC8TBcqHE
 Lv8nXLAGmY10uBdVE7HK3sUqV2UhxcGPbkzjMgo2RFdmwmL2JXdVBaJfPlutN9bBNXHKPMj9y
 vKh9ci5iUZn5GgAm5H97+FlZVoHwTucMflKxS83ggZV2Jb7IHzPZBxtXgREtwa/dhTdY0ZLef
 V+tQrTBoonOqyrkjQsuSiUoTVPcWgFPIMnfoVh0QTIPCHw8s0hjwAFHocxzF6r+QB5DcOP3z9
 El7BumFDEUqX8X7maahx7EptYm1lU/sajbrDGFzih/LMXyzE50bfnia0nAPowvKQUmCCARg25
 thYx2pBn12t+/4Vz/ZEoU/k8rX9AxFFxHTQ1oAqVhfqUhOB/bZdLGT1djCtqojcLmc9s4R6+0
 UoUkJkGO7rRiAQ79uVTRRVJr9hDYHI63EgjEkWqS0p5Gy6PXZgCaOAOVjJSMjny9NCsuQmfu8
 ip5pV/ckBwMQyuD1CV3py7qOkSmd3XDaqc0JFif6GxVG6oY/1AAg+77z/XOaRDDQ+ZW3dirgP
 8lu0fBJ3gdourytre9pfLykWG1OnHafhmFMU6shnCq9hNmxFIey6srEDK0EKeKd1KouQjiaQx
 5mnMpb8zzy8SOxe4sp1wGwhZy2AqapnA6HkRuoxnxmZgXZiIxjGXo6Ee/yKqGqJuKwOouJJom
 7WAnGlRWTOHDG1veCSQIEZ1c8O1iai1y/NKA92xZb0wicvMybBMYZJP6Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1369221152-1653169379=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Victoria,

[sorry for the long delay, I was being pulled into too many directions,
but am incredibly grateful for your fantastic investigation.]

On Thu, 24 Mar 2022, Victoria Dye wrote:

> Johannes Schindelin via GitGitGadget wrote:
> > Changes since v1:
> >
> >  * In the patch that removed MAKE_TARGETS, a stale comment about that
> >    variable is also removed.
> >  * The comment about set -x has been adjusted because it no longer app=
lies
> >    as-is.
> >  * The commit message of "ci: make it easier to find failed tests' log=
s in
> >    the GitHub workflow" has been adjusted to motivate the improvement
> >    better.
> >
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Recent patches intended to help readers figure out CI failures much qu=
icker
> > than before. Unfortunately, they haven't been entirely positive for me=
. For
> > example, they broke the branch protections in Microsoft's fork of Git,=
 where
> > we require Pull Requests to pass a certain set of Checks (which are
> > identified by their names) and therefore caused follow-up work.
> >
> > Using CI and in general making it easier for new contributors is an ar=
ea I'm
> > passionate about, and one I'd like to see improved.
> >
> >
> > The current situation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Let me walk you through the current experience when a PR build fails: =
I get
> > a notification mail that only says that a certain job failed. There's =
no
> > indication of which test failed (or was it the build?). I can click on=
 a
> > link at it takes me to the workflow run. Once there, all it says is "P=
rocess
> > completed with exit code 1", or even "code 2". Sure, I can click on on=
e of
> > the failed jobs. It even expands the failed step's log (collapsing the=
 other
> > steps). And what do I see there?
> >
> > Let's look at an example of a failed linux-clang (ubuntu-latest) job
> > [https://github.com/git-for-windows/git/runs/4822802185?check_suite_fo=
cus=3Dtrue]:
> >
> > [...]
> > Test Summary Report
> > -------------------
> > t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53=
 Failed: 1)
> >   Failed test:  49
> >   Non-zero exit status: 1
> > t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 F=
ailed: 0)
> >   TODO passed:   45, 47
> > Files=3D957, Tests=3D25489, 645 wallclock secs ( 5.74 usr  1.56 sys + =
866.28 cusr 364.34 csys =3D 1237.92 CPU)
> > Result: FAIL
> > make[1]: *** [Makefile:53: prove] Error 1
> > make[1]: Leaving directory '/home/runner/work/git/git/t'
> > make: *** [Makefile:3018: test] Error 2
> >
> >
> > That's it. I count myself lucky not to be a new contributor being face=
d with
> > something like this.
> >
> > Now, since I am active in the Git project for a couple of days or so, =
I can
> > make sense of the "TODO passed" label and know that for the purpose of
> > fixing the build failures, I need to ignore this, and that I need to f=
ocus
> > on the "Failed test" part instead.
> >
> > I also know that I do not have to get myself an ubuntu-latest box just=
 to
> > reproduce the error, I do not even have to check out the code and run =
it
> > just to learn what that "49" means.
> >
> > I know, and I do not expect any new contributor, not even most seasone=
d
> > contributors to know, that I have to patiently collapse the "Run
> > ci/run-build-and-tests.sh" job's log, and instead expand the "Run
> > ci/print-test-failures.sh" job log (which did not fail and hence does =
not
> > draw any attention to it).
> >
>
> You can count me as one of the ones that, until this series, had no idea
> this information existed in the CI logs. And it definitely would have be=
en
> helpful in figuring out some of the OS-specific bugs I've run into in th=
e
> past. :)

Excellent. I think I have enough accounts to consider it a universal truth
that our CI output _needs_ something like this here patch series.

> > I know, and again: I do not expect many others to know this, that I th=
en
> > have to click into the "Search logs" box (not the regular web browser'=
s
> > search via Ctrl+F!) and type in "not ok" to find the log of the failed=
 test
> > case (and this might still be a "known broken" one that is marked via
> > test_expect_failure and once again needs to be ignored).
> >
> > To be excessively clear: This is not a great experience!
> >
> >
> > Improved output
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Our previous Azure Pipelines-based CI builds had a much nicer UI, one =
that
> > even showed flaky tests, and trends e.g. how long the test cases ran. =
When I
> > ported Git's CI over to GitHub workflows (to make CI more accessible t=
o new
> > contributors), I knew fully well that we would leave this very nice UI
> > behind, and I had hoped that we would get something similar back via n=
ew,
> > community-contributed GitHub Actions that can be used in GitHub workfl=
ows.
> > However, most likely because we use a home-grown test framework implem=
ented
> > in opinionated POSIX shells scripts, that did not happen.
> >
> > So I had a look at what standards exist e.g. when testing PowerShell
> > modules, in the way of marking up their test output in GitHub workflow=
s, and
> > I was not disappointed: GitHub workflows support "grouping" of output =
lines,
> > i.e. marking sections of the output as a group that is then collapsed =
by
> > default and can be expanded. And it is this feature I decided to use i=
n this
> > patch series, along with GitHub workflows' commands to display errors =
or
> > notices that are also shown on the summary page of the workflow run. N=
ow, in
> > addition to "Process completed with exit code" on the summary page, we=
 also
> > read something like:
> >
> > =E2=8A=97 linux-gcc (ubuntu-latest)
> >    failed: t9800.20 submit from detached head
> >
> >
> > Even better, this message is a link, and following that, the reader is
> > presented with something like this
> > [https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue=
]:
> >
> > =E2=8F=B5 Run ci/run-build-and-tests.sh
> > =E2=8F=B5 CI setup
> >   + ln -s /home/runner/none/.prove t/.prove
> >   + run_tests=3Dt
> >   + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> >   + group Build make
> >   + set +x
> > =E2=8F=B5 Build
> > =E2=8F=B5 Run tests
> >   =3D=3D=3D Failed test: t9800-git-p4-basic =3D=3D=3D
> > =E2=8F=B5 ok: t9800.1 start p4d
> > =E2=8F=B5 ok: t9800.2 add p4 files
> > =E2=8F=B5 ok: t9800.3 basic git p4 clone
> > =E2=8F=B5 ok: t9800.4 depot typo error
> > =E2=8F=B5 ok: t9800.5 git p4 clone @all
> > =E2=8F=B5 ok: t9800.6 git p4 sync uninitialized repo
> > =E2=8F=B5 ok: t9800.7 git p4 sync new branch
> > =E2=8F=B5 ok: t9800.8 clone two dirs
> > =E2=8F=B5 ok: t9800.9 clone two dirs, @all
> > =E2=8F=B5 ok: t9800.10 clone two dirs, @all, conflicting files
> > =E2=8F=B5 ok: t9800.11 clone two dirs, each edited by submit, single g=
it commit
> > =E2=8F=B5 ok: t9800.12 clone using non-numeric revision ranges
> > =E2=8F=B5 ok: t9800.13 clone with date range, excluding some changes
> > =E2=8F=B5 ok: t9800.14 exit when p4 fails to produce marshaled output
> > =E2=8F=B5 ok: t9800.15 exit gracefully for p4 server errors
> > =E2=8F=B5 ok: t9800.16 clone --bare should make a bare repository
> > =E2=8F=B5 ok: t9800.17 initial import time from top change time
> > =E2=8F=B5 ok: t9800.18 unresolvable host in P4PORT should display erro=
r
> > =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
> >   Error: failed: t9800.20 submit from detached head
> > =E2=8F=B5 failure: t9800.20 submit from detached head
> >   Error: failed: t9800.21 submit from worktree
> > =E2=8F=B5 failure: t9800.21 submit from worktree
> >   =3D=3D=3D Failed test: t9801-git-p4-branch =3D=3D=3D
> >   [...]
> >
> >
> > The "Failed test:" lines are colored in yellow to give a better visual=
 clue
> > about the logs' structure, the "Error:" label is colored in red to dra=
w the
> > attention to the important part of the log, and the "=E2=8F=B5" charac=
ters indicate
> > that part of the log is collapsed and can be expanded by clicking on i=
t.
> >
> > To drill down, the reader merely needs to expand the (failed) test cas=
e's
> > log by clicking on it, and then study the log. If needed (e.g. when th=
e test
> > case relies on side effects from previous test cases), the logs of pre=
ceding
> > test cases can be expanded as well. In this example, when expanding
> > t9800.20, it looks like this (for ease of reading, I cut a few chunks =
of
> > lines, indicated by "[...]"):
> >
> > [...]
> > =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
> >   Error: failed: t9800.20 submit from detached head
> > =E2=8F=B7 failure: t9800.20 submit from detached head
> >       test_when_finished cleanup_git &&
> >       git p4 clone --dest=3D"$git" //depot &&
> >         (
> >           cd "$git" &&
> >           git checkout p4/master &&
> >           >detached_head_test &&
> >           git add detached_head_test &&
> >           git commit -m "add detached_head" &&
> >           git config git-p4.skipSubmitEdit true &&
> >           git p4 submit &&
> >             git p4 rebase &&
> >             git log p4/master | grep detached_head
> >         )
> >     [...]
> >     Depot paths: //depot/
> >     Import destination: refs/remotes/p4/master
> >
> >     Importing revision 9 (100%)Perforce db files in '.' will be create=
d if missing...
> >     Perforce db files in '.' will be created if missing...
> >
> >     Traceback (most recent call last):
> >       File "/home/runner/work/git/git/git-p4", line 4455, in <module>
> >         main()
> >       File "/home/runner/work/git/git/git-p4", line 4449, in main
> >         if not cmd.run(args):
> >       File "/home/runner/work/git/git/git-p4", line 2590, in run
> >         rebase.rebase()
> >       File "/home/runner/work/git/git/git-p4", line 4121, in rebase
> >         if len(read_pipe("git diff-index HEAD --")) > 0:
> >       File "/home/runner/work/git/git/git-p4", line 297, in read_pipe
> >         retcode, out, err =3D read_pipe_full(c, *k, **kw)
> >       File "/home/runner/work/git/git/git-p4", line 284, in read_pipe_=
full
> >         p =3D subprocess.Popen(
> >       File "/usr/lib/python3.8/subprocess.py", line 858, in __init__
> >         self._execute_child(args, executable, preexec_fn, close_fds,
> >       File "/usr/lib/python3.8/subprocess.py", line 1704, in _execute_=
child
> >         raise child_exception_type(errno_num, err_msg, err_filename)
> >     FileNotFoundError: [Errno 2] No such file or directory: 'git diff-=
index HEAD --'
> >     error: last command exited with $?=3D1
> >     + cleanup_git
> >     + retry_until_success rm -r /home/runner/work/git/git/t/trash dire=
ctory.t9800-git-p4-basic/git
> >     + nr_tries_left=3D60
> >     + rm -r /home/runner/work/git/git/t/trash directory.t9800-git-p4-b=
asic/git
> >     + test_path_is_missing /home/runner/work/git/git/t/trash directory=
.t9800-git-p4-basic/git
> >     + test 1 -ne 1
> >     + test -e /home/runner/work/git/git/t/trash directory.t9800-git-p4=
-basic/git
> >     + retry_until_success mkdir /home/runner/work/git/git/t/trash dire=
ctory.t9800-git-p4-basic/git
> >     + nr_tries_left=3D60
> >     + mkdir /home/runner/work/git/git/t/trash directory.t9800-git-p4-b=
asic/git
> >     + exit 1
> >     + eval_ret=3D1
> >     + :
> >     not ok 20 - submit from detached head
> >     #
> >     #        test_when_finished cleanup_git &&
> >     #        git p4 clone --dest=3D"$git" //depot &&
> >     #        (
> >     #            cd "$git" &&
> >     #            git checkout p4/master &&
> >     #            >detached_head_test &&
> >     #            git add detached_head_test &&
> >     #            git commit -m "add detached_head" &&
> >     #            git config git-p4.skipSubmitEdit true &&
> >     #            git p4 submit &&
> >     #            git p4 rebase &&
> >     #            git log p4/master | grep detached_head
> >     #        )
> >     #
> >   Error: failed: t9800.21 submit from worktree
> >   [...]
> >
> >
> > Is this the best UI we can have for test failures in CI runs? I hope w=
e can
> > do better. Having said that, this patch series presents a pretty good =
start,
> > and offers a basis for future improvements.
> >
>
> I think these are really valuable improvements over our current state, b=
ut I
> also understand the concerns about performance elsewhere in this thread
> (it's really slow to load for me as well, and scrolling/expanding the lo=
g
> groups can be a bit glitchy in my browser). That said, I think there are=
 a
> couple ways you could improve the load time without sacrificing the (ver=
y
> helpful) improvements you've made to error log visibility. I experimente=
d a
> bit (example result [1]) and came up with some things that may help:
>
> * group errors by test file, rather than by test case (to reduce
>   parsing/rendering time for lots of groups).

I really would like to avoid that, based on my past experience with
diagnosing test failures. It is definitely helpful if the structure lets
the reader expand individual test cases.

> * print the verbose logs only for the failed test cases (to massively cu=
t
>   down on the size of the log, particularly when there's only a couple
>   failures in a test file with a lot of passing tests).

That's an amazingly simple trick to improve the speed by a ton, indeed.
Thank you for this splendid idea!

> * skip printing the full text of the test in 'finalize_test_case_output'
>   when creating the group, i.e., use '$1' instead of '$*' (in both passi=
ng
>   and failing tests, this information is already printed via some other
>   means).
>
> If you wanted to make sure a user could still access the full failure lo=
gs
> (i.e., including the "ok" test results), you could print a link to the
> artifacts page as well - that way, all of the information we currently
> provide to users can still be found somewhere.

That's a good point, I added that hint to the output (the link is
unfortunately not available at the time we print that advice).

>
> [1] https://github.com/vdye/git/runs/5666973267
>
> > Johannes Schindelin (9):
> >   ci: fix code style
> >   ci/run-build-and-tests: take a more high-level view
> >   ci: make it easier to find failed tests' logs in the GitHub workflow
> >   ci/run-build-and-tests: add some structure to the GitHub workflow
> >     output
> >   tests: refactor --write-junit-xml code
> >   test(junit): avoid line feeds in XML attributes
> >   ci: optionally mark up output in the GitHub workflow
> >   ci: use `--github-workflow-markup` in the GitHub workflow
> >   ci: call `finalize_test_case_output` a little later
> >
>
> The organization of these commits makes the series a bit confusing to re=
ad,
> mainly due to the JUnit changes in the middle. Patches 5-6 don't appear =
to
> be dependent on patches 1-4, so they could be moved to the beginning (af=
ter
> patch 1). With that change, I think this series would flow more smoothly=
:
> "Cleanup/non-functional change" -> "JUnit XML improvements" -> "Log UX
> improvements".

Great feedback! I changed the order as suggested.

Again, thank you so much for helping me improve the user experience of
Git's CI/PR builds.

Ciao,
Dscho

--8323328-1369221152-1653169379=:352--
