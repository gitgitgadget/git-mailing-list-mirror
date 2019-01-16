Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC13A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393205AbfAPNgQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:16 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:46267 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390489AbfAPNgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:15 -0500
Received: by mail-ed1-f42.google.com with SMTP id o10so5380430edt.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ec/d9d5FoVzcFqPZcoCOYrODhG5KJ1Yord/Mk14GMxs=;
        b=lWpkXMwwTiuPOGehcpFzuJDLmPT1opxNVdIPziTytjBn7Ft+tOD7pGkH7qBuJht4fY
         dx1/Kao03BWuRqMYQypuBgZ5fWIxk55RoInPK1lul3B3eG8ZUh4H8RbC3/joHc7jNA3J
         x/ywhtqxt9mm+5eAMLe+NmEVyxQeHfNxYx5znEUbWUANCRfrDMaaloWyxdhaUXbVioAr
         nTmU22tF6Yg6bvTytqX/8ezOkBUYGDZiqw31XuQdTDna5l9n+CIYhws57kicBEQkUCfO
         G97fFM7KpiW6Dihuh/6Rl2VYK7xT8SK0P7uNwOLI2UXrAJXEK3fgpH0x5L2ygpQErjmz
         UYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ec/d9d5FoVzcFqPZcoCOYrODhG5KJ1Yord/Mk14GMxs=;
        b=gRbQs5CeTY3K44fqkYu0hgKI08C7gWrLr4XjHvXUbcbhyHWv4RYgUsN61R7cRZpkY5
         O3nHIuv30G5woVXAHD0wYwFyp8htmHl+EDj/86BfwUFqSs6xsUUF3EaSGRnxq4STsYM3
         ZqkPpejX2s7y89l/BwZGEQ6DhGMS7els5kKUTJOQir7+qHuUinh3F2i3YLuAj7LEIQ7J
         T4euE5zMhE7Q/+PgAMn3Kpg/zYDe+7NYrc+qKZv/SQVYCiD8ss3u8rV7TiwxEqY/971+
         pWg1TKmn0BnRnM9MFDxeCry5u6UE9yS0uxRgt46phlsnYx8njrjoFvxK5e2idtL20J6/
         WoCA==
X-Gm-Message-State: AJcUukcbxj1D+Md7c2n3F4jbIrGAs3ByaWP2/v7IWQaDa4TDoJgpK0Mt
        FN84A8pCl8QCG2INwdD6sEZM5z0A
X-Google-Smtp-Source: ALg8bN7ZkLtwNuXCLY+3JqLFUBPI4yeAHqyQn1/IqUEMEuZL3U2KaVG7G/YFkLt/pOUsZtiEUYFOsw==
X-Received: by 2002:a17:906:4a0d:: with SMTP id w13-v6mr6913595eju.128.1547645771649;
        Wed, 16 Jan 2019 05:36:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17-v6sm3170212ejj.43.2019.01.16.05.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:10 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:10 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:48 GMT
Message-Id: <pull.31.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/21] Offer to run CI/PR builds in Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a long time already, we have tested Git's source code continuously via
Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
served us well, and more and more developers actually pay attention and
benefit from the testing this gives us.

It is also an invaluable tool for contributors who can validate their code
contributions via PRs on GitHub, e.g. to verify that their tests do actually
run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
one).

