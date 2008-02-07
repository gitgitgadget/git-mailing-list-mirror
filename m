From: Gerrit Pape <pape@smarden.org>
Subject: Re: Bug in gitk - can post the window off screen
Date: Thu, 7 Feb 2008 10:10:51 +0000
Message-ID: <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 11:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3io-0003uU-30
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 11:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYBGKKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 05:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbYBGKKe
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 05:10:34 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53654 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752777AbYBGKKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 05:10:34 -0500
Received: (qmail 19460 invoked by uid 1000); 7 Feb 2008 10:10:51 -0000
Content-Disposition: inline
In-Reply-To: <200802071056.19370.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72920>

On Thu, Feb 07, 2008 at 10:56:19AM +0100, Robin Rosenberg wrote:
> torsdagen den 7 februari 2008 skrev Shawn O. Pearce:
> > Tommy Thorn <tommy-git@thorn.ws> wrote:
> > > Just a quick heads-up: I was running a dual screen setup with gitk on my 
> > > 2nd monitor. When I later started gitk up without the 2nd monitor, the 
> > > gitk window didn't appear. Given the time between the two sessions, it 
> > > didn't occur to me what the problem was.
> > > 
> > > Gitk should probably validate the "set geometry(main)" variable against 
> > > the current resolution.
> > 
> > Sad to say but this is a known issue with both gitk and git-gui.
> > Both applications save the prior geometry and restore it during
> > the next run, but neither validates the new geometry makes sense
> > with the current available desktop space.  :-\
> 
> Seems KDE forces it back into visible space, but it is annoying that the 
> gitk/git-gui windows do not come up on the same monitor as my cursor is on. 
> Could we change it and save just size, just like "all other" apps?

Not saving the geometry on exit was also suggested through the Debian
BTS, "as window placement and sizing are the task of the window
manager"
 http://bugs.debian.org/442253

Regards, Gerrit.
