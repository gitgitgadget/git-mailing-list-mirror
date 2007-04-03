From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Distribution of longest common hash prefixes
Date: Wed, 4 Apr 2007 01:08:46 +0200
Message-ID: <20070403230846.GB8479@dspnet.fr.eu.org>
References: <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com> <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com> <20070403172123.GD27706@spearce.org> <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org> <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704031529300.28181@xanadu.home> <7vhcrxw6h5.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704031635100.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYs7R-0004HQ-RS
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992486AbXDCXIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992493AbXDCXIs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:08:48 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:3706 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992486AbXDCXIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:08:47 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 68411A420A; Wed,  4 Apr 2007 01:08:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704031635100.28181@xanadu.home>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43693>

On Tue, Apr 03, 2007 at 04:39:02PM -0400, Nicolas Pitre wrote:
> On Tue, 3 Apr 2007, Junio C Hamano wrote:
> 
> > I stated it wrongly.  What I was getting at was that we might
> > want to consider an abbreviation that matches only a single
> > commit unambiguous even when there are ambiguous objects of
> > other kinds.
> 
> Maybe.  But by the time your object hash distribution starts showing 
> ambiguous objects with a given abbreviated name between a commit and a 
> non commit, I'll bet you'll start to see ambiguities between commits 
> soon enough as well.

Isn't the number of objects an order of magnitude bigger than the
number of commits?  Well, I guess that depends on your workflow...

  OG.
