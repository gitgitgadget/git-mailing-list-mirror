From: Junio C Hamano <junkio@cox.net>
Subject: Re: announce: git browser
Date: Mon, 05 Dec 2005 22:53:39 -0800
Message-ID: <7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	<20051205004238.GE22159@pasky.or.cz>
	<40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
	<20051205232626.GH22159@pasky.or.cz>
	<40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Artem Khodush <greenkaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 07:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjWhu-0007hZ-2h
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 07:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVLFGxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 01:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVLFGxl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 01:53:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46247 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751392AbVLFGxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 01:53:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206065226.YQIB17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 01:52:26 -0500
To: git@vger.kernel.org
In-Reply-To: <40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
	(Artem Khodush's message of "Tue, 6 Dec 2005 09:40:32 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13258>

Artem Khodush <greenkaa@gmail.com> writes:

>> I see. Well, how useful the big picture is? (Or rather the part of it
>> you don't get by just looking at the current state.)
>
> Yes, I see that for day-to-day development the gitk view is optimal.
> I'll see if I can do something similar, but web-based.

I think there are at least two web interfaces already and this
is the third one with an interesting "twist".  Javascript
drawing is cute.

This is not to discourage yet another web based one, but I wish
there were an NNTP interface, that feeds each repository/branch
as a newsgroup and each commit as if it is "git-format-patch"
output, with References: pointing at its parent commit "articles".

A merge commit would probably become a multipart with usually 2
attachments (but N attachments for a N-way octopus), showing
diff from each branch.
