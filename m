From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:03:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111601280.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu>
 <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu>
 <20080911190335.GB1451@cuci.nl>
 <alpine.LFD.1.10.0809111527030.23787@xanadu.home>
 <20080911194447.GD1451@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsOs-0003Pp-OG
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYIKUDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYIKUDP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:03:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYIKUDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:03:15 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K71005JCRP9N2C0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 16:03:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911194447.GD1451@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95635>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> Nicolas Pitre wrote:
> >On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
> >> Not quite.  Obviously all parents of p and p^ will continue to exist.
> >> I.e. deleting branch B will cause all commits from p till the tip of B
> >> (except p itself) to vanish.  Keeping p implies that the whole chain of
> >> parents below p will continue to exist and be reachable.  That's the way
> >> a git repository works.
> 
> >And that's what I called stupid in my earlier reply to you.  Either you 
> >have proper branches or tags keeping P around, or deleting B brings 
> >everything not reachable through other branches or tags (or reflog) 
> >away too.  Otherwise there is no point making a dangling origin link 
> >valid.
> 
> Well, the principle of least surprise dictates that they should be kept
> by gc as described above, however...
> I can envision an option to gc say "--drop-weak-links" which does
> exactly what you describe.

Don't you think this starts to look silly at that point?


Nicolas
