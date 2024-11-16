Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFDB18FC9D
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731720215; cv=none; b=CeACQz6F9QisWJg/5va+LBy9L2wTB2jHoFFQdZdCXlASi5PW8TJEBD15R84o+qnRynuvJkFj2E8DiIsucsooN3DVBP8mZpAbjAss4jCEVPtGqNSkXEKWcxq1YGCZEkRqc56QY6/tQ3w6/6x18UQ/O1mXZmGN0tNmYGpspkE7bSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731720215; c=relaxed/simple;
	bh=S7/Xt2/VmnHmdjlVvJsAJGm7PXSWJ+iNlG6Fu03cbIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsEl5A1W9C9P+s9WYscjaNBEKSzFGK9egf8gCFFtTJN7n9uLjXMdQEl7Z+tTomByqFMkjRBzWXw/5ZPd/I1MoH0HGtzuzrrVqhNiNRL9LEVew3AUXJ6U2wXJ1O+wD94QaXqBLTiApVHzygjLP47Ad1WqyaZBNFfmyRulp3VSBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=rbcsoIGT; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="rbcsoIGT"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id C7WxttDL8xileC7WytKUM0; Sat, 16 Nov 2024 01:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1731720203; bh=L55VzS7n1gNtjAuBbdwk8kYamyk24p2CQOWPOAtcoFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rbcsoIGTs8Ox43asBQ2sms+U7nYX0EAxpQM0+DuxN8pg/nnFwOT+UcLOdLi9ZH/yX
	 L893Vf4Q5+nEySayDNYKRNUxDD+CO3QIGLgzmbp3T596Cp6LEQKNdk9lsFvP/qV8gv
	 1AnhlcfMW+Kf79ZCBq7kKUCca3iO2DXm515r2hEDkgAVdifDG+GDrynALSaqlyqATp
	 h6V1Et7GLMIX1aF1iqy7rFE6GRyNcuPV6EqDFzZ3FjRyYBHHQfqRhVQOyYO/6OtQmS
	 fDIyZ7CETjNlReqRLR0XS9XWwI7K8UYH6ydWjCwqWq2wO0Q+wdxjIiWTx6gEZew9Zw
	 Vlyb0Z4BHkxzQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=6737f40b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VW4sGV-CBb1OaSC5hLAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>
Date: Sat, 16 Nov 2024 01:23:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH RFC v7 00/22] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>,
 Christian Couder <chriscool@tuxfamily.org>
References: <cover.1727881164.git.ps@pks.im>
 <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF5IO56I0ZheRjBwa9vEc0cYSr/qELZkB9v2d4wsdOOTFO9SIJuB8m8CsnM/wrdDxBXM4/zuh/jgMymvEEsz0fglt1HhggIPX1ajI89b1W6D2MVskZ1U
 AggNFbo/E2TuiDBqxeQxCOPiGHpymGPrpEZ82+x3NGgOXV6qVZiY/dxSRYZASOqib+8IKQzMW5uGhu9JwSLPWVdbCfN303esU1I=



On 15/11/2024 07:21, Patrick Steinhardt wrote:
[snip]
> Changes in v7:
> 
>   - Fix overriding TEST_OUTPUT_DIRECTORY via the environment.
> 
>   - Rework generation of version information. GIT-VERSION-GEN now knows
>     to replace @PLACEHOLDERS@ in other files, and this gets used across
>     Makefiles, CMake and Meson now. This makes us properly rebuild when
>     the version info changes and fixes the version numbers in "git.rc".
> 
>   - The CMake build instructions are now doing a proper out-of-tree
>     build.
> 
>   - We now generate and install gitweb.js, which gets built via a new
>     "generate-gitweb-js.sh".
> 
>   - Some improvements to the Meson documentation.
> 
>   - Wire up DEVELOPER=1 style warnings via `--warnlevel 2` and above.
> 
>   - Wire up sanitizers properly.
> 
>   - Provide a new "regex" option to disable the platform-provided
>     version of regcomp() et al.

Hmm, OK, but what about all the other 'configurations'?

> 
>   - Stop installing git-http-backend into bindir.
> 
>   - Install Perl scripts into libexecdir.
> 
>   - Install git-cvsserver into bindir and libexecdir.
> 
>   - Install template directory into datadir.
> 
> As before, the tip of this patch series catches up with what is
> happening in "seen". If you want to test it without topics in "seen" you
> have to revert it.
> 

