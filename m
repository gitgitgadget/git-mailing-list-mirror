Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB5C433FE
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 23:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiBSXqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 18:46:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiBSXqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 18:46:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D65B46
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645314386;
        bh=x3ZhbZ4qkfvCiPg911UZtDl2H4A9bmljnt9hCVekYno=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N0gBNFFqWgSRYSmH2mWD0EUXkTuHYCKsOKGS3ybtIC1UeUt4nMDlEP4R+M7hC0war
         1pWx8AfzVF6nHx/EPgjUB0z6aiWl6MboGMwmYqx4q1ZrU2sT0mS4AXqIzWN4+w/6td
         mSr9nAYRjJRn8fXdc5+HIS/yA9VJqCmUNkC2i7Vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1oLxd108qj-011End; Sun, 20
 Feb 2022 00:46:26 +0100
Date:   Sun, 20 Feb 2022 00:46:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-660609956-1645314386=:26495"
X-Provags-ID: V03:K1:2tf/03h9SSu+Acf+BL2CqnEkdX9RlUGiUQBEp6S1VmryuxZ4/oM
 AAIjt/4/+RAcq2xsTMBTYMKYrC5LM6o7w4bHeiqHs0+j42JB3IiqkG9wLGuuT6c+skpjyHy
 Xf9/cujmuKvPzg6CyjcktmV3SY/vsrNixULNPfJBq9iC18KRle9deXDa2iuHifOR7S7JsGK
 Ba4mA+XaeaprE6V78sDKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k50rah/30/I=:mnoKVDEdHWPEkPtBIZF/oG
 sdX0CmD3H7czfQK7qpPE5RzQUud2dP3GkDnHfOGtoLM0UgSFcG/6Ebi7C+s4KPUQG9SxNf9kP
 somAa94cxNcwINpUloTmd2m7wOuy9Po260g193xxUexRfX4BVYYlUTnPXrjmmfeh9P4p9dd8l
 XviUSHJLTkYFEdHMoTpUO9sReCPeTPdQtoMqe4Lt5uD73xOrviM8jX9OPSXNcBM1g6hz5x7dO
 Sn9LP0k4lKMZrfdhy7ugn3UrGS/i2vn4v8rleG8fe7N6N8bC6fKRaMC0Im3P8e12mTzj6F4Ji
 o0rP0bHGBh1qFSi/Hjye/sjGibRc7iS19tk9+Ga5fUoNdJFjZ+FUsrfOfQZVXQaqbLLp6xs3O
 jx+7L72WH1IWRnivCOQ8RZePQd0ma57Zon5ELEPDiffgxIsvqEeN8SrZTpXv4uM6U5SeEpZIw
 GQMphw7g6MHxPuqAmYteXEfiTsqJ5yWZHT0L29HWh6YIwA4sg5/Gf5FnjWVY2pTfie2m87U4/
 XZm2iraBkewRU0ithzG1mQb5vXD6mUGFqYbz7VzMFOg8RbRz/Fex0BKIiVDqfKDWKby8aaRNZ
 00Q1/g7JmbTdbo/wLLPZVpTHT5IIAXVxsf/80sD3K67r2L/kSPaodGKgOrVj2EXGqnsihJoF6
 evAt+uWX12Y/ftOLm/TbWXoqaBZYIohHDXyTDqembZlR3MQVZ7w1wRastwfmeMQj7yESFGvtU
 aoLxpPCGTeZrV06/pmKRRmh3JmYd0AdKtX3cX/nBeidIoq1P1vDJnUYM4tZXo63EXLNECesB6
 ftqV779S2d9JzNHHlWyJx1hDXT2s1Br9i86jR99Tu+wyrVIdwbf2SDrqQG9zMZPfDBon6v8Qq
 uKi47XCiRRrU7gA1LCErxKKLyCgRNFiLFBZPQico0wLDPCJMLAHE63joy7ytnJXzrw0mSr0Ov
 wmyidC8AayilwrJfcXV+oBI2chA/l4+ifxCTT5SOLwmq31SbbvJsBZ/cTVPMzMIr5e1a1WxeD
 TBDPQTiU3UZP/QB9nCb7H1t0XGPzOW7Ol/jX1HaDxQAl8COnFIfls//c7CX+ZdSj5YgulQepe
 cMI2IHGfw4fPak=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-660609956-1645314386=:26495
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

