From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: C-compiler features
Date: Mon, 11 Feb 2008 11:24:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802111115360.13593@iabervon.org>
References: <20080211090326.2d0c64cd@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObTa-00041h-Ad
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758719AbYBKQYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758619AbYBKQYU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:24:20 -0500
Received: from iabervon.org ([66.92.72.58]:58156 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758430AbYBKQYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:24:17 -0500
Received: (qmail 18856 invoked by uid 1000); 11 Feb 2008 16:24:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Feb 2008 16:24:14 -0000
In-Reply-To: <20080211090326.2d0c64cd@pc09.procura.nl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73550>

On Mon, 11 Feb 2008, H.Merijn Brand wrote:

> Having to answer questions about my C-compiler isn't always that easy.
> Sometimes you need to find include files, for which you don't know if
> and if how they are used. Sometimes you need to compile test programs
> to see the behaviour, and then there is threads, 32/64 bitness etc.
> 
> I was recently pointed to http://www.math.utah.edu/pub/features/
> Which gives a nice summary of what your C/C++ compiler behaves like.
> Here's the output for HP C-ANSI-C on HP-UX 11.23/64 IPF and on 11.00

Hmm. I'm actually more curious about what language features a compiler 
supports (Is "inline" a keyword? Does it accept C99 comments? C99 struct 
initializers? Flex arrays?). Sometimes the errors you get when these 
aren't what the code expects are hard to identify, because the compiler 
comes up with some odd interpretation of the structure as what you meant 
but messed up, and you get a slew of inappropriate error messages, 
sometimes hiding the actual wrong thing. Missing header 
files/types/macros/declarations generally give a clear first error 
message.

	-Daniel
*This .sig left intentionally blank*
