From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 17:01:05 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0904151654330.10753@iabervon.org>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>  <alpine.LNX.1.00.0904151148030.19665@iabervon.org> <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 23:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuCFu-0004hg-Ri
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 23:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZDOVBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZDOVBH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 17:01:07 -0400
Received: from iabervon.org ([66.92.72.58]:49369 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbZDOVBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 17:01:06 -0400
Received: (qmail 11378 invoked by uid 1000); 15 Apr 2009 21:01:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Apr 2009 21:01:05 -0000
In-Reply-To: <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116648>

On Wed, 15 Apr 2009, E R wrote:

> Ok - I was wrong about the timestamps not getting updated. Thanks for
> that correction.
> 
> However, what about the idea of associating the result of a build with
> the hash of the source files used by the build, and using git to
> compute the hash?

It's a reasonable idea, in general, but may or may not be useful for any 
particular problem. In general, the objects in your subdirectories are 
also doing to depend on some but not most things from an include 
directory, and so there's not much benefit you can get on a per-directory 
granularity. On the other hand, I've gotten good results by embedding the 
commit sha1 in generated object files, which allowed me to exactly 
identify different builds much later, and even figure out what the source 
that went into them was.

	-Daniel
*This .sig left intentionally blank*
