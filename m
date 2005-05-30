From: Ryan Anderson <ryan@michonline.com>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 18:19:22 -0400
Message-ID: <20050530221922.GC21076@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:18:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcsZP-0005dK-HF
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVE3WTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVE3WTw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:19:52 -0400
Received: from mail.autoweb.net ([198.172.237.26]:43720 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261785AbVE3WTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 18:19:25 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DcsbT-00059r-EU; Mon, 30 May 2005 18:19:23 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dcsd7-0005BV-00; Mon, 30 May 2005 18:21:05 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DcsbS-0004Fh-Q5; Mon, 30 May 2005 18:19:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 01:00:42PM -0700, Linus Torvalds wrote:
> 
> I think I'll move the "cvs2git" script thing to git proper before the 1.0 
> release (again, in order to have the tutorial able to show what to do if 
> you already have an existing CVS tree), what else?

Umm, why do you maintain two seperate "git" related trees?

Why not merge all of git-tools in, in a tools/ subdirectory?

I've been meaning to ask the same question about "gitweb" for that
matter.  The distributions that want seperate packages for dependency
reasons can handle that easily inside one tree, anyway, I believe.

I'd guess part of this is a holdover from the fact that you needed an
independent tree for BitKeeper, but does it still make sense?

-- 

Ryan Anderson
  sometimes Pug Majere
