Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8274B1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 11:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeGDLWZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 07:22:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:58339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753520AbeGDLWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 07:22:24 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MADqP-1fPuDK3Sv3-00BJFO; Wed, 04
 Jul 2018 13:22:19 +0200
Date:   Wed, 4 Jul 2018 13:22:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git mailing list <git@vger.kernel.org>,
        Dan Jacques <dnj@google.com>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZhEmRBkvTNStSvr78YMNKtlmeDdfJvBA5Z/uFKYYDD+JMblPhMy
 0LyLHPZyE/18B1uvrCG9RZk9pt8VV1avdtRymRx/tYgIXYm4gdp/ONchtce18omNH/C3MeM
 t5Y/Gw1wfedalRU1jkHqOBTRaxRvIKhFt0zEcS0rj6ipeYBTic16WYkKumsYy1NvgM+IaHA
 sQHryVFg6dvhk0b0FSHmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EkaeaB67y4E=:JcLncslOAaAJq22JF2lrRy
 yBUn+0retMZPV6pj/zs9E0iC0FxgDOEGGEp35BamJNFHMBGNfWw6+eCjOMPjyeilMzjaJcSl7
 UPt3/d7Dr7gmn2nN/c8TaXsftZwkvKAwMBJDmhRDl1pHKSuaK6+CyOPNZXVy/4c74Sf2RBQuP
 VX115qF0/7R1QbGoYPb6Nl8sPiG+NqPiburSK8hAfJlEd25hp8HNEGrAUSUYKFV4+6I74xkh+
 oRWGe5uZM6/AW5Zai7MwSet/aMx508z7UvmxbJjVv7XhYHjRBOVjTiekRtcZVH9fWoshI2d37
 T38DeStbRl4AHJCW4okeivJNii0kHC4da2EyM0DMJ/2dPkg2oWiJnolaZvQWgF/Z0rTtWHlAG
 AzxHUfDsltZg0ZNpzasqkgUExi5wNXZJ8QDl9zypNptJQcFnumSZn2JIEYxnzh/o9ME2TIEKA
 JImv6cBW32BkU280D36t3OhV2sAxqxxE/JfVMYjg7IeJfcw9oTbJLK4WpF6tLPAvfwj/A/GTG
 +Yi4/UqIKqbYLbmu37xu69SgPI6Un4eaYf9vkkfbzzyAd1Z9vB1r/I+8WSBb9OBDRcuJcEzRH
 vGt0VftmijuU/2oe1xIAX4Mm98SphMumZLzJ1SAvfILi8ce365ELxbZKGhkldAVg+33nDiM/+
 qoY5r6D2PcchlZYVHomrGlaAdq04rPxZoHAZiuppzUH5AQtfmQ2DQPBjXrf4xtEp+a8oCqPDU
 BrsWcRJYD70TnCm0lXBQJlUmJOOuUwfBp3mBdb5W08Vub6a/cwydfy54icqSw+UWzECATxKpX
 FJRNgKu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 4 Jul 2018, Paul Smith wrote:

> I was excited to see the RUNTIME_PREFIX for POSIX systems patchset go
> by earlier this year.  Although I didn't see any mention of it being
> included in the 2.18.0 release notes, it does appear that it was merged
> in for this release.
> 
> Has anyone else tried to get it working?  It doesn't appear to be
> working properly for me so I'm not sure if I'm supposed to be doing
> something different... I didn't see any documentation on it.

It is working (for ages) in the Git for Windows build.

> Basically what happens is that I run configure with
> --prefix=/my/install/path --with-gitconfig=etc/gitconfig
> --with-gitattributes=etc/gitattributes.
> 
> Then I run make with RUNTIME_PREFIX=YesPlease.

Ah. In Git for Windows, we do not use configure. I *think* this points to
an incompatibility of the RUNTIME_PREFIX feature with our autoconf
support, and this is a grand opportunity for you to step in and help.

Essentially, what you will want to do is to implement a new configure
option --with-runtime-prefix that then prevents the autoconf script from
munging the relative paths in the way it does.

> When I look in the makefile, I see that the make variable gitexecdir is
> initially properly set to libexec/git-core which is what I expect.
> 
> However, later in the makefile we include the config.mak.autogen file,
> which was generated from config.mk.in by configure.  In the .in file we
> have this:
> 
>  gitexecdir = @libexecdir@/git-core
> 
> After configure gets done with it, this becomes:
> 
>  gitexecdir = ${prefix}/libexec/git-core
> 
> which is a fully-qualified path.  This means that exec-cmd.c is
> compiled with -DGIT_EXEC_PATH="/my/install/path/libexec/git-core" which
> effectively disables RUNTIME_PREFIX, as the exec-cmd.c:system_prefix()
> function always returns FALLBACK_RUNTIME_PREFIX since GIT_EXEC_PATH is
> not a suffix of executable_dirname (once the install location has been
> moved).

Right.

I am actually quite surprised that it builds for you, given this part of
the Makefile:

-- snip --
ifdef RUNTIME_PREFIX

ifneq ($(filter /%,$(firstword $(gitexecdir_relative))),)
$(error RUNTIME_PREFIX requires a relative gitexecdir, not: $(gitexecdir))
endif

[...]
-- snap --

I am also quite surprised that config.mk.in tries to set gitexecdir. But I
guess that is for cases where you want to override it via --libexecdir?

> I suppose we need to pass more configure options to reset paths; is
> there information somewhere on exactly which ones should be overridden?
>  For example if I try to pass configure --libexecdir=libexec to solve
> the above issue, I get an error from configure:
> 
>  configure: error: expected an absolute directory name for --libexecdir: libexec
> 
> Any info on how this is supposed to work, is welcome!

I just saw another thing:

-- snip --
exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
        '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
        '-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
        '-DBINDIR="$(bindir_relative_SQ)"' \
        '-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
-- snap --

Is it possible that we should use `gitexecdir_relative_SQ` here instead?
Does that fix things for you?

I Cc:ed Dan so he could correct my hunch that this GIT_EXEC_PATH
definition needs to be fixed.

Ciao,
Johannes
