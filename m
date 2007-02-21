From: Nicolas Pitre <nico@cam.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 13:02:08 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702211236180.31945@xanadu.home>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:02:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJvnF-00048y-9e
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbXBUSCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbXBUSCK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:02:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39089 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422676AbXBUSCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:02:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDT00E1XRFKHSA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 13:02:08 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40310>

On Wed, 21 Feb 2007, Linus Torvalds wrote:

> But at least in theory, it wouldn't be impossible to extend on the 
> ".git/grafts" kind of setup to say "this object has been consciously 
> deleted", and that could in some circumstances be a better model. The 
> biggest headache there would be the need to extend the native git protocol 
> with a way to add such objects.

I think that would be a big security issue.  Right now the GIT history 
can be validated and more importantly trusted from a single commit 
signature.  If poking holes in that model is allowed by the graft 
mechanism, it must remain a local thing and a very conscious one 
otherwise the GIT trust model would be greatly weakened.

If your goal is to remove content froma repository then the only 
sensible way is to rewrite history before publishing.  It is pointless 
to add mechanisms to remove content after it has been distributed.


Nicolas
