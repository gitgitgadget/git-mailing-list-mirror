From: Junio C Hamano <junkio@cox.net>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 10:07:03 -0800
Message-ID: <7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	<864q52xrm6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:08:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8Mu-0005m2-8I
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVLUSHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVLUSHM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:07:12 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6853 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751152AbVLUSHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:07:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221180609.UKEE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 13:06:09 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <864q52xrm6.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Dec 2005 09:54:57 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13886>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Sorry, I do not know what Cogito is doing there (the message is
> Junio> from an "echo" in cg-fetch).  git-clone over HTTP seems to work
> Junio> for me, and I just tried git-fetch over HTTP in my random
> Junio> back-up repo that happened to be at around 0.99.9g without
> Junio> problems, so I am reasonably sure the public repository is not
> Junio> corrupt.
>
> It worked once I changed the URL from http://www to git://git
>
> Perhaps something is wrong with the archive when viewed with HTTP protocol?

I said I tried cloning from scratch and fetching into an old one
over HTTP and succeeded, did I not?  So it does not seem to be
the case either.

My initial reaction after seeing the two other messages that
report failure to grab the tip of the master head was "Perhaps,
the usual mirroring delay".  But considering that your failure
happened way later than when the release material was placed on
the server that public servers mirror from (which was around
01:00 US/Pacific), I do not know what to think (especially
before my caffeine ;-).
