From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9l aka 1.0rc4
Date: Mon, 05 Dec 2005 12:16:37 -0800
Message-ID: <7vu0dnb8pm.fsf@assigned-by-dhcp.cox.net>
References: <7vy831p69i.fsf@assigned-by-dhcp.cox.net>
	<20051205172601.4980.qmail@67565db8368c55.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 21:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjMlQ-0004y9-2Z
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVLEUQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVLEUQk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:16:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58603 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751421AbVLEUQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:16:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205201525.GRHF17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 15:15:25 -0500
To: Gerrit Pape <pape@smarden.org>
In-Reply-To: <20051205172601.4980.qmail@67565db8368c55.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Mon, 5 Dec 2005 18:26:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13223>

Gerrit Pape <pape@smarden.org> writes:

> On Sun, Dec 04, 2005 at 01:21:13AM -0800, Junio C Hamano wrote:
>> *1* It appears Debian finally has an official maintainer, so I
>
> Yes, I've taken over maintainership, and introduced the git-core package
> into Debian/unstable, the git tools previously were included in the
> cogito package.

This question is probably relevant only to you and people who
want to build deb themselves until you package the updated
upstream, but what is your (and others') preference on debian/
directory in what _I_ ship?

I see three possibilities:

 - Do not care, and keep them as they are as they bitrot.

 - Remove debian/ from the upstream tree.

 - You feed patches to me, and I promise you not to touch
   debian/ area, except adding a new -0 entry at the top of the
   changelog when bumping the version number up, and perhaps
   adjusting to the main Makefile changes if the solution is
   obvious.

I am neutral between the second and the third.
