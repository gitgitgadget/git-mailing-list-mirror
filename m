From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 20:58:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107202041480.21187@xanadu.home>
References: <20110720221632.14223.qmail@science.horizon.com>
 <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
 <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, George Spelvin <linux@horizon.com>,
	anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 02:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjhby-0003Bj-Lf
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab1GUA7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:59:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14169 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab1GUA7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:59:14 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LON00G16S0A2H20@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jul 2011 20:57:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4E276DF8.8030301@cisco.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177569>

On Wed, 20 Jul 2011, Phil Hord wrote:

> On 07/20/2011 07:36 PM, Nicolas Pitre wrote:
> > On Wed, 20 Jul 2011, david@lang.hm wrote:
> > 
> > > If the generation number is part of the repository then it's going to
> > > be the same for everyone.
> > The actual generation number will be, and has to be, the same for
> > everyone with the same repository content, regardless of the cache used.
> > It is a well defined number with no room to interpretation.
> 
> Nonsense.
> 
> Even if the generation number is well-defined and shared by all clients, the
> only quasi-essential definition is "for each A in ancestors_of(B), gen(A) <
> gen(B)".

Sure.  But what do you gain by making holes in the sequence?

> In practice, the actual generation number *will be the same* for everyone with
> the same repository content, unless and until someone develops a different
> calculation method.  But there is no reason to require that the number *has to
> be* the same for everyone unless you expect (or require) everyone to share
> their gen-caches.

And with the above you clearly reinforced the argument _against_ storing 
the generation number in the commit object.  If you can imagine a 
different calculation method already, and if it is actually useful, then 
who knows if something even better could be done eventually.


Nicolas
