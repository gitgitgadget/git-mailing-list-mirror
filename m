Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4DC4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2623A65
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QbShdWXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgIUWwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:52:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:51053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgIUWwo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600728759;
        bh=PGoS8of/3VoE9QogG1gW3NJlvN3HZxSKP0YqR/kQCro=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QbShdWXAxq1fZX2udLoxZSXJSUti+zPQp9w143hfdrVMYsTSNygONwLufESkltGoJ
         ujsyZNDbiTJtRCDkfMDtXV+Ufz74fvBqWJEAm4CqicrDWdDdkVtIrVhrO8+6ogit5r
         Av0cd4VnOYQuWCXjKRH69ja2nm+bgRUFQRmz5pBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1kpxWn1MUU-00nBAE; Tue, 22
 Sep 2020 00:52:39 +0200
Date:   Sun, 20 Sep 2020 19:37:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet> <xmqqft7fnlxr.fsf@gitster.c.googlers.com> <20200918155015.GA1837@danh.dev>
 <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1471567309-1600623463=:5061"
X-Provags-ID: V03:K1:CfQkLxd2I03/j8OaWs2BeJ15Sv/5TO5TYNX4Kkvmqna3M+H3Tpk
 mR7uDWEuBA8tqRi21mSCzTE+YiZ87RjPQGNWJ7YL51LCJB3700/XpQ+XZl5FDW2qfyeOpE4
 L/D26HgEN/s/mri3PYs9eIC/r1LBLIt3rZvH3eXbEOx2fcFqy28+oVYBM2F45ua0jqeVEwB
 rDYFq8OhOB+Ypet9upt6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7kwS8zYhas=:3wDkIYx57p4mtNRtpOYp/S
 szOfLFe7k5iP/dIkMHrHZuKHHOIJfKMjaGH9wvPnvRGVv4HkAP7e+UK9ZlWqvMsDJdhKjNmTs
 4OXiZCLWIHOpih/9H+t1JPTxgd8t42N9TBaUGpq6zztAa3FtQpx8EZMbJtPgmalDjEBZmX6L9
 msy6iUtk5Dys2vSqn0t5Mb+mazLjjjnTlDFBmJEwmlmaRFc9spYSVLQrPcn3DDKtyOr0JuDae
 nkvZiMiMtU6qxj0BJF9sdu5KqWFEid+BNCYKhlal+0AssE5F2uPUie+6KXq1+lzuH0/7sJHoA
 sDjKEs0l0izL0gwt80sPONK1smWmubJeu63Pna04vDzs3kKptsoqcjLeDtf1mXzecDeUJHJRv
 ge9mdop0a+jWXh76cffvAQTxnvcXmvrqk9h5i23Avd/2mdb+uOBi3cXe+AnB8FUFKq0skTmce
 8Rho6bBjQ6a0qetRdwPyL68e2MgGK4+7v5l/L5VWHA42ymZ0fs72Bllm8oX5yy5rzTnh3MyMx
 b/0o2Z5fmOH+iRJBsiuEK/OtMKx70kfVl8+NwqauCLz0dLYX8QLFfnPjHf1IMjTuErknjzcGN
 RFeVP1gfC1R0c4flUESVl4qU5Pjch8TUVR3DgF1g1fnC4SSgkN6hLxxXZOi17ysUd2XNmTNt2
 WYQO7r8ZTMKwXLEYemVwfna3TyCZbmg25ECL+ZXuIl+GMGWS+YvXWxVKMmF/WnXdx6aOOf5YU
 eGXMYIKH8FtopHCptk+JgTreqa7oHz6dXLEptmI4dVHJpc8Fxmlg2FpNjWKAIzp9ATPBL7gRg
 x2YNJoeXSazAL/9EsIhj2SCq1sVA2JyF1WcpF89BnyIkA571DI3yElUoCPAkwhl3vpHSeytRx
 45fVWnID5KVrdg9gJUzcnvRhnspazz3RBeUlyVHrdOEI51XbVh4+FPZpearFMX/cWBaH4F0zT
 /4wo1aGVzw+DD6em7AfA+JFLz/ilfm2Cc7PSO1l2lQ+8O72bYRS1S2mMWcsl2RYz2jMh8G3Qk
 S70aV9PGepK5tdzLTSc3E7KZNj0NNPzRLw7U3xrsHVnztAGSmo5foO0xlMcV8E7m8xeBR32oZ
 +HAnORvgZ5Stod3dBowkQkY+ReNQ0ruS0b+e+qJH8BzMlw6Va8d09nOjE5EOnnA5mdFIjOGlb
 eDf2c/BkUel30uEAqcHlyVYfBq5uJcNOoshaysb34a/llBO+2emZuZh88ry0xQAVvl8F8sPr9
 xbK2YYjz78pXZcKJGVL4dbs6OqtZufAGC/nYKmQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1471567309-1600623463=:5061
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 18 Sep 2020, Junio C Hamano wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> write=
s:
>
> > Actually, in CMake land, people usually do this instead:
> >
> > 	mkdir build
> > 	cmake [-Ggenerator] ..
> > 	<make/ninja/msbuild>
>
> I presume you "cd build" between steps 1 & 2?  I take the "people
> usually do" is the best current practice?
>
> > Then, when they want to run something equivalent with make distclean,
> > they run:
> >
> > 	cd ..
> > 	rm -rf build
> >
> > instead.
> >
> > The change that Dscho suggested was meant for those people that run
> > CMake in same directory of source dir, which is mostly discouraged
> > in CMake land.

