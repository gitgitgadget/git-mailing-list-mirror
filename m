Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253DC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 21:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiFRV5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFRV5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 17:57:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70412AA8
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655589430;
        bh=egpvepW1UJCcxKaSYHIllJarN9rzkMTPu2GrCt8kmwk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U7YLlqLaIVUukPkx9ojkD/JfIlSmb+rjqNyctEttDYiQHFFR0RyY6BHwBvrbGLqZL
         nKvS+qwAP5PQQ9JFWnXdHNjdVff7uAjZHpJPJY6foulbvpje74eZ2VaBlh33x82cgV
         wFuI4jsUfkyrl8ywhEQxD2stU1NyAUBqenWiSN1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx105
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5b-1nXlSw40iB-00ecJu; Sat, 18
 Jun 2022 23:57:10 +0200
Date:   Sat, 18 Jun 2022 23:57:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Lukas Buricin <lukas.buricin@cubicmotion.com>
cc:     git@vger.kernel.org
Subject: Re: Windows long file paths bug(s) with "-c core.longpaths=true"
 whilst cloning
In-Reply-To: <CA+c+RB=ud_==QYJMgcwQ=X4imQhxsFvMuKp_bP0H_MBY1BbUgQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206182308590.349@tvgsbejvaqbjf.bet>
References: <CA+c+RB=ud_==QYJMgcwQ=X4imQhxsFvMuKp_bP0H_MBY1BbUgQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pu+sDZpbb4zBg9EtzpcuBuEqdTufTN1iGB5aIKLz5nr+faLtym1
 Bi8LyArO8DpCB70nfDD1GxtwYoWxneSQivn0LeKeKb52xhEXsUA9XDJGQfXYGyjdHMxO2sT
 rZ+VxL1muPc8y5LI4qL1KguimuHwcfTpAbNOFKBJ1sRPw/tNy9tx3Thj0nWQ1tV98rjTea6
 sSaDbQtaGlDSfZXp2++Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UpMNDv/m2gk=:rHnzHc/tRPJuaMrZUji4vM
 yilDgZp4cNmeZgiFPAgSQJMxQM6mM7gAYyR8QftZI7aDPyW4HHJjPdXnHMRmi38NYuqB3BGcu
 hBvDinBP8mWQUEh4NoUUw5NQ2WapAVLP9wQPEqarVyi8SHwdvJnHDLMaYpZvy6PH2Z7RAeNQl
 zE9X51TjD20OYkIaJI0ml0CNmH137MhX2I1hNCxyvasoFlckIau1gmuvZEuAc0Y1mI5CP2+gm
 Ee0AAZcODOm/ZQML6hEcFbRp+36DijQtHIB59lnNu78EjXF2maCMh6jmfYmRfLBaksSwAl/Vg
 tIqFxDv4wstPyHzhfeY6YCrAqH6HL0NTXwBSRsewwx8uab7x4vbJv+4r28KUdIIuECLv1nMC5
 6xZfkxm9nXGYLzKv5cpxeDl6NLL4mQaCl+rFTspiscSuDG0456IN8Ei/4V9fYixoF/XQqWi6y
 9A5ywqD3/ZR6NAX+V0hvXnqf7fd65YQ24ElKlZ/1WV+Gf3PvAERXOMgldEmnNnyQJXM1QOUbN
 zsXSXmg0U6cXC60WaCkXlGQwKNzmaVNWwLJ4gIa4ryIOHmoZT7NxGRT6rueVkoScm+hnQI8TF
 plzTqyS7K1n4nYtEY7oxNT0mdgv1Kbhdah6Segat2s6zaFnlTg9Riw2GHv48szg/FoVxRlq7B
 DqMgo5KkGR3dvd8J9YHwGI+lrgAv+B7OvyqHEoXTi5wpQ5QZ3LDZuPI2B1O1QaXi1Ov4NLlZ/
 qiIrczVhanScE9uWTUm0kvivRZHplpuSdk0FO9aK7HdHPcAvrXc/HTW8KVTHXAg0vMkIxAPzs
 Ubd8/XITKlCtNaO2trm9e9gXRgs8sJ8OuGppDtCCRQUfPeTilGSMZjZH1mOy8lzQ6tTMju2MS
 kFv6NTF3MY32PZF8lkmI5y/ojI8ouFl0uRzXVgdo7ZMLzlAZCmB36FWDPFXNcwlfaBiRVMg1O
 pgXmgr/W9W5ceLB4mEfJXfXh8toM1u8poPq8PPl3yTIXD7l9DBiZasjn7CGNPbGkRFuMBSuy1
 tC2KH4ZvfK83Q0dhIGfVsPAa/so1ttLQzIWUEG0C5Uf7fiS14TudH3aOhpR+cuZ07S2k/pvvu
 8kk2nxUKcqAF0J+DyhCo35TunSJkMt+rgUlarMMUqFF5x4hBnT8cRltjQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lukas,

