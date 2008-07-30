From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Wed, 30 Jul 2008 11:32:40 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807301121270.19665@iabervon.org>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness> <20080730121454.GA8767@leksak.fem-net>
 <alpine.LSU.1.00.0807301556140.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODgN-0007zY-KU
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYG3Pcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG3Pcm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:32:42 -0400
Received: from iabervon.org ([66.92.72.58]:44071 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbYG3Pcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:32:41 -0400
Received: (qmail 10190 invoked by uid 1000); 30 Jul 2008 15:32:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2008 15:32:40 -0000
In-Reply-To: <alpine.LSU.1.00.0807301556140.3486@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90806>

On Wed, 30 Jul 2008, Johannes Schindelin wrote:

> On Wed, 30 Jul 2008, Stephan Beyer wrote:
> 
> > Johannes Schindelin wrote:
> >
> > > Whoa, does that mean that
> > > 
> > > 	$ git checkout my-private-branch
> > > 	$ git sequencer --onto=master
> > > 
> > > will change _master_?
> > 
> > Exactly.
> 
> /me does not like that.  I could see a new porcelain doing that, but not 
> the thing that will be called by rebase.

Yeah, an option to change which branch is current should be called 
something different. --onto is an initial reset --hard, not an initial 
checkout; it specifies the branch (or commit) that the sequence of changes 
are done on top of, not the branch that will contain them. "Onto" (as an 
english preposition) specifies a destination, not a location, so it 
doesn't make sense as the location that stuff is done.

	-Daniel
*This .sig left intentionally blank*
