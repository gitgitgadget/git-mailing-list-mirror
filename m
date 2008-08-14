From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 10:01:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808140954400.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <48A3D1D7.5030805@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdPA-00039x-NW
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYHNOBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYHNOBO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:01:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33897 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYHNOBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:01:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5L00DEBG9SNILE@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Aug 2008 10:01:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <48A3D1D7.5030805@op5.se>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92358>

On Thu, 14 Aug 2008, Andreas Ericsson wrote:

> As a corporate git user, I can say that I'm very rarely worried
> about how much data gets sent over our in-office gigabit network.
> My primary concern wrt server side git is cpu- and IO-heavy
> operations, as we run the entire machine in a vmware guest os
> which just plain sucks at such things.

In the general case, the amount of data sent over the network is 
directly proportional to disk IO.


Nicolas
