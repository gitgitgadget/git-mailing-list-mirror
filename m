From: Nicolas Pitre <nico@cam.org>
Subject: Re: kde.git is now online
Date: Thu, 05 Apr 2007 15:45:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704051532240.28181@xanadu.home>
References: <46152BF5.3050502@zytor.com>
 <Pine.LNX.4.64.0704051029240.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704051334590.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Lee <clee@kde.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 21:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZXuM-0000CZ-7e
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 21:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767262AbXDETqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 15:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767266AbXDETqF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 15:46:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47538 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767262AbXDETqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 15:46:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG100IADIWPZF20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 15:46:01 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0704051334590.28181@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43850>

On Thu, 5 Apr 2007, Nicolas Pitre wrote:

> On Thu, 5 Apr 2007, Linus Torvalds wrote:
> 
> > 
> > 
> > On Thu, 5 Apr 2007, H. Peter Anvin wrote:
> > > 
> > > http://userweb.kernel.org/~hpa/kdegit/
> > > 
> > > It's available both as a tarball and as an expanded tree.
> > 
> > Thanks. Am downloading it right now ("0% 146.99kB/s" - it will take quite 
> > some time ;)
> 
> I'm downloading it too (794.3 KB/s).

OK this is a really nice test repo. I have only 1 GB of ram, and 
although basic operations appear to work just fine, this data set shows 
its weight in some ways.

For example I think there might be ways to improve the pack mmap 
windowing, or git-fsck's IO patterns.  For example, git-fsck --full 
spend 96% of the time waiting for IO completion and only 4% actually 
performing some work according to top.  At that rate that makes fsck 
--full rather unusable on this repo.  Without --full then fsck completes 
in less than 2 seconds.


Nicolas
