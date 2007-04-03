From: Junio C Hamano <junkio@cox.net>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 11:22:55 -0700
Message-ID: <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
	<86r6r2isva.fsf@blue.stonehenge.com>
	<m3r6r1jsmq.fsf@lugabout.jhcloos.org>
	<867istcrhr.fsf@blue.stonehenge.com>
	<20070403172123.GD27706@spearce.org>
	<Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 20:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYnep-0006yc-Dq
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 20:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXDCSW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbXDCSW5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 14:22:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63178 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161071AbXDCSW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 14:22:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403182256.SIMY27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 14:22:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iiNv1W00A1kojtg0000000; Tue, 03 Apr 2007 14:22:56 -0400
In-Reply-To: <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 3 Apr 2007 10:50:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43635>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yeah, the short SHA1 form is obviously always going to be risky. But in 
> practice, since people almost always use it just for commits, it's 
> probably good enough in practice, and even if you get a collision in 8 
> nibbles, most of the time it will probably be trivial to figure out which 
> one was meant, so it's not like it's a disaster if somebody ends up 
> reporting a bug with a non-unique abbreviation.

Are you hinting to update sha1_name.c::get_sha1() so that we do
not accept abbreviated non-commit object names?
