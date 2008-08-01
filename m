From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Is there any hope (format-patch)??
Date: Fri, 1 Aug 2008 13:35:52 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808011323110.19665@iabervon.org>
References: <4892FBF6.8060505@sitecno.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matti Kaasinen <matti.kaasinen@sitecno.fi>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOyYp-0008WJ-U1
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 19:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbYHARfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYHARfy
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 13:35:54 -0400
Received: from iabervon.org ([66.92.72.58]:59729 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbYHARfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 13:35:53 -0400
Received: (qmail 19058 invoked by uid 1000); 1 Aug 2008 17:35:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Aug 2008 17:35:52 -0000
In-Reply-To: <4892FBF6.8060505@sitecno.fi>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91075>

On Fri, 1 Aug 2008, Matti Kaasinen wrote:

> Hi!
> 
> Is there any hope with following procedure:
> I took reporitory from linux git:
> # git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> For getting patches to make recent version from v2.6.26-rc3 I executed:
> # git format-patch -o patchdir v2.6.26-rc3..origin

format-patch isn't going to work too well with non-linear history. When 
two people make nearby or overlapping changes which get merged later, and 
this gets turned into a linear sequence of changes, there's no 
possible patch that will accurately reflect the change which got ordered 
second.

> Then I checked out v2.6.26-rc3 to a new branch and patched it with
> at91patch/maxim.org.za that was produced against v2.6.26-rc3. That worked out
> without complaints.

It sounds like you really just want to do "merge origin" now, and skip the 
whole patch series thing.

You'll probably get some conflicts (or applying the patch directly to 
origin would have worked), but they should be relatively easy to resolve.

	-Daniel
*This .sig left intentionally blank*
