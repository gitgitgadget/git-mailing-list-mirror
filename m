From: Marius Vollmer <marius.vollmer@uni-dortmund.de>
Subject: Documentating branches (was: nicer frontend to get rebased tree?)
Date: Sun, 24 Aug 2008 00:38:33 +0300
Message-ID: <87k5e7fm3q.fsf_-_@uni-dortmund.de>
References: <20080822174655.GP23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
	<20080822182718.GQ23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
	<20080823071014.GT23334@one.firstfloor.org>
	<alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org>
	<20080823164546.GX23334@one.firstfloor.org>
	<20080823181827.GA15993@atjola.homenet>
	<alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 23:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX0qd-00057d-M8
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 23:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYHWVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYHWVig
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 17:38:36 -0400
Received: from smtp5.pp.htv.fi ([213.243.153.39]:40399 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbYHWVif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 17:38:35 -0400
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp5.pp.htv.fi (Postfix) with SMTP id 753065BC021
	for <git@vger.kernel.org>; Sun, 24 Aug 2008 00:38:34 +0300 (EEST)
Received: (qmail 8675 invoked by uid 1000); 24 Aug 2008 00:38:34 +0300
In-Reply-To: <alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 23 Aug 2008 11:56:27 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93491>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So part of it is not even necessarily about _git_ documentation, but about 
> the documentation for some of the trees that use git, but that aren't 
> really meant for others to then use. 

Incidentally, can Git attach random blurbs to branches?

I know that gitweb uses ".git/description" to describe the whole
repository.  Is there a way I can add descriptions for individual
branches?

Junio periodically posts "A note from the maintainer" that explains how
the Git repository is structured and what each of the branches is for.
It would good if this information could be found in a standard location
in the repository itself.

Putting a README or HACKING (or MaintNote) file in the project sources
itself doesn't seem right, since the sources can be offered from many
repositories, each with their own way of doing things.

One could extend the .git/description convention to
.git/descriptions/refs/heads/master, say, and gitweb would put that next
to the link for master.

But what about putting this information into proper objects, so that we
have the goodness of git to handle it.  There could be a head called
"README", and gitweb (and everybody else) could look there for blurbs.

A simple convention should suffice, and maybe there is already one that
I just don't know about.  No changes to Git are needed.  But
implementing it in gitweb would both be useful and would help people
finding them.
