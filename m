From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches
Date: Sat, 14 Jul 2007 13:38:05 -0700
Message-ID: <20070714203805.GA5419@soma>
References: <1184405128718-git-send-email-madduck@madduck.net> <20070714105010.GA14842@muzzle> <20070714110431.GA3854@piper.oerlikon.madduck.net> <20070714113435.GC14842@muzzle> <20070714120450.GA21890@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 22:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9oNZ-0003ID-AZ
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762510AbXGNUiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762205AbXGNUiI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:38:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41854 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761280AbXGNUiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:38:07 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E8B052DC032;
	Sat, 14 Jul 2007 13:38:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Jul 2007 13:38:05 -0700
Content-Disposition: inline
In-Reply-To: <20070714120450.GA21890@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52507>

martin f krafft <madduck@madduck.net> wrote:
> also sprach Eric Wong <normalperson@yhbt.net> [2007.07.14.1334 +0200]:
> > I have highlighting search set in my editor (vim :set hls)
> > and usually just search for spaces vs tabs to make sure I'm clean.
> 
> Try:
> 
>   :se lcs=tab:>-,trail,-

That didn't work, this does:

    :se lcs=tab:>-,trail:-

>   augroup listinsert
>     autocmd InsertEnter * set nolist
>     autocmd InsertLeave * set list
>   augroup end

Eep.  Too confusing ;)  I have my hls color set to be a red underscore
(which nothing else in my syntax higlighting uses), so it's less
intrusive for me.

> > Of course, maintaining a consistent whitespace style helps a *lot*
> > with the git/Linux patch exchange development style because it
> > avoids needless patch application conflicts that arise from
> > whitespace differences.
> 
> Using tabs also makes it impossible to X-cut-paste patches from
> emails; you *have* to use git-am and/or a temporary file, which
> i don't like at all.

Ah.  I that's one of the reasons I rarely use X-cut-paste for multi-line
strings.

When I apply patches with or without git-am from email, I just start
mutt inside the working source directory I'm in, and from the mutt index
I spawn vim to edit any email (just hit 'e'), go into visual mode,
select the part I want to apply and pipe that to whatever patch
application program I want to use, and :q! out of vim.

-- 
Eric Wong
