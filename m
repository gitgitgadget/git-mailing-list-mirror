Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D7F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfAQN2z (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:28:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:39985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQN2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:28:54 -0500
Received: from [10.49.97.215] ([95.208.59.108]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBWIM-1gubqy3Cru-00AUuE; Thu, 17
 Jan 2019 14:28:46 +0100
Date:   Thu, 17 Jan 2019 14:28:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] travis-ci: don't be '--quiet' when running the
 tests
In-Reply-To: <20190117012913.30562-4-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901171427090.41@tvgsbejvaqbjf.bet>
References: <20181220162452.17732-1-szeder.dev@gmail.com> <20190117012913.30562-1-szeder.dev@gmail.com> <20190117012913.30562-4-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1856440331-1547731726=:41"
X-Provags-ID: V03:K1:tMKD3gGd51EBlnD3hVE7pS3aJvDUeqEuc3vFFDdRVR4ju55CYye
 G50vH/wBx0i4L0tbergQnbdhdRXraV4MhkPepoN2wS20YHZh408Jff2+nFQemhRFsGE2uHN
 MvMnktSCrzmrDdqQXCR2GQm+nPUAYbL0ZGuOswBEJWsh2PhWPpdK7CfLZBz/lpSvuKup1aa
 8U1F8mYzxxuUIq51C4JsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9aLKM0PFqco=:6H6MLdi0PBSMyqhDqsKKWz
 zjWG8fq3K6TBV3q+PiCg7yA/ym/NjhdpykitQM3zGYUB56/L1voqmf7miJodUDA+Kot3dhdEG
 iQIFxFfQTo0qVG9F2luISbBjuD79Sr/pEfwRG3rfB/0aSQlPstnBKMjIBm4ZmKrWHpyiRF1XV
 z8BIzf8hcFq/qK6+3BJ70DR20RznQmxGsmoS5X9PvmN1850hhDZTgC5Mp58Gngzz5RlcpA1dU
 TsR2uLYNNloQSU64uGrQsK92i0bNkS0RSBtkJIyuhfU1S6MHLk8Sv4A6E0bPHG/dJH/BL5lzc
 JIZFpgySxrupaLYjkHrGIZWcWW0MgFqGTgdws/iwcpoL4WJeAuHbqyM1pCTQBXa4lZ3G1vv8B
 Goy7j8bUBRvMMAG/xdEexIgDJv/o3H685uxvGCw7v2AGv3MWWX3ea9cx5Vmj3W/hT9agMg8xR
 NjrHEuz219DAiRj3aoZAcpwQd9EJa5/QKK7iRn/zPCWRGdOf/o7RIqgZUV2Ea+ok7hBqzloOt
 7nG3VHtyX7N83n5Muip3tQW47oR68Os2rU2ek2uTX078Dic2k2R+7GhAYqVoRsEYVTm0bO5sM
 Pt2zVPtOXTfMCSEe6uq6o3h6Ab/uiQH+D7uo8S/llrKFCzCCk0it6GxQ71/kADDx8U/Eq1WQ/
 wu4Q83+pBa28A950+0mnblcF8FAJc+AGRwA3CYjE4azN+Nh9IOsvB3gkO5xT30XYSCDc2pmIy
 VbAeX7dnXPtDYIkhKuU0APvcDIm7odrWbmcLC+gsM2GqAezc+VJxj8jeDekXW4kPPIbOuByn/
 bSDvJOA4irF2d7TbCmfi0vTzYSNmQsOvBaQm/90qiIGd4VxxydhD3HKWQfr4DoUMIWtLGpZW8
 71OmmfM0+Jb65xCZiDbAcDHqGayrR9UX59ABs+IFg9ghoHmV1REL+O/SwqQXzzaRNiJkFcR+q
 97fm72wYWeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1856440331-1547731726=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 17 Jan 2019, SZEDER Gábor wrote:

> All Travis CI build jobs run the test suite with 'make --quiet test'.
> 
> On one hand, being quiet doesn't save us from much clutter in the
> output:
> 
>   $ make test |wc -l
>   861
>   $ make --quiet test |wc -l
>   848
> 
> It only spares 13 lines, mostly the output of entering the 't/'
> directory and the pre- and post-cleanup commands, which is negligible
> compared to the ~700 lines printed while building Git and the ~850
> lines of 'prove' output.
> 
> On the other hand, it's asking for trouble.  In our CI build scripts
> we build Git and run the test suite in two separate 'make'
> invocations.  In a prelimiary version of one of the later patches in

s/prelimiary/preliminary/

> this series, to explicitly specify which compiler to use, I changed
> them to basically run:
> 
>   make CC=$CC
>   make --quiet test
> 
> naively thinking that it should Just Work...  but then that 'make
> --quiet test' got all clever on me, noticed the changed build flags,
> and then proceeded to rebuild everything with the default 'cc'.  And
> because of that '--quiet' option, it did so, well, quietly, only
> saying "* new build flags", and it was by mere luck that I happened to
> notice that something is amiss.
> 
> Let's just drop that '--quiet' option when running the test suite in
> all build scripts.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

Just like the first two patches, this makes tons of sense to me.

I thank you and will read on,
Dscho

> ---
>  ci/run-build-and-tests.sh | 4 ++--
>  ci/run-linux32-build.sh   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index cda170d5c2..84431c097e 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -8,7 +8,7 @@
>  ln -s "$cache_dir/.prove" t/.prove
>  
>  make --jobs=2
> -make --quiet test
> +make test
>  if test "$jobname" = "linux-gcc"
>  then
>  	export GIT_TEST_SPLIT_INDEX=yes
> @@ -17,7 +17,7 @@ then
>  	export GIT_TEST_OE_DELTA_SIZE=5
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
> -	make --quiet test
> +	make test
>  fi
>  
>  check_unignored_build_artifacts
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index 2c60d2e70a..26c168a016 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -56,5 +56,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
>  	cd /usr/src/git
>  	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
>  	make --jobs=2
> -	make --quiet test
> +	make test
>  '
> -- 
> 2.20.1.499.gf60de1223c
> 
> 
--8323328-1856440331-1547731726=:41--
