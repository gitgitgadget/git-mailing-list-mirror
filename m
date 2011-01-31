From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 16:28:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:28:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1It-0008Lq-NI
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab1AaV2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:28:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17637 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1AaV2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:28:50 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW00CZXOZD9R30@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 16:28:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110131210045.GB14419@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165755>

On Mon, 31 Jan 2011, Jeff King wrote:

> On Mon, Jan 31, 2011 at 03:28:37PM -0500, Nicolas Pitre wrote:
> 
> > We do have subdirectories for documentation, tests, contributions, etc.  
> > But a sizeable part of the tree is just a big splat of source files 
> > dumped right in the root of the tree.
> > 
> > So I'd suggest doing the following:
> > 
> > 1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and 
> >    the builtin directory from the root directory to it.
> 
> Wouldn't this just be the same giant splat of source files, but in a
> different tree? I don't really see the advantage, and it seems like an
> extra annoyance. 

Like I said to Junio, if you don't see the advantage, there's nothing I 
can do for you.  To me this is simple good source code hygiene.

> Besides being just one more directory to go up and down, it does make 
> history browsing more annoying. As much as I love git's "don't record 
> renames" philosophy, our handling of renames on the viewing side is 
> often annoying. I already get annoyed sometimes following stuff across 
> the s!builtin-!builtin/! change. This would be like that but more so.

So... we do suck at something?  So why not take this opportunity to 
shake yourself out of this easy comfort and improve Git as a result on 
both front?  :-)

> Or maybe it is a good thing for that reason, as we will eat our own
> rename dogfood. :)

Exactly!  And maybe we'll make Git even more useful in the process.

> > 5) Rename t/ to testsuite/ so this doesn't look like some garbage 
> >    leftover.
> 
> Ugh, more typing. :P

Come on!  You sound like an old fart now!  ;-)


Nicolas
