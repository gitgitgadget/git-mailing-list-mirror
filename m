From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] t5300-pack-object.sh: portability issue using /usr/bin/stat
Date: Sat, 07 Apr 2007 08:39:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704070831140.28181@xanadu.home>
References: <20070406234903.GJ3854@regex.yaph.org>
 <7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704062227430.28181@xanadu.home>
 <7vabxkhleh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 14:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaACc-0000e0-PX
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 14:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbXDGMjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbXDGMjQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 08:39:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18029 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965818AbXDGMjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 08:39:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG400LH1OHFYJG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Apr 2007 08:39:15 -0400 (EDT)
In-reply-to: <7vabxkhleh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43964>

On Fri, 6 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Fri, 6 Apr 2007, Junio C Hamano wrote:
> >
> > Well... since this test already depends on wc then why not just use that 
> > instead of adding a perl dependency?
> 
> Because (1) other tests already use Perl; (2) wc -c reads pack
> to find out the size, "-s $file" doesn't AFAIK.

Maybe.  But my point is that wc is already used to find file size in 
other part of the test.  So it should at least be consistent.  And my 
patch has the advantage of looking much simpler.


Nicolas
