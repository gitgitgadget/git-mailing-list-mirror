From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 00:43:20 -0800
Message-ID: <7vvewjb5xz.fsf@assigned-by-dhcp.cox.net>
References: <43CC695E.2020506@codeweavers.com>
	<7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	<43CC89DC.5060201@codeweavers.com>
	<46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
	<7v8xtfclyx.fsf@assigned-by-dhcp.cox.net>
	<46a038f90601170033y334d111fjed277fc787a2e523@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EymR3-0004Sy-BX
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAQInX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWAQInX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:43:23 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14322 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932336AbWAQInW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 03:43:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117084203.DYTM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 03:42:03 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601170033y334d111fjed277fc787a2e523@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 17 Jan 2006 21:33:23 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14789>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> GIT won't literally lose them,  someone could run git-fsck and fish
> out the dangling heads from the repo, and after a bit of spelunking
> recover them, but it's suddenly a really tricky operation.

"git-lost-found".

You are right.  We will lose #1 and #2, (although the "already
up to date" might catch some cases) and this _is_ dangerous.  I
need to do something about this soon.

Thanks for the discussion.


[Footnote]

*1* ... or #1 and #3 --- sorry, my "one of them picked up by
upstream" scenario description was inconsistent in the previous
message.