It is discouraged, but not disallowed.

> > In additional, CMake's default Generator in *nix is Unix Makefiles,
> > which will clash with our Makefile, and totally unsupported.
>
> I recall that our CMakeLists file asks the top-level Makefile about
> basic things so that we do not have to duplicate "list of files"
> etc.  in places, so I can understand that it would lead to a
> disaster to do "cmake -Ggenerator" at the top-level.

Indeed, when asking CMake to generate a Makefile twice, there will be a
problem.

But so far, we successfully resisted making the CMake support powerful
enough to support anything but Windows and Visual C.

> > I think the original CMake proposal didn't touch .gitignore because
> > they run in a separated build-dir.
>
> If so, not only my "do we need a matching change to CMakeLists to
> teach how to clean crufts?" becomes unnecessary, but the original
> patch that started this thread to touch .gitignore at the top level,
> does, too.
>
> I wonder what led Dscho not to follow the "create a 'build' dir and
> do things there" practice.  Judging from the fact that the "because
> they run in a separate build directory" assumption did not hold to
> somebody as experienced as Dscho, it is likely others would do the
> same.

That's because Dscho does not like the separate build directory, even if
they know that in the CMake world, it is kind of expected.

It's just that it would be super convenient for Visual Studio users to
just generate their project files in-place. That's why I started down that
road.

> What can we do to make it easier for people to discover and follow
> the best current practice?  Are there things in our build
> instruction document (e.g. the comment at the top of CMakeLists.txt)
> that needs updating?

Ideally, we would tell Visual Studio users to "just install CMake, start
its GUI, direct it to the Git source, configure and generate". Alas, it is
not that easy:

- The `SH_EXE` is not found by default (`C:\Program Files\Git\bin\sh.exe`
  should be used in the vast majority of the cases),
- If the build directory is left unspecified, the non-writable `C:\Program
  Files\CMake\bin` directory is used,
- The `compat\vcbuild\vcpkg` system is not initialized automatically, and
  even if the user initialized it, the dependencies (such as expat, zlib)
  are still not found.

I would like to make things easier, and forcing users to use a separate
build directory (that needs to be outside of the Git source tree because
our `.gitignore` does not handle it well) would go the other direction, I
fear.

In short: this `.gitignore` is but one small step in the endeavor to make
it more convenient for Visual Studio users to contribute.

Ciao,
Dscho

--8323328-1471567309-1600623463=:5061--
