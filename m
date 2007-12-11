From: Nicolas Pitre <nico@cam.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 13:01:41 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111259120.555@xanadu.home>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
 <alpine.LFD.0.99999.0712111245260.555@xanadu.home>
 <4aca3dc20712110953h13e3c33ftb310609bbac6a0a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29Qj-00089B-Kq
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbXLKSBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbXLKSBm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:01:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52940 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbXLKSBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:01:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW00JLOCQT46G0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 13:01:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4aca3dc20712110953h13e3c33ftb310609bbac6a0a8@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67895>

On Tue, 11 Dec 2007, Daniel Berlin wrote:

> On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 11 Dec 2007, Daniel Berlin wrote:
> >
> > > On the gcc repository (which is now a 234 meg pack for me), git
> > > annotate ChangeLog takes > 800 meg of memory (I stopped it at about
> > > 1.6 gig, since it started swapping my machine).
> > > I assume it will run out of memory.  I stopped it after 2 minutes.
> >
> > And I bet this is the exact same issue as the repack one.
> >
> > Do you still have the 2.1GB pack around?  I bet annotate would eat much
> > less memory in that case.
> 
> I do not, but i could remake it in a few days if it would help

Well, depending on the amount of RAM in your machine, you might even not 
be able to remake it at the moment.  I currently can't reproduce it 
myself due to the same out-of-memory issue.


Nicolas
