From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 06:00:49 +0100
Message-ID: <20051106050049.GA5910@vrfy.org>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYceZ-0003Uh-MR
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 06:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVKFFA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 00:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKFFA5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 00:00:57 -0500
Received: from soundwarez.org ([217.160.171.123]:49381 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932295AbVKFFA5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 00:00:57 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 70397587A4; Sun,  6 Nov 2005 06:00:49 +0100 (CET)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11191>

On Sun, Nov 06, 2005 at 12:12:30AM -0300, Horst von Brand wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > > Now, I happen to think that 2500+ files in /usr/bin is a bit much (ever 
> > > try to use the horrid gnome executable finder on it when you want to 
> > > convince firefox to use xpdf instead of that broken crap called "evince"? 
> > > Takes absolutely ages and is horrible).
> > >
> > > And git made it about 4% worse all on its own.
> 
> [...]
> 
> > Since we do not have enough clout to have /usr/bin/git/ and ask
> > the users to put that in their PATH like X11 does,
> 
> That is going away. No more /usr/X11R6/{bin,lib,man} junk.
> 
> >                                                    we need to
> > teach some of our commands that use other git commands to
> > prepend /usr/lib/git/ (or /usr/libexec/git)
> 
> AFAIU, /usr/libexec/git (or /usr/libexec/git-<version>) would be better.

Note that "libexec" is not LSB conform - whatever that means, but it
should probably not be used for new projects. It states: "Applications
may use a single subdirectory under /usr/lib."

Kay