I notice that you did not take this into `seen` yet. I find that a little
sad because it would potentially have helped others to figure out the
failure in the latest `seen`:
https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue#step:5=
:162

Essentially, a recent patch introduces hard-coded SHA-1 hashes in t3007.3.

Ciao,
Dscho


On Mon, 24 Jan 2022, Johannes Schindelin via GitGitGadget wrote:

>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Recent patches intended to help readers figure out CI failures much quic=
ker
> than before. Unfortunately, they haven't been entirely positive for me. =
For
> example, they broke the branch protections in Microsoft's fork of Git, w=
here
> we require Pull Requests to pass a certain set of Checks (which are
> identified by their names) and therefore caused follow-up work.
>
> Using CI and in general making it easier for new contributors is an area=
 I'm
> passionate about, and one I'd like to see improved.
>
>
> The current situation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Let me walk you through the current experience when a PR build fails: I =
get
> a notification mail that only says that a certain job failed. There's no
> indication of which test failed (or was it the build?). I can click on a
> link at it takes me to the workflow run. Once there, all it says is "Pro=
cess
> completed with exit code 1", or even "code 2". Sure, I can click on one =
of
> the failed jobs. It even expands the failed step's log (collapsing the o=
ther
> steps). And what do I see there?
>
> Let's look at an example of a failed linux-clang (ubuntu-latest) job
> [https://github.com/git-for-windows/git/runs/4822802185?check_suite_focu=
s=3Dtrue]:
>
> [...]
> Test Summary Report
> -------------------
> t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 F=
ailed: 1)
>   Failed test:  49
>   Non-zero exit status: 1
> t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Fai=
led: 0)
>   TODO passed:   45, 47
> Files=3D957, Tests=3D25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 86=
6.28 cusr 364.34 csys =3D 1237.92 CPU)
> Result: FAIL
> make[1]: *** [Makefile:53: prove] Error 1
> make[1]: Leaving directory '/home/runner/work/git/git/t'
> make: *** [Makefile:3018: test] Error 2
>
>
> That's it. I count myself lucky not to be a new contributor being faced =
with
> something like this.
>
> Now, since I am active in the Git project for a couple of days or so, I =
can
> make sense of the "TODO passed" label and know that for the purpose of
> fixing the build failures, I need to ignore this, and that I need to foc=
us
> on the "Failed test" part instead.
>
> I also know that I do not have to get myself an ubuntu-latest box just t=
o
> reproduce the error, I do not even have to check out the code and run it
> just to learn what that "49" means.
>
> I know, and I do not expect any new contributor, not even most seasoned
> contributors to know, that I have to patiently collapse the "Run
> ci/run-build-and-tests.sh" job's log, and instead expand the "Run
> ci/print-test-failures.sh" job log (which did not fail and hence does no=
t
> draw any attention to it).
>
> I know, and again: I do not expect many others to know this, that I then
> have to click into the "Search logs" box (not the regular web browser's
> search via Ctrl+F!) and type in "not ok" to find the log of the failed t=
est
> case (and this might still be a "known broken" one that is marked via
> test_expect_failure and once again needs to be ignored).
>
> To be excessively clear: This is not a great experience!
>
>
> Improved output
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Our previous Azure Pipelines-based CI builds had a much nicer UI, one th=
at
> even showed flaky tests, and trends e.g. how long the test cases ran. Wh=
en I
> ported Git's CI over to GitHub workflows (to make CI more accessible to =
new
> contributors), I knew fully well that we would leave this very nice UI
> behind, and I had hoped that we would get something similar back via new=
,
> community-contributed GitHub Actions that can be used in GitHub workflow=
s.
> However, most likely because we use a home-grown test framework implemen=
ted
> in opinionated POSIX shells scripts, that did not happen.
>
> So I had a look at what standards exist e.g. when testing PowerShell
> modules, in the way of marking up their test output in GitHub workflows,=
 and
