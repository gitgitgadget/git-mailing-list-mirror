Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE991F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdL0TQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:16:02 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38976 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdL0TQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:16:01 -0500
Received: by mail-wm0-f53.google.com with SMTP id i11so40630986wmf.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Lo5qqHH5OKT9s9OpNK/x1TmZwN5qY+dQ43uqlPA5BEc=;
        b=afML20BrtwUWRgrjLz4Exln2/7HWDfaZTDbYOVDr0b+x/9fIWy9uXpKTDUGaNhr/7K
         zX5rRu3E7OLdTxBL8ueFbcc7eLq9zxbM0iJtRfr4BHHHkPOQuZ4d7iN/GkqS8yyntav0
         GrogBgvewXAbu4kf3zwzeK32E0rCwfRF1L7nMEJ3o06ysFqHt/T/Mdz3ikXt+viU7u4W
         tQ8+fggkDtQHy3/K0goFQ5P9uYW1PwoJm3RuZz+a7oDTX+IITFuNdZbeZi/oV8uxmbf6
         k7CuHZZXbS3HdKsx4lhrvp5X89CEvNsl1M3Zx/qey5UnQknFMqrZrhDF3MJMhXjACPF6
         8w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Lo5qqHH5OKT9s9OpNK/x1TmZwN5qY+dQ43uqlPA5BEc=;
        b=ulApjcWaUbsBftImtx1456liniT0mV9i5C5an3uIhRxwfMa9IHqmdirE1W068FAiNw
         lOhu6dHQaN/rvSU7FpfjjRJ8scwx5cAOK9Ka5DhA5t28zI8ba5gdTREKoD0GR+g9IAof
         VQmiQ8YYU447nxc50SuYBkvmrtuNIxSO/p6uc5gKCtHfCpbD/gGqX2W3YMw7BzLuA1NN
         MGDRLhQ/8DEZP/WaVOYpzKpAIGB/+6kczBjpEQKkcW3daatDzdRyvayWclegMcvAZbhc
         lA3LCbXA7qTCv85XxlQIdQsmuVRqOzQKY6wI43Xz22dF9By7FpgYpE3g+2MHB8KhFb7D
         DuAA==
X-Gm-Message-State: AKGB3mLFthZQyfqtugTmPKRSSXePRuwUJj8RXYW4dze45dQ6keOTMbgm
        phPfu1puZ8LOMs3Nz9yoTiJvG5yO
X-Google-Smtp-Source: ACJfBotKNFNOiDqNc95dA0Jzd/um+Z/CZT1x4HbJge9diX/O/kGwSaSMuOQgpc8YUu8frRvdeeEpwQ==
X-Received: by 10.28.224.137 with SMTP id x131mr23913167wmg.49.1514402159652;
        Wed, 27 Dec 2017 11:15:59 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5682.dip0.t-ipconnect.de. [93.219.86.130])
        by smtp.gmail.com with ESMTPSA id w11sm23277577wrg.41.2017.12.27.11.15.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 11:15:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171227164905.13872-3-szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 20:15:58 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> Travis CI dutifully builds and tests each new branch tip, even if its
> tree has previously been successfully built and tested.  This happens
> often enough in contributors' workflows, when a work-in-progress
> branch is rebased changing e.g. only commit messages or the order or
> number of commits while leaving the resulting code intact, and is then
> pushed to a Travis CI-enabled GitHub fork.
>=20
> This is wasting Travis CI's resources and is sometimes scary-annoying
> when the new tip commit with a tree identical to the previous,
> successfully tested one is suddenly reported in red, because one of
> the OSX build jobs happened to exceed the time limit yet again.
>=20
> So extend our Travis CI build scripts to skip building commits whose
> trees have previously been successfully built and tested.  Use the
> Travis CI cache feature to keep a record of the object names of trees
> that tested successfully, in a plain and simple flat text file, one
> line per tree object name.  Append the current tree's object name at
> the end of every successful build job to this file, along with a bit
> of additional info about the build job (commit object name, Travis CI
> job number and id).  Check, using a simple grep invocation, in each
> build job whether the current commit's tree is already in there, and
> skip the build if it is.  Include a message in the skipped build job's
> trace log, containing the URL to the build job successfully testing
> that tree for the first time and instructions on how to force a
> re-build.  Catch the case when a build job, which successfully built
> and tested a particular tree for the first time, is restarted and omit
> the URL of the previous build job's trace log, as in this case it's
> the same build job and the trace log has just been overwritten.
>=20
> Using an ever-growing flat text file might seem like asking for
> trouble on the long run, but it's perfectly adequate for this purpose.
> Contributors' topic branches are short-lived in general, so this file
> won't grow large enough to cause any issues.  Grepping through several
> tens of thousands such lines is sufficiently fast, so not even
> git/git's forever living integration branches will cause scalability
> issues with the current rate of ~1 push/day for a couple of decades.
> And even if we reach the point that this file grows too big, the
> caches can be deleted on Travis CI's web interface.
>=20
> Note: this won't kick in if two identical trees are on two different
> branches, because Travis CI caches are not shared between build jobs
> of different branches.