On Wed, 15 Jun 2022, Lukas Buricin wrote:

> I am seeing multiple problems when cloning. I use "-c
> core.longpaths=3Dtrue" and I of course have the long paths enabled in
> Windows.
>
> Cloning long file names appears to work only when the file names
> themselves breach the limit MAX_PATH 260 characters, but not in other
> cases.
>
> 1) When cloning in a directory path that is on its own longer than
> MAX_PATH. For example, when cloning to
>
> C:\my_very_long_named_directory_..._reaching_over_MAX_PATH_260_long
>
> then the content of '.git' folder in
>
> C:\my_very_long_named_directory_..._reaching_over_MAX_PATH_260_long\.git
>
> fails to get created. Whilst this may seem like an unlikely scenario
> for a single repository being in such a long-named directory, it can
> happen with a more complex hierarchy of submodules, where the problem
> becomes more obvious ("external" represents directories containing
> submodules):
>
> c:\my_projects\my_project\external\app_components\external\app_api_layer=
\external\framework\external\video_components\external\core_components\ext=
ernal\base\external\windows-third-parties\gtest\...
>
> The first problem seems to be in compat\mingw.c, inside char
> *mingw_mktemp(char *template) where we still use wchar_t
> wtemplate[MAX_PATH];
>
> After replacing it with MAX_LONG_PATH the problem moves further to
> usages of xutftowcs_path() that internally assumes everything to be
> just MAX_PATH.

Indeed. You will see much of the same journey, in the form of testable
patches, at https://github.com/git-for-windows/git/pull/3877.

One major problem, of course, is the assumption of `mktemp()` that the
buffer passed as a parameter has the size `MAX_PATH`. So if we start
assuming that the size is actually much larger, we risk buffer overruns
unless we litter Git's code even outside of `compat/mingw.c` with
`MAX_LONG_PATH` instances, a proposal I have no doubt would be shot down
immediately on the Git mailing list.

> When replaced all the calls to xutftowcs_path() with
> xutftowcs_path_ex() providing MAX_LONG_PATH and passing
> "core_long_paths", the initial parent git process moves on. However
> ...
>
> 2) The git process spawns another child git process, which doesn't
> reflect the parent core_long_paths (being 1), because in the child
> process it's 0,

Why would it be 0, though? The `-c core.longPaths=3Dtrue` option is parsed
into the environment variable `GIT_CONFIG_PARAMETERS`, which is passed
down to the child process.

> hence all the functions that should be allowed to prepend the paths with
> \\?\ are told not to extend anything. This obviously leads to more
> failures.
>
> 3) Even when the directory paths and the files do fit in the 260 limit
> (I have shrunk all the paths by renaming 'external' to 'ext' in order
> to fit in the MAX_PATH), git falls over in its internal .git folder
> because it stores some information in significantly longer paths than
> what is present in the repository itself. Using the example of
>
> c:\my_projects\my_project\external\app_components\external\app_api_layer=
\external\framework\external\video_components\external\core_components\ext=
ernal\base\external\windows-third-parties\gtest\...
>
> there will be folders 'modules' added at each level in the .git
> internal folder for all submodules, so will end up somewhat like:
>
> c:\my_projects\my_project\.git\modules\external\app_components\modules\e=
xternal\app_api_layer\modules\external\framework\modules\external\video_co=
mponents\modules\external\core_components\modules\external\base\modules\ex=
ternal\windows-third-parties\modules\gtest\...
>
> So the content in .git is much more likely to breach the MAX_PATH
> limit than the repository "user" files themselves.

Right, and there is the additional problem that the current working
directory cannot have more than 260 characters, either, when spawning new
processes.

