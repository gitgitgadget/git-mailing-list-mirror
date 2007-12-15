From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 21:23:38 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
 <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <m3fxy5qwbq.fsf@roke.D-201>
 <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
 <20071214215206.GB7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 03:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Mh7-0007LD-VT
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 03:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbXLOCXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 21:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXLOCXk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 21:23:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbXLOCXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 21:23:39 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT200MASJZEI4E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Dec 2007 21:23:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071215004230.GF7300@mail.oracle.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68371>

On Fri, 14 Dec 2007, Joel Becker wrote:

> On Fri, Dec 14, 2007 at 05:46:14PM -0500, Nicolas Pitre wrote:
> > On Fri, 14 Dec 2007, Joel Becker wrote:
> > 
> > > On Fri, Dec 14, 2007 at 05:34:49PM -0500, Nicolas Pitre wrote:
> > > > But you know what? repositories with the change affecting 1.4.4 users 
> > > > are _already_ out there and no one complained recently.  Anyone pushing 
> > > 
> > > 	I did, as did people I work with.  It's on git-list, even.  I'm
> > > pretty sure it corrupted too.
> > 
> > Could you please give me a reference to such message, so to verify that 
> > we're actually talking about the same thing?
> 
> 	The relevant message is:
> 
> Message-ID: <7vveaindgp.fsf@gitster.siamese.dyndns.org>
> 
> See the paragraphs at the bottom.  The thread, started by me, begins
> with:
> 
> Message-ID: <20070910205429.GE27837@tasint.org>

OK.  From those emails Junio forwarded to me, I don't see any case for 
actual _corruptions_.  Git does indeed refuse to work with unknown pack 
index or unknown objects in a pack.  Really old versions were not overly 
clueful as to why they refused to work, but they should never corrupt a 
pack which, for all purposes, is always read-only anyway.


Nicolas
