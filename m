From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show-branch: make --topo-order noop and default.
Date: Thu, 12 Jan 2006 20:11:55 -0800
Message-ID: <7vslrsg41g.fsf@assigned-by-dhcp.cox.net>
References: <7v4q4ajonx.fsf@assigned-by-dhcp.cox.net>
	<43C70F69.7010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGIC-0003WN-9R
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWAMEL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMEL6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:11:58 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48794 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964799AbWAMEL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:11:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113041107.QYZS3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 23:11:07 -0500
To: gitzilla@gmail.com
In-Reply-To: <43C70F69.7010103@gmail.com> (A. Large Angry's message of "Thu,
	12 Jan 2006 18:24:41 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14612>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
>> It really does not make sense not doing --topo-order.
>
> I disagree. I do like to see the chronological commit history of some
> repositories.

But the thing is if you do chronological order, you may not see
enough commits without --more=, because show-branches stops at
the first common commit.  Try it yourself in a repository with
merges on topic branches of different vintage, with and without
the option, to see where output stops.
