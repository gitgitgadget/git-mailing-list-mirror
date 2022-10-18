Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8AC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJROsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJROsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B5D7E34
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666104498;
        bh=FFr9IJXEwB4QCHNSL/mcAGeoZUI+e1quOhnjnMHac6U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i+6QBjeOYdzJ7nFbepEfGRInjgsFQ9ju8XF3HQLvCr2ccd2Wwmqd2s25QFTJsgH+U
         0BVwPG/4V28qFHRIOSbEdXr1QGu9cJktfd7mlKfo76v+AykFgYtSyxM/BmQ2SFse0T
         WXOuYnkS1kw24vrCb5WSKroomuNTLrd0TpYMB0iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1pLUPw2any-00gWlI; Tue, 18
 Oct 2022 16:48:18 +0200
Date:   Tue, 18 Oct 2022 16:02:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
In-Reply-To: <220811.86sfm3ov5z.gmgdl@evledraar.gmail.com>
Message-ID: <3q98po6o-561o-0r9n-qsqp-1052oqpo889r@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com> <220811.86sfm3ov5z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1872230682-1666079959=:174"
Content-ID: <p80sr726-n92s-r201-0s83-s392ors82q11@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:a0yIW6QKz++dNMlLotrDd1REMlDNYTuTYej6HDKA3/6uidxmcz6
 L7s1CMAelJtMs1WX5DNj7NGv9ph1swqIO+cv+BOymXiXTK55zjey1S1qk9uCFGlZNIklhOb
 crwAr4NlsOXn50gywruuurDmhca5eAP6ayBthBzBXYApXR8ozdqSzeU9ilTI0zlpTSr5RU5
 yOulylVTnsBb09/JMtDsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P4UpFdunAdM=:xHZoEPEKeFeBiER3Sfhep2
 J6Pd7jgO/6CjmDVut+w2h2KOMaUfkdNAMRRHsJR6wXxA64c28cmR3MXYAEXsSHFGI9CMf7XB6
 lPkikDjxlXLf+5C9qru/tilRcE6l7tekcd6zV0a21BChhvTwOUd5dMmkPs9EERZv5APacnzCH
 1vXegrGhHx7+4BLbssl5VdgC3TBYZ0Zj+AS/uF5i9yC7IX19GDa05wxls1wipoEje9cnHNCRR
 NBTf3QIZoQe9kiIJK0K48UxPS1l7BoI8xHAtQKGyYCm25q9TJQp63ggq+c7kbYCkd58/4+dXi
 8fz1ktgmbrrYxdBRYUkk4pykNIOpJFg480GmzJ9T3jEPuU5ZyxwtB+LQhrg6GOpB/MnfvpE3q
 4ueAatwU0LkaGjNQ0CLxYaZpxE8BN6wy0ymWNjt1w1zhDjGqQ05aBLlkyFH89jGVW7cjOyFnk
 7b0ieQMhWdSHSqR4Bjif8nKm4OogUVR8Z76+k89VGMpPl2JH0owkkvyX448R0I8f0zta2GOIJ
 9Q3YBi847yj6P77KhcR+rcNxeeTOZ6MGahtwqHRBu7JprN9xMplBw6uN0J0i53tb03iOqUe8X
 yb80fNnXqeh7nPW2WZTH3qNmnu2CTANQWzL5uuCH7flHru9BKmKyx5hiMi9j48DNL5sIeb+jU
 n+B57Jl8zDkQFlhke9RUpBybQBYVhxtmcNIKxr4+WMJaGH1Nr3ZYZM3Z1/ZzZ9gnqejPQYhx3
 VpIyhDz7Y8ZdrxvsEkTMfsxPS9pjROKtK00fJ6buu2SboPesMaipalFdHHn5sdScdjr63S6t8
 c2KOgAWPdBYKzBn856iYtXvcHwqb35XP+n9O8ct/EpQ0ehZmDG4lhJBZvKuUmFg7uvNVRDyYy
 CFj4PQXukJAzvzaYfHNXAHVktcwbvfLP5ixcqY4z+VEQ57aOuEIqlT2F8Po8Z8Rd0dh8Iqzfa
 7HN1o5Ff1LCLxTuk25co9jrseGd47vGdgPOBuEW+veVYY6CKXdBaA52ywXAgMyriNbnbU0k09
 qdkHnGrngrJhEjW1tokGGSJVL/4HujCKfZbDm41ULaWoVwlLBCsCrzMDh6kog9zRftdKk9HA5
 TvHUxqBo+AerGQQoPdfFmMeR3BeNB4XIavavzNLqxVMvwPt3U2RDOnU4chlUp6VO+wRKfDAT9
 /OxSSWxzG+YnjHVdg96Ye1R8bqtDqDPIT3v9w4sGQEor7VyTKC0TKiArmwMAgO1AGL/HKqAQD
 o0e7UF/4bm1bYQ2I/xKtyNDSD1G9DoH8cSCbs5LHdH01BE2l/6ZK/KBD+ykrcvRlIOFcwP9dc
 AzfnJRC3P91d8JxUVIzCCgIdzMt4rwm89mr1bxoWeIKYOY4NdWiQNvSCBlGGQNI0oYb2zcu1Z
 lVgenRI9jytI+poBdb3Y2p7uTcyvyOwB+ntYeGqKxrgb7cLycKL+w4qi68pbdWHwxz7aUIJrr
 7Jo5Xy96B+Fr4u+8vmD8PAAuRX1m6QY445JiKOoHvbgR6YytdYR0xVmm+OOqJ/Y1h19/WTZ0Q
 gU+r+q0p/PdPJCSlQV5LZ95r7UH4K7c6AEXWU3Lg0Nd2lzlwX0xU3c3oPSrYTNx2+aQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1872230682-1666079959=:174
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <490o3s8s-5304-5365-5qn1-376588135s50@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Thu, 11 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Aug 10 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 7f5397a07c6c (cmake: support for testing git when building out of t=
he
> > source tree, 2020-06-26), we implemented support for running Git's tes=
t
> > scripts even after building Git in a different directory than the sour=
ce
> > directory.
> >
> > The way we did this was to edit the file `t/test-lib.sh` to override
> > `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> > directory.
> >
> > This is unideal because it always leaves a tracked file marked as
> > modified, and it is all too easy to commit that change by mistake.
> >
> > Let's change the strategy by teaching `t/test-lib.sh` to detect the
> > presence of a file called `GIT-BUILD-DIR` in the source directory. If =
it
> > exists, the contents are interpreted as the location to the _actual_
> > build directory. We then write this file as part of the CTest
> > definition.
> >
> > To support building Git via a regular `make` invocation after building
> > it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (fo=
r
> > convenience, this is done as part of the Makefile rule that is already
> > run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> > up to date).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .gitignore                          |  1 +
> >  Makefile                            |  1 +
> >  contrib/buildsystems/CMakeLists.txt |  7 +------
> >  t/test-lib.sh                       | 11 ++++++++++-
> >  4 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/.gitignore b/.gitignore
> > index a4522157641..b72ddf09346 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -2,6 +2,7 @@
> >  /fuzz_corpora
> >  /fuzz-pack-headers
> >  /fuzz-pack-idx
> > +/GIT-BUILD-DIR
> >  /GIT-BUILD-OPTIONS
> >  /GIT-CFLAGS
> >  /GIT-LDFLAGS
> > diff --git a/Makefile b/Makefile
> > index 04d0fd1fe60..9347ed90da7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3028,6 +3028,7 @@ else
> >  	@echo RUNTIME_PREFIX=3D\'false\' >>$@+
> >  endif
> >  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> > +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
> >
> >  ### Detect Python interpreter path changes
> >  ifndef NO_PYTHON
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index fe606c179f7..29d7e236ae1 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -1067,14 +1067,9 @@ endif()
> >  #Make the tests work when building out of the source tree
> >  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMa=
keCache.txt ABSOLUTE)
> >  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> > -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BI=
NARY_DIR}/CMakeCache.txt)
> > -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_R=
ELATIVE})
> >  	#Setting the build directory in test-lib.sh before running tests
> >  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL =
REGEX \"GIT_BUILD_DIR=3D(.*)\")\n"
> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CON=
SUME)\n"
> > -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=3D\\\"$T=
EST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> > -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> > +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}=
\")")
> >  	#misc copies
> >  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BI=
NARY_DIR}/t/)
> >  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DI=
R}/po/)
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 55857af601b..4468ac51f25 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -42,7 +42,16 @@ then
> >  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
> >  fi
> >  GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
> > -if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> > +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> > +then
> > +	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> > +	# On Windows, we must convert Windows paths lest they contain a colo=
n
> > +	case "$(uname -s)" in
> > +	*MINGW*)
> > +		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
> > +		;;
> > +	esac
> > +elif test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> >  then
> >  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?"=
 >&2
> >  	exit 1
>
> So we'll now skip the assertion added in 9dbf20e7f62 (test-lib: correct
> and assert TEST_DIRECTORY overriding, 2022-02-27), shouldn't these tests
> run inside a "t" directory generated in contrib/buildsystems/ ?
>
> This really seems like a hack-upon-hack, and will break some workflows
> when you switch back & forth, e.g.:
>
> 	make
> 	# run cmake
> 	make -C t
>
> Will now pick up this new file, and result in broken tests, as we'll
> rely on the now-stale file.
>
> IOW you're making the assumption that by piggy-backing on the
> GIT-BUILD-OPTIONS rule that anything that needs it will also *re-run
> it*, but that's not the case.
>
> I can think of ways to get around it, but it would be nasty as we'd need
> to complete the dependency graph between the two, and figure out the
> various interactions.
>
> But why do we need this at all? Right now I tried:
>
>  * (Manually) removing the existing hack
>  * Copying t/*lib*.sh over to contrib/buildsystems/t
>  * cd contrib/buildsystems/t
>  * ../../../t/t0001-init.sh

I appreciate that you want to make it easier for developers. From my
experience with (Windows) developers, I have to point out that what you
describe is _not_ easier than `cd t && ./t0001-init.sh`, though.

It might be easier from some point of view that seems vaguely familiar,
but the user experience of this approach looks prohibitively bad to me.

> Which (aside from a small fixable nit about oid-info) Just Works,
> because the cmake build is already creating a GIT-BUILD-OPTIONS.
>
> Presumably that "copying" step should be simlynking, or we'd be smarter
> about doing includes from test-lib.sh.
>
> But isn't that a much better approach? Rather than working around the
> directory discovery just teach it to run from the generated t/ directory
> directly?

I am sure I could poke more holes into that approach, probably whipping
out something something about `contrib/`, but the user experience alone
(so, dear developer, contrary to what you read in the README and in other
documentation flying all over the internet, yes, you need to switch to
`contrib/buildsystems`, no wait, there's a typo, there's no dash between
`build` and `systems`, there you go, why `buildsystems`? Well, it's just
the way it is. Yes. Now, type out, no, no, wait, *wait!*, you cannot run
`t0006-date.sh` directly as documented, no, wait, you need to prefix it
with this here, and now carefully count the dots, yep, that's right, six
dots in total, three slashes, then a `t/`, yes, I know you were already in
`t/` but not _that_ `t/`, there are now two of 'em, yes, it is
unintuitive, you're absolutely correct, but you know...) is enough for me
to not want to consider this approach any further.

Ciao,
Johannes

--8323328-1872230682-1666079959=:174--
