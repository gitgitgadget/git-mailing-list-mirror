From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 18:55:42 -0700
Message-ID: <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7PJ-0004nj-OD
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933620AbXCSCPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933663AbXCSCPc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:15:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34691 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933620AbXCSCPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:15:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319021531.RQWD321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 22:15:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cSFW1W01J1kojtg0000000; Sun, 18 Mar 2007 22:15:31 -0400
In-Reply-To: <20070319020053.GA11371@thunk.org> (Theodore Tso's message of
	"Sun, 18 Mar 2007 22:00:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42560>

Theodore Tso <tytso@mit.edu> writes:

> Is it at all possible to figure out <commit-id-before-the-push>?  It
> seems the answer is no, and I suspect that's a bug.

Doesn't update hook get pre- and post- commit object name?
