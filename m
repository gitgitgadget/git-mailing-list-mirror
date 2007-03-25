From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Removed the printf("rm 'file'") from git-rm.
Date: Sat, 24 Mar 2007 23:22:16 -0700
Message-ID: <7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
References: <11747590062554-git-send-email-tilman@code-monkey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Sun Mar 25 08:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVM7f-0000wn-8B
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 08:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXCYGWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 02:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbXCYGWS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 02:22:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50923 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXCYGWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 02:22:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325062217.MZFE321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 02:22:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id euNG1W00F1kojtg0000000; Sun, 25 Mar 2007 02:22:17 -0400
In-Reply-To: <11747590062554-git-send-email-tilman@code-monkey.de> (Tilman
	Sauerbeck's message of "Sat, 24 Mar 2007 18:56:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43033>

Tilman Sauerbeck <tilman@code-monkey.de> writes:

> We used to print that, because you actually had to run the output
> of git-rm to get rid of the files before Git 1.5. Now that git-rm
> really removes the files, it's not needed anymore.

Even though I admit I do not deeply care, as I never use 'git
rm' myself, I do not necessarily agree with "because" part.

I suspect people are by now accustomed to see the assuring
feedback from the command when used this way:

	$ git rm -r one
        rm 'one/1'
        rm 'one/2'
        rm 'one/3'

and even in non-recursive case, expect the similar output for
consistecy's sake.
