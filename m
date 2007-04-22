From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver
 definition.
Date: Sun, 22 Apr 2007 14:11:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704221409390.28339@xanadu.home>
References: <11771520591529-git-send-email-junkio@cox.net>
 <"11771520591703-gi t-send-email-junkio"@cox.net>
 <7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgXW-00055U-9m
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXDVSLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbXDVSLy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:11:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46791 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbXDVSLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:11:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGW005OIVVT8F50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Apr 2007 14:11:53 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45259>

On Sun, 22 Apr 2007, David Lang wrote:

> On Sat, 21 Apr 2007, Junio C Hamano wrote:
> 
> > > 3. why specify seperate clean/smudge programs instead of just one
> > > script with a read/write parameter?
> > 
> > I think the most common two ways have clean as a cleaner and
> > smudge as a no-op (similar to crlf=input conversion), or clean
> > and smudge are inverse operations (similar to crlf=true
> > conversion.  I do not see a sane case where clean and smudge are
> > the same, unless you are thinking about the toy demonstration
> > test piece I added to t0021 which uses rot13 as both clean and
> > smudge filters.
> 
> actually, I'm thinking of much more complicated filters, where it's easier to
> have one program do both functions then it is to have two seperate programs
> (like tar -c /tar -x)

Just specify the same program in both entries with the appropriate 
parameter and be happy.

It is much easier to have two entries with the same program than having 
only one entry when you actually have two separate programs.


Nicolas
