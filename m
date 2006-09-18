From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Sun, 17 Sep 2006 21:18:55 -0400
Message-ID: <20060918011855.GA19955@spearce.org>
References: <20060918004831.GA19851@spearce.org> <7vodtex9xm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 03:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7n0-000429-Dp
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 03:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWIRBTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 21:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIRBTC
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 21:19:02 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58528 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965207AbWIRBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 21:19:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GP7mZ-0003Rm-E4; Sun, 17 Sep 2006 21:18:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 94EB720FB1F; Sun, 17 Sep 2006 21:18:56 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodtex9xm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27220>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Since these are completion routines only for tools shipped with
> > core Git and since bash is a popular shell on many of the native
> > core Git platforms (Linux, Mac OS X, Solaris, BSD) including these
> > routines as part of the stock package would probably be convienent
> > for many users.
> >
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> >
> >  contrib/bash-git-completion.sh |  330 +++++++++++++++...
> >  1 files changed, 330 insertions(+), 0 deletions(-)
> 
> Hmph.  I tried this and found that I like "git pull ."
> completion quite a bit.  Having said that:

I got hooked very fast on the completion for git pull, git checkout
and git fetch, especially on my local network where setting up
the SSH connection for a remote git-ls-remote isn't that much
of a performance hit.  Trying to use ref completion on the Git
repository itself on kernel.org was quite horrible.  But it does
(sort of) beat doing an ls-remote first.
 
>  * If many people like it (like me), this may deserve to be
>    outside contrib/
> 
>  * Otherwise, it would probably be better to place it in either
>    contrib/bash/git-completion.sh (with potentially other
>    bash-related things not just completion, but I do not know
>    offhand what other kind of hooks would be useful) or
>    contrib/completion/git-completion.bash (possibly with
>    completion for other shells).

I'm not sure there are too many other things to hook into bash in
addition to completion so contrib/completion/git-completion.bash may
be the better location, assuming it doesn't graduate out of contrib/.

-- 
Shawn.
