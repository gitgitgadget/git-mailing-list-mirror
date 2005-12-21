From: Junio C Hamano <junkio@cox.net>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 10:27:27 -0800
Message-ID: <7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	<864q52xrm6.fsf@blue.stonehenge.com>
	<7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
	<86zmmuwbzh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8gc-0005A8-5Z
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVLUS1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVLUS1e
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:27:34 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:25076 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964788AbVLUS1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:27:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221182638.PMS20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 13:26:38 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86zmmuwbzh.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Dec 2005 10:17:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13888>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> I said I tried cloning from scratch and fetching into an old one
> Junio> over HTTP and succeeded, did I not?  So it does not seem to be
> Junio> the case either.
>
> Cloning from scratch probably worked differently than starting
> from wherever I was.

Yup, that's why I tried both.

> ... However, I'm very clear on the symptoms... trying to start
> from wherever I had last updated, to update to the current release,
> failed when sucking from HTTP, but worked when sucking from GIT.

I do not doubt you got a failure.  I just couldn't reproduce it
easily by fetching into a copy of a stale repository.  Earlier I
was suspecting mirroring lags (my successful trial was done
within the last hour) but I do not think that is the case
because your failure was also way after the mirroring should
have happened.

Will dig a bit more when able.
