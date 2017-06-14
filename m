Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1898E20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdFNNYK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:24:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:52624 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNNYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:24:09 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McEkx-1d4z6R04wh-00JbYG; Wed, 14
 Jun 2017 15:24:04 +0200
Date:   Wed, 14 Jun 2017 15:24:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philipp Gortan <philipp@gortan.org>
cc:     philipoakley@iee.org, avarab@gmail.com, git@vger.kernel.org,
        matthias.serfling@googlemail.com
Subject: Re: [PATCH] respect core.hooksPath, falling back to .git/hooks
In-Reply-To: <20170602202301.6413-1-philipp@gortan.org>
Message-ID: <alpine.DEB.2.21.1.1706141516540.171564@virtualbox>
References: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com> <20170602202301.6413-1-philipp@gortan.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HoUTsq90ZaS6TvlfVfET69+pSLLKGMki1d80aGdbcdBT0GWqZjV
 Fkx5SxC+znG/QcD8EQwBvQHDoDl2bXC1sFQJTT+KZb4r5BlWHMXy5NA59/T6qhxL8ee+4cZ
 mcMUCN/odyli0Dd4WK/pmr8L38Inp+rvlVBHYJ47T6wZcrlmLpgO5sfH23/1aeiRjYRIK6e
 z+peH4KJBz3WurLBq95fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V7ig+7gOZ34=:rx3GYhClHRT3EANQMczBYY
 Tt4IGW2mgrBkqIKTHDtKPsHPL7H0Aisnf5S/Zauq9LJw41LnrpOtzobkZsjO+Llc9tiUpOHjt
 i0f8fr8gR8NA4vG11tAdnUB5M16inWvLkMA1MUMk5PYSz4dMnQujLR0Q75pt2tOSBgcIjaQNu
 gounXyyBsTNIYf3nTb667lPgXi7QQXh/qGTASMxKGHdFII0+r5zC00hXNCT9Ep4kX9swWexYo
 LGwLF+1YhqTHPE+x4tl0GLqzrBWlUlyXDAABZtiKSd3eAs0P1v7SXkjmkixRK7r+pwiNcil/3
 atvw+3rv0RiwdtN635aBWnH0Q4CUmhvrTWx/TT0pLQpScTeExDDwc4+DaDEj8kXznMZhowkHT
 Q3WdWfFsWJUU8VUFqppkGx/g8dDv7ivgVPv0Fnu5L5or7hbRH9iIHHMKsc1daHu2nIopi8HPH
 pUBCNPtYN3Mqu/+39LKAcZ3bzN6W/z5BxWlTdVI4+0BK8yiJNyyonTAGbh7nnfAdwm5jD1Lem
 V90geIHqSgehbh8zCXcBEDy/g8dTix8O2LVyHjtojlJPV5Hcodt0cU2+OWu9WWSQq6tyGli2R
 2/1FWr0wez+nPGHggY1kXCQI5QAbK9Dq02jNiwagpUYVIYDlxG75uQm8JK9x1VPdso4wsV55T
 GONY5CI1p9YP1tzzImLTNCyG4yr4GiP0dUMX4+dQwQow2fGjSxpJstPxKNT3hOcI7p86qOfDr
 +K504vwZabbeeP5x1J6pcLKLj0yDAc+zn6e3CY4nNN5pYF9KM0E2Ps0t4ToNW8cy2Gr5eScMQ
 196VXho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philipp,

On Fri, 2 Jun 2017, Philipp Gortan wrote:

> Signed-off-by: Philipp Gortan <philipp@gortan.org>

I just saw this. I made sure that the thread to which I just replied did
not have any news from you, but you simply started a new thread ;-)

This commit message needs a little bit of love. Something along the lines:

	Since v2.9.0, Git knows about the config variable core.hookspath
	that allows overriding the path to the directory containing the
	Git hooks.

	Since v2.10.0, the `--git-path` option respects that config
	variable, too, so we may just as well use that command.

	For Git versions older than v2.5.0 (which was the first version to
	support the `--git-path` option for the `rev-parse` command), we
	simply fall back to the previous code.

(This assumes that you'll go with the approach I outlined in the other
thread, comparing the Git version to 2.5.0 and going with --git-path if
available.)

> ---
> 
> The following patch tries to fix git-gui to respect the core.hooksPath config
> variable, falling back to the old behavior.

That would also have been a decent commit message, if a bit short. But you
need to put this text before the `---` line, even before the
`Signed-off-by:` footer.

> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..a5335b1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -624,7 +624,10 @@ proc git_write {args} {
>  }
>  
>  proc githook_read {hook_name args} {
> -	set pchook [gitdir hooks $hook_name]
> +	if {[catch {set hooksdir [git config core.hooksPath]}]} {

Did you not mean [get_config core.hookspath] here, i.e. get_config and the
key all lower-case?

> +		set hooksdir [gitdir hooks]
> +	}
> +	set pchook [file join $hooksdir $hook_name]
>  	lappend args 2>@1
>  

The problem I see with that is, as I mentioned in the other thread, that
it duplicates the logic in config.c that may change at any stage.

Even worse: it is inconsistent with the way Git handles core.hooksPath, if
the installed `git` executable predates v2.9.0. Git GUI explicitly allows
for being used with a large range of Git versions.

In short: I think it would be better to go with the approach I outlined in
the other thread. I'll reproduce the patch (completely untested) here:

-- snipsnap --
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 37c1c5d227b..3067a3b000a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -624,7 +624,11 @@ proc git_write {args} {
 }
 
 proc githook_read {hook_name args} {
-	set pchook [gitdir hooks $hook_name]
+	if {[package vcompare $::_git_version 2.5.0] >= 0} {
+		set pchook [git rev-parse --git-path "hooks/$hook_name"]
+	} else {
+		set pchook [gitdir hooks $hook_name]
+	}
 	lappend args 2>@1
 
 	# On Windows [file executable] might lie so we need to ask
