From: Junio C Hamano <junkio@cox.net>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 05 Jan 2007 15:50:36 -0800
Message-ID: <7vejq9c9tf.fsf@assigned-by-dhcp.cox.net>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ypd-0004zE-Nt
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAEXui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXAEXui
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:50:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58545 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbXAEXuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:50:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105235037.ZEWL29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:50:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7bpo1W00e1kojtg0000000; Fri, 05 Jan 2007 18:49:49 -0500
To: ltuikov@yahoo.com
In-Reply-To: <776323.21089.qm@web31808.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 5 Jan 2007 15:02:31 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36051>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I can see that the remote heads are where they are supposed to be
> but no local tracking heads are created (by default).  I had
> to do this manually.

Ah, after firing off a few messages, I think I now guessed
what you are talking about correctly.

You are talking about the separate remote layout "git clone"
creates, and talking about the fact that there is nothing in
refs/heads/ except master while refs/remotes/origin/ mirrors
what the remote side has faithfully, aren't you?

If that is the case, I can explain.  It is a good topic to talk
about.
