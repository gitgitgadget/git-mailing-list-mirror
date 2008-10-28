From: Peter Krefting <peter@softwolves.pp.se>
Subject: Git/Mercurial interoperability (and what about bzr?) (was: Re: [VOTE]
  git versus mercurial)
Date: Tue, 28 Oct 2008 15:41:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
 <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 15:43:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KupmR-0003Cm-94
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 15:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbYJ1Ole (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 10:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYJ1Ole
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 10:41:34 -0400
Received: from ds9.cixit.se ([193.15.169.228]:34780 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbYJ1Old (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 10:41:33 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9SEfTY1025628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Oct 2008 15:41:30 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9SEfTB7025623;
	Tue, 28 Oct 2008 15:41:29 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 28 Oct 2008 15:41:30 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99292>

Johannes Schindelin:

> While many may say that that is a half-baked solution, I actually
> like it. Mercurial and Git are pretty similar in their concept (if
> not in how the data is actually stored).

That touches on something that I have been thinking about for a while.

How difficult are the storage formats? Would it be possible, in a
reasonable amount of work, to add support for the Mercurial protocol
and format in "git clone", so that I could clone a Mercurial repository
and work on it with Git, and then possibly use "git push" to possibly
push the result back to Mercurial?

It seems to me that use of DVCS is polarising between Git, Mercurial
and Bzr. It would be nice to have easy interoperability between the
systems, at least as far as can be covered by the lowest common
denominator of what they support. I would love to be able to use Git to
clone a Bzr repository that I need to be able to access, since bzr is
just different enough from Git to be annoying. Same goes for Mercurial.
And I am sure that users of the other tools feel the same.

Would it be possible to design a common transfer format that could be
implemented by all three (and that would be a little smarter than
fast-export/fast-import)?

-- 
\\// Peter - http://www.softwolves.pp.se/
