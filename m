From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 20:44:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701192040130.3011@xanadu.home>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
 <7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701191437450.3011@xanadu.home>
 <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701191729060.3011@xanadu.home>
 <7vps9aeghh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85H6-0007Ls-EO
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbXATBoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXATBoF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:44:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39905 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965094AbXATBoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:44:04 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC5001LH8TDLWE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Jan 2007 20:44:02 -0500 (EST)
In-reply-to: <7vps9aeghh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37247>

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> annotate is already ancillary and blame also is.  Do you want to
> promote one of them to mainporcelain?

I'd think so.

> > Is git-show-branch really a primary command?
> 
> Ah, I didn't notice that you wanted to move it out of
> mainporcelain in your patch.
> 
> I personally use it quite often while juggling topics,
> especially since I do not usually work inside X, but I'm fine
> either way -- ancillaryinterrogators?

Sure.

> Ok, then how about this on top of what you saw on the list.

I'd put fsck-objects in  ancillaryinterrogators.

Otherwise it looks fine.


Nicolas
