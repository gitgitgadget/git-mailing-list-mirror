From: Junio C Hamano <junkio@cox.net>
Subject: Re: Experimental "git prune"
Date: Tue, 04 Jul 2006 15:55:41 -0700
Message-ID: <7vac7pf09e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607041539550.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 00:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxto1-0004cp-T9
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWGDWzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWGDWzn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:55:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13774 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932339AbWGDWzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 18:55:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704225542.YOWS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 18:55:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607041539550.12404@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 4 Jul 2006 15:41:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23326>

Linus Torvalds <torvalds@osdl.org> writes:

> This is an example of how "git prune" could be speeded up a lot.

Ah, you are avoiding the verification cost of fsck-objects.  Neat.
