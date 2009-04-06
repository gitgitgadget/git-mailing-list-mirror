From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 10:14:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904061011460.6741@xanadu.home>
References: <20090405T001239Z@curie.orbis-terrarum.net>
 <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
 <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <vpq3acm6n7p.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0904060912530.6741@xanadu.home>
 <20090406T140124Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqpcf-00075G-BA
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZDFOOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbZDFOOx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:14:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48345 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZDFOOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:14:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO00ITVNKLI890@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 10:14:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090406T140124Z@curie.orbis-terrarum.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115834>

On Mon, 6 Apr 2009, Robin H. Johnson wrote:

> I haven't read all this morning submissions to the thread yet, but I
> wanted to make two posts before I leave on a trip (in ~20 minutes), and
> I'll be back late on Thursday.
> 
> On Mon, Apr 06, 2009 at 09:29:04AM -0400, Nicolas Pitre wrote:
> > > To me, this is a non-issue (if the content of these objects are
> > > secret, then why are they here at all on a public server?), but I
> > > think there were discussions here about it (can't find the right
> > > keywords to dig the archives though), and other people may think
> > > differently.
> > Guess who was involved in that discussion...
> > I may allow you to pull certain branches directly from my own PC through 
> > the git native protocol.  That doesn't mean you have direct access to 
> > the whole of any of the packs I have on my disk.
> If the native rsync protocol is allowed to the repo, then that argument
> is moot.

The rsync protocol is _not_ the native git protocol.  And I personally 
don't encourage its usage either, except as a _temporary_ workaround for 
unresolved issues.  You will never see this protocol available from any 
git server I maintain.


Nicolas