> I was not disappointed: GitHub workflows support "grouping" of output li=
nes,
> i.e. marking sections of the output as a group that is then collapsed by
> default and can be expanded. And it is this feature I decided to use in =
this
> patch series, along with GitHub workflows' commands to display errors or
> notices that are also shown on the summary page of the workflow run. Now=
, in
> addition to "Process completed with exit code" on the summary page, we a=
lso
> read something like:
>
> =E2=8A=97 linux-gcc (ubuntu-latest)
>    failed: t9800.20 submit from detached head
>
>
> Even better, this message is a link, and following that, the reader is
> presented with something like this
> [https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue]:
>
> =E2=8F=B5 Run ci/run-build-and-tests.sh
> =E2=8F=B5 CI setup
>   + ln -s /home/runner/none/.prove t/.prove
>   + run_tests=3Dt
>   + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>   + group Build make
>   + set +x
> =E2=8F=B5 Build
> =E2=8F=B5 Run tests
>   =3D=3D=3D Failed test: t9800-git-p4-basic =3D=3D=3D
> =E2=8F=B5 ok: t9800.1 start p4d
> =E2=8F=B5 ok: t9800.2 add p4 files
> =E2=8F=B5 ok: t9800.3 basic git p4 clone
> =E2=8F=B5 ok: t9800.4 depot typo error
> =E2=8F=B5 ok: t9800.5 git p4 clone @all
> =E2=8F=B5 ok: t9800.6 git p4 sync uninitialized repo
> =E2=8F=B5 ok: t9800.7 git p4 sync new branch
> =E2=8F=B5 ok: t9800.8 clone two dirs
> =E2=8F=B5 ok: t9800.9 clone two dirs, @all
> =E2=8F=B5 ok: t9800.10 clone two dirs, @all, conflicting files
> =E2=8F=B5 ok: t9800.11 clone two dirs, each edited by submit, single git=
 commit
