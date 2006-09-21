From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 14:05:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609211357450.2627@xanadu.home>
References: <20060921162401.GD3934@spearce.org>
 <20060921164048.GY8259@pasky.or.cz>
 <Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 20:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQSvG-00082W-Rv
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 20:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWIUSFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIUSFO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 14:05:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34197 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751422AbWIUSFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 14:05:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5Y00FNBFKO5CD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Sep 2006 14:05:12 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27501>

On Thu, 21 Sep 2006, Linus Torvalds wrote:

> Right now, a plain "git pull" means "fetch all branches and merge the 
> first one", and the thing is, that's generally the right thing _only_ if 
> you pull into "master".
> 
> It's usually exactly the _wrong_ thing to do for any other branch. In 
> particular, if you work with a project that has lots of branches, and 
> you're working in another branch (that is directly tracking a remote, for 
> example), doing a "git pull" definitely should _not_ merge the first head. 
> It should fetch everything, and possibly merge the _matching_ head.
> 
> Which it doesn't do right now.

I think you're summarizing my grip about git pull quite well.  This is 
really counter-intuitive and I've been bitten by that behavior on many 
occasions.


Nicolas
