From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 15:30:03 -0700
Message-ID: <20070604223003.GJ6528@ca-server1.us.oracle.com>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org> <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com> <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org> <20070604175751.GL19935@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org> <20070604212121.GA31852@dspnet.fr.eu.org> <alpine.LFD.0.98.0706041429380.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Galibert <galibert@pobox.com>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvL4M-00034C-G6
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857AbXFDWa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXFDWaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:30:25 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:37982 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbXFDWaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:30:22 -0400
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l54MU5ED032292;
	Mon, 4 Jun 2007 17:30:05 -0500
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l54MU3fm011607
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2007 16:30:04 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <joel.becker@oracle.com>)
	id 1HvL3r-0001sW-I5; Mon, 04 Jun 2007 15:30:03 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706041429380.23741@woody.linux-foundation.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49137>

On Mon, Jun 04, 2007 at 02:33:18PM -0700, Linus Torvalds wrote:
> (That said, gits own 'pu' branch ends up jumping around, and it hasn't 
> caused all that much confusion, so maybe I'm overstating even that human 
> confusion)

	It survives because it is well-known.  Everyone expects it to
break.  ocfs2 has an "ALL" branch that is everything we have working,
sort of a "test this bleeding edge" thing.  It gets rebased all the
time, and everyone knows that they can't trust it to update linearly.
Other developers have similar things in their repositories.

Joel

-- 

"What no boss of a programmer can ever understand is that a programmer
 is working when he's staring out of the window"
	- With apologies to Burton Rascoe

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
