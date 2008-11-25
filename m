From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn rebase creates some commits with empty author,
	commiter and date fields
Date: Tue, 25 Nov 2008 14:06:17 -0800
Message-ID: <20081125220617.GA21644@mayonaise>
References: <200811181121.18264.peter.kirk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Kirk <peter.kirk@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 25 23:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L564o-0000vJ-QF
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 23:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYKYWGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 17:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYKYWGy
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 17:06:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:44358 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYKYWGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 17:06:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 543F72DC01A;
	Tue, 25 Nov 2008 22:06:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200811181121.18264.peter.kirk@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101689>

Peter Kirk <peter.kirk@gmx.de> wrote:
> Hi there,
> 
> I am using git version 1.6.0.3, which I compiled myself from sources on my 
> linux/amd64 box which runns kubuntu 8.10.
> 
> Now, when I do "git svn clone" to retrieve the entire history from the svn 
> server then everything works fine. Then I start working with this, commit some 
> myself, and run "git svn rebase" frequently. What happens (and I don't see the 
> pattern) is that *some* commits that are retrieved via "git svn rebase" are 
> broken...they don't contain a valid author field, the date is at 1970 and, most 
> importantly (for me) the commit message is empty except for the "git-svn-id:" 
> line that "git svn" adds automatically. The diff is fine, and I can still use 
> the checkout fine...but I cannot view the log-message/author/date of some 
> commits, which becomes tiresome quickly.
> The only way to "fix" these broken commits is to do a clean "git svn clone", 
> but as new commits are pulled via "git svn rebase", my repository will again 
> become polluted with broken commits.

Weird.

Does this happen on other repositories you may use as well?  Do you know
of any strange hooks or otherwise non-standard setup with the SVN
server?

Which version of the SVN perl bindings are you using?

-- 
Eric Wong