This is a nice idea. If there are no other objections to this approach=20=

then I will forward it to the TravisCI folks. Maybe they are willing to=20=

implement this natively to safe some more cycles beyond */git ;-)


>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh        | 43 =
+++++++++++++++++++++++++++++++++++++++++++
> ci/run-linux32-docker.sh  |  2 ++
> ci/run-static-analysis.sh |  2 ++
> ci/run-tests.sh           |  2 ++
> ci/run-windows-build.sh   |  2 ++
> ci/test-documentation.sh  |  2 ++
> 6 files changed, 53 insertions(+)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 348fe3c3c..05e73123f 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -21,6 +21,48 @@ skip_branch_tip_with_tag () {
> 	fi
> }
>=20
> +good_trees_file=3D"$HOME/travis-cache/good-trees"
> +
> +# Save some info about the current commit's tree, so we can skip the =
build
> +# job if we encounter the same tree again and can provide a useful =
info
> +# message.
> +save_good_tree () {
> +	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT =
$TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
> +}
> +
> +# Skip the build job if the same tree has already been built and =
tested
> +# successfully before (e.g. because the branch got rebased, changing =
only
> +# the commit messages).
> +skip_good_tree () {
> +	if ! good_tree_info=3D"$(grep "^$(git rev-parse =
$TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
> +	then
> +		# haven't seen this tree yet; continue the build job
> +		return
> +	fi
> +
> +	echo "$good_tree_info" | {
> +		read tree prev_good_commit prev_good_job_number =
prev_good_job_id
> +
> +		if test "$TRAVIS_JOB_ID" =3D  "$prev_good_job_id"

Under what circumstances would that be true?

Nit: One unintended space after =3D ?!

> +		then
> +			cat <<-EOF
> +			Skipping build job for commit $TRAVIS_COMMIT.
> +			This commit has already been built and tested =
successfully by this build job.
> +			To force a re-build delete the branch's cache =
and then hit 'Restart job'.
> +			EOF
> +		else
> +			cat <<-EOF
> +			Skipping build job for commit $TRAVIS_COMMIT.
> +			This commit's tree has already been built and =
tested successfully in build job $prev_good_job_number for commit =
$prev_good_commit.
> +			The log of that build job is available at =
https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
> +			To force a re-build delete the branch's cache =
and then hit 'Restart job'.
> +			EOF

Maybe add a few newlines before and after EOF to make the text more =
stand out?
Or print it in a different color? Maybe red?

See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625

Thanks,
Lars


> +		fi
> +	}
> +
> +	exit 0
> +}
> +
> # Set 'exit on error' for all CI scripts to let the caller know that
> # something went wrong.
> # Set tracing executed commands, primarily setting environment =
variables
> @@ -28,6 +70,7 @@ skip_branch_tip_with_tag () {
> set -ex
>=20
> skip_branch_tip_with_tag
> +skip_good_tree
>=20
> if test -z "$jobname"
> then
> diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
> index 3a8b2ba42..870a41246 100755
> --- a/ci/run-linux32-docker.sh
> +++ b/ci/run-linux32-docker.sh
> @@ -22,3 +22,5 @@ docker run \
> 	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
> 	daald/ubuntu32:xenial \
> 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
> +
> +save_good_tree
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index 68dd0f080..fe4ee4e06 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -6,3 +6,5 @@
> . ${0%/*}/lib-travisci.sh
>=20
> make coccicheck
> +
> +save_good_tree
> diff --git a/ci/run-tests.sh b/ci/run-tests.sh
> index ccdfc2b9d..eb5ba4058 100755
> --- a/ci/run-tests.sh
> +++ b/ci/run-tests.sh
> @@ -7,3 +7,5 @@
>=20
> ln -s $HOME/travis-cache/.prove t/.prove
> make --quiet test
> +
> +save_good_tree
> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> index 86999268a..d99a180e5 100755
> --- a/ci/run-windows-build.sh
> +++ b/ci/run-windows-build.sh
> @@ -99,3 +99,5 @@ gfwci "action=3Dlog&buildId=3D$BUILD_ID" | cut -c =
30-
>=20
> # Set exit code for TravisCI
> test "$RESULT" =3D "success"
> +
> +save_good_tree
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index 7a0a848e8..3d62e6c95 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -25,3 +25,5 @@ sed '/^GIT_VERSION =3D / d' stderr.log
> ! test -s stderr.log
> test -s Documentation/git.html
> grep '<meta name=3D"generator" content=3D"Asciidoctor ' =
Documentation/git.html
> +
> +save_good_tree
> --=20
> 2.15.1.500.g54ea76cc4
>=20

