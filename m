Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0221F404
	for <e@80x24.org>; Sat, 23 Dec 2017 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756951AbdLWWsV (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 17:48:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:50507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752935AbdLWWsU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 17:48:20 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.73]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MK3bN-1eS36t3D7t-001NLA; Sat, 23 Dec 2017 23:48:18 +0100
Date:   Sat, 23 Dec 2017 23:48:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Vadim Petrov <tridronet@yandex.ru>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] setup.c: move statement under condition
In-Reply-To: <3853941514059379@web42g.yandex.ru>
Message-ID: <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <3853941514059379@web42g.yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HqPu/979lJVxkfyJgkr/B4JuNCkEK4s2aRpIlkEu2P2/giyC7GG
 NouQS9oaYc1zVbz3GSa4Udjj/NMeawCtI4y6CYZuqxBhzbCJn3s8l6I/qfb4TDqjtnYvPO8
 TP/EqGglwIzBUV2Q1oA+bp/x5x1Vt8H9I2wCwkqVUaUQ1wEBJtMCXkIeB9ONX4h+dymKVmZ
 95bA6fg4Eq/o81A+WQq0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+m6yQTqcP0w=:xwFnf2HSSwnONbiWqfEG/O
 b4WQhIhcnF2YK2ij0ssjjTAs9QV3zRv0rNtIE7LpMpMHedCnBDAcepM1tScVdExiwteISuLF7
 cg81Y0Nr0wlaPaMnO+7798cDMw+zTXdqQelBgX2KNdZfHfJB64H9Ouc6x7w4fYisUCdrETi1b
 r1bf21HUCkrlzUBtV9Q+DZT+cdavPW3qmw6roJ9RQc+OsRmh2PPIDannSn7kAR36rQ28xVYO6
 EqEi3kjglhE1IRCt8zqwDjzToX2jLXzjXstrcw/ruXFRAJ3aL67BaY2M2mvaNJHdh9IQPQNFh
 35emf+dmgIfzLedm5TPJ3N4XddAmuKP5FmrpESC0QmTQwU4FpbA4qtb0Bzci0jN1VTS/fBxkj
 SMcGwR4v2Mh3nHoDpkG8KlvjfuuSbyg6c8hRIsoaR2e/+m9rBgnoyMo/UbrzPTpqU2KV6OGYF
 uCpZcbqWgb7d2II2QkV2pYuxhT5IOyoiv+HlArGhoXJMEKIfVpCJN6x7dNsO8WjQnvgOrYmXS
 dDS9yB1hHL384TrPFgxx/azZwJgRZAmxcI3cbYL6dK4V0nTSpUtnD7nZbgb7YNFkLNWVESV5k
 UxsY8thhSMbQmPD4FTZFTKFajd2ojr9/z7prqAyhHR0wo8aWa7zJwf/+ARgC3EgQeNKa3pusg
 UZCOsl1fDmbAcZ/vKbp1EVtbvsA1k11g5JsC8vsPrCaGqUiEMI5bfyCcHabNQDVUBO4vBhDzj
 l+wGmWgqOEBwtaUVd4sW/a//aD66uF/J16QtY0ny4aADNPz6rMdCThNkl7mY6hAfKJgM/j0x8
 rKsYVSUvgcyTNfFvbyGJ6WtApepzRzDkrIg63UWUegmDEqluhU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vadim,

thank you for your contribution!

On Sun, 24 Dec 2017, Vadim Petrov wrote:

> I suppose that if the condition is fulfilled then the previously
> obtained value will not be necessary.

I have to be honest: this commit message (including the subject) left me
quite puzzled as to the intent of this patch.

Maybe something like this would have spared me that puzzlement:

	Avoid unnecessary offset_1st_component() when prefixing filenames

	In the abspath_part_inside_repo() function that is called
	somewhere deep in the call-chain when prefixing paths, we
	calculate the offset of the first component, but under certain
	circumstances, the result is not even used.

	This patch changes the code to avoid that.

If you also have a background story that motivated you to work on this
patch (for example, if you hit a huge performance bottleneck with some
tool that fed thousands of absolute paths to Git that needed to be turned
into paths relative to the worktree's top-level directory), I would
definitely put that into the commit message, too, if I were you.

> diff --git a/setup.c b/setup.c
> index 8cc34186c..1ce0189fa 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -35,7 +35,6 @@ static int abspath_part_inside_repo(char *path)
>  		return -1;
>  	wtlen = strlen(work_tree);
>  	len = strlen(path);
> -	off = offset_1st_component(path);
>  
>  	/* check if work tree is already the prefix */
>  	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> @@ -49,6 +48,8 @@ static int abspath_part_inside_repo(char *path)
>  		}
>  		/* work tree might match beginning of a symlink to work tree */
>  		off = wtlen;
> +	} else {
> +		off = offset_1st_component(path);
>  	}

Up until recently, we encouraged dropping the curly brackets from
single-line statements, but apparently that changed. It is now no longer
clear, and often left to the taste of the contributor. But not always.
Sometimes we start a beautiful thread discussion the pros and cons of
curly brackets in the middle of patch review, and drop altogether
reviewing the actual patch.

However, we still encourage to put shorter alternative code paths
(i.e. the blocks after `if` and `else`) first, in your case:

@@ -35,18 +35,19 @@ static int abspath_part_inside_repo(char *path)
 		return -1;
 	wtlen = strlen(work_tree);
 	len = strlen(path);
-	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
- 	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
+	if (wtlen > len || strncmp(path, work_tree, wtlen))
+		off = offset_1st_component(path);
+	else {
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
			/* work tree is the root, or the whole path */
			memmove(path, path + wtlen, len - wtlen + 1);
			return 0;
		}
		/* work tree might match beginning of a symlink to work * tree */
		off = wtlen;
	}

I would also encourage to generate the patch so that it includes the `off
= wtlen` line (by passing -U11 or some such to `git format-patch`), to
make the review super easy.

In short: I think your patch does the right thing, and I hope that you
find my suggestions to improve the patch useful.

Ciao,
Johannes
