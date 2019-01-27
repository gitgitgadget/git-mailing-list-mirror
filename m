Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936761F453
	for <e@80x24.org>; Sun, 27 Jan 2019 21:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA0VWa (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 16:22:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:59931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfA0VWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 16:22:30 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MegbQ-1gYZ1E1yYq-00OIzK; Sun, 27
 Jan 2019 22:22:24 +0100
Date:   Sun, 27 Jan 2019 22:22:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <20190125135127.GE6702@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1901272022410.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com> <20190125135127.GE6702@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-236681125-1548624145=:45"
X-Provags-ID: V03:K1:34hVHM9mP9GI6twBLAjhW1254PontveIdxWdfotG1L0acQ4H+8x
 8D0RkcYkzEAWssgGFZ4iS1puCnVk+Q+Qwyhd9+Ok2xrjzBBtVY9WZND5Qay5YNGudfekc2t
 CS4UOUq0GuV25AhIeHmjpZc3a5V0nyQdQWrmJp2kpGGN/NfNL1xENfegfV6Fji5Ghlj0P5N
 ozZN+DCMwfek9qaFVk6Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQN0XeiqgLI=:Q8hI8WZbbuEZ2Ty5C9UIhQ
 mWZFeZLSAfF83boSvQ5W8mWY7GGt/3O77YEWi1yyREPVl5qHb0hTaXLi9/rvh0VY3RMmNTerl
 7FLHQ82xhOuNLf+yI/4Axvr92Xelg/TtiLQTOURpW4hFYDQAoAtfCB9jNXo/uhXLwrXX4mi4D
 NTD5hEGPJuu1FHu6VoTLSmIUojMeI01XejsaUW0nPD2zkUm8gCTskYrR59mCk4AS5WNHbl40T
 Syfpl4S6jTEdb7mcFtruVEQ3a5qKtRmGNwyKeb2eRYT3V+e9BXXuwiy9QAgX1Ts3P9BaeKOvw
 dLjNFS83+aUGDFCio+HMZrDXhm+jYo5ipUj+PIJXg7y6yGMhxA5Dt9wLtrxhtxviAmQFkm2Uq
 pxWGG64/YuDrhj8cQl2OsWqJ8UsWbluQj1U6V8eialZluIvdjrXsE6SZAwfRcOkL2GKhxPAJY
 xCxoW+14mcqXrnr6wJELaorflctdUtB1oG80t3qxP1UXTbgH6oXlMSjHah0/rl79lEHmMZdsW
 YTInljqfhxdsSjjkApDdpw0tImhTzFSGxBdljSW3+jPh6W/ESqBrKWM50/sVdt7iW4QMBvDND
 n7mjvx+Eqd17e0FjaDxaOV3DTKtl6pkHxF3f2yP7acgfmRUR21IjvcYLVpdthTr1GD4F9m+1M
 fTrx52qyKmNdfKGYO18QMnDCpPErRHspMlT56A7/kg92Pz5ueZextvJyQuBo/LquPj5UFIQ/3
 76QzVv2wfji7ppsrhcqOyotKvhyPFX4YkstlKOKyFjspnnJrKwkciZILSGqMlAL58k1GAR6OU
 JwpJYRqQJPrttWp6Oxff8eFN8KQ7QLFjoEinBw4rrLWcgzPtsmtX5Pg1Qv2uVdVoGRij6wgNP
 6gSI1ihwwrWwkf//GgqutjnSh1NPQFXjaoY4x3dWaFX9SQpGEidPUu8VkW/lBBsur1m/9Nj9I
 osJJ/csZXcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-236681125-1548624145=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Fri, 25 Jan 2019, SZEDER Gábor wrote:

> On Wed, Jan 23, 2019 at 06:40:16AM -0800, Johannes Schindelin via
> GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > The upcoming patches will allow building git.git via Azure Pipelines
> > (i.e. Azure DevOps' Continuous Integration), where variable names and
> > URLs look a bit different than in Travis CI.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index c26bb6a274..4456dbbcb0 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -1,8 +1,26 @@
> >  # Library of functions shared by all CI scripts
> >  
> > -# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
> > -# want here. We want the source branch instead.
> > -CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> > +if test true = "$TRAVIS"
> > +then
> > +	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
> > +	# what we want here. We want the source branch instead.
> > +	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> > +	CI_COMMIT="$TRAVIS_COMMIT"
> > +	CI_JOB_ID="$TRAVIS_JOB_ID"
> > +	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> > +	CI_OS_NAME="$TRAVIS_OS_NAME"
> > +	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
> > +
> > +	cache_dir="$HOME/travis-cache"
> > +
> > +	url_for_job_id () {
> > +		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
> > +	}
> > +
> > +	BREW_INSTALL_PACKAGES="git-lfs gettext"
> > +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> > +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> > +fi
> 
> Please set these variables after 'set -x' has been turned on, so the
> values will be visible in the logs.
> 
> https://public-inbox.org/git/20181018220106.GU19800@szeder.dev/

Oooops. Sorry, I overlooked this! I'm sorry. Will fix.

The fix will actually be squashed into 1/21 ("travis: fix skipping tagged
releases") because due to the re-ordering requested by Junio, this is now
the first offender.

> > diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> > index 7aef39a2fd..d2045b63a6 100755
> > --- a/ci/print-test-failures.sh
> > +++ b/ci/print-test-failures.sh
> > @@ -69,7 +69,7 @@ do
> >  	fi
> >  done
> >  
> > -if [ $combined_trash_size -gt 0 ]
> > +if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]
> 
> Nit: if [ -n "$TRAVIS_JOB_ID" ] && [ $combined_trash_size -gt 0 ]
> 
> More importantly: is this necessary, because on Azure Pipelines there
> is no URL from where the logs could be downloaded conveniently and
> reliably?  I wonder whether it's worth to spend the extra effort in
> preparing the base64-encoded trash directories of failed tests in the
> first place.

You're right, of course. There *should* be a way to extract these from the
log even on Azure Pipelines. I did find the API to get the logs, but it
seems that at least for the moment, there is no environment variable
specifying the number of the current task (on Azure Pipelines, the logs
are split by task). So I could not actually figure out any way to generate
the Azure Pipelines equivalent of this URL:

	https://api.travis-ci.org/v3/job/$TRAVIS_JOB_ID/log.txt

But then, this code (which builds tar files of the trash directories of
the failed tests and then logs a base64 version of it) simply is a
workaround in the first place, accommodating for the fact that Travis does
not offer build artifacts. But Azure Pipelines does. So that's what I am
doing with those trash directories now: publish them as build artifacts
(which can be downloaded conveniently as .zip files from the web page
showing the build result).

Thanks for helping me improve this patch series!
Dscho

> >  then
> >  	echo "------------------------------------------------------------------------"
> >  	echo "Trash directories embedded in this log can be extracted by running:"
> 
> 
--8323328-236681125-1548624145=:45--