Just a quick note to say that I tested this on Linux and Cygwin (just build)
and noticed a few things:

  - 'make clean' does not delete the 'version-def.h' file.

  - the RUNTIME_PREFIX set in the GIT-BUILD-OPTIONS file on the master
    branch is not the same as on this 'meson-v7' branch (patches 1-21
    based on current master branch):

    $ diff GBO-master GIT-BUILD-OPTIONS
    3a4,5
    > PERL_LOCALEDIR='/home/ramsay/share/locale'
    > NO_PERL_CPAN_FALLBACKS=''
    19a22,28
    > FSMONITOR_DAEMON_BACKEND=''
    > FSMONITOR_OS_SETTINGS=''
    > TEST_OUTPUT_DIRECTORY=''
    > GIT_TEST_OPTS=''
    > GIT_TEST_CMP=''
    > GIT_TEST_CMP_USE_COPIED_CONTEXT=''
    > GIT_TEST_UTF8_LOCALE=''
    20a30,36
    > GIT_PERF_REPEAT_COUNT=''
    > GIT_PERF_REPO=''
    > GIT_PERF_LARGE_REPO=''
    > GIT_PERF_MAKE_OPTS=''
    > GIT_PERF_MAKE_COMMAND=''
    > GIT_INTEROP_MAKE_OPTS=''
    > GIT_TEST_INDEX_VERSION=''
    22c38,47
    < RUNTIME_PREFIX='false'
    ---
    > GIT_TEST_TEXTDOMAINDIR='/home/ramsay/git/po/build/locale'
    > GIT_TEST_POPATH='/home/ramsay/git/po'
    > GIT_TEST_TEMPLATE_DIR='/home/ramsay/git/templates/blt'
    > GIT_TEST_GITPERLLIB='/home/ramsay/git/perl/build/lib'
    > GIT_TEST_MERGE_TOOLS_DIR='/home/ramsay/git/mergetools'
    > RUNTIME_PREFIX=''
    > GITWEBDIR='/home/ramsay/share/gitweb'
    > USE_GETTEXT_SCHEME=''
    > LOCALEDIR='/home/ramsay/share/locale'
    > BROKEN_PATH_FIX='/^# @BROKEN_PATH_FIX@$/d'
    $ 

Note that master has RUNTIME_PREFIX='false' rather than being un-set.
(Indeed, the Makefile on the master branch normalizes the value of
RUNTIME_PREFIX to 'true' or 'false').

    - I used the new 'regex' variable, on cygwin, like so:

    $ meson setup .. -Dprefix=$HOME -Dregex=disabled

    after first trying '-Dregex' and then '-Dregex=1', because why not? ;)
    This correctly set NO_REGEX=1 in the build.

    - As a result of the above, the grep-binary test now behaves the same
      way as on Linux (ie that test now 'fails' instead of unexpectedly
      passing). Note:

    $ meson test 't7815-*'
    ninja: Entering directory `/home/ramsay/git/build'
    [2/9] Generating GIT-VERSION-FILE with a custom command
    1/1 t7815-grep-binary        OK              7.55s

    Ok:                 1   
    Expected Fail:      0   
    Fail:               0   
    Unexpected Pass:    0   
    Skipped:            0   
    Timeout:            0   

    Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
    $ vim meson-logs/testlog.txt # test 12 again '# TODO known breakage'
    $ 

    - The format of the GIT-BUILD-OPTIONS file generated by the Makefile
      and meson are formatted differently, so you have to massage the
      top-level file to be able to diff them:

    $ sed -e 's/\x27\x27//' GIT-BUILD-OPTIONS |
    > sed -e 's/\x27/"/g' >GBO
    $ diff GBO build/GIT-BUILD-OPTIONS 
    1,2c1,2
    < SHELL_PATH="/bin/sh"
    < TEST_SHELL_PATH="/bin/sh"
    ---
    > SHELL_PATH="/usr/bin/sh"
    > TEST_SHELL_PATH="/usr/bin/sh"
    6c6
    < DIFF="diff"
    ---
    > DIFF="/usr/bin/diff"
    8c8
    < TAR="tar"
    ---
    > TAR="/usr/bin/tar"
    12c12
    < USE_LIBPCRE2=
    ---
    > USE_LIBPCRE2=1
    21,24c21,24
    < X=
    < FSMONITOR_DAEMON_BACKEND=
    < FSMONITOR_OS_SETTINGS=
    < TEST_OUTPUT_DIRECTORY=
    ---
    > X=""
    > FSMONITOR_DAEMON_BACKEND=""
    > FSMONITOR_OS_SETTINGS=""
    > TEST_OUTPUT_DIRECTORY="/home/ramsay/git/build/test-output"
    26c26
    < GIT_TEST_CMP=
    ---
    > GIT_TEST_CMP="/usr/bin/diff -u"
    37,38c37,38
    < GIT_TEST_PERL_FATAL_WARNINGS="YesPlease"
    < GIT_TEST_TEXTDOMAINDIR="/home/ramsay/git/po/build/locale"
    ---
    > GIT_TEST_PERL_FATAL_WARNINGS=
    > GIT_TEST_TEXTDOMAINDIR="/home/ramsay/git/build/po"
    40,41c40,41
    < GIT_TEST_TEMPLATE_DIR="/home/ramsay/git/templates/blt"
    < GIT_TEST_GITPERLLIB="/home/ramsay/git/perl/build/lib"
    ---
    > GIT_TEST_TEMPLATE_DIR="/home/ramsay/git/build/templates"
    > GIT_TEST_GITPERLLIB="/home/ramsay/git/build/perl"
    44c44
    < GITWEBDIR="/home/ramsay/share/gitweb"
    ---
    > GITWEBDIR=/home/ramsay/share/gitweb
    47c47
    < BROKEN_PATH_FIX="/^# @BROKEN_PATH_FIX@$/d"
    ---
    > BROKEN_PATH_FIX=
    $ 

Note that the Makefile build on Linux does not, by default, build with
libpcre, even if the library is installed on the system (as it is for me).
Also, note the values of BROKEN_PATH_FIX.

[This was on Linux; cygwin is similar but not identical]

ATB,
Ramsay Jones

    

