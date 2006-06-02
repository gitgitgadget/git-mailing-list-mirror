From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 01 Jun 2006 23:40:30 -0700
Message-ID: <7vac8wdpr5.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	<Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
	<9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
	<Pine.LNX.4.64.0606011809401.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 08:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm3L4-0004UA-MG
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWFBGkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 02:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWFBGkc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 02:40:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51697 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751211AbWFBGkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 02:40:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602064031.HAXB6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 02:40:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21151>

Linus Torvalds <torvalds@osdl.org> writes:

> You're much better off using "gitk --all" if you want to see the result, 
> the "show-branch" this is really broken. It is using the old algorithm 
> that we used to use for "git-rev-tree", and got rid of about a year ago 
> there in favour of git-rev-list ;)

Are you sure about it?  My recollection is it uses the
merge-base logic, naturally enhanced for multiple heads.

And enhancing it to support more than one int wide bitmap should
not be too difficult, although looking at the output would be
very taxing for human eye, so I do not know if it is worth it.
