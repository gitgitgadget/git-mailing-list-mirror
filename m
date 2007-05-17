From: Johan Herland <johan@herland.net>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 19:28:34 +0200
Message-ID: <200705171928.34927.johan@herland.net>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
 <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 19:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojmW-0004hT-Jk
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbXEQR2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbXEQR2n
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:28:43 -0400
Received: from [84.208.20.33] ([84.208.20.33]:42841 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754072AbXEQR2n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:28:43 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI700C034JPWY00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 19:28:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700CIN4JNH580@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 19:28:35 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700LP64JNXU60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 19:28:35 +0200 (CEST)
In-reply-to: <20070517171150.GL5272@planck.djpig.de>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47543>

On Thursday 17 May 2007, Frank Lichtenheld wrote:
> On Thu, May 17, 2007 at 06:57:22PM +0200, Johan Herland wrote:
> > Of course, it all depends on whether the $Id$ conversion is triggered by 
> > git-archive...
> 
> Another possibility might be to add a commandline switch to git-archive
> so you can decide whether the commit id should be added as a header to
> the tar file (which it already supports) or as a ordinary file (which
> should be reasonable trivial to implement). The question if whether
> it would be worth to add that feature. Don't know if there are many
> other users out there that need it.

Although this efficiently solves Michael's problem, I still think the ideal 
solution would be for git-archive to do the same conversions/filters as a 
regular checkout would. Otherwise, we'll easily get into situations where 
a git-archive tree is different enough from a "regular" working tree to 
cause annoying differences in behaviour.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
