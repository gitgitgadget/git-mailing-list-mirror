From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 13:44:27 -0400
Message-ID: <20070905174427.GC13314@fieldses.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISyve-00029B-ID
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbXIERod (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbXIERod
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:44:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36641 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbXIERoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:44:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1ISyvT-0006J2-Us; Wed, 05 Sep 2007 13:44:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57728>

On Wed, Sep 05, 2007 at 12:09:27AM -0700, Linus Torvalds wrote:
> I personally repack everything way more often than is necessary, and I had 
> kind of assumed that people did it that way, but I was apparently wrong. 
> Comments?

Well, this may just prove I'm an idiot, but one of the reasons I rarely
run it is that I have trouble remembering exactly what it does; in
particular,

	- does it prune anything that might be needed by a repo I
	  cloned with -s?
	- is there anything that's unsafe to do while the git-gc is
	  running?
	- what are the implications for http users if this is a public
	  repo?
	- is git-gc enough on its own or should I be running something
	  more agressive ocassionally too?

No doubt they all have simple answers, which probably amount to "just
don't worry about it", and which I could have found in less time than
it'd take to write this email.  But when I've got other work to do,
reading "man git-gc" is just enough effort for me to postpone the whole
thing to another day.

So, anyway, your message reminded me to run git-gc on my main working
repo.  At which point one of my personal scripts immediately started
failing--it was assuming it could find any ref under .git/refs/, and I
hadn't realized (or maybe I had once, and I'd forgotten) that git-gc
packs refs by default now.

Bah.  I don't know what the moral of that story is.

--b.
