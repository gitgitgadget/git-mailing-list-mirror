From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Submodule usability
Date: Sat, 29 Sep 2007 15:02:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709291453410.5926@iabervon.org>
References: <Pine.LNX.4.64.0709291302240.5926@iabervon.org>
 <20070929185238.GB19943@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 21:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibhan-0007PB-P7
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 21:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbXI2TC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbXI2TC7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 15:02:59 -0400
Received: from iabervon.org ([66.92.72.58]:55122 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbXI2TC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 15:02:58 -0400
Received: (qmail 8946 invoked by uid 1000); 29 Sep 2007 19:02:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Sep 2007 19:02:57 -0000
In-Reply-To: <20070929185238.GB19943@uranus.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59486>

On Sat, 29 Sep 2007, Sam Ravnborg wrote:

> Hi Daniel
> On Sat, Sep 29, 2007 at 01:24:53PM -0400, Daniel Barkalow wrote:
> > 
> > Also, would it be reasonable to have a gitmodules option for submodules 
> > that the supermodule doesn't make sense without? E.g., multiple projects 
> > are now using kbuild as their build system,
> 
> Out of couriosity...
> I know of busybox and klibc.
> Are there any others using kbuild these days?
> 
> I see that several build system share some ideas with kbuild
> which I btw am glad to see.
> But if there are enough project taking benefit of kbuild I should
> maybe revisit my idea to factor out all the common stuff somehow.

I'm only sure of busybox and klibc (3 including the kernel is "multiple"), 
but IIRC a number of linux-specific userspace projects seem awfully 
similar. I wouldn't be surprised if the build systems that currently share 
only ideas would share code if it were factored out.

	-Daniel
*This .sig left intentionally blank*
