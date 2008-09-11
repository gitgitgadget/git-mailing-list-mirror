From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 22:46:19 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809102244100.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl>
 <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl>
 <20080910151015.GA8869@coredump.intra.peff.net>
 <20080910215045.GA22739@cuci.nl>
 <20080910215410.GA24432@coredump.intra.peff.net>
 <20080910223427.GB22739@cuci.nl>
 <20080910225518.GA24534@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 04:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdcDV-0007BN-Su
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 04:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYIKCq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 22:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbYIKCq0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 22:46:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55872 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbYIKCqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 22:46:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7000EPPFP77BF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Sep 2008 22:46:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080910225518.GA24534@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95575>

On Wed, 10 Sep 2008, Jeff King wrote:

> On Thu, Sep 11, 2008 at 12:34:27AM +0200, Stephen R. van den Berg wrote:
> 
> > I see.  Indeed.  That's a lot better.
> > Did the binary search inside tree objects ever get implemented?
> 
> I believe it's still linear (and skimming tree-walk.c:find_tree_entry
> seems to confirm). However, one advantage of such an approach is that it
> will improve as tree lookup improves (e.g., I believe the pack v4 work
> included improvements in this area).

No, not yet.  Actually that's the part that still needs serious 
thinking.


Nicolas
