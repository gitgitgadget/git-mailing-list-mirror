From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 20:45:29 +0100
Message-ID: <20060226194529.GA21009@mars.ravnborg.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org> <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net> <20060225210712.29b30f59.akpm@osdl.org> <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 20:45:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDRpr-0001TQ-VC
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 20:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBZTph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 14:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWBZTph
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 14:45:37 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6664 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751362AbWBZTpg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 14:45:36 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id D9B311EC301;
	Sun, 26 Feb 2006 20:45:35 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id D67083940A2; Sun, 26 Feb 2006 20:45:29 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16789>

On Sun, Feb 26, 2006 at 09:29:00AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 25 Feb 2006, Andrew Morton wrote:
> > 
> > I'd suggest a) git will simply refuse to apply such a patch unless given a
> > special `forcing' flag, b) even when thus forced, it will still warn and c)
> > with a different flag, it will strip-then-apply, without generating a
> > warning.
> 
> This doesn't do the "strip-then-apply" thing, but it allows you to make 
> git-apply generate a warning or error on extraneous whitespace.

Can this somehow be done in a way so everyone that clones your tree
will inherit the warn/error on whitespace setting?
In this way we make sure it gets enabled automagically in many trees
and I do not have to remember yet another options.

Alternatively something that is enabled for a tree so I only have to do
something once - a trigger maybe?

	Sam
