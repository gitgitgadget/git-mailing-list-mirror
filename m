From: Junio C Hamano <junkio@cox.net>
Subject: Re: My first git success [not quite]
Date: Sun, 15 Jan 2006 02:44:54 -0800
Message-ID: <7v4q457ot5.fsf@assigned-by-dhcp.cox.net>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<dqb5vg$a09$1@sea.gmane.org>
	<Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 11:45:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ey5Nw-0001Bj-N2
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 11:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWAOKo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 05:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWAOKo6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 05:44:58 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:23445 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750849AbWAOKo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 05:44:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115104347.QUWJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 05:43:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601141117120.13339@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 14 Jan 2006 11:25:54 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14696>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, Junio has patches (maybe they even got merged in mainline) to relax 
> the "exactly the same" rule a bit, and instead try to merge any dirty 
> state into the branch you're switching to. Conceptually nothing changed: 
> dirty state is branchless, so when you switch to another branch, the dirty 
> state follows you. 

FYI, I pushed this out, along with some other changes.

 * checkout -m can be used to merge while switching branches.
 * format-patch now always does --mbox and shows RFC2822 Date.
 * clone --naked can be used for creating "project.git" style repository.
 * octopus allows hand resolving in limited form.
 * show-branch user interface updates.
 * push --tags to push all tags; it does not fall back on "matching" refs.
