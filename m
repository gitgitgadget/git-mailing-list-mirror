From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Include local config before platform tweaks
Date: Tue, 05 Sep 2006 15:13:06 -0700
Message-ID: <7vlkoyarnx.fsf@assigned-by-dhcp.cox.net>
References: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 00:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKjAO-0005AN-I5
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 00:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWIEWNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWIEWNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 18:13:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:65516 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965208AbWIEWNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 18:13:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905221306.TSLW12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 18:13:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JmD71V00A1kojtg0000000
	Tue, 05 Sep 2006 18:13:07 -0400
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com> (Brian
	Gernhardt's message of "Tue, 5 Sep 2006 18:00:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26496>

Brian Gernhardt <benji@silverinsanity.com> writes:

> Having config.mak included after the platform tweaks ignores NO_FINK
> or NO_DARWIN_PORTS in that file.  Simply including the config earlier
> fixes that.

I vaguely recall that this was brought up before, and the
conclusion was that the include location is correct but the way
darwin bits were done was wrong.  I do not recall the details
but does anybody on the list know?
