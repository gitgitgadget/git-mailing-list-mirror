Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008AE1F744
	for <e@80x24.org>; Tue, 19 Jul 2016 11:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbcGSLYZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 07:24:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:51992 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbcGSLYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 07:24:24 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MWSwU-1brdAE06UU-00XbmC; Tue, 19 Jul 2016 13:24:20
 +0200
Date:	Tue, 19 Jul 2016 13:24:19 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Richard Soderberg <rsoderberg@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global
 grep.patternType
In-Reply-To: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607191323010.3472@virtualbox>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lJtRspdfTnLHZPwRHFJQmn2L2hx0i9Y0X4sYElFaSz+ZMkfq3OK
 RlpCRVl8qb37TBohHzt9Bz4OGZcoqaCgPcmsz2+ubpuauEmtQPZhc1C0BPYe4XUxxZanvW6
 uobd1P39YnGqbQg2FBjXd6JnC+YTb9XZqTWbsgFWBCoscmdFQklLea0CTrW0pMhgw1J+1HP
 iF0dZ110j++gmzHmRN5nQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QvXvJid+AlU=:sJoTfsFhqjEsyn6iY7PvBQ
 rvCaLMc6MMUQdFVTQuVpA6l8QpQQ/+LpZk7JUO00zP7rUhmkI3hesjntRoM/Gg4lauR7+q1UA
 8q7H3G0dFm4pD8m5u1jfk1VFnEwGQR3tUIzN+Kf39Z17UyMv12HhGhXhgNDRVhKtIaarTd8Wv
 3I1NfCsUqVQ3TdrAHwJ2uOFje69QoSy5rIypFjPsTdOkGUrzXzX4DmJCswS0cjJW98LB+VErP
 8Yhs5EQv9/smz1nGCLYCWn/W/wTzl4lgpfcw85rF8Bk7SPPdCYk4feqP0JLXFOOyaV4VxZVBH
 EDVlYc5YB/ZwQOByKVLxvM1fEwuUfBFC6JHE7IHiUtoIh6rUnxou33xADUR3ExsrlXy9kcif6
 tQG/KqCKw/bdvJZonPjMT1B9h2TOazAUv1tXlGGIJ0xZnamoM7u0KDu9UMgG7dqDuJ1wSoeI5
 G0ngwNKwCbgTvT4h+UqPReBI4Nf2rIvGZrlIV4aguZR8Wg/z0QnE9yfxlbd0koyKyLVc5I44E
 AHIlDWQVFOikM0pVNC+f8vmUIzw1kI4qSV22JB9Tc4/k6jfzg0SAaYP1w6U2o9wUqubdM9QEN
 WPTas0PfAZQr/fIuaV2cNoWacSCz5V9/A9Gqt1B+zev9cm9lXeV87zhxshxRWJP92+s1eXTIK
 PMWWSYxh95zWNGOX0en4dD21WQ3gkFWt1fnXWH7JppZc3VIMjxFwSoGXD2RcwiPdnmfsxx1s6
 lRxidb7cRR279ZkYom9LZtq70ycDmIyK3S90yoxVFfJDnEL+AaNcs/08xJbyzMNFqlo+LMl/h
 zOOLwmN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Richard,

On Mon, 18 Jul 2016, Richard Soderberg wrote:

> Hi, I wanted to report something interesting that I found while tracing
> a severe slowdown in git-prompt.sh.
> 
> https://github.com/git/git/commit/6d158cba282f22fa1548af1188f78042fed30aed#diff-f37c4f4a898819f0ca4b5ff69e81d4d9R141
> 
> Way back in this commit, someone added a useful chunk of code that works
> perfectly with svn+ssh:// URLs under basic regexes:
> 
> + local svn_upstream=($(git log --first-parent -1 \ +
> --grep="^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))
> 
> However, if I switch over to Perl regexes (or Extended):
> 
> git config --global grep.patternType perl
> 
> Then the command runs for one wall clock second and shows incorrect
> results on my repository. I eventually traced this to an issue with the
> regular expression provided, assuming the svn repository url is
> "svn+ssh://...":
> 
> git log ... --grep="^git-svn-id: \(svn+ssh://...\)" 2>/dev/null
> 
> The + sign isn't escaped in git-prompt.sh, which under non-basic regexes
> causes the match to fail entirely.
> 
>  - R.
> 
> ps. git log --basic-regexp does not fix the issue, as for unknown
> reasons (I'll start another thread) the command-line option doesn't
> override grep.patternType.

Maybe this helps?

-- snipsnap --
diff --git a/contrib/completion/git-prompt.sh
b/contrib/completion/git-prompt.sh
index 97eacd7..74be907 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -143,7 +143,7 @@ __git_ps1_show_upstream ()
 		# get the upstream from the "git-svn-id: ..." in a commit
 		# message
 		# (git-svn uses essentially the same procedure internally)
 		local -a svn_upstream
-		svn_upstream=($(git log --first-parent -1 \
+		svn_upstream=($(git -c grep.patternType=default log --first-parent -1 \
 					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
 			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}

