From: Nicolas Pitre <nico@cam.org>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 10:01:08 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703260959310.3041@xanadu.home>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
 <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org>
 <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org>
 <20070325203141.GA12376@spearce.org>
 <alpine.LFD.0.83.0703252102520.3041@xanadu.home>
 <20070326020257.GB13247@spearce.org> <eu818b$im6$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVpl4-0000N8-FT
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 16:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbXCZOBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 10:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXCZOBL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 10:01:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9136 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbXCZOBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 10:01:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFI008TBK9WS900@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Mar 2007 10:01:08 -0400 (EDT)
In-reply-to: <eu818b$im6$2@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43153>

On Mon, 26 Mar 2007, Jakub Narebski wrote:

> Shawn O. Pearce wrote:
> 
> > Nicolas Pitre <nico@cam.org> wrote:
> 
> >> BTW Shawn there is no need to store the number of tree records at the 
> >> beginning of the tree object since that can be deduced directly from the 
> >> object size stored in the object header.
> > 
> > Doh.  Yes, of course.
> 
> But if it makes for easier _implementation_, perhaps it should stay...

No.

I don't think a division by 6 is that much of an implementation issue.


Nicolas
