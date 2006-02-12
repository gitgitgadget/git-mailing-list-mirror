From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 21:48:19 -0800
Message-ID: <7v1wy9f7q4.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
	<7vslqpi9mg.fsf@assigned-by-dhcp.cox.net>
	<7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602112045340.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602112122400.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 06:48:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8A5x-0005Gn-FH
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 06:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWBLFsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWBLFsV
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 00:48:21 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33939 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932251AbWBLFsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 00:48:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212054554.UHYO17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 00:45:54 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602112122400.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 11 Feb 2006 21:23:10 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15984>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 11 Feb 2006, Linus Torvalds wrote:
>> 
>> If somebody shows that the other approaches are faster, then I guess I'll 
>> just have to sulk in a corner and grown quietly at people.
>
> growl. growL. With an 'L'!

I do not get it.

But my impression was the circular hash with trivial fixes were
the fastest.  I am benching them now.
