From: Junio C Hamano <junkio@cox.net>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 05 Jan 2007 15:17:26 -0800
Message-ID: <7vzm8xcbcp.fsf@assigned-by-dhcp.cox.net>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yJX-0004nX-Gi
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXAEXR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbXAEXR2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:17:28 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58260 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbXAEXR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:17:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105231727.NXTO7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:17:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7bGe1W00J1kojtg0000000; Fri, 05 Jan 2007 18:16:38 -0500
To: ltuikov@yahoo.com
In-Reply-To: <776323.21089.qm@web31808.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 5 Jan 2007 15:02:31 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36044>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I can see that the remote heads are where they are supposed to be
> but no local tracking heads are created (by default).  I had
> to do this manually.
>
> Old behavior was that git did that for you automatically.
> So I suppose this is another newbie protection.

A very fuzzily stated question which is hard to answer, but I do
not think it is another newbie protection, if it apparently is
actively hurting you.  Also the documentation may need to be
updated to teach you enough about how to achieve what you want.

You can see where remote heads are by doing what?  ls-remote?
"Old behaviour" for what configuration?

A fresh clone made with a recent version sets things up to track
all remote branches from the repository you cloned from under
remotes/origin/, and it even tracks new ones as they are added
at the remote, so you probably are doing something different
from the default configuration that has:

    remotes.origin.fetch = +refs/heads/*:refs/remotes/origin/*
