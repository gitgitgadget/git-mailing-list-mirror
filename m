Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8064EC48BE6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDDF613E7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJJte (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:49:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:51063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhFJJtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623318452;
        bh=FesWKO8IZXtRMhCE2SBc+9amND/k7QUHGMxrc0etoEQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GySJjVe9GumQXAooTQeaHB/Xi+4TOCZ5hQE6DUHzkHJxBInNvXN93gnE7AJ7zf0Xe
         hjXb6MsLok29J6PQ8qdkqqlpTU9mtSU/O4Xt/vaF+WHbzn76HL+EZhrhNrNupO5bNN
         NZo8glDWeyiCU0V8JZzGLod5EvdJyuDPuZIpEEqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1lkuJ51C15-00TV3y; Thu, 10
 Jun 2021 11:47:32 +0200
Date:   Thu, 10 Jun 2021 11:47:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 0/3] Make CMake work out of the box
In-Reply-To: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106101146230.57@tvgsbejvaqbjf.bet>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:feox/E0e1YVd2FlBkEw53W4oizMxCBMTC16xRa1arBeGLGfYDO/
 Vu0ndrtq5nf6HbYtQJX19LhMsfepot5LUxaRqDSXw8i3yQEh08sJc0kBp9pNRAU3eDqBMAs
 WAuFTUtj1qC+4MXte8mwR6GPAgG87RfyYau7GWgCsrypSGXL5g/pbSWHPbfeHENfF4mebSh
 iuphYDAUBeldEaUFRM8Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBUnpMX8nuI=:0AbR6pxBfvmictgJ2Psbuk
 UvtALNX6q2lkIKgTHYJiyAcn2AYxJMLkDd9Do4A+KOtNMPHCEJRipxeuxDIN2lpm11XfhA/+5
 Aat+LuRBsFBgNa/fUGBspE46yMl6rkSXCb36sC+C6p3tKsA7DboLjxwKQRF9ebaAJbFSJXbDa
 fAqLh2Wpnqz0jifezb8hdaxfYNWzg/OtZK3oei9O4v+mKrnvtKadY7P8vNJZV6WLZobOUeIM2
 jdhwZEHHK0SA/5Nm0SVuS34k0BgGyvKMXa5Q3//Mmo4PzodzWCTotKBp9dc5Bkm/cx8K5ZWi9
 iyL4GBflt2Va+ECzBXGtd5XT9Llhs2DBEMenu/gBExOCx5bl25g9eAEZDBB7dapz2VvOdHSum
 J/9ZXIWEbHthV8oJpBHyu8i5/i1usfQyYzzAJflUK/6JlgvVSQg86b4c+IX5O5RInmu7rCAcf
 Tzp7YVrirYuvi0w7Ilrgf1ekQ3uPX/VHh0yHuiOse8/nngEf/D8cuATedLS1HYYzzi8LPVs59
 TcQ/IXNHqXF1zHgcTC6RNMDowjehGNS7ukzCDhlG2hciulshbNBtJ/Agsj6koVNIfe5RrPkpc
 RdFTmQGfHj2Sqc23DFm6a0f0fGH25k1j3zUhGyhPefI/NRbOnwpn+c9G1T1vkrNQZrYI4QzIb
 3prmc1u/6mnTDvzoTuZC/QsFjd/Qpix0XuBdS/fjJ2X3yJQXPsYXg3BQJtTSO3RGJUdYscFLR
 G7OEvt3Rh4RrBjOVd2LFfTWXRQiXFy9/KAcX9k54ZOtV6HkekCpM8KGvnBDARtPb9YzPKwoPn
 0LjXHMGq0fh1Byjqq3hdxWyDS0dcrcDwikE/lnRb0rfc+34Cu/8Y7Z1K12l7c//U42ENhjN8O
 up4zeSHKo7sPLwBFozvYFCtMoYGUYJnluyCWHkbQEqwQlYD+8ch8KxEmv1hES6nxLNfYmEjdn
 1CNIDKaIaEibEpmX2h0xxDXiRsZwDdU34dH1fzKc/Eo/ZBUXyRIqYyIH8U2fFB7YAC4EaDih6
 FUUY2pjkUqigIzWPuc15FhVUM2Rtfdu+E+Gv0lFgm+eANn5oHl9KF7jPRFz9DtOSPX0OKh1oW
 dPfUwrngYMrKuiOWxY7fi9e/4y7UDpLnSzsOHxMQJJZ9G24axjlL+ieUA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt,

On Sun, 6 Jun 2021, Matthew Rogers via GitGitGadget wrote:

> This pull request comes from our discussion here[1], and I think these
> patches provide a good compromise around the concerns discussed there
>
> 1:
> https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRg=
i_oZAWw@mail.gmail.com/
>
> CCing the people involved in the original discussion. cc: Philip Oakley
> philipoakley@iee.email cc: Sibi Siddharthan
> sibisiddharthan.github@gmail.com, cc: Johannes Schindelin
> johannes.schindelin@gmx.de, cc: Danh Doan congdanhqx@gmail.com

Just in case that a v3 is needed, I fixed the PR description so that these
"Cc:"s are interpreted correctly again by GitGitGadget.

But from a brief glance over v2, all patches look good to me.

Thanks,
Dscho

>
> Matthew Rogers (3):
>   cmake: add knob to disable vcpkg
>   cmake: create compile_commands.json by default
>   cmake: add warning for ignored MSGFMT_EXE
>
>  contrib/buildsystems/CMakeLists.txt | 37 ++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
>
> base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-970%2F=
ROGERSM94%2Ffix-cmake-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-970/ROGER=
SM94/fix-cmake-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/970
>
> Range-diff vs v1:
>
>  1:  3170f78daa5f ! 1:  485254b49de8 cmake: add knob to disable vcpkg
>      @@ Commit message
>               generators.
>
>             - Some versions of Visual Studio 2019 moved away from using =
the
>      -        VS 2019 by default, making it impossible for Visual Studio=
 to
