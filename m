From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Thu, 02 Feb 2006 21:28:00 -0800
Message-ID: <7vu0bhko4f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 06:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4tUe-0005ki-FB
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 06:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWBCF2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 00:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWBCF2E
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 00:28:04 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62412 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964807AbWBCF2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 00:28:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203052533.JSLD26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 00:25:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 15:03:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15525>

Linus Torvalds <torvalds@osdl.org> writes:

> And now when I look at Len's "Merge from hell", not only does it take less 
> than 2 seconds for git-diff-tree to calculate, it looks correct too. At 
> least I don't see anything that I consider extraneous, although it might, 
> of course, have removed too much, and I'd not notice.

I've run "diff -u0" between -c output and --cc output and what
was dropped looked sane.
