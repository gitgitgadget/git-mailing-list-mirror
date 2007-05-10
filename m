From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 09 May 2007 17:31:41 -0700
Message-ID: <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	<vpqbqgxak1i.fsf@bauges.imag.fr>
	<46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
	<alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
	<20070509134151.GT4489@pasky.or.cz>
	<alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 10 02:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlwZQ-0006La-NB
	for gcvg-git@gmane.org; Thu, 10 May 2007 02:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbXEJAbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756502AbXEJAbn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 20:31:43 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33756 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000AbXEJAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 20:31:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510003142.NUQC2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 20:31:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xCXh1W00a1kojtg0000000; Wed, 09 May 2007 20:31:42 -0400
In-Reply-To: <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 9 May 2007 08:52:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46817>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And unlike the "simpler" model of committing individual hunks
> with "git add -i" or something like that, my model is actually
> much superior!

I obviously agree with this.  As I said a few times I regret
introducing "add -i" --- it encourages a wrong workflow, in that
what you commit in steps never match what you had in the working
tree and could have tested until the very end.
