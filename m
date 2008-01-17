From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 16:17:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801171559480.13593@iabervon.org>
References: <20080117141143.38a88c7a@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFc7s-0008F0-SB
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 22:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYAQVRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 16:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYAQVRr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 16:17:47 -0500
Received: from iabervon.org ([66.92.72.58]:58501 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYAQVRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 16:17:46 -0500
Received: (qmail 10489 invoked by uid 1000); 17 Jan 2008 21:17:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2008 21:17:41 -0000
In-Reply-To: <20080117141143.38a88c7a@pc09.procura.nl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70928>

On Thu, 17 Jan 2008, H.Merijn Brand wrote:

> I think not building with a non-gcc C compiler could be a showstopper for us -
> our policy is to compile all packages (yes, even gcc itself) using HP's
> ANSI C and C++ compilers unless it's literally impossible to do so (the
> only package exception so far is "pdftk" and that's only because HP don't
> have a compiler equivalent to gcj).

Is HP's ANSI C compiler C99 or C89? Git is sort of officially C89, but 
most developers use C99 compilers, so there's a bunch of C99-isms; seems 
to me like a slew of "inline" as a keyword and three C++/C99 comments.

If the compiler is supposed to be C99, the issues should be reported to HP 
and the gcc people, since "make CFLAGS=-std=c99" has no problem with git, 
suggesting that there's some issue with interpretation of the standard for 
one or the other.

	-Daniel
*This .sig left intentionally blank*
