From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 13:41:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905281339030.3906@xanadu.home>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
 <m3y6siboij.fsf@localhost.localdomain>
 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net>
 <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
 <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
 <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>
 <alpine.LFD.2.00.0905272312370.3906@xanadu.home>
 <loom.20090528T041831-21@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 19:42:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9jcI-00052D-9b
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZE1RmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 13:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZE1RmA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 13:42:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48224 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZE1RmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 13:42:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKD00L637TNGT50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 May 2009 13:41:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <loom.20090528T041831-21@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120202>

[ please don't drop original sender address and CC unless asked to ]

On Thu, 28 May 2009, Eric Raible wrote:

> Nicolas Pitre <nico <at> cam.org> writes:
> 
> > On Wed, 27 May 2009, Linus Torvalds wrote:
> > 
> > > +pack.packDeltaLimit::
> > > +	The default maximum size of objects that we try to delta.
> > 
> > The option name feels a bit wrong here, like if it meant the max number 
> > of deltas in a pack.  Nothing better comes to my mind at the moment 
> > though.
> 
> pack.maxDeltaSize sounds weird when said aloud.
> How about pack.deltaMaxSize?

pack.MaxSizeForDelta

Whatever...


Nicolas
