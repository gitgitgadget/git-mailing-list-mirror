From: Nicolas Pitre <nico@cam.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 16:39:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031635100.28181@xanadu.home>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
 <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
 <86bqi6kae7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
 <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com>
 <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
 <20070403172123.GD27706@spearce.org>
 <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
 <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704031529300.28181@xanadu.home>
 <7vhcrxw6h5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpmv-0005Oy-M4
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbXDCUjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945933AbXDCUjG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:39:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25441 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945925AbXDCUjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:39:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00H94W12Z460@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 16:39:02 -0400 (EDT)
In-reply-to: <7vhcrxw6h5.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43657>

On Tue, 3 Apr 2007, Junio C Hamano wrote:

> I stated it wrongly.  What I was getting at was that we might
> want to consider an abbreviation that matches only a single
> commit unambiguous even when there are ambiguous objects of
> other kinds.

Maybe.  But by the time your object hash distribution starts showing 
ambiguous objects with a given abbreviated name between a commit and a 
non commit, I'll bet you'll start to see ambiguities between commits 
soon enough as well.

> Not that I consider it a pressing issue, though.

Indeed.  And even then it is not something really hard to implement 
either.


Nicolas
