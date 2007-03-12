From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 19:03:32 -0700
Message-ID: <7vfy8busjv.fsf@assigned-by-dhcp.cox.net>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
	<20070311160424.GA629@fieldses.org>
	<200703111815.l2BIFHbq010315@localhost.localdomain>
	<Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
	<45F46713.6030702@qumranet.com>
	<Pine.LNX.4.63.0703112241040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avi Kivity <avi@qumranet.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 03:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQZt9-0004UQ-51
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 03:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXCLCDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 22:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXCLCDe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 22:03:34 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46414 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbXCLCDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 22:03:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312020333.QHOV321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 22:03:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ze3Y1W00h1kojtg0000000; Sun, 11 Mar 2007 22:03:33 -0400
In-Reply-To: <Pine.LNX.4.63.0703112241040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 11 Mar 2007 22:41:48 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42003>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This feature would be good for top-level trees and for major subsystem 
>> trees IMO.
>
> What? You should sign-off on stuff you did not review? Or do you review 
> the stuff _before_ merging? I don't.

Actually I've done a few merging recently, and I do review the
stuff before merging.  It is easier to review after making a
merge, so technically the review happens _after_ merging but if
I do not like what the other branch has, I can throw it away
with "reset --hard ORIG_HEAD", which means in practice the
review is done before.
