From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 13:53:50 -0500
Message-ID: <20061022185350.GW75501@over-yonder.net>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 20:53:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbiSK-0008HB-Mo
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVSxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWJVSxx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:53:53 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:57046 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1750700AbWJVSxw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 14:53:52 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id D27CF2842A;
	Sun, 22 Oct 2006 13:53:51 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id E21CA61C52; Sun, 22 Oct 2006 13:53:50 -0500 (CDT)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87zmbozau2.wl%cworth@cworth.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29774>

On Sun, Oct 22, 2006 at 07:25:41AM -0700 I heard the voice of
Carl Worth, and lo! it spake thus:
>
> 	git pull . mainline

This throws me a little.  I'd expect it to Just Do It when it's
fast-forwarding, but if it's doing a merge, I'd prefer it to stop and
wait before creating the commit, even if there are no textual
conflicts.  I realize you can just look at it afterward and back out
the commit if necessary, but still...


> Ah, I hadn't realized that bzr commits stored an "originating
> branch" inside them.

Every branch has a nickname, settable with 'bzr nick' (defaulting to
whatever the directory it's in is), and that's stored as a text field
in each commit.  It's mostly cosmetic, but it's handy to see at a
glance.


> This special treatment influences or directly causes many of the
> things in bzr that we've been discussing:
  [...]
> I've been arguing that all of these impacts are dubious. But I can
> understand that a bzr user hearing arguments against them might fear
> that they would lose the ability to be able to see a view of commits
> that "belong" to a particular branch.

Dead center.


> The mainline..featureA syntax literally just means:
> 
> 	the set of commits that are reachable by featureA
> 	and excluding the set of commits reachable by mainline

>From what I can gather from this, though, that means that when I merge
stuff from featureA into mainline (and keep on with other stuff in
featureA), I'll no longer be able to see those older commits from this
command.  And I'll see merged revisions from branches other than
mainline (until they themselves get merged into mainline), correct?
It sounds more like a 'bzr missing --mine-only' than looking down a
mainline in log...


> I haven't been able to find something similar in bzr yet. Does it
> exist?

The branch: (head) and ancestor: (latest common rev) revspecs let you
refer to the respective bits of other branches, which I think would
fill this role.


> It avoids a lot of the things in bzr that look so bizarre to people
> coming from git.

Well, what would be the fun in that?   8-}


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
