Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7501F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDET5y (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:57:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:39091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbeDET5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:57:53 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbM2k-1efWJu0R10-00kuQg; Thu, 05
 Apr 2018 21:57:52 +0200
Date:   Thu, 5 Apr 2018 21:57:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make running git under other debugger-like programs
 easy
In-Reply-To: <20180405174935.598-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804052144310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zeB9BvZzR0RfJiDtG2PzyMWwZuFOrfCM7yYhB/LDY5UNygt1oGt
 PggSfWKB7D3bdwyqnzxk+2nuUBYbWuIDgYTG79ETpuN/kv6nzLPAQhvBI4TiTIrOujYW5KH
 E1OLZsGg0/aoOFebQyP6+3kCjwrLDM3JlfSTY1I2nRMx4nQIpVVbOxRJeIEPRL/VLCFMXtr
 P3jg9JUxzV0qHUx7uAjsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2cHy3nEHS0g=:JdeiQPehAzkyPK6M4aTIxm
 mXuUKgtJez6Js/tfwb0lo+B2kXFt/BEPOiqLhLpIcyRDnbtzPTw5cN3Lw3mIqO8IV2eKYO/A/
 15e9L1VD5skihUYpgBZPqeJ9CnocdNK0GCJ6tNabr4RJKIGut+RySTCn+AMwtfCaWERN5lio7
 7DYS77muKcHftuInWlv5fEqWgqcoB5DA1I0mrUulpjNfzNE+Kqyazf0OCYf3CJTda0KYs7RY0
 IwrQio/0ueI2I2MZwe/lR8AOHojYo3Ps7KTUABQzPYnM3DLZZ7vGKLYUvmVKPaQEYNXblgeU+
 Sl3YBcq8eQDG5YJ36q5S6ZFIudWY3KaSHd+iRgNhUr8I844pu6Mn10O+VMr+42vvFBq42r6cR
 so6MlCfmhG0Kuv3PEmBqGVQZwwjelSBjRMJagFzRf9FyKZgcHCdN05gM1IklPJpd60t2FP10E
 b0jtkc/HIH8IxPk+2iJT4igQnmb9M/kiCvqCu8Jw05o44jq3p+RWB+MGPn3T0tOAyX82zs2cT
 +7GUD8qk0gJWJku7f6kg7oPRNObEGKmqGB3uRJRyQZ6JxplGRJ1wzPp6vWKh4C077I0e51QLA
 eTdubFgs5JfKp5OHReYXJAZ2xCBrtABHb7zqPjfHBp5YXKoFKylZ4q9aJVSoTGEt65FEyJHRh
 TYxFDul+33UtYVXP62aluUxXJYGG/r8d86BRSwgSt8tIUL4PTMWjwC16vh1VpuqQo6/Td0wXE
 xCXb1xv8ERlaYbC/ODOVphTtGBGRZjKy0q/HoPqZyPLEh0grrWwHdV+XRucd9nejScoJ/h/ho
 cbckmN3kvkd4C+MFXu+CmnwcpQaUwA8qh7NbmutcpXDglsIagYxjVdu4z2ndQvj6ngjhTJo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 5 Apr 2018, Elijah Newren wrote:

> This allows us to run git, when using the script from bin-wrappers, under
> other programs.  A few examples:
>    GIT_WRAPPER=nemiver git $ARGS
>    GIT_WRAPPER="valgrind --tool=memcheck --track-origins=yes" git $ARGS
> 
> Yes, we already have GIT_TEST_GDB (which could potentially be replaced
> with GIT_WRAPPER="gdb --args"), and a bunch of options for running
> a testcase or multiple testcases under valgrind, but I find the extra
> flexibility useful.

It would be even more useful if it could be made to work interactively,
too, by removing those redirections. The `debug` function does this
thusly:

debug () {
         GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
}

I wonder whether a better approach would be to add an optional argument to
that `debug` function (which is intended to have `git` as first argument,
anyway, or at least a command/function that does not start with a dash):

debug_aux () {
	shift
	"$@" <&6 >&5 2>&7
}

debug () {
	case "$1" in
	-d)
		shift &&
		GIT_TEST_GDB="$1" debug_aux "$@"
		;;
	--debugger=*)
		GIT_TEST_GDB="${1#*=}" debug_aux "$@"
		;;
	*)
		GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
		;;
	esac
}

... and then in wrap-for-bin.sh, we would replace the last lines

if test -n "$GIT_TEST_GDB"
then
	unset GIT_TEST_GDB
	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
else
	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
fi

by

case "$GIT_TEST_GDB" in
'')
	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
	;;
1)
	unset GIT_TEST_GDB
	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
	;;
*)
	GIT_TEST_GDB_$$="$GIT_TEST_GDB"
	unset GIT_TEST_GDB
	exec $GIT_TEST_GDB_$$ "${GIT_EXEC_PATH}/@@PROG@@" "$@"
	;;
esac

or some such.

Then your magic "GIT_WRAPPER" invocation would become a bit more explicit:

    debug --debugger=nemiver git $ARGS
    debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS

(In any case, "GIT_WRAPPER" is probably a name in want of being renamed.)

Ciao,
Dscho
