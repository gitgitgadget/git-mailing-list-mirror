From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Tue, 17 Jul 2007 22:48:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707172216420.14596@iabervon.org>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAzaI-000090-85
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247AbXGRCsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758182AbXGRCsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:48:09 -0400
Received: from iabervon.org ([66.92.72.58]:4817 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbXGRCsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 22:48:08 -0400
Received: (qmail 16931 invoked by uid 1000); 18 Jul 2007 02:48:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2007 02:48:05 -0000
In-Reply-To: <Pine.LNX.4.64.0707172346450.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52822>

On Tue, 17 Jul 2007, Johannes Schindelin wrote:

> The transport specific stuff was moved into libgit.a, and the
> bundle specific stuff will not be left behind.
> 
> This is a big code move, with one exception: the function
> unbundle() no longer outputs the list of refs.  You have to call
> list_bundle_refs() yourself for that.

You should use -C on this sort of thing, so that the interesting aspects 
of the patch are easier to see. (It actually comes out longer in this 
case, but it's far easier to tell that the code in the new file is the 
same as the old code.) Can you tell I've been rearranging a lot of code 
lately and trying to make the patches not look really scary?

Aside from presentation, it looks good to me. Shall I stick the bundle 
changes into my series? I'd like to have them come before the patch to 
switch to builtin-fetch, so that there aren't any revisions where "git 
fetch" doesn't have bundle support.

And I think it would be best to take part 3 as a review fix to my final 
patch.

	-Daniel
*This .sig left intentionally blank*
