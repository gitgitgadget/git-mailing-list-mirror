From: Junio C Hamano <junkio@cox.net>
Subject: Re: uncommon shell code
Date: Fri, 23 Sep 2005 02:00:20 -0700
Message-ID: <7vwtl8duqj.fsf@assigned-by-dhcp.cox.net>
References: <72499e3b05092207326abadd91@mail.gmail.com>
	<7vu0gclpyo.fsf@assigned-by-dhcp.cox.net>
	<72499e3b05092301322a145e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:01:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjPt-00076J-Pi
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIWJAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVIWJAX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:00:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50609 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbVIWJAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:00:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923090021.EZLM28168.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 05:00:21 -0400
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b05092301322a145e52@mail.gmail.com> (Robert Watson's
	message of "Fri, 23 Sep 2005 09:32:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9164>

Robert Watson <robert.oo.watson@gmail.com> writes:

> Well, it's fine now that I know what it is.  But it hurts
> readability, and probably it's a good idea to simplify it.

I try to stay away from style discussion, but readability is
always relative and personal.  Things like 'while case $# in
..." is an idiom for some but not for others -- and I am
included in the former group of people (unfortunately).  In any
case, 'while test $# != 0' is not too much of a simplification
anyway.

> Any reasonable shell should built-in test(1)?

Correct.  The idiom comes from performance issues -- lack of
built in test long ago -- and that issue is not relevant
anymore.  But the pattern being an idiom for some still is.

Having said that, I do not feel too strong about enforcing _my_
style.  I _do_ feel somewhat strong about consistency, so if
somebody wants to update them, without dropping the ball in the
middle, it is very likely that I can be persuaded to take a
series of patches to modernize them.
