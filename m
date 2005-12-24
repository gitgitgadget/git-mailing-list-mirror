From: Junio C Hamano <junkio@cox.net>
Subject: Re: "p4 revert -a" equivalent in git?
Date: Fri, 23 Dec 2005 16:23:09 -0800
Message-ID: <7vd5jn4a36.fsf@assigned-by-dhcp.cox.net>
References: <20051224001308.7078.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 01:23:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpxBs-0002DT-8Y
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 01:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbVLXAXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 19:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbVLXAXN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 19:23:13 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47286 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161146AbVLXAXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 19:23:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224002313.WJKH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Dec 2005 19:23:13 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051224001308.7078.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 23 Dec 2005 16:13:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14002>

Luben Tuikov <ltuikov@yahoo.com> writes:

> That is I want to git-update-index --refresh for all
> files whose inode may have changed but the actual file
> data has not.

That's what "git-update-index --refresh" does, unless I am
misreading what you say you want.

	$ git checkout master
        $ touch *.c
	$ git diff-index HEAD ;# tons of changes
        $ git update-index --refresh
	$ git diff-index HEAD ;# no changes
