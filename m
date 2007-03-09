From: Jim Meyering <jim@meyering.net>
Subject: git-log --full-history renamed-file
Date: Fri, 09 Mar 2007 22:30:23 +0100
Message-ID: <87lki6umts.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 22:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPmfX-0006tH-4N
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 22:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965821AbXCIVaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 16:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965823AbXCIVaZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 16:30:25 -0500
Received: from mx.meyering.net ([82.230.74.64]:50698 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965821AbXCIVaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 16:30:24 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 41F3A889D; Fri,  9 Mar 2007 22:30:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41811>

Hello,

Is there some git-log-like command (or some git-log option)
to print a log of deltas affecting a file across renames?

I know that git-annotate can detect renames (and gitk),
but that's not quite the interface I was looking for.

I've tried with git-log --full-history, with and without --parents,
to no avail.  Adding --parents does make it produce a couple more
log entries, but they are not relevant.

The "Why does git not track renames?" section in the wiki,
http://git.or.cz/gitwiki/Godfry says that "git-log -M"
will do what I want, but that appears to have no effect.

To be precise, I'd like to run a command like this

  git-log <options> current-name

to summarize the commits affecting current-name as well as
those affecting old-name (which I git-mv'd to current-name).

Jim
