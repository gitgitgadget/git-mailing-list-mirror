From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 23:48:46 -0700
Message-ID: <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com>
	<alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
	<6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 08:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFP3k-0005wD-9K
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 08:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938924AbXG3Gst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 02:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939055AbXG3Gst
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 02:48:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64132 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935035AbXG3Gss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 02:48:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730064847.QPVO1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Jul 2007 02:48:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Viom1X00G1kojtg0000000; Mon, 30 Jul 2007 02:48:47 -0400
In-Reply-To: <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> (Steffen Prohaska's
	message of "Mon, 30 Jul 2007 08:10:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54193>

This is an old topic rehashed from time to time.  The last time
was March this year if I recall correctly.

    http://thread.gmane.org/gmane.comp.version-control.git/41931/focus=41983
 
I tend to agree that it would make sense to allow something like:

    $ git merge --no-fast-forward -m 'Merge topic XYZ' xyz

but at the same time Linus is pretty clear that he would not use
that for his kernel merges, so even if we add that feature,
gitweb at k.org that shows linux-2.6 history would not see it.
