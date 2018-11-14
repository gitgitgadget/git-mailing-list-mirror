Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6311F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbeKNX2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:28:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:38843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeKNX2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:28:06 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxdfb-1fQXyv3fA3-017BVC; Wed, 14
 Nov 2018 14:24:46 +0100
Date:   Wed, 14 Nov 2018 14:24:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] tests: explicitly use `git.exe` on Windows
In-Reply-To: <xmqq5zx0p7ej.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811141422270.39@tvgsbejvaqbjf.bet>
References: <pull.73.git.gitgitgadget@gmail.com>        <cd314e1384312cd5b0c0031efd40c6442074e11c.1542030510.git.gitgitgadget@gmail.com> <xmqq5zx0p7ej.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ewQuxYhOuRh0CYbt4y92/EJ85pj0ysxShGVz2QIQqlel5+i2ZdG
 aJa1aZZL4UKtYCVg0oYZf2ADog6VXHIe5Kfr6cxTtm5JiAD6x6lf68sdZYNbJg1InApbKpw
 /dQ6TdyFAE8K9YKyPMIARL5TNMhrj/09fk7mqC5D/G94yhg1R8cm7BgDrfhiKvV9Kw0Kc+U
 P2ntkTXvwNe04Jwy6v4/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8JyEzsWv18w=:BavcYJIFbaOFoynEtLzbV7
 NRVPbB8lw4dlzj3yIC8/wN0+//CQboqIRZsNOkq36s8+/bxdHp84t4yOdLneb7yNbtqPs7gf5
 N//VMpKz3A+SPWzYComsX5jGDYi/iucL+RjdF2ycZ9VM9tBVm7Yf5pfnFlEsB6cx7iso6xZfW
 tuozdqIt3p+LYhZzMHkfnTs1Qxi9J7F8N+neiddkDQrMn57oua1UPdW8vC0LxY4nsTNaSNhHr
 r20OLRlqYNbxoSH2pvOK3XnJAq3V1KB+noBQB1eV7LwOv4pRLAxdemcVMzpzeYmDPYCDgGxtH
 oHegY9BxVLvldmcR7RZeC4dWxmBeQ5oBcBxt84qIvwpoHlLpFuumwMXHczKEuSr4fPjLmLcNJ
 44ITkT52gfiGSyd45bJZDgEMpS97RNh3efwgOI7v3Rgld7O3qHdwohdY0XL63j2LdsXZROmlh
 GQMTgOU/IjfKrXeZZEN0j4TGIFTS3pa5Ofv/+iN+tKH+2YOtqGEwNxTnKh4xwJRlCdoNblUfI
 wz9leNf+YDzO8sz8ozq90GMC7CH0MlSR7xmh+YDkvaZOrZk9/HuQ/zbeYEW63lsmzRN6wt2ll
 wLYSC8iQJIO+L2OH0x2skB2jJ6xSeDxc9lAjvw9mXYixtmLs7nrhqs1CTb1QE+DlQRzvHu4ty
 cdpEZjpLOztdUTOVPhtHhJ5DrEoBaJJQZiI7KLz05AbZtQxX8Ev5phCIdq2T/xNy42XK/eblL
 nnI2KMEqz0M8tB9Te22G2e4q52STOXKmeQ+4e0rUT5siVkAUHC3+QgAMeMKp4nzFauVfnZ66X
 ttCQ34uv+SMaSJDE87/h95Lpn+KWihj7JashEVe0wmpad6kJ9coWRpjOfxKlNrQ0ClM7Aamde
 HcUpWlR75KGdEof1dhBJX+kEH8LOZVWjsSO6zz0slBYjxCL2Q8Dy1KtILqnJkWffN3V/XiHzz
 eVIF6CUfLHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index bbfbb4292d..5df0118ce9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2590,6 +2590,7 @@ GIT-BUILD-OPTIONS: FORCE
> >  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
> >  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
> >  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
> > +	@echo X=\'$(X)\' >>$@+
> 
> Made me wonder if a single letter $(X) is a bit too cute to expose
> to the outside world; as a narrowly confined local convention in
> this single Makefile, it was perfectly fine.  But it should do for
> now.  Its terseness is attractive, and our eyes (I do not speak for
> those new to our codebase and build structure) are already used to
> seeing $X suffix.  Somebody may later come and complain but I am OK
> to rename it to something like $EXE at that time, not now.
> 
> >  ifdef TEST_OUTPUT_DIRECTORY
> >  	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> >  endif
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 801cc9b2ef..c167b2e1af 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -900,7 +900,7 @@ test_create_repo () {
> >  	mkdir -p "$repo"
> >  	(
> >  		cd "$repo" || error "Cannot setup test environment"
> > -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
> > +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> 
> Good.
> 
> >  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> >  		error "cannot run git init -- have you built things yet?"
> >  		mv .git/hooks .git/hooks-disabled
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 1ea20dc2dc..3e2a9ce76d 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -49,18 +49,23 @@ export ASAN_OPTIONS
> >  : ${LSAN_OPTIONS=abort_on_error=1}
> >  export LSAN_OPTIONS
> >  
> > +if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> > +then
> > +	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
> > +	exit 1
> > +fi
> 
> OK, this tells us that we at least attempted to build git once, even
> under test-installed mode, and hopefully people won't run $(MAKE) and
> immediately ^C it only to fool us by leaving this file while keeping
> git binary and t/helpers/ binary unbuilt.
> 
> > +. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> > +export PERL_PATH SHELL_PATH
> > +
> >  ################################################################
> >  # It appears that people try to run tests without building...
> > -test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
> > +test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git$X" >/dev/null ||
> 
> The latter half of this change is a good one.  Given what the
> proposed log message of this patch says
> 
>     Note also: the many, many calls to `git this` and `git that` are
>     unaffected, as the regular PATH search will find the `.exe` files on
>     Windows (and not be confused by a directory of the name `git` that is
>     in one of the directories listed in the `PATH` variable), while
>     `/path/to/git` would not, per se, know that it is looking for an
>     executable and happily prefer such a directory.
> 
> which I read as "path-prefixed invocation, i.e. some/path/to/git, is
> bad, it must be spelled some/path/to/git.exe", I am surprised that
> tests ever worked on Windows without these five patches, as this
> line used to read like this:
> 
> 	"$GIT_BUILD_DIR/git" >/dev/null
> 	if test $? != 1
> 	then
> 		...
> 
> Wouldn't "$GIT_BUILD_DIR/git" have failed (and "executable not
> found" hopefully won't produce exit code 1) and stopped the test
> suite from running even after you built git and not under the
> test-installed-git mode?

"$GIT_BUILD_DIR/git" did not fail until I regularly built with Visual
Studio (and my Visual Studio project generator generates a directory named
"git" to live alongside "git.exe").

And when it failed, I patched Git for Windows. Fast-forward, years later I
managed to contribute the patch we are discussing right now ;-)

So yes, it is primarily a concern when testing Git in specific setups
where a "git" directory can live next to the "git.exe" that we want to
test. Not necessarily a big deal for most developers on Windows.

Ciao,
Dscho

> 
> >  if test $? != 1
> >  then
> >  	echo >&2 'error: you do not seem to have built git yet.'
> >  	exit 1
> >  fi
> >  
> > -. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> > -export PERL_PATH SHELL_PATH
> > -
> >  # if --tee was passed, write the output not only to the terminal, but
> >  # additionally to the file test-results/$BASENAME.out, too.
> >  case "$GIT_TEST_TEE_STARTED, $* " in
> 
