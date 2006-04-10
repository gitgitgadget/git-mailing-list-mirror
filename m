From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull origin doesn't update the master
Date: Mon, 10 Apr 2006 00:24:42 -0700
Message-ID: <7vmzetao5h.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
	<7vr7469c4n.fsf@assigned-by-dhcp.cox.net>
	<cc723f590604092345r7d0e2cedr8f9838d054ecb023@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 09:24:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSqld-0007JX-2x
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 09:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWDJHYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDJHYo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 03:24:44 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62100 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751071AbWDJHYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 03:24:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410072443.NGZM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 03:24:43 -0400
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590604092345r7d0e2cedr8f9838d054ecb023@mail.gmail.com>
	(Aneesh Kumar's message of "Mon, 10 Apr 2006 12:15:36 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18582>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> Work flow is now a bit complicated. I clone the repository. Now i need
> to edit remotes/origin to make sure what all branches i need to
> follow. And then do a git pull origin. Earlier i just need to do a
> clone and a git pull. I don't need to fast forward pu branch.

What you are saying is that the previous round did a wrong thing
without telling the user, and it just happened that you did not
care about the wrong thing it did.

It is a gentle reminder that heads that are rewound need to be
advertised as such.  It is conceivable that in future versions
of git we might want to be able to mark some branches "this is
expected to be rewound" explicitly and make the clone operation
to take notice, to give you the plus sign automatically.
