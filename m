From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merging to and from non-current branches.
Date: Tue, 4 Aug 2009 22:45:24 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 04:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYWVj-0005dG-7l
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 04:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933523AbZHECpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 22:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933373AbZHECpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 22:45:25 -0400
Received: from iabervon.org ([66.92.72.58]:53554 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933361AbZHECpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 22:45:24 -0400
Received: (qmail 27875 invoked by uid 1000); 5 Aug 2009 02:45:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 02:45:24 -0000
In-Reply-To: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124838>

On Tue, 4 Aug 2009, lists@mgreg.com wrote:

> Hi All,
> 
> I've been reading up on some of the GIT commands and I'm not sure if what I
> want/need exists.  Basically I want to merge all changes from one branch to
> another, regardless of whether I'm in either of those branches.  At the very
> least I would like to merge an existing "development" branch with the "master"
> branch without needing to first check out master.  I've seen rebase, but I'm
> not absolutely sure what that's doing.  Thoughts?

It can't work, because you need to be able to use the working tree to 
resolve any conflicts that arise during the merge. Merging without 
checking out a branch is a bit like building without checking out a 
branch; it would be avoiding using the filesystem for what it's there for.

	-Daniel
*This .sig left intentionally blank*
