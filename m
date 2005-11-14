From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Not grabbing ALL branches and tags with git clone
Date: Mon, 14 Nov 2005 13:01:13 -0800
Message-ID: <7v7jbbx7ty.fsf@assigned-by-dhcp.cox.net>
References: <20051114182616.GB19105@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 22:01:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EblS2-0005Dc-5z
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 22:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKNVBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVKNVBP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:01:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19172 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932120AbVKNVBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 16:01:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114210006.VDRJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 16:00:06 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051114182616.GB19105@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Mon, 14 Nov 2005 11:26:16 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11848>

Carl Baldwin <cnb@fc.hp.com> writes:

> Lately, I've found that 'git clone' gives me more than what I want.
> Especially when there are a lot of branches and tags in the remote
> repository.

When I make a clone of git.git, oftentimes the first thing I do
is:

	$ git branch -D todo

But I've always considered that a rare exception (i.e. the todo
branch is not related to the main source).  What kind of
unrelated things do you keep in a single repository such that
you do not want to start out in sync with all of its branches?
