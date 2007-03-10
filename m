From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, nitpickingly final version] git-branch, git-checkout: autosetup for remote branch tracking
Date: Fri, 09 Mar 2007 16:59:25 -0800
Message-ID: <7v4pot3ocy.fsf@assigned-by-dhcp.cox.net>
References: <45EFB205.4000604@lu.unisi.ch>
	<7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
	<45EFDE4B.3010408@lu.unisi.ch>
	<7vabyo9gr6.fsf@assigned-by-dhcp.cox.net>
	<7vr6rz8khv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 01:59:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPpvz-0001yt-Un
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767700AbXCJA73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767699AbXCJA73
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:59:29 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60289 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767700AbXCJA71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:59:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310005926.GHXB2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 19:59:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YozR1W00c1kojtg0000000; Fri, 09 Mar 2007 19:59:26 -0500
In-Reply-To: <7vr6rz8khv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Mar 2007 13:59:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41829>

Junio C Hamano <junkio@cox.net> writes:

> Gaah.
>
> The new create_branch() is totally borked, and I did not notice
> it while exchanging review e-mails.
> ...
> The appended is on top of your "final".  This is what I am
> considering to apply currently.
>
> Grumble....

I _like_ this feature.  I even think it _might_ make sense to
turn it on by default --- I would definitely argue for it if
this were before 1.5.0 which we have enough time to give advance
warning to users that the defaults and UIs would change, and the
only reason I am saying "it _might_" is because it _is_ a change
and it is post 1.5.0.

But because I had to say Gaah, I am currently in "discouraged"
state.  Extra eyeballing from the list, tests and Acks are
greatly appreciated on this series from Paolo.
