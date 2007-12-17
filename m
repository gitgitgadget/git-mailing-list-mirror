From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 17:15:18 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712171711100.8467@xanadu.home>
References: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <20071217211317.GC19816@mail.oracle.com> <20071217213049.GG13515@fieldses.org>
 <alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
 <20071217215709.GH13515@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OFx-0002u3-ME
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbXLQWPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755878AbXLQWPs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:15:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24719 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbXLQWPs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:15:48 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT700IHJSHIG3D1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 17:15:18 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071217215709.GH13515@fieldses.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68636>

On Mon, 17 Dec 2007, J. Bruce Fields wrote:

> On Mon, Dec 17, 2007 at 04:52:16PM -0500, Nicolas Pitre wrote:
> > On Mon, 17 Dec 2007, J. Bruce Fields wrote:
> > 
> > > By the way, just as a data point: I do keep some git repositories on
> > > NFS, and access them from multiple machines with different git versions
> > > (not on purpose--it's just that the machines don't all run the same
> > > distro, so it'd be extra work to give them all the same version).  I
> > > don't use anything older than 1.5.0.  If the repository became unusable
> > > on one of those machines without warning it'd be annoying.
> > 
> > What the v1.5.5 release notes will say is that you'll have to set 
> > pack.indexversion=1 to remain compatible with pre-1.5.2 Git versions.  
> 
> Is there any reason not to make pack.indexversion=1 the default (for
> preexisting repositories at the very least) and suggest in the release
> notes that people set something else if they want the features the new
> version provides?

That's already the case now.

But the thing is that index version 2 is better and actually plug a flaw 
in the repacking process where unnoticed corruption could be repacked 
otherwise.  So for better repo integrity sake, it has to become the 
default at some point.


Nicolas
