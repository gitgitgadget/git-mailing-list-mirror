From: Nicolas Pitre <nico@cam.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 13:12:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161308070.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org>
 <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <45FAC75B.3030902@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFz1-0007xa-Do
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965693AbXCPRMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965712AbXCPRMs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:12:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965693AbXCPRMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:12:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF0006FGAHAQ6A0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 13:12:47 -0400 (EDT)
In-reply-to: <45FAC75B.3030902@garzik.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42382>

On Fri, 16 Mar 2007, Jeff Garzik wrote:

> Although it sounds like zlib could indeed be optimized to reduce its startup
> and shutdown overhead, I wonder if switching compression algorithms to a pure
> Huffman or even RLE compression (with associated lower startup/shutdown costs)
> would perform better in the face of all those small objects.
> 
> And another random thought, though it may be useless in this thread:  I bet
> using a pre-built (compiled into git) static zlib dictionary for git commit
> and tree objects might improve things a bit.

See my last post.  We'll do even better with special object 
encoding altogether.  Those representations are so dense that 
compression provides no gain at all making the point moot.


Nicolas
