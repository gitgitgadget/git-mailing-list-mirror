From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 21:11:49 -0400
Message-ID: <45F9EED5.3070706@garzik.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0zC-00046s-2E
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbXCPBL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbXCPBL7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:11:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:54498 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbXCPBL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:11:58 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HS0z0-0003eF-QG; Fri, 16 Mar 2007 01:11:51 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42310>

Linus Torvalds wrote:
> Now, it's possible that I'm just wrong, but the instruction-level profile 
> really did pinpoint the "look up state branch pointer and jump to it" as 
> some of the hottest part of that function. Which is just *evil*. You can 

ISTR there are a bunch of state transitions per byte, which would make 
sense that it shows up on profiles.


> Now, I'm just wondering if anybody knows if there are better zlib 
> implementations out there? This really looks like it could be a noticeable 
> performance issue, but I'm lazy and would be much happier to hear that 
> somebody has already played with optimizing zlib. Especially since I'm not 
> 100% sure it's really going to be noticeable..

I could have sworn that either Matt Mackall or Ben LaHaise had cleaned 
up the existing zlib so much that it was practically a new 
implementation.  I'm not aware of any open source implementations 
independent of zlib (except maybe that C++ behemoth, 7zip).

	Jeff
