From: Nicolas Pitre <nico@cam.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 12:26:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
References: <20070316042406.7e750ed0@home.brethil>
 <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
 <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
 <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFGE-0002V0-Bh
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbXCPQ01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbXCPQ01
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:26:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56689 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbXCPQ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:26:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF0002GL8C1KBX0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 12:26:25 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42374>

On Fri, 16 Mar 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 16 Mar 2007, Nicolas Pitre wrote:
> 
> > On Fri, 16 Mar 2007, Johannes Schindelin wrote:
> > 
> > > We already _have_ the data structures!
> > 
> > Well... Shawn and I are contemplating alternate data structures to 
> > improve things dramatically.
> 
> I was alluding to rev_info, not pack_window and friends.
> 
> > With a fixed public API I doubt such improvements could be as effective.
> 
> Just think of the "API" we have for porcelains. It is literally unchanged 
> since the beginning. You can even use the original script git-log.sh 
> today! _That_ is what I mean by fixed public API: give certain guarantees 
> about what will not go away.

Sure.  But the output from an executable is a damn good abstraction and 
the executable itself is an impenetrable boundary.  Anything can change 
(and did change) underneath.

This is why a public API must be done at a higher level to allow for 
anything to change at the lower level as we wish.


Nicolas
