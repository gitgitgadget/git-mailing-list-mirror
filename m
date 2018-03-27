Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049DD1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 18:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeC0SKa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 14:10:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:41653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeC0Q2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:28:51 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1fHIwr28Pk-00L1MX; Tue, 27
 Mar 2018 18:28:45 +0200
Date:   Tue, 27 Mar 2018 18:28:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Daniel Jacques <dnj@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX
 design
In-Reply-To: <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803271817060.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com> <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com> <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nHV1boWxisqgipotmb4QXJ8O5zYWFj4Pkt4axv+VuNoHjQCWmyS
 F4ckxRK/Rqb94eH5z/+TCbHt0P8Qqaz0tPFPG4p1fwq37UzhUYCg8L1KaSj1+QY/eACHh9P
 rUo2rdifdlFfCrxVBz5d1lT4LSU3uMOMcdiUAm2bZH5Pkdvn3hE2urB47Xri/398LIPS8+C
 OB6DtxyhEFDMFza215uPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LWZzk+qvRmQ=:rR+0MWIcBI3ywXi16r6PmY
 RpDlU68KSW3C6At562NXOuZ9tm0yOmV31Asm0Qbdtiq1DZkr2pzLzY7zLp0DT8G05iWyt6/dB
 KzkZQCKiqt2ofziwU/2VVIPLu4BCSAuQjfxxtwip+HaEjHahp063G0O0pmP4hrHoFsQ2fP35T
 rBfXhw4uWR4vc/tJ2IubPM2Y65qTY9gmc8xOWgK3pjEGMP+kNQ3RvaPOuYD1qZH7R46cq8m3r
 HAa2y02GVSg5Pf0aaG9U2gfSn0ySoWbLeJZ4WwnyLkitjsns7lmCYeyUywWR2pF9Ddg75PkiD
 gbW7Zs9cgvxTLa5Z9j4afQ3K57crHoLJFaJ5c9IZuX2T6vOgvSK9yC/VPfCcZKiIz6DZYNzxH
 r18geNIzegyfeRjl80lKN6HeR9k8rgWddpY0jG5ft9ep5663ioB3JpoZCxxuVQXCW6RHxZ1LL
 z1uLShqNiqnb3fuUOb9J23p9mv6it3I7fqrPMUOfq+Yf95SfvIOHpFyad9aSzbnoEDEuy+u2H
 YxKDYYbx2Ogi/X2MzoSli7dRWs813wH4lZgOtVVV90+oAGxTghjxXVi49YyxkHVBLg7qoaLBZ
 3SYuLTSrl9jsREKmiy876Htimn6NnRgQY0DcVb5M9cv+o444w6GzEBEBqOpTIOywaJw3FzWz3
 lSb2IAhgsCGWjStwuST4kJAmOh0m2DhrcJoVpUf5clVl+9ztvgn1tym/g0Uc5BxUNTYCLSQHr
 fxIoJLIq32zLit5BRCq3I36vCp1Ko30oWyMzDZNxMomtm6esWuurW7n2LEjhn6V9kfQNSBwiD
 omCEeS3+Cx/vcU5+3Wq0zZ5z39Q/o75+KZKUOfX2Us6qvywHMcuFXkFPA8pMxXOxWXTnxms
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dan,

On Tue, 27 Mar 2018, Daniel Jacques wrote:

> On Tue, Mar 27, 2018 at 11:54 AM Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
> 
> > I guess we should add a test where we copy the `git` executable into a
> > subdirectory with the name "git" and call `git/git --exec-path` and
> > verify that its output matches our expectation?
> 
> I'm actually a little fuzzy on the testing model here.

Alright, I'll bite.

You are correct that the test must be contingent on the RUNTIME_PREFIX
prerequisite. This could be tested thusly:

	test_lazy_prereq RUNTIME_PREFIX '
		# test whether we built with RUNTIME_PREFIX support
		grep " -DRUNTIME_PREFIX" "$GIT_BUILD_DIR/GIT-CFLAGS"
	'

The subsequent test would run like this:

	test_expect_success RUNTIME_PREFIX '
		mkdir git &&
		cp "$GIT_BUILD_DIR/git$X" git/ &&
		path="$(git/git$X --exec-path)" &&
		case "$(echo "$path" | tr '\\' /)" in
		"$(pwd)/libexec/git-core") ;; # okay
		*)
			echo "Unexpected exec path: $path" >&2
			return 1
			;;
		esac
	'

I say "like this" because it is a little bit tricky to get right, in
particular when supporting Windows ;-)

For example, when building with Visual C, the dependencies' .dll files
need to be copied into the same directory as the .exe files because there
is no good central place to put them (don't get me started on the problems
incurred by some software copying some random OpenSSL version's
ssleay32.dll into C:\Windows\system32, unless you buy me beer all night
and want to be entertained). And that obviously would fail with this
approach.

> As things are, this test will only work if Git is relocatable; however,
> the test suite doesn't seem to be equipped to build multiple versions of
> Git for different tests.  From this I conclude that the right approach
> would be to make a test that runs conditional on RUNTIME_PREFIX being
> set, but I'm not familiar enough with the testing framework to be
> confident that this is correct, or really how to go about writing such a
> test.
> 
> A simple grep suggests that the current test suite doesn't seem to have any
> RUNTIME_PREFIX-specific tests. When I've been running the test suites, I've
> been doing it with a "config.mak" file that explicitly enables
> RUNTIME_PREFIX to get the runtime prefix code tested against the standard
> Git testing suites.

Indeed, this would be the first test.

>  From a Git maintainer's perspective, would such a test be a
>  prerequisite for landing this patch series, or is this a good candidate
>  for follow-up work to improve our testing coverage?

I cannot speak for Junio, but from my understanding he would probably be
fine without such a test. Or a separate patch at a later stage that
introduces that.

Or something completely different such as a helper in t/helper/ that
always succeeds if RUNTIME_PREFIX is not defined, otherwise passes argv[1]
as parameter to git_resolve_executable_dir() and outputs that. Would be a
lot more robust than what I described above. But I would want for Duy's
test-tool patch series to land first because I would hate to introduce
*yet* another stand-alone .exe in t/helper/.

Ciao,
Dscho
