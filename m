From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 01 Jan 2007 19:36:08 -0800
Message-ID: <7vy7omyuaf.fsf@assigned-by-dhcp.cox.net>
References: <405044.6078.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 04:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1aRi-0000at-D0
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 04:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbXABDgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 22:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbXABDgL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 22:36:11 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41752 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbXABDgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 22:36:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102033610.LZWM97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 22:36:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 63bN1W00G1kojtg0000000; Mon, 01 Jan 2007 22:35:23 -0500
To: ltuikov@yahoo.com
In-Reply-To: <405044.6078.qm@web31809.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Mon, 1 Jan 2007 18:05:11 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35767>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Questions:
>
> What is the reasonining of defining branch.<name>.merge to point
> to the "remote's setup"?

See list archives.  

Because you are not required to use remote tracking branches.
By the way, I think we allow the name of the remote tracking
branch as well, but we do not advertise it -- always using
remote's name consistently is much less confusing.

> The reasoning is that the remote's setup should only leak into
> [remote] and no further.  I.e. [remote] is the only one concerned
> with the mapping between the remote repo and the local repo.

No.  Remote is not about mapping -- if mapping is there you can
talk about it, but that is optional.
