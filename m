From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: pulling from local mirror but committing via svn+ssh
Date: Fri, 21 Dec 2007 20:35:28 -0800
Message-ID: <20071222043528.GB18812@soma>
References: <8bd0f97a0712200821j778c12a9g9d42bf02482d953c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Frysinger <vapier.adi@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 05:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5w5e-0002cL-IY
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 05:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbXLVEfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 23:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXLVEfa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 23:35:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43527 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbXLVEf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 23:35:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 26A237DC122;
	Fri, 21 Dec 2007 20:35:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0712200821j778c12a9g9d42bf02482d953c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69119>

Mike Frysinger <vapier.adi@gmail.com> wrote:
> i have local (fast) mirrors of the svn trees i use, so i normally keep
> everything pointing at those.  when i need to commit, i use `svn
> switch --relocate ...` to flip to the svn+ssh master, and then flop
> back to the local mirror.  it actually works out nicely.
> 
> my reading of git-svn(1) seems to indicate that git-svn cant really
> handle switching of repository URLs on the fly ?
> http://www.kernel.org/pub/software/scm/git/docs/git-svn.html
> 
> i tried tweaking my .git/config and changing the url to my svn+ssh,
> but it seems any modification in the URL just causes errors ...
> vapier@G5[ppc] git $ git-svn dcommit
> Use of uninitialized value in concatenation (.) or string at
> /usr/bin/git-svn line 384.
> Committing to  ...
> Unable to determine upstream SVN information from HEAD history
> 
> guess i'll have to bite the bullet and just clone the svn+ssh repo :/
> 
> (i'm using 1.5.3.7 over here)

Sam:

Can useSvmProps handle this?  I honestly forgot how that stuff
was supposed to work with SVK/svn-mirror.


Mike:

On the other hand, there's little point in keeping local mirrors around
when using git-svn since git already does that for you :)

-- 
Eric Wong
