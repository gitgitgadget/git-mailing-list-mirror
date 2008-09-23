From: Peter Krefting <peter@softwolves.pp.se>
Subject: Recording "partial merges" (was: Re: [RFC] origin link for cherry-pick
 and revert)
Date: Tue, 23 Sep 2008 14:51:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809231447030.28506@ds9.cixit.se>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8Jw-0007vS-B4
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYIWNvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754577AbYIWNvY
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:51:24 -0400
Received: from ds9.cixit.se ([193.15.169.228]:38736 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbYIWNvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:51:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8NDpIY1018155
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Sep 2008 15:51:18 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8NDpH32018150;
	Tue, 23 Sep 2008 15:51:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080909211355.GB10544@machine.or.cz>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 23 Sep 2008 15:51:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96563>

Petr Baudis:

> I think this is misguided. In general case, cherrypicks can be from
> completely unrelated histories, and if you are doing the cherry pick,
> you are saying that actually, the history *does not matter*.

As my workflow sometimes make me do cherry-picks where history does
matter, in form of me doing a "partial merge" of one or more than one
commit from branch A into branch B, which does not necessarily have to
be directly related,

 is there a way to perform something like that, while keeping history?


Perhaps I'm damaged by having used CVS for too long, and merging just
some files, or abusing CVS internals to make some files on branch A
also be part of branch B by having their branches point to the same RCS
branch revision number, but sometimes I find that I miss being able to
do it in Git.

Not really a big deal, just curious.

-- 
\\// Peter - http://www.softwolves.pp.se/
