From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFD 4/3] t7300: Tests for git-clean using filenames with spaces/punctuation
Date: Sun, 06 May 2007 11:54:35 -0700
Message-ID: <7vr6ptbx5g.fsf@assigned-by-dhcp.cox.net>
References: <463E1705.2090201@gmail.com> <463E19F6.9000906@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun May 06 20:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklsX-0004Ls-0B
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbXEFSyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbXEFSyg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:54:36 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51062 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbXEFSyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 14:54:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506185436.QBOV26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 6 May 2007 14:54:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vuua1W00F1kojtg0000000; Sun, 06 May 2007 14:54:35 -0400
In-Reply-To: <463E19F6.9000906@uwaterloo.ca> (Michael Spang's message of "Sun,
	06 May 2007 14:09:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46360>

Michael Spang <mspang@uwaterloo.ca> writes:

> Is this even properly solvable without making clean a builtin or
> writing git-unescape?

If you know how to use "xargs -0" and are willing to depend on
the -0 GNU extension, then the answer is yes.

I do not use git-clean myself, as I do not see what (I think) it
tries to solve as a problem to begin with, so obviously I do not
care too deeply about the command's implementation --- I just
let it be there because there seem to be others who want it ---
but if I were asked an advice on the right direction to proceed,
I would probably suggest rewriting it in C.
