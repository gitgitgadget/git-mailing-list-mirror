From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Sun, 17 Sep 2006 18:03:49 -0700
Message-ID: <7vodtex9xm.fsf@assigned-by-dhcp.cox.net>
References: <20060918004831.GA19851@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 03:03:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7YB-0000uJ-2K
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 03:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWIRBDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWIRBDv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 21:03:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43938 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965203AbWIRBDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 21:03:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918010350.CJAB6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 21:03:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Pd3d1V00e1kojtg0000000
	Sun, 17 Sep 2006 21:03:38 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27219>

Shawn Pearce <spearce@spearce.org> writes:

> Since these are completion routines only for tools shipped with
> core Git and since bash is a popular shell on many of the native
> core Git platforms (Linux, Mac OS X, Solaris, BSD) including these
> routines as part of the stock package would probably be convienent
> for many users.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
>
>  contrib/bash-git-completion.sh |  330 +++++++++++++++...
>  1 files changed, 330 insertions(+), 0 deletions(-)

Hmph.  I tried this and found that I like "git pull ."
completion quite a bit.  Having said that:

 * If many people like it (like me), this may deserve to be
   outside contrib/

 * Otherwise, it would probably be better to place it in either
   contrib/bash/git-completion.sh (with potentially other
   bash-related things not just completion, but I do not know
   offhand what other kind of hooks would be useful) or
   contrib/completion/git-completion.bash (possibly with
   completion for other shells).
