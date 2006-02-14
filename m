From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 18:03:04 -0800
Message-ID: <7v3bimy9wn.fsf@assigned-by-dhcp.cox.net>
References: <43F0B577.4070608@gorzow.mm.pl>
	<7vy80eydq0.fsf@assigned-by-dhcp.cox.net>
	<43F13776.9000501@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:03:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8pX4-0004Sa-JK
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWBNCDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWBNCDH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:03:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7848 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750920AbWBNCDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 21:03:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214020144.HFZD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 21:01:44 -0500
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <43F13776.9000501@gorzow.mm.pl> (Radoslaw Szkodzinski's message
	of "Tue, 14 Feb 2006 02:50:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16100>

Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> writes:

> Wrong. I wanted to display files that are ignored and not checked in.
> (unlike your example)

Wow, you have a strong voice.

> That's why I used the -o (--others).

You asked it to show either ignored or others.


> I would like to use it for backup~ hunting purposes in a script
> and not have to worry about find and other less portable tools.

I usually do this for that:

	git ls-files -o '*~'
