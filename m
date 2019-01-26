Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B971F453
	for <e@80x24.org>; Sat, 26 Jan 2019 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAZShz (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 13:37:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:44205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfAZShz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 13:37:55 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFdDB-1gzpIF46Ld-00Ea7o; Sat, 26
 Jan 2019 19:37:47 +0100
Date:   Sat, 26 Jan 2019 19:37:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com> <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9ifAl7vZRVazpK3E8AKcknoeYu2ZX/VpMfbpXX/808WchDzRDso
 5hUoUNjtWrsJMt2/evRviP0zHAiqiin3697yPPng8MrNYKg1VObcvtQi1YHLgZogxrXB7fV
 16UCo5whkGaFtWAje+Kjj63UNnkh+1hw2i+LKgAibj/RuP9eAr1+h+oOLimkAWVwvFuoQHm
 ocXgH9X7RrU7xlcIRLAxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GVceBIuXWE=:HlVXY432OZzAmWg4K5layf
 +nbIgX9fuAI1defZuADFSt5YYjxoG7DMyxzcwJRMKv15f0ZUZaCBiizT7XxP9Ttgt+04GhQkF
 xKQVqNCP8Va9dMT0ov4gtXmj1PAwIMt+Rzdl8pm5lHfDkkEPxLWsBZc0vez27WqqOISMcL1HR
 erEet9Yi0bxYJh+4+i5lRd4w+7+KKaHgEla2BObkIy+JvdJiZ+cIWCcaW4AjhnzKCir0qJssd
 WXcFA8jHS3y2AxVhv4o2lvYV6ithLDuopPl2eymIsGSATbm8QpfddVnuz9c8RUqurBZt1mPHp
 WIoetZkaN5q9mqCy52Jg/dx+rsih9s4IKJBGinC6In/KpkitJo/ImtXlaUUgnyYb9S4Mm1r22
 kT52REAiBvPiVjTEHnq3R0VcBvzdVkJp4y8qxV7t83MJmnKEBi1y5WDeYiZvrNi3+q2c4MJMU
 wLLc2d47iD4pjfbwlx9kS47lsDHE0UMLrEmjJEpo5kTtxa+LEHfAZYXo53eItZ1mTyOw8Jkd6
 T1St9NRgaDleUveyM3emc2Xl+r7b86zDUnQXYyISD7NN+4E6pTdm91d2xN+1bc+1x4+fVXay4
 IN2W8qSTSXHlF97H5SJfUAAYycHTZbNpki02KO8ziPphgO75cxfnji9ModD2mLGtdEsUi39Da
 qCYfq8FytZVhwyj83xnzUBVGn7+3hcdVYBaE/57xyYobFUF76ZlmELp5AgFTalapWMBM8er2n
 mGfJzYqXEm9qAaJdPh0ukmqlZyAWHEVYvPoS+jbNEBDxOlUzlVskcFhzaFmUSmsW09wXHXrsp
 IszW9g/hYnmSw0krJXcgKhjC5iL72JF4JxEriwP/5iqLHczV6V0CBRqaPSfyz96dcdO+5MrHn
 Wo1d5xEK5693v4HldfuZNeKIv6/hv0SawlO0AhXpDcRVn+YEKZ43e0ttXLElYD/uYQJbGttqA
 7UBqWkcLR9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index fe65144152..bcdcc71592 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -37,7 +37,8 @@ osx-clang|osx-gcc)
> >  	brew update --quiet
> >  	# Uncomment this if you want to run perf tests:
> >  	# brew install gnu-time
> 
> Isn't this comment now stale?

No, not really. Actually, not at all.

> It would be, under this new arrangement of the code, most natural for
> Those who want to use gnu-time to arrange it to be somehow added to
> $BREW_INSTALL_PACKAGES, no?

The purpose of BREW_INSTALL_PACKAGES is to list the packages necessary to
build Git and run its test suite, and the only reason why this is no
longer a hard-coded list of packages is that it depends on the CI platform
(or more concretely, on the available macOS agents of said CI platform)
which packages need to be installed to do so.

The gnu-time package is not such a package, and it is unlikely to be
dependent on the particular CI you want to use.

So this spot really is the appropriate place to say that you want to
install gnu-time.

> > -	brew install git-lfs gettext
> > +	test -z "$BREW_INSTALL_PACKAGES" ||
> > +	brew install $BREW_INSTALL_PACKAGES
> 
> It is unclear how this relates to "encapsulate Travis-specific"; it
> is guessable that perhaps only under Travis we'd use
> BREW_INSTALL_PACKAGES, but it still is unexplained why under other
> CIs we don't do lfs or gettext (if that is the plan---that is not
> clear, either).

I added this paragraph to the commit message:

	Also, the configurations of the available agents are different. For
	example, Travis' and Azure Pipelines' macOS agents are set up
	differently, so that on Travis, we have to install the git-lfs and
	gettext Homebrew packages, and on Azure Pipelines we do not need to.

Does that sound good enough?

> >  	brew link --force gettext
> >  	brew install caskroom/cask/perforce
> >  	;;
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
> OK.  I actually was expecting this to be something like
> 
> 	case "$CI_TYPE" in
> 	Travis) ... the reindented travis specific stuff here ... ;;
> 	*) echo >&2 "unknown CI_TYPE: $CI_TYPE"; exit 1 ;;
> 	esac
> 
> to make it equally easy to add not just the second one but the third
> one.

That's a very valid point.

There is not actually a CI_TYPE available, so I still use an `if`
construct, but I added an `else` that will error out if we could not
identify the CI platform.

> > @@ -28,7 +46,7 @@ skip_branch_tip_with_tag () {
> >  # job if we encounter the same tree again and can provide a useful info
> >  # message.
> >  save_good_tree () {
> > -	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
> > +	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
> 
> Makes sense.  $CI_COMMIT is still coming from $TRAVIS_COMMIT but is
> that different from "git rev-parse $CI_BRANCH" I wonder (thinking
> aloud, not suggesting any changes).

Actually, I found out the hard way (a succeeding build that was a false
negative) that `TRAVIS_COMMIT` does, at least sometimes, refer to the
*merge* commit merging e.g. `pu` into `master` (which does not make sense
at all to me, because that's neither what you did nor what you asked
Travis to do for you).

So no, we need to use `TRAVIS_COMMIT` here lest we record a tree that was
not tested.

> > @@ -38,7 +56,7 @@ save_good_tree () {
> > ...
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
> I do not quite understand this change.
> 
> If this wants to say that "we know how to show failures only when we
> know the job id", then testing for $CI_JOB_ID would be more
> appropriate, and if this wants to say that "we know how to show
> failures only when we are running under travis", then it would be
> more appropriate to switch on test "$TRAVIS" = true that is used at
> the beginning of ci/lib.sh (or if you would switch to "case $CI_TYPE"
> there, use the same construct).  I cannot quite make an argument to
> support the use of $TRAVIS_JOB_ID in either case.

I tried to be cheap and *not* introduce that CI_TYPE variable. But you are
correct, it is the right thing to do.

> > +test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> >  gem install asciidoctor
> >  
> >  make check-builtins
> 
> OK, BREW_INSTALL_PACKAGES has an assignment in the travis specific
> section to trigger install of two separate packages, and there is no
> assignment to ALREADY_HAVE_ASCIIDOCTOR in the travis specific
> codepath, so we will end up installing asciidoctor here.  Makes
> sense, even though this one too is under-explained just like the
> other one is.

Hopefully the added paragraph (which says "for example" and then uses the
Homebrew packages as example) is enough to make the reader not puzzled
about this here change, too?

Ciao,
Dscho
