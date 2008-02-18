From: Nicolas Pitre <nico@cam.org>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Sun, 17 Feb 2008 19:00:07 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802171859010.2732@xanadu.home>
References: <47A20503.2000603@debian.org>
 <420D37FF-C808-47CA-A3C8-38E1F8578FAC@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQtRI-0006X6-Ip
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 01:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbYBRAAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 19:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbYBRAAK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 19:00:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11829 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbYBRAAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 19:00:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWE00IB4QO76NF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 17 Feb 2008 19:00:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <420D37FF-C808-47CA-A3C8-38E1F8578FAC@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74207>

On Sat, 16 Feb 2008, Rhodes, Kate wrote:

> 
> On Jan 31, 2008, at 12:27 PM, Daniel Baumann wrote:
> 
> > git commit supports --author to overwrite the author information on a
> > particular commit; it would be nice if git tag would offer the same.
> 
> What are the implications of this on the GPG signature aspect of git-tag
> (desired or otherwise)?
> 
> If you were committing someone else's tag wouldn't you want to sign not only
> the commit, but their signature on the commit?
> 
> Ignoring the GPG issue, I'm just not seeing the benefit to having an author
> AND a committer on a tag. I mean... it's a *tag*. The only value I see in
> having any name associated with a tag is knowing who to point the finger at
> when the wrong thing gets tagged. But, I don't see any authorship aspect to
> the concept of a tag. To me it's more: "Bob" set it and it points to this. The
> end.
> 
> What you're proposing sounds more like: "Bob" said to set it and then "Mary"
> did, because Bob said to.

And in that case this information can be contained in the tag text body 
itself.


Nicolas
