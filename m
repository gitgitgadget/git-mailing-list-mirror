From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 14:48:08 +0100
Message-ID: <20051128134808.GQ22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net> <438AC32E.5010100@op5.se> <200511281359.04741.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgjML-0007WS-Hi
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVK1Nry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVK1Nry
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:47:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51596 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932103AbVK1Nrx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 08:47:53 -0500
Received: (qmail 3876 invoked by uid 2001); 28 Nov 2005 14:48:08 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511281359.04741.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12878>

Dear diary, on Mon, Nov 28, 2005 at 01:59:04PM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> (2) project config (in .git/project.conf)

What are you going to keep in it? There isn't much of stuff which is not
per-user or per-instance. I can't think of anything now, but there is no
list of configuration variables to check yet.

(Upstream maintainer email is interesting, OTOH it alone doesn't seem to
justify the mechanism by itself; also, the upstreams may be different
based on where you cloned the project from, etc.)

> For (2), git-clone should copy some files, e.g. the .git/project.conf
> or .git/info/exclude. But project config probably should be kept
> up to date among all repositories for a project, i.e. it should be
> version controlled itself, but independent from the project.
> We could use a project config head .git/refs/projectconfig for this;
> of course post-1.0 material.

If you still want per-project config, why should it be independent from
the project? Actually, like you have .gitignore, having something like
.gitconfig in project root would be by far the simplest - if you want
separate head, your merging and stuff gets quite more complicated, as
well as actually branching the project config, etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
