From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 16:37:38 -0500
Message-ID: <20070120213738.GA8973@spearce.org>
References: <17842.1385.366750.915767@lisa.zopyra.com> <7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net> <7vfya57ast.fsf@assigned-by-dhcp.cox.net> <17842.29542.229557.460473@lisa.zopyra.com> <7vbqkt78n7.fsf@assigned-by-dhcp.cox.net> <7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 22:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8NuE-00079H-E2
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 22:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbXATVhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbXATVhn
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 16:37:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46351 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965396AbXATVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 16:37:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H8Nu0-0008Pn-0w; Sat, 20 Jan 2007 16:37:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E499A20FBAE; Sat, 20 Jan 2007 16:37:38 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37294>

Junio C Hamano <junkio@cox.net> wrote:
> Funny thing is, at least in recent enough git, I think we set up
> redirection to force output from hook scripts to stderr, but I
> do not remember when it happened.  Let's see...
> 
> 	...goes and looks...
> 
> That was supposed to have been fixed with commit cd83c74c (Dec
> 30, 2006), but this indicates the fix is not working at all when
> your login shell is tcsh.

Don't tell us tcsh is doing something ugly like opening the tty for
stdout/stderr instead of using the ones it inherited from its parent.
'cause that's just useless!

-- 
Shawn.
