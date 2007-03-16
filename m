From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 17:13:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSF3J-0004W0-1Y
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965407AbXCPQNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965415AbXCPQNJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:13:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965407AbXCPQNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:13:08 -0400
Received: (qmail invoked by alias); 16 Mar 2007 16:13:05 -0000
X-Provags-ID: V01U2FsdGVkX18g1rRQ5NkgioXbv1wYCaz/m4blQJxUVsjHIjXwCD
	kEsjAMQ7LhdBp3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42369>

Hi,

On Fri, 16 Mar 2007, Nicolas Pitre wrote:

> On Fri, 16 Mar 2007, Johannes Schindelin wrote:
> 
> > We already _have_ the data structures!
> 
> Well... Shawn and I are contemplating alternate data structures to 
> improve things dramatically.

I was alluding to rev_info, not pack_window and friends.

> With a fixed public API I doubt such improvements could be as effective.

Just think of the "API" we have for porcelains. It is literally unchanged 
since the beginning. You can even use the original script git-log.sh 
today! _That_ is what I mean by fixed public API: give certain guarantees 
about what will not go away.

> One thing that was really done right in the Linux kernel is to _not_ 
> have any sort of fixed API at all for drivers.  This is a big upside for 
> progress.  Yet the Linux kernel is regarded as highly useful.

Yes. I am a Linux user myself.

Ciao,
Dscho
