From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Wed, 15 Feb 2006 20:07:38 -0800
Message-ID: <7vzmksj69h.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602151953290.916@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 05:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9aQi-0005uJ-SD
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 05:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBPEHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 23:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBPEHl
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 23:07:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19153 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932267AbWBPEHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 23:07:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216040455.HDTE26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 23:04:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602151953290.916@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 15 Feb 2006 19:55:32 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16270>

Linus Torvalds <torvalds@osdl.org> writes:

> No ugly special-case caching, just automatically "the right thing", with 
> very little overhead.
>
> It just makes sense.

Thanks.  I threw away two rounds of crap before this one, which
were full of ugly special cases ;-).
