From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: url.<base>.insteadOf and git-clone
Date: Thu, 8 May 2008 17:11:38 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805081707570.19665@iabervon.org>
References: <48232158.6090708@tordek.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Guillermo O. Freschi" <tordek@tordek.com.ar>
X-From: git-owner@vger.kernel.org Thu May 08 23:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDPj-0007UX-BZ
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbYEHVLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760060AbYEHVLl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:11:41 -0400
Received: from iabervon.org ([66.92.72.58]:42992 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374AbYEHVLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:11:40 -0400
Received: (qmail 11863 invoked by uid 1000); 8 May 2008 21:11:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2008 21:11:38 -0000
In-Reply-To: <48232158.6090708@tordek.com.ar>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81565>

On Thu, 8 May 2008, Guillermo O. Freschi wrote:

> Nearly gone insane about this: adding a configuration like
> [url "ssh://example.com/foo"]
>     insteadOf = foo:
> 
> works for git-fetch and git-pull (of what I've tested), but does not on git-clone (As of version 1.5.5.GIT).
> 
> Given that this config appears on the git-clone manpage, am I to assume it's a bug?

At this point, it's a documentation bug; it's a new feature for programs 
other than clone that will eventually be supported in clone but is not 
yet. The documentation makes the currently-overly-optimistic assumption 
that clone supports all of the common stuff.

	-Daniel
*This .sig left intentionally blank*
