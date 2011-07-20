From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 19:36:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107201931510.21187@xanadu.home>
References: <20110720221632.14223.qmail@science.horizon.com>
 <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Jul 21 01:37:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjgK6-0005zW-HS
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 01:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab1GTXg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 19:36:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38618 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1GTXg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 19:36:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LON00L7JO8SA190@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jul 2011 19:36:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177563>

On Wed, 20 Jul 2011, david@lang.hm wrote:

> On Wed, 20 Jul 2011, George Spelvin wrote:
> 
> > > The alternative of having to sometimes use the generation number,
> > > sometimes use the possibly broken commit date, makes for much more
> > > complicated code that has to be maintained forever.  Having a solution
> > > that starts working only after a certain point in history doesn't look
> > > eleguant to me at all.  It is not like having different pack formats
> > > where back and forth conversions can be made for the _entire_ history.
> > 
> > It seemed like a pretty strong argument to me, too.
> 
> except that you then have different caches on different systems.

So what?

> If the generation number is part of the repository then it's going to 
> be the same for everyone.

The actual generation number will be, and has to be, the same for 
everyone with the same repository content, regardless of the cache used.  
It is a well defined number with no room to interpretation.

> in either case, you still have the different heristics depending on what
> version of git someone is running

Indeed.


Nicolas
