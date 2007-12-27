From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Distributing Windows binary package compiled with non gpl
 code
Date: Thu, 27 Dec 2007 17:08:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712271647130.13593@iabervon.org>
References: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J80uA-0000rS-1C
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbXL0WIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbXL0WII
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:08:08 -0500
Received: from iabervon.org ([66.92.72.58]:60612 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbXL0WIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:08:07 -0500
Received: (qmail 17418 invoked by uid 1000); 27 Dec 2007 22:08:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Dec 2007 22:08:04 -0000
In-Reply-To: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69266>

On Thu, 27 Dec 2007, Marco Costalba wrote:

> Packaged together with qgit.exe there are the necessary Micorsoft
> Visual C dll's. Is this a problem for someone?

It depends on how they're packaged together. If it's possible to unpack 
them (into a bunch of separate files, where each is either all GPL or no 
GPL), then this is "mere aggregation" and perfectly fine (assuming you're 
allowed to distribute the Visual C dlls, of course). IIRC, bundled 
libraries for Windows programs are stored on the user's disk as separate 
files anyway, so this is automatically okay.

I'd actually be more concerned about whether you can (or should) 
distribute GPL code compiled with a proprietary compiler; people who get 
the binaries and the source still couldn't edit the source and generate a 
corresponding binary, because they don't necessarily have the build 
environment you used. On the other hand, nothing you could do differently 
would be any better for anyone with the right to complain, so it shouldn't 
be an issue in practice. (And a user of qgit for Windows is more likely 
than usual to have MSVC anyway)

	-Daniel
*This .sig left intentionally blank*
