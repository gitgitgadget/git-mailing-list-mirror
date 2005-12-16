From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 11:21:57 -0800
Message-ID: <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 20:24:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnL9Y-0007RB-MU
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 20:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVLPTWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVLPTWA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 14:22:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56798 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932375AbVLPTV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 14:21:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216192201.SGKQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 14:22:01 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	(Morten Welinder's message of "Fri, 16 Dec 2005 13:07:16 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13745>

Morten Welinder <mwelinder@gmail.com> writes:

>> While I am sympathetic, this "Oops, I said pull when I meant
>> fetch" sounds remotely similar to "oops, I said 'rm -r' when I
>> meant to say 'ls -r'".  Is it that the tool is too fragile?
>
> Didn't bk come with some kind of (one-level) undo pull?  It should not
> be too hard to create something similar considering that one could
> just leave new objects in the db orphaned.

Yes, that is called "git reset".