The one sad part about this is the Windows support. Travis used to lack it
(Travis announced some early support for Windows, hot off the press
[https://blog.travis-ci.com/2018-10-11-windows-early-release]), and we work
around that by using Azure Pipelines (the CI part of Azure DevOps, formerly
known as Visual Studio Team Services) indirectly: one phase in Travis would
trigger a build, wait for its log, and then paste that log.

As Git's Windows builds (and tests!) take quite a bit of time, Travis often
timed out, or somehow the trigger did not work, and for security reasons
(the Windows builds are performed in a private pool of containers), the
Windows builds are completely disabled for Pull Requests on GitHub.

One might ask why we did not use Azure Pipelines directly. There were a
couple of reasons for that:

 * most notably, Azure Pipelines' build logs could not be viewed
   anonymously,
 * while Azure Pipelines had Linux and Windows agents, it lacked macOS
   agents,
 * etc

The main two reasons no longer apply: macOS agents are available now
[https://docs.microsoft.com/en-us/azure/devops/release-notes/2018/jul-10-vsts]
, and are public projects
[https://docs.microsoft.com/en-us/azure/devops/organizations/public/about-public-projects] 
now, i.e. it is possible to configure a Azure Pipelines project so that 
anybody can view the logs. Since I offered v1, Azure Pipelines has been made
available via the GitHub Marketplace, free of cost for open source projects.

I had secured such a public project for Git for Windows already, and I also
got one for Git. For now, the latter is hooked up with my personal git.git
fork on GitHub, but it is my hope that I convince y'all that these Azure
Pipelines builds are a good idea, and then hook it up with 
https://github.com/git/git.

As a special treat, this patch series adds the ability to present the
outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
Pipelines build to present fun diagrams, trends, and makes it a lot easier
to drill down to test failures than before. See for example 
https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
[https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details] 
(you can click on the label of the failed test, and then see the detailed
output in the right pane).

But maybe you're not interested as much in the presentation of test failures
as in the speed? Well, I got you covered with that, too. As of v3, the test
suite is run in parallel on Windows, cutting the overall run time to ~33
minutes (see the latest build
[https://dev.azure.com/git/git/_build/results?buildId=302&view=logs], for
example).

This patch series took waaaaaaaay more time than I had originally
anticipated, but I think that in particular the advanced display of the test
results and the reduction of the overall run time was worth it. Please let
me know what you think about this.

Changes since v2:

 * Removed left-over debugging code that would skip a good chunk of 
   t0000-init.sh.
 * Fixed the URL of the build badge.
 * Removed a trailing empty line from, and added a missing closing pointy
   bracket to, ci/mount-fileshare.sh.
 * Moved the "travis: fix skipping tagged releases" commit up to the
   beginning of the patch series.
 * The commit message of "ci/lib.sh: add support for Azure Pipelines" now
   mentions explicitly that the Homebrew packages that need to be installed
   on Travis' macOS agents are already installed on Azure Pipelines'.
 * Some commands were not guarded by || exit 1, i.e. if they would fail, the
   build would not have failed.
 * We now install gcc-8 for the linux-gcc job.
 * We no longer try to re-run failed tests with verbose log. Instead, we
   simply use the verbose log to begin with. Tests showed that it had a
   negligible impact on the overall run time.
 * The test_atexit_handler function was scratched; It would be the right
   thing to do, but is actually an independent topic (it was only
   implemented in v2 to accommodate the "re-run with verbose log on failure"
   trick)
 * We now use a new YAML schema (most notably, "phase" is now known as
   "job")
 * The Windows job contained PowerShell sections that were indented with 3
   spaces instead of 2.
 * The Windows job is now structured better, by separating different
   concerns into different "tasks" so that it is easier to see what exactly
   failed (was it the build? was it the test?)
 * The Windows job was split into a job to build Git and 10 parallel jobs to
   run the test suite with the artifacts built by the first job. This
   reduces the overall run time from ~1h20 (which was the run time by the
   Windows job) to ~35 minutes (which is the run time of the linux-gcc job).
 * The JUnit XML is now written using a test helper rather than a fragile
   and probably not even portable sed call.
 * Since we needed to determine the file size of the verbose log (to cut out
   individual test cases' log output), we now introduce a test helper to do
   that, and use it throughout the test suite (where Perl was used before).
 * It would appear that a recent change either in Cygwin or in the Azure VMs
   causes problems sporadically where the trash directories cannot be
   removed, but a subsequent rm will succeed. We now simply do that, because
   it won't harm the common case (where the first rm succeeds already) and
   because it helps the Windows job succeed pretty reliably.

Changes since v1:

 * Removed a superfluous eval.
 * Added the commit that fixes the Travis PR builds targeting master that 
   just happens to be tagged (see 
   https://travis-ci.org/git/git/jobs/424276413 for an incorrectly-skipped
   build).
 * The commit messages and the cover letter now reflect the name change from
   Visual Studio Team Services to Azure DevOps (and in particular, Azure
   Pipelines for the automated builds).
 * Now we're using test_atexit (which we introduced for that purpose)
   instead of hard-coding kill_p4d and stop_git_daemon.
 * The build should now also succeed for Pull Requests (where secret
   variables are not available, for security reasons, and as a consequence
   the file share cannot be mounted).
 * The shell scripted parts now use proper && chains.

Johannes Schindelin (21):
  travis: fix skipping tagged releases
  ci: rename the library of common functions
  ci/lib.sh: encapsulate Travis-specific things
  ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  ci: use a junction on Windows instead of a symlink
  test-date: add a subcommand to measure times in shell scripts
  tests: optionally write results as JUnit-style .xml
  ci/lib.sh: add support for Azure Pipelines
  Add a build definition for Azure DevOps
  ci: move the Windows job to the top
  ci: use git-sdk-64-minimal build artifact
  mingw: be more generous when wrapping up the setitimer() emulation
  README: add a build badge (status of the Azure Pipelines build)
  tests: avoid calling Perl just to determine file sizes
  tests: include detailed trace logs with --write-junit-xml upon failure
  mingw: try to work around issues with the test cleanup
  tests: add t/helper/ to the PATH with --with-dashes
  t0061: fix with --with-dashes and RUNTIME_PREFIX
  tests: optionally skip bin-wrappers/
  ci: speed up Windows phase
  ci: parallelize testing on Windows

 Makefile                            |  11 +
 README.md                           |   2 +
 azure-pipelines.yml                 | 344 ++++++++++++++++++++++++++++
 ci/install-dependencies.sh          |   5 +-
 ci/{lib-travisci.sh => lib.sh}      |  70 ++++--
 ci/make-test-artifacts.sh           |  12 +
 ci/mount-fileshare.sh               |  25 ++
 ci/print-test-failures.sh           |   4 +-
 ci/run-build-and-tests.sh           |   9 +-
 ci/run-linux32-docker.sh            |   2 +-
 ci/run-static-analysis.sh           |   2 +-
 ci/run-test-slice.sh                |  17 ++
 ci/run-windows-build.sh             |   2 +-
 ci/test-documentation.sh            |   3 +-
 compat/mingw.c                      |   2 +-
 t/.gitignore                        |   1 +
 t/README                            |   9 +
 t/helper/test-date.c                |  12 +
 t/helper/test-path-utils.c          |  43 ++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/helper/test-xml-encode.c          |  80 +++++++
 t/t0021-conversion.sh               |   2 +-
 t/t0061-run-command.sh              |   3 +-
 t/t1050-large.sh                    |   2 +-
 t/t5315-pack-objects-compression.sh |   2 +-
 t/t9303-fast-import-compression.sh  |   2 +-
 t/test-lib.sh                       | 138 ++++++++++-
 28 files changed, 768 insertions(+), 38 deletions(-)
 create mode 100644 azure-pipelines.yml
 rename ci/{lib-travisci.sh => lib.sh} (58%)
 create mode 100755 ci/make-test-artifacts.sh
 create mode 100755 ci/mount-fileshare.sh
 create mode 100755 ci/run-test-slice.sh
 create mode 100644 t/helper/test-xml-encode.c


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-31%2Fdscho%2Fvsts-ci-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-31/dscho/vsts-ci-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/31

Range-diff vs v2:

  -:  ---------- >  1:  75ec97b392 travis: fix skipping tagged releases
  1:  c963184510 =  2:  d520f45108 ci: rename the library of common functions
  2:  815152e0f5 !  3:  06fa564386 ci/lib.sh: encapsulate Travis-specific things
     @@ -28,10 +28,14 @@
      @@
       # Library of functions shared by all CI scripts
       
     +-# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
     +-# want here. We want the source branch instead.
     +-TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
      +if test true = "$TRAVIS"
      +then
     -+	# We are running within Travis CI
     -+	CI_BRANCH="$TRAVIS_BRANCH"
     ++	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
     ++	# what we want here. We want the source branch instead.
     ++	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
      +	CI_COMMIT="$TRAVIS_COMMIT"
      +	CI_JOB_ID="$TRAVIS_JOB_ID"
      +	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
     @@ -48,10 +52,9 @@
      +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
      +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
      +fi
     -+
     + 
       skip_branch_tip_with_tag () {
       	# Sometimes, a branch is pushed at the same time the tag that points
     - 	# at the same commit as the tip of the branch is pushed, and building
      @@
       	# we can skip the build because we won't be skipping a build
       	# of a tag.
  -:  ---------- >  4:  52fb8e72fb ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
  -:  ---------- >  5:  a35bc43a04 ci: use a junction on Windows instead of a symlink
  3:  52337f1875 =  6:  16090ff67c test-date: add a subcommand to measure times in shell scripts
  4:  cf4c5ae470 !  7:  272c0c0446 tests: optionally write results as JUnit-style .xml
     @@ -5,8 +5,26 @@
          This will come in handy when publishing the results of Git's test suite
          during an automated Azure DevOps run.
      
     +    Note: we need to make extra sure that invalid UTF-8 encoding is turned
     +    into valid UTF-8 (using the Replacement Character, \uFFFD) because
     +    t9902's trace contains such invalid byte sequences, and the task in the
     +    Azure Pipeline that uploads the test results would refuse to do anything
     +    if it was asked to parse an .xml file with invalid UTF-8 in it.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + diff --git a/Makefile b/Makefile
     + --- a/Makefile
     + +++ b/Makefile
     +@@
     + TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
     + TEST_BUILTINS_OBJS += test-subprocess.o
     + TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
     ++TEST_BUILTINS_OBJS += test-xml-encode.o
     + TEST_BUILTINS_OBJS += test-wildmatch.o
     + TEST_BUILTINS_OBJS += test-windows-named-pipe.o
     + TEST_BUILTINS_OBJS += test-write-cache.o
     +
       diff --git a/t/.gitignore b/t/.gitignore
       --- a/t/.gitignore
       +++ b/t/.gitignore
     @@ -16,11 +34,121 @@
       /chainlinttmp
      +/out/
      
     + diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
     + --- a/t/helper/test-tool.c
     + +++ b/t/helper/test-tool.c
     +@@
     + 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
     + 	{ "subprocess", cmd__subprocess },
     + 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
     ++	{ "xml-encode", cmd__xml_encode },
     + 	{ "wildmatch", cmd__wildmatch },
     + #ifdef GIT_WINDOWS_NATIVE
     + 	{ "windows-named-pipe", cmd__windows_named_pipe },
     +
     + diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
     + --- a/t/helper/test-tool.h
     + +++ b/t/helper/test-tool.h
     +@@
     + int cmd__submodule_nested_repo_config(int argc, const char **argv);
     + int cmd__subprocess(int argc, const char **argv);
     + int cmd__urlmatch_normalization(int argc, const char **argv);
     ++int cmd__xml_encode(int argc, const char **argv);
     + int cmd__wildmatch(int argc, const char **argv);
     + #ifdef GIT_WINDOWS_NATIVE
     + int cmd__windows_named_pipe(int argc, const char **argv);
     +
     + diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
     + new file mode 100644
     + --- /dev/null
     + +++ b/t/helper/test-xml-encode.c
     +@@
     ++#include "test-tool.h"
     ++
     ++static const char *utf8_replace_character = "&#xfffd;";
     ++
     ++/*
     ++ * Encodes (possibly incorrect) UTF-8 on <stdin> to <stdout>, to be embedded
     ++ * in an XML file.
     ++ */
     ++int cmd__xml_encode(int argc, const char **argv)
     ++{
     ++	unsigned char buf[1024], tmp[4], *tmp2 = NULL;
     ++	ssize_t cur = 0, len = 1, remaining = 0;
     ++	unsigned char ch;
     ++
     ++	for (;;) {
     ++		if (++cur == len) {
     ++			len = xread(0, buf, sizeof(buf));
     ++			if (!len)
     ++				return 0;
     ++			if (len < 0)
     ++				die_errno("Could not read <stdin>");
     ++			cur = 0;
     ++		}
     ++		ch = buf[cur];
     ++
     ++		if (tmp2) {
     ++			if ((ch & 0xc0) != 0x80) {
     ++				fputs(utf8_replace_character, stdout);
     ++				tmp2 = 0;
     ++				cur--;
     ++				continue;
     ++			}
     ++			*tmp2 = ch;
     ++			tmp2++;
     ++			if (--remaining == 0) {
     ++				fwrite(tmp, tmp2 - tmp, 1, stdout);
     ++				tmp2 = 0;
     ++			}
     ++			continue;
     ++		}
     ++
     ++		if (!(ch & 0x80)) {
     ++			/* 0xxxxxxx */
     ++			if (ch == '&')
     ++				fputs("&amp;", stdout);
     ++			else if (ch == '\'')
     ++				fputs("&apos;", stdout);
     ++			else if (ch == '"')
     ++				fputs("&quot;", stdout);
     ++			else if (ch == '<')
     ++				fputs("&lt;", stdout);
     ++			else if (ch == '>')
     ++				fputs("&gt;", stdout);
     ++			else if (ch >= 0x20)
     ++				fputc(ch, stdout);
     ++			else if (ch == 0x09 || ch == 0x0a || ch == 0x0d)
     ++				fprintf(stdout, "&#x%02x;", ch);
     ++			else
     ++				fputs(utf8_replace_character, stdout);
     ++		} else if ((ch & 0xe0) == 0xc0) {
     ++			/* 110XXXXx 10xxxxxx */
     ++			tmp[0] = ch;
     ++			remaining = 1;
     ++			tmp2 = tmp + 1;
     ++		} else if ((ch & 0xf0) == 0xe0) {
     ++			/* 1110XXXX 10Xxxxxx 10xxxxxx */
     ++			tmp[0] = ch;
     ++			remaining = 2;
     ++			tmp2 = tmp + 1;
     ++		} else if ((ch & 0xf8) == 0xf0) {
     ++			/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
     ++			tmp[0] = ch;
     ++			remaining = 3;
     ++			tmp2 = tmp + 1;
     ++		} else
     ++			fputs(utf8_replace_character, stdout);
     ++	}
     ++
     ++	return 0;
     ++}
     +
       diff --git a/t/test-lib.sh b/t/test-lib.sh
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
      @@
     - 	--verbose-log)
     + 	-V|--verbose-log)
       		verbose_log=t
       		shift ;;
      +	--write-junit-xml)
     @@ -115,14 +243,7 @@
      +}
      +
      +xml_attr_encode () {
     -+	# We do not translate CR to &#x0d; because BSD sed does not handle
     -+	# \r in the regex. In practice, the output should not even have any
     -+	# carriage returns.
     -+	printf '%s\n' "$@" |
     -+	sed -e 's/&/\&amp;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g' \
     -+		-e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
     -+		-e 's/	/\&#x09;/g' -e 's/$/\&#x0a;/' -e '$s/&#x0a;$//' |
     -+	tr -d '\012\015'
     ++	printf '%s\n' "$@" | test-tool xml-encode
      +}
      +
      +write_junit_xml_testcase () {
  5:  486d1d2518 !  8:  fefab79d46 ci/lib.sh: add support for Azure Pipelines
     @@ -6,6 +6,10 @@
          variables and a function that displays the URL given the job id (to
          identify previous runs for known-good trees).
      
     +    For example, we do not have to install the git-lfs and gettext packages
     +    on Azure Pipelines' macOS agents: they are already installed, and trying
     +    to install them again would result in an error.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/ci/lib.sh b/ci/lib.sh
     @@ -15,7 +19,7 @@
       	BREW_INSTALL_PACKAGES="git-lfs gettext"
       	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
       	export GIT_TEST_OPTS="--verbose-log -x --immediate"
     -+elif test -n "$SYSTEM_TASKDEFINITIONSURI"
     ++elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
      +then
      +	# We are running in Azure Pipelines
      +	CI_BRANCH="$BUILD_SOURCEBRANCH"
  6:  1a22efe849 !  9:  ddee8ecd8a Add a build definition for Azure DevOps
     @@ -28,12 +28,11 @@
      +- repo: self
      +  fetchDepth: 1
      +
     -+phases:
     -+- phase: linux_clang
     ++jobs:
     ++- job: linux_clang
      +  displayName: linux-clang
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
     @@ -43,7 +42,7 @@
      +
      +       export CC=clang || exit 1
      +
     -+       ci/install-dependencies.sh
     ++       ci/install-dependencies.sh || exit 1
      +       ci/run-build-and-tests.sh || {
      +           ci/print-test-failures.sh
      +           exit 1
     @@ -62,19 +61,19 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: linux_gcc
     ++- job: linux_gcc
      +  displayName: linux-gcc
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     ++       sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
      +       sudo apt-get update &&
     -+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin || exit 1
     ++       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 || exit 1
      +
     -+       ci/install-dependencies.sh
     ++       ci/install-dependencies.sh || exit 1
      +       ci/run-build-and-tests.sh || {
      +           ci/print-test-failures.sh
      +           exit 1
     @@ -93,18 +92,17 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: osx_clang
     ++- job: osx_clang
      +  displayName: osx-clang
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted macOS
     ++  pool: Hosted macOS
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
      +       export CC=clang
      +
     -+       ci/install-dependencies.sh
     ++       ci/install-dependencies.sh || exit 1
      +       ci/run-build-and-tests.sh || {
      +           ci/print-test-failures.sh
      +           exit 1
     @@ -123,16 +121,15 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: osx_gcc
     ++- job: osx_gcc
      +  displayName: osx-gcc
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted macOS
     ++  pool: Hosted macOS
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       ci/install-dependencies.sh
     ++       ci/install-dependencies.sh || exit 1
      +       ci/run-build-and-tests.sh || {
      +           ci/print-test-failures.sh
      +           exit 1
     @@ -151,11 +148,10 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: gettext_poison
     ++- job: gettext_poison
      +  displayName: GETTEXT_POISON
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
     @@ -183,73 +179,81 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: windows
     ++- job: windows
      +  displayName: Windows
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted VS2017
     -+    timeoutInMinutes: 240
     ++  pool: Hosted
     ++  timeoutInMinutes: 240
      +  steps:
      +  - powershell: |
     -+       # Helper to check the error level of the latest command (exit with error when appropriate)
     -+       function c() { if (!$?) { exit(1) } }
     -+
     -+       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -+         net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no; c
     -+         cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\; c
     -+       }
     -+
     -+       # Add build agent's MinGit to PATH
     -+       $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
     -+
     -+       # Helper to initialize (or update) a Git worktree
     -+       function init ($path, $url, $set_origin) {
     -+           if (Test-Path $path) {
     -+               cd $path; c
     -+               if (Test-Path .git) {
     -+                   git init; c
     -+               } else {
     -+                   git status
     -+               }
     -+           } else {
     -+               git init $path; c
     -+               cd $path; c
     -+           }
     -+           git config core.autocrlf false; c
     -+           git config core.untrackedCache true; c
     -+           if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
     -+               git remote add origin $url; c
     -+           }
     -+           git fetch --depth=1 $url master; c
     -+           git reset --hard FETCH_HEAD; c
     -+           git clean -df; c
     -+       }
     -+
     -+       # Initialize Git for Windows' SDK
     -+       $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
     -+       init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
     -+       init usr\src\build-extra https://github.com/git-for-windows/build-extra 1
     -+
     -+       cd "$(Build.SourcesDirectory)"; c
     -+
     -+       $env:HOME = "$(Build.SourcesDirectory)"
     -+       $env:MSYSTEM = "MINGW64"
     -+       git-sdk-64\git-cmd --command=usr\\bin\\bash.exe -lc @"
     -+         . ci/lib.sh
     -+
     -+         make -j10 DEVELOPER=1 NO_PERL=1 || exit 1
     -+         NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"--quiet --write-junit-xml\" time make -j15 -k DEVELOPER=1 test || {
     -+           NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"-i -v -x\" make -k -C t failed; exit 1
     -+         }
     -+
     -+         save_good_tree
     -+       "@
     -+       c
     -+
     -+       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -+         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     -+       }
     -+    displayName: 'build & test'
     ++      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     ++        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
     ++        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
     ++      }
     ++    displayName: 'Mount test-cache'
     ++    env:
     ++      GITFILESHAREPWD: $(gitfileshare.pwd)
     ++  - powershell: |
     ++      # Helper to check the error level of the latest command (exit with error when appropriate)
     ++      function c() { if (!$?) { exit(1) } }
     ++
     ++      # Add build agent's MinGit to PATH
     ++      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
     ++
     ++      # Helper to initialize (or update) a Git worktree
     ++      function init ($path, $url, $set_origin) {
     ++        if (Test-Path $path) {
     ++          cd $path; c
     ++          if (Test-Path .git) {
     ++            & git init; c
     ++          } else {
     ++            & git status
     ++          }
     ++        } else {
     ++          & git init $path; c
     ++          cd $path; c
     ++        }
     ++        & git config core.autocrlf false; c
     ++        & git config core.untrackedCache true; c
     ++        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
     ++          & git remote add origin $url; c
     ++        }
     ++        & git fetch --depth=1 $url master; c
     ++        & git reset --hard FETCH_HEAD; c
     ++        & git clean -df; c
     ++      }
     ++
     ++      # Initialize Git for Windows' SDK
     ++      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
     ++      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
     ++
     ++      # Let Git ignore the SDK and the test-cache
     ++      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
     ++    displayName: 'Initialize the Git for Windows SDK'
     ++  - powershell: |
     ++      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
     ++        export MAKEFLAGS=-j10
     ++        export DEVELOPER=1
     ++        export NO_PERL=1
     ++        export NO_SVN_TESTS=1
     ++        export GIT_TEST_SKIP_REBASE_P=1
     ++
     ++        ci/run-build-and-tests.sh || {
     ++          ci/print-test-failures.sh
     ++          exit 1
     ++        }
     ++      "@
     ++      if (!$?) { exit(1) }
     ++    displayName: 'Build & Test'
     ++    env:
     ++      HOME: $(Build.SourcesDirectory)
     ++      MSYSTEM: MINGW64
     ++  - powershell: |
     ++      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     ++        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     ++      }
     ++    displayName: 'Unmount test-cache'
     ++    condition: true
      +    env:
      +      GITFILESHAREPWD: $(gitfileshare.pwd)
      +  - task: PublishTestResults@2
     @@ -261,29 +265,14 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: linux32
     ++- job: linux32
      +  displayName: Linux32
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
      +
     -+       sudo apt-get update &&
     -+       sudo apt-get -y install \
     -+           apt-transport-https \
     -+           ca-certificates \
     -+           curl \
     -+           software-properties-common &&
     -+       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
     -+       sudo add-apt-repository \
     -+          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     -+          $(lsb_release -cs) \
     -+          stable" &&
     -+       sudo apt-get update &&
     -+       sudo apt-get -y install docker-ce &&
     -+
      +       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS=-j3 bash -lxc ci/run-linux32-docker.sh || exit 1
      +
      +       sudo chmod a+r t/out/TEST-*.xml
     @@ -301,11 +290,10 @@
      +      publishRunAttachments: false
      +    condition: succeededOrFailed()
      +
     -+- phase: static_analysis
     ++- job: static_analysis
      +  displayName: StaticAnalysis
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
     @@ -322,11 +310,10 @@
      +    env:
      +      GITFILESHAREPWD: $(gitfileshare.pwd)
      +
     -+- phase: documentation
     ++- job: documentation
      +  displayName: Documentation
      +  condition: succeeded()
     -+  queue:
     -+    name: Hosted Ubuntu 1604
     ++  pool: Hosted Ubuntu 1604
      +  steps:
      +  - bash: |
      +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
     @@ -344,6 +331,19 @@
      +    env:
      +      GITFILESHAREPWD: $(gitfileshare.pwd)
      
     + diff --git a/ci/lib.sh b/ci/lib.sh
     + --- a/ci/lib.sh
     + +++ b/ci/lib.sh
     +@@
     + 
     + 	BREW_INSTALL_PACKAGES=
     + 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
     +-	export GIT_TEST_OPTS="--quiet --write-junit-xml"
     ++	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
     + fi
     + 
     + skip_branch_tip_with_tag () {
     +
       diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
       new file mode 100755
       --- /dev/null
     @@ -357,7 +357,7 @@
      +}
      +
      +test $# = 4 ||
     -+die "Usage: $0 <share> <username> <password> <mountpoint"
     ++die "Usage: $0 <share> <username> <password> <mountpoint>"
      +
      +mkdir -p "$4" || die "Could not create $4"
      +
     @@ -374,4 +374,3 @@
      +	;;
      +esac ||
      +die "Could not mount $4"
     -+
  7:  12d6137f8d <  -:  ---------- tests: introduce `test_atexit`
  8:  3bb226b79b <  -:  ---------- git-daemon: use `test_atexit` in the tests
  9:  3e2193a73d <  -:  ---------- git-p4: use `test_atexit` to kill the daemon
 10:  ae3c42519a <  -:  ---------- tests: include detailed trace logs with --write-junit-xml upon failure
 11:  2466a48aa3 <  -:  ---------- tests: record more stderr with --write-junit-xml in case of failure
  -:  ---------- > 10:  58bb8d0469 ci: move the Windows job to the top
  -:  ---------- > 11:  b6bb6a87a3 ci: use git-sdk-64-minimal build artifact
  -:  ---------- > 12:  2b6ee78f02 mingw: be more generous when wrapping up the setitimer() emulation
 12:  d112b3fe86 ! 13:  df326039d9 README: add a build badge (status of the Azure Pipelines build)
     @@ -10,7 +10,7 @@
       --- a/README.md
       +++ b/README.md
      @@
     -+[![Build Status](https:/dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
     ++[![Build Status](https://dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
      +
       Git - fast, scalable, distributed revision control system
       =========================================================
 13:  0a53f37135 <  -:  ---------- travis: fix skipping tagged releases
  -:  ---------- > 14:  0d547db8f7 tests: avoid calling Perl just to determine file sizes
  -:  ---------- > 15:  f678b105f8 tests: include detailed trace logs with --write-junit-xml upon failure
  -:  ---------- > 16:  8ef674a236 mingw: try to work around issues with the test cleanup
  -:  ---------- > 17:  b503167084 tests: add t/helper/ to the PATH with --with-dashes
  -:  ---------- > 18:  713910e1dc t0061: fix with --with-dashes and RUNTIME_PREFIX
  -:  ---------- > 19:  3a77eafb44 tests: optionally skip bin-wrappers/
  -:  ---------- > 20:  fba97133bf ci: speed up Windows phase
  -:  ---------- > 21:  e568349930 ci: parallelize testing on Windows

-- 
gitgitgadget
