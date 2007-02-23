From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-push hook to update remote working copy safely
Date: Fri, 23 Feb 2007 10:32:39 -0800
Message-ID: <7v649s4tdk.fsf@assigned-by-dhcp.cox.net>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>
	<7v649t5ebq.fsf@assigned-by-dhcp.cox.net>
	<1172248500.32514.1176151445@webmail.messagingengine.com>
	<Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Watkins <swatkins@fastmail.fm>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfEC-0006fF-CI
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbXBWScl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933174AbXBWScl
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:32:41 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59763 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173AbXBWSck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:32:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223183241.EERJ6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 13:32:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T6Yf1W00T1kojtg0000000; Fri, 23 Feb 2007 13:32:39 -0500
In-Reply-To: <Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 17:40:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40461>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Don't you have any user interaction? I.e. if the remote working directory 
> is only ever changed by your hook, you can use what Junio sent. It is even 
> overkill for that purpose.

And it even has a bug (perhaps more, but I know of at least
one).

The comparison after running merge-base should compare the merge
base and the old commit object name.
