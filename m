From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 17:21:31 -0500
Message-ID: <20061023222131.GB17019@over-yonder.net>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 00:21:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8Ar-00084W-18
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWJWWVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWJWWVd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:21:33 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:30144 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S932165AbWJWWVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 18:21:33 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 116602842A;
	Mon, 23 Oct 2006 17:21:32 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 772C861C57; Mon, 23 Oct 2006 17:21:31 -0500 (CDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29891>

On Mon, Oct 23, 2006 at 10:29:53AM -0700 I heard the voice of
Linus Torvalds, and lo! it spake thus:
> 
> I already briought this up once, and I suspect that the bzr people
> simply DID NOT UNDERSTAND the question:
> 
>  - how do you do the git equivalent of "gitk --all"

I for one simply DO NOT UNDERSTAND the question, because I don't know
what that is or what I'd be trying to accomplish by doing it.  The
documentation helpfully tells me that it's something undocumented.


> For example, how long does it take to do an arbitrary "undo" (ie
> forcing a branch to an earlier state) [...]

I don't understand the thrust of this, either.  As I understand the
operation you're talking about, it doesn't have anything to do with a
branch; you'd just be whipping the working tree around to different
versions.  That should be O(diff) on any modern VCS.


> and yes, performance does matter.

I agree, and I currently find a number of places bzr doesn't hit the
level of performance I think it should.  I'm not convinced, however,
that any notable proportion of that has to do with the abstract model
behind it.  And insofar as it has to do with the physical storage
model, that can easily be (and I'm confident will be, considering it's
a focus) ameliorated with later repository formats.


> The whole confusing between "bzr pull" and "bzr merge" is another
> _technical_ sign of why branch-local revision numbers are a mistake. 

I consider it a _technical_ sign of a way of thinking about branches I
prefer   8-}


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
