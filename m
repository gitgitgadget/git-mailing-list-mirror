From: Junio C Hamano <junkio@cox.net>
Subject: Re: binary safe?
Date: Thu, 03 Nov 2005 14:49:50 -0800
Message-ID: <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net>
References: <86br115r0z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 23:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnu7-0006X0-T3
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVKCWtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKCWtw
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:49:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2965 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932606AbVKCWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:49:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103224932.ZLZR16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 17:49:32 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86br115r0z.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "03 Nov 2005 14:02:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11105>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I presume emailing diff-patches is out of the question, but if all I'm
> doing is git-push and git-pull (using the shared central repository
> model), and if I'm stupid enough to have a merge error it's OK to just
> blow up on a binary file, will everything else work fine?

It should.  I trust git well enough to track some png files in
my day-job project.
