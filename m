From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add a test for another combination of --reference
Date: Thu, 22 May 2008 22:03:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805222202060.19665@iabervon.org>
References: <alpine.LNX.1.00.0805221800090.19665@iabervon.org> <200805230034.33567.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 23 04:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzMe2-0003Ez-9W
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 04:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976AbYEWCDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 22:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbYEWCDj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 22:03:39 -0400
Received: from iabervon.org ([66.92.72.58]:48613 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329AbYEWCDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 22:03:38 -0400
Received: (qmail 1723 invoked by uid 1000); 23 May 2008 02:03:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 May 2008 02:03:36 -0000
In-Reply-To: <200805230034.33567.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82674>

On Fri, 23 May 2008, Johan Herland wrote:

> On Friday 23 May 2008, Daniel Barkalow wrote:
> > From: Johan Herland <johan@herland.net>
> > 
> > In this case, the reference repository has some useful loose objects,
> > but not all useful objects, and we make sure that we can find the
> > objects we fetch from the repository we're cloning in the new
> > repository, instead of potentially being distracted by the reference
> > repository.
> > 
> > Doing the wrong thing in a builtin-clone implementation would lead to
> > this looking for an object in the wrong place, not finding it (because
> > it's only in the right place), and crashing.
> > 
> > Signed-off-by: Johan Herland <johan@herland.net>
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> Thanks again.
> 
> ...Johan
> 
> PS: I'm holding off on submitting my builtin-clone-packs-refs series until
> 1.5.6 is out. I think builtin-clone has seen enough action in this cycle. :)

Yeah, I agree.

	-Daniel
*This .sig left intentionally blank*