> =E2=8F=B5 ok: t9800.12 clone using non-numeric revision ranges
> =E2=8F=B5 ok: t9800.13 clone with date range, excluding some changes
> =E2=8F=B5 ok: t9800.14 exit when p4 fails to produce marshaled output
> =E2=8F=B5 ok: t9800.15 exit gracefully for p4 server errors
> =E2=8F=B5 ok: t9800.16 clone --bare should make a bare repository
> =E2=8F=B5 ok: t9800.17 initial import time from top change time
> =E2=8F=B5 ok: t9800.18 unresolvable host in P4PORT should display error
> =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
>   Error: failed: t9800.20 submit from detached head
> =E2=8F=B5 failure: t9800.20 submit from detached head
>   Error: failed: t9800.21 submit from worktree
> =E2=8F=B5 failure: t9800.21 submit from worktree
>   =3D=3D=3D Failed test: t9801-git-p4-branch =3D=3D=3D
>   [...]
>
>
> The "Failed test:" lines are colored in yellow to give a better visual c=
lue
> about the logs' structure, the "Error:" label is colored in red to draw =
the
> attention to the important part of the log, and the "=E2=8F=B5" characte=
rs indicate
> that part of the log is collapsed and can be expanded by clicking on it.
>
> To drill down, the reader merely needs to expand the (failed) test case'=
s
> log by clicking on it, and then study the log. If needed (e.g. when the =
test
> case relies on side effects from previous test cases), the logs of prece=
ding
> test cases can be expanded as well. In this example, when expanding
> t9800.20, it looks like this (for ease of reading, I cut a few chunks of
> lines, indicated by "[...]"):
>
> [...]
> =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
>   Error: failed: t9800.20 submit from detached head
> =E2=8F=B7 failure: t9800.20 submit from detached head
>       test_when_finished cleanup_git &&
>       git p4 clone --dest=3D"$git" //depot &&
>         (
>           cd "$git" &&
>           git checkout p4/master &&
>           >detached_head_test &&
>           git add detached_head_test &&
>           git commit -m "add detached_head" &&
>           git config git-p4.skipSubmitEdit true &&
>           git p4 submit &&
>             git p4 rebase &&
>             git log p4/master | grep detached_head
>         )
>     [...]
>     Depot paths: //depot/
>     Import destination: refs/remotes/p4/master
>
>     Importing revision 9 (100%)Perforce db files in '.' will be created =
if missing...
>     Perforce db files in '.' will be created if missing...
>
>     Traceback (most recent call last):
>       File "/home/runner/work/git/git/git-p4", line 4455, in <module>
>         main()
>       File "/home/runner/work/git/git/git-p4", line 4449, in main
>         if not cmd.run(args):
>       File "/home/runner/work/git/git/git-p4", line 2590, in run
>         rebase.rebase()
>       File "/home/runner/work/git/git/git-p4", line 4121, in rebase
>         if len(read_pipe("git diff-index HEAD --")) > 0:
>       File "/home/runner/work/git/git/git-p4", line 297, in read_pipe
>         retcode, out, err =3D read_pipe_full(c, *k, **kw)
>       File "/home/runner/work/git/git/git-p4", line 284, in read_pipe_fu=
ll
>         p =3D subprocess.Popen(
>       File "/usr/lib/python3.8/subprocess.py", line 858, in __init__
>         self._execute_child(args, executable, preexec_fn, close_fds,
>       File "/usr/lib/python3.8/subprocess.py", line 1704, in _execute_ch=
ild
>         raise child_exception_type(errno_num, err_msg, err_filename)
>     FileNotFoundError: [Errno 2] No such file or directory: 'git diff-in=
dex HEAD --'
>     error: last command exited with $?=3D1
>     + cleanup_git
>     + retry_until_success rm -r /home/runner/work/git/git/t/trash direct=
ory.t9800-git-p4-basic/git
>     + nr_tries_left=3D60
>     + rm -r /home/runner/work/git/git/t/trash directory.t9800-git-p4-bas=
ic/git
>     + test_path_is_missing /home/runner/work/git/git/t/trash directory.t=
9800-git-p4-basic/git
>     + test 1 -ne 1
>     + test -e /home/runner/work/git/git/t/trash directory.t9800-git-p4-b=
asic/git
>     + retry_until_success mkdir /home/runner/work/git/git/t/trash direct=
ory.t9800-git-p4-basic/git
>     + nr_tries_left=3D60
>     + mkdir /home/runner/work/git/git/t/trash directory.t9800-git-p4-bas=
ic/git
>     + exit 1
>     + eval_ret=3D1
>     + :
>     not ok 20 - submit from detached head
>     #
>     #        test_when_finished cleanup_git &&
>     #        git p4 clone --dest=3D"$git" //depot &&
>     #        (
>     #            cd "$git" &&
>     #            git checkout p4/master &&
>     #            >detached_head_test &&
>     #            git add detached_head_test &&
>     #            git commit -m "add detached_head" &&
>     #            git config git-p4.skipSubmitEdit true &&
>     #            git p4 submit &&
>     #            git p4 rebase &&
>     #            git log p4/master | grep detached_head
>     #        )
>     #
>   Error: failed: t9800.21 submit from worktree
>   [...]
>
>
> Is this the best UI we can have for test failures in CI runs? I hope we =
can
> do better. Having said that, this patch series presents a pretty good st=
art,
> and offers a basis for future improvements.
>
> Johannes Schindelin (9):
>   ci: fix code style
>   ci/run-build-and-tests: take a more high-level view
>   ci: make it easier to find failed tests' logs in the GitHub workflow
>   ci/run-build-and-tests: add some structure to the GitHub workflow
>     output
>   tests: refactor --write-junit-xml code
>   test(junit): avoid line feeds in XML attributes
>   ci: optionally mark up output in the GitHub workflow
>   ci: use `--github-workflow-markup` in the GitHub workflow
>   ci: call `finalize_test_case_output` a little later
>
>  .github/workflows/main.yml           |  12 ---
>  ci/lib.sh                            |  81 ++++++++++++++--
>  ci/run-build-and-tests.sh            |  11 ++-
>  ci/run-test-slice.sh                 |   5 +-
>  t/test-lib-functions.sh              |   4 +-
>  t/test-lib-github-workflow-markup.sh |  50 ++++++++++
>  t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
>  t/test-lib.sh                        | 128 ++++----------------------
>  8 files changed, 287 insertions(+), 136 deletions(-)
>  create mode 100644 t/test-lib-github-workflow-markup.sh
>  create mode 100644 t/test-lib-junit.sh
>
>
> base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1117%2=
Fdscho%2Fuse-grouping-in-ci-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1117/dsch=
o/use-grouping-in-ci-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1117
> --
> gitgitgadget
>
>

--8323328-660609956-1645314386=:26495--
