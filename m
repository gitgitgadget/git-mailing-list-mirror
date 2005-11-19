From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Fri, 18 Nov 2005 17:21:16 -0800
Message-ID: <7vr79dcu0j.fsf@assigned-by-dhcp.cox.net>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
	<Pine.LNX.4.64.0511180915560.13959@g5.osdl.org>
	<7v3bltea1t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511181705390.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:22:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHQ0-00052f-7N
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVKSBVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKSBVS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:21:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52727 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030266AbVKSBVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 20:21:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119012042.ZUVU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 20:20:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181705390.13959@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 18 Nov 2005 17:07:38 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12316>

Linus Torvalds <torvalds@osdl.org> writes:

> I'm not convinced we ever really _need_ a pure "tree-to-tree" thing, 
> although you can always do that by creating an extra commit with no parent 
> and thus no history ;)

Nah, it is more like a commit object that records its tree and
another tree as its parent ;-).

I do not think tree-to-tree thing is very useful and that is
what I meant to say by "tree-to-tree is still stronger than
necessary".

What is recorded as a "change" by darcs feels more like "This
makes it to do Y instead of doing X", and it is not about
tree-to-tree.  I know David Roundy is lurking on this list;
David, do you have any comment on this?