And we _also_ have to deal with the reality that by far not all
executables handle long paths gracefully, even as we teach `git.exe` more
tricks.

For example, the MSYS2 Bash used by Git for Windows does not handle long
paths. Which is a problem because we still have some core functionality in
Git being implemented as Unix shell script: The `submodule`, `bisect`, and
`mergetool` commands are commonly-used examples.

Now, one approach we discussed over at
https://github.com/git-for-windows/git/pull/3877 is to configure that
registry setting that allows longer paths for executables whose manifest
indicate that they are "long-paths aware". The mechanics of rolling
something like that out would get tricky, though, as it would mean that
the MSYS2 runtime would have to be modified, too, and for obvious reasons
it would then require _all_ of the programs that link to it to be made
long paths-aware, too, otherwise we would be bogged down in buffer
overrun-related problems.

> In general, aften seeing the code (admittedly first time ever), I also
> have a few questions, because I might be missing some context ...
>
> 1) Why do we use MAX_PATH for buffers at all?

That is a good question. Historical reasons, I suppose. You mentioned
`mktemp()` above, which is a fine example how the C library functions were
originally designed with a hard-coded assumption as to buffers of size
`MAX_PATH`. On Windows, there is at least `_mktemp_s()`, which takes a
pointer and a size as parameters, but on Linux/Unix, I am unaware of any
such function, they all seem to expect buffers of size `MAX_PATH`, which
essentially limits what Git can use. I guess a MAX_PATH of 1024 "ought to
be enough for anybody".

> This might be my misunderstanding, but I would have thought that
> providing long file name support would essentially mean not using that
> contant other than for determining whether to prepend given wchar_t*
> output by \\?\ when the input const char* is longer than MAX_PATH,
> before passing the wchar_t* in Windows API calls? This conversion and
> eventual prepending could be done in one place and should be no burden
> for the CPU.

Even functions like `GetFullPathNameW()` require you to provide some
reasonably-sized buffer as parameter. That's the reson why we still stick
with MAX_LONG_PATH, which we chose as 4096. Because I (and IIRC Karsten
Blees) guessed at the time that 4096 out to be enough for anybody.

> 2) Why not having long paths by default? Again, this might be me
> missing some historical context of regression, but it just seems
> logical to simply prepend by \\?\ whenever needed rather than fail.

There are a few reasons why they should not be on by default, most
importantly that many 3rd-party programs cannot handle them. For example,
for a long time CMD itself could not. And of course the MSYS2 version of
`rm.exe`, which we tried to use in the test suite, cannot handle them.

Rather than succeeding to clone repositories into long paths by default
only to let the user run into trouble not only using their favorite tools
on the checked out files, but then also be unable to `rm -rf` the thing,
we chose to disable long paths support by default instead.

There are also performance implications. Accessing files via their
relative paths is much quicker than first constructing that `\\?\` form
(which must be an absolute path).

> 3) Why to have a "-c core.longpaths=3Dtrue" command line argument at
> all? Given that we can detect whether the long file names are enabled
> in the OS, we could easily drop that argument and have the full
> support for free? (Losing also the problem of passing the flag to
> child git processes). In fact we might even not need the OS support
> detection, we may simply rely on the Windows API return values and
> GetLastError() whilst always proving MAX_LONG_PATH and eventually
> prepending paths with \\?\.

Even just the `mktemp()` example you found _already_ puts a stick into the
wheels of your idea.

I also sense that there's confusion between the two forms long paths
support can take:

- Convert paths that would otherwise be too long to the `\\?\` form and
  use the `*W()` functions of the Windows API. This is supported by all
  Windows versions that are supported by Git for Windows.

- Require users to configure a registry setting, use the `*W()` family of
  Win32 API functions exclusively, add a manifest entry that your
  executable is long paths-aware, and skip that `\\?\` prefixing. See
  https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-=
limitation
  for more details. This requires Windows 10 Build 1607 or later.

The more elegant solution would be the latter, of course, but its Windows
10 Build 1607 requirement is incompatible with Git for Windows' promise
that it still supports Windows versions all the way back to Vista
(although you can expect Vista support to be dropped after Git for Windows
v2.37.0 is released, with Windows 7 and Windows 8 support to follow around
the end of this year).

Ciao,
Dscho
