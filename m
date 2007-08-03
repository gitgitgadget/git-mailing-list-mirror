From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Fri, 3 Aug 2007 08:56:01 -0400
Message-ID: <20070803125601.GA28323@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de> <20070803030101.GI20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwhO-0007T8-HF
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbXHCM4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757286AbXHCM4G
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:56:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44689 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756185AbXHCM4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:56:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGwhF-0007dg-Kp; Fri, 03 Aug 2007 08:56:01 -0400
Content-Disposition: inline
In-Reply-To: <20070803030101.GI20052@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54717>

On Thu, Aug 02, 2007 at 11:01:01PM -0400, Shawn O. Pearce wrote:
> Steffen, you seem to be more in-tune with the Mac UI standards
> than I am.  Any suggestions on what I can do in git-gui to make
> this feature more obvious to users?
> 
> I myself use a Mac OS X based PowerBook as my primary development
> system, but I have to admit, I'm not the best GUI developer that has
> ever walked on this planet.  Far far far from it.

You're way ahead of me!

> So I'd really love to do better.  But frankly I'm at a loss here
> and just don't know what sort of change to make.

The one thing that struck me when I fired up git-gui was that it wasn't
obvious to me which things I should try clicking on.

For example: the buttons, drop-down menus, and check-boxes all cry out
to be played with.  But the filenames in the lists at the top are less
obvious, and it might never have occurred to me on my own to right-click
on the diff hunks at the bottom.  That just looks like passive colorized
text to me.

I don't know what sort of user-interface conventions say "play with
me!", though.  Random ideas:

	- maybe the cursor should change shape over the diff hunks (or
	  just the headers?)
	- maybe buttons, hunk headers, file names, etc., should all be
	  in the same color?
	- maybe the hunk headers could benefit from a little more
	  decoration?  I don't know how to do that without just making
	  the display look more cluttered, though.
	- maybe left-clicking on diff hunks should do something too?

I dunno.

--b.