>      -        configure the project in the likely event that it couldn't=
 find the
>      -        dependencies.
>      +        VS 2019  generator by default, making it impossible for Vi=
sual
>      +        Studio to configure the project in the likely event that i=
t couldn't
>      +        find the dependencies.
>
>             - Inexperienced users of CMake are very likely to get trippe=
d up by
>               the errors caused by a lack of vcpkg, making the above bul=
let point
>               both annoying and hard to debug.
>
>      -    As such, lets make using vcpkg the default on windows.  Users =
who want
>      +    As such, let's make using vcpkg the default on windows.  Users=
 who want
>           to avoid using vcpkg can disable it by passing -DNO_VCPKG=3DTR=
UE.
>
>           Signed-off-by: Matthew Rogers <mattr94@gmail.com>
>      @@ contrib/buildsystems/CMakeLists.txt: NOTE: By default CMake uses=
 Makefile as the
>        set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>       -if(WIN32)
>       +
>      -+if (WIN32 AND NOT NO_VCPKG)
>      -+	set(USING_VCPKG TRUE)
>      -+else()
>      -+	set(USING_VCPKG FALSE)
>      ++option(USE_VCPKG "Whether or not to use vcpkg for obtaining depen=
dencies.  Only applicable to Windows platforms" ON)
>      ++if(NOT WIN32)
>      ++	set(USE_VCPKG OFF CACHE BOOL FORCE)
>       +endif()
>       +
>      -+if(USING_VCPKG)
>      ++if(USE_VCPKG)
>        	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
>       -	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
>       +	if(NOT EXISTS ${VCPKG_DIR})
>      @@ contrib/buildsystems/CMakeLists.txt: endif()
>        find_program(MSGFMT_EXE msgfmt)
>        if(NOT MSGFMT_EXE)
>       -	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/download=
s/tools/msys2/msys64/usr/bin/msgfmt.exe)
>      -+	if (USING_VCPKG)
>      ++	if (USE_VCPKG)
>       +		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloa=
ds/tools/msys2/msys64/usr/bin/msgfmt.exe)
>       +	endif()
>        	if(NOT EXISTS ${MSGFMT_EXE})
>      @@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_=
DIR}/GIT-BUILD-O
>        file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON=3D'$=
{NO_PYTHON}'\n")
>        file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPL=
E_IPC=3D'${SUPPORTS_SIMPLE_IPC}'\n")
>       -if(WIN32)
>      -+if(USING_VCPKG)
>      ++if(USE_VCPKG)
>        	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=3D\"$PAT=
H:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
>        endif()
>
>  2:  c3bf266cf03a ! 2:  a3b5eef54188 cmake: create compile_commands.json=
 by default
>      @@ Commit message
>           time of this writing, and no real negative consequences that I=
 can find
>           with my search-skills.
>
>      -    NOTE: That the comppile_commands.json is currenntly produced o=
nly when
>      +    NOTE: That the compile_commands.json is currently produced onl=
y when
>           using the Ninja and Makefile generators.  See The CMake docume=
ntation[3]
>           for more info.
>
>      @@ Commit message
>           Signed-off-by: Matthew Rogers <mattr94@gmail.com>
>
>        ## contrib/buildsystems/CMakeLists.txt ##
>      -@@ contrib/buildsystems/CMakeLists.txt: else()
>      - 	set(USING_VCPKG FALSE)
>      +@@ contrib/buildsystems/CMakeLists.txt: if(NOT WIN32)
>      + 	set(USE_VCPKG OFF CACHE BOOL FORCE)
>        endif()
>
>      -+if (NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
>      -+	SET(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
>      ++if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
>      ++	set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
>       +endif()
>       +
>      - if(USING_VCPKG)
>      + if(USE_VCPKG)
>        	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
>        	if(NOT EXISTS ${VCPKG_DIR})
>  3:  07763a9de723 ! 3:  2110c8ffa423 cmake: add warning for ignored MSGF=
MT_EXE
>      @@ Commit message
>           configured, as such add a check for NO_GETTEXT before attempti=
ng to set
>           it.
>
>      -    suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>      +    Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>           Signed-off-by: Matthew Rogers <mattr94@gmail.com>
>
>        ## contrib/buildsystems/CMakeLists.txt ##
>      @@ contrib/buildsystems/CMakeLists.txt: if(WIN32 AND NOT MSVC)#not =
required for vis
>
>       -find_program(MSGFMT_EXE msgfmt)
>       -if(NOT MSGFMT_EXE)
>      --	if (USING_VCPKG)
>      +-	if (USE_VCPKG)
>       -		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloa=
ds/tools/msys2/msys64/usr/bin/msgfmt.exe)
>       -	endif()
>       -	if(NOT EXISTS ${MSGFMT_EXE})
>      @@ contrib/buildsystems/CMakeLists.txt: if(WIN32 AND NOT MSVC)#not =
required for vis
>       +else()
>       +	find_program(MSGFMT_EXE msgfmt)
>       +	if(NOT MSGFMT_EXE)
>      -+		if (USING_VCPKG)
>      ++		if(USE_VCPKG)
>       +			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downlo=
ads/tools/msys2/msys64/usr/bin/msgfmt.exe)
>       +		endif()
>       +		if(NOT EXISTS ${MSGFMT_EXE})
>
> --
> gitgitgadget
>
