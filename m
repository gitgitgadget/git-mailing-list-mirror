From: Junio C Hamano <junkio@cox.net>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 06 Feb 2007 23:12:41 -0800
Message-ID: <7vsldibfva.fsf@assigned-by-dhcp.cox.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Mark Wooding <mdw@distorted.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 08:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEgzj-0004jW-Np
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 08:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965659AbXBGHMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 02:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965661AbXBGHMp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 02:12:45 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:35161 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965659AbXBGHMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 02:12:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207071243.BIDP1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 02:12:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LXCh1W00J1kojtg0000000; Wed, 07 Feb 2007 02:12:43 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38892>

The feature release after 1.5.0 will be 1.5.1; hopefully we can
stick to 6-8 weeks schedule between feature releases, which
makes it due sometime in April, assuming that 1.5.0 will be done
in a week or so.

In 1.5.0, you will still see git-resolve and git-diff-stages,
but they will be removed by 1.5.1.

We will keep the following for now, but not encourage use of
them to new users.  There isn't any definite removal schedule
right now and we may not even need one.

	whatchanged (use "log --full-history --raw -r" instead)
	applymbox (use "am" instead)
	init-db (use "init")
	fsck-objects (use "fsck")
	repo-config (use "config")

When we created the contrib/ area, I said that anything there is
subject to periodical review for removal if kept unused and
unmaintained.  But anything that satisfies the requirements of
its small userbase will have happy users without exposing its
shortcomings, so I suspect removal from contrib/ by periodic
review would never happen in practice.

I've already removed contrib/colordiff and git-merge-recur.

Among the ones I mentioned in my initial message, the ones that
are not mentioned in this message will stay as before.
