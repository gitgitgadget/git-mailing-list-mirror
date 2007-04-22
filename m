From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Sun, 22 Apr 2007 16:30:02 -0700
Message-ID: <7virbokmx1.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 01:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HflVR-0000MC-FA
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 01:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbXDVXaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 19:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXDVXaF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 19:30:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62767 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161023AbXDVXaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 19:30:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422233004.RMLE1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 19:30:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qPW31W0021kojtg0000000; Sun, 22 Apr 2007 19:30:03 -0400
In-Reply-To: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 23 Apr 2007 11:25:01 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45288>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> # checkout an upstream branch to test that it has a bug
> $ git-checkout origin/MOODLE_18_STABLE
> $ git-status
> <shows a clean status>
>
> # switch back to our local branch to test that the bug is gone
> $ git-checkout mdl18-local
> $ git-status
> <shows a very dirty status - the index has changed but the files
> weren't updated to the contents of mdl18-local>

Shouldn't happen.  Details?
