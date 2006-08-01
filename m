From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Tue, 01 Aug 2006 16:54:05 -0700
Message-ID: <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 02 01:57:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G847D-0000do-GP
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 01:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWHAX4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 19:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWHAX4D
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 19:56:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61405 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbWHAXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 19:54:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801235406.MQNP12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 19:54:06 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24616>

Luben Tuikov <ltuikov@yahoo.com> writes:

> As does "gitweb.css".  Similarly, "gitweb.css"'s contents
> used to live in "gitweb.cgi" itself.

Not convincing argument.  gitweb.css, and git-logo.png patch I
think I will take, are meant to be fed to the http clients.
They do not compare with the customization.pm which is not.

In any case, I think tweaking gitweb.cgi from Makefile like
Martin Waitz did is as easy and clean for people who want to
customize; it should just be the matter of defining the
necessary params in config.mak.

I do not think there is much difference between any of the
customization proposed so far (yours, Martin's and the one from
Matthias Lederhofer) from functionality and ease-of-use point of
view.  They all try to make customization can be done in one
place, and the difference is mostly of taste, so I'd just pick
one from Martin.
