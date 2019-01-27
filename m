Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FAA1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfA0S0G (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 13:26:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:56779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfA0S0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 13:26:05 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1hRoVe1bGc-00eQ7K; Sun, 27
 Jan 2019 19:26:00 +0100
Date:   Sun, 27 Jan 2019 19:26:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 08/21] ci/lib.sh: add support for Azure Pipelines
In-Reply-To: <xmqqimyf54gx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901271925450.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <178dc9b789caef8e2402ab518bb5ca36da2c32ad.1548254412.git.gitgitgadget@gmail.com> <xmqqimyf54gx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7QXuuQQ/jP6RfE5BQOSlgEW3ue6W/MPkrCQUnpE0jLEOvXeBjXh
 oGWm3DamooG0F+hYOnxwwf21vVzsKZbTmPJ4UtgUpCxyiKrPUSqasDfHw0MaHLXWFc+cfUv
 aS4iqDcxxsDrIvEeuZ3lmRQ7j35gxOzTkZMR8IHqH0xdUpvyjd443FrEtYsmLoluKh4iTp1
 bv+HLjGlmHj4GT8Hq8CJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cMX8iUVexbw=:cZO8K0Xk13xCSOJFUXR7cV
 j+bVy6BdadaJ50i0GTUPbKkYd7pq5a5D+/QzA0I3Dt7qn0wLaiNUk3bgE8WNhsNQWPj9s0kHU
 vvxY7NQLspDfMTMkZY5UiZQup4EA2G7IC1dCysU23pU1uC40d0Jyy9Acqwm6GQHClNLdnKgBl
 FoDxkpIyquOGbGnC4iLRwRwISaOu2ez3Ld70khK4vTx9gCrV/MFlDtW0znhsLGkU9iGUgIVFS
 /2zkgxG+xzr/k8IHMER1HXtp2J4//4z7/Upe/PTp9p7z7Vg/6JX3D5BDt/isy+PAjYNuiH4aU
 o+tTslPQ/h7Y0PXVfmdqIPTF9IvidllPu9TaEO3iSvQAB79JNWLB4MR8QyhHA0oU72ysPvCEw
 exhNMTipjyFY3ui3lIRw/WYoF0Su2WGgHE6pZGLFNHOLmzf3NH7kyoIoeE3rykVNmXqta3Q6Q
 0idDKxiuf3jPcCS7+g3kngr8+zwIJvk86U3EqNlib6q8RZHtZ08jt0z4bwllYfVaDxY0BVrzL
 V1kzKjMdaCkFp3HWOWX+N245XgiIjnBW/fE6+4oG9EYgGBgIHtmsOEeyVgNcnMmi3Su4gESdZ
 gtsAph2KtlMp0RnjicMVn2ZHH7aLqfQQsVq4mbJgy1/Z86ZNur+1tKQiQdAhEOUH4xTd6nHko
 dRIZeDM/6ijHXzcYvf4MASXSSIHCBpbzPB8kN4THVDGbvwjP1eKYJsVGISph10c9I0DKtXaxy
 qMzfH4zsgxtiWCuhwxz1hUDyrfoEyguPGQwXFdY5HXMEzKCqhTQkYn5uRNjIHNdGF3ZVs+Jcy
 GplviI8ND9pdAFDk2b52p2m6pPWrhnWMgyoCOpE5/jkoDq2Og8oTDFjNQA/kasWR/7SI6el+4
 4JFTbRdK83QLokIc3QSplc/+YIYwlxv2srXpC0GPibzVfyxjJ7Wcbhd9LQF7vIQSK34RcdH9P
 ubWavyGhQ2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This patch introduces a conditional arm that defines some environment
> > variables and a function that displays the URL given the job id (to
> > identify previous runs for known-good trees).
> >
> > For example, we do not have to install the git-lfs and gettext packages
> > on Azure Pipelines' macOS agents: they are already installed, and trying
> > to install them again would result in an error.
> 
> The rationale in the second paragraph is shared with the earlier one
> that introduced BREW_INSTALL_PACKAGES variable in the first place.
> It would have made more sense if it was explained there (i.e. say
> "in environments other than Travis, some packages may be pre
> installed and asking to install them again may cause failure, so
> make it configurable what to install")---that way, the explanation
> in this step's log message can just say "Because Azure pipeline's
> macOS agents already have git-lfs and gettext installed, unlike
> Travis, we can leave BREW_INSTALL_PACKAGES empty".

Makes sense.

Will do that,
Dscho

> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/lib.sh | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 4456dbbcb0..a9eb4f4eae 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -20,6 +20,29 @@ then
> >  	BREW_INSTALL_PACKAGES="git-lfs gettext"
> >  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> > +elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
> > +then
> > +	# We are running in Azure Pipelines
> > +	CI_BRANCH="$BUILD_SOURCEBRANCH"
> > +	CI_COMMIT="$BUILD_SOURCEVERSION"
> > +	CI_JOB_ID="$BUILD_BUILDID"
> > +	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
> > +	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
> > +	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
> > +	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
> > +	CC="${CC:-gcc}"
> > +
> > +	# use a subdirectory of the cache dir (because the file share is shared
> > +	# among *all* phases)
> > +	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
> > +
> > +	url_for_job_id () {
> > +		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
> > +	}
> > +
> > +	BREW_INSTALL_PACKAGES=
> > +	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> > +	export GIT_TEST_OPTS="--quiet --write-junit-xml"
> >  fi
> >  
> >  skip_branch_tip_with_tag () {
> 
