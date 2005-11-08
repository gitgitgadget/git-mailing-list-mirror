From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull.sh's bad mode
Date: Tue, 08 Nov 2005 08:25:56 -0800
Message-ID: <7v4q6njecr.fsf@assigned-by-dhcp.cox.net>
References: <E1EZUK2-0005EG-56@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 17:31:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWIV-0005cn-T9
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 17:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVKHQZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 11:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKHQZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 11:25:59 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64706 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932444AbVKHQZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 11:25:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108162529.IXPL9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 11:25:29 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EZUK2-0005EG-56@jdl.com> (Jon Loeliger's message of "Tue, 08
	Nov 2005 08:19:38 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11335>

Jon Loeliger <jdl@freescale.com> writes:

> Public apology and brown paper bag.  My patch
> accidentally twiddled the mode on git-pull.sh:
>
>      mode change 100755 => 100644 git-pull.sh

No need for worrying things like this.  Mistakes and accidents
happen.

Makefile installs git-pull with executable bit set anyway, so it
really does not matter.

-jc
