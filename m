From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] git-cvsexportcommit.perl: Fix usage() output.
Date: Mon, 14 Nov 2005 15:04:52 -0800
Message-ID: <7vsltyvnjf.fsf@assigned-by-dhcp.cox.net>
References: <20051114164047.GB9131@raven.localdomain>
	<20051114164505.GF9131@raven.localdomain>
	<7vbr0mx4fj.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511141420u11e396d3q9a6710c79abe0ca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Geiss <kevin@desertsol.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 00:06:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbnNt-0001p7-1A
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVKNXEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKNXEz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:04:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51445 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932187AbVKNXEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:04:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114230342.XTFV20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 18:03:42 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511141420u11e396d3q9a6710c79abe0ca3@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 15 Nov 2005 11:20:59 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11862>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> ... I'm happy with Kevin's patches -- what's the ideal
> workflow for this? Is the sign-off line important enough that
> I should setup a public repo for you to pull from?

Given that you are far more familiar with that part of the code,
and I suspect I'd be asking your help in archimport as well, a
repo I can pull from would be more preferable (and sign-off by
you is certainly an added bonus).  If a public repo is too much
hassle, however, e-mail forwarding is perfectly fine as well.
Your choice.

BTW, there is no "mana" points involved in deciding if I
directly pull from somewhere.  Even if that were the case, you
have accumulated enough of them already ;-).

> BTW, File::Basename is a standard library usually installed w perl -- 
> it shouldn't add any painful dependencies. Not sure if that matters.

Although some might find "${\function}" expansion too cute for
their taste, Keven's code is fine as-is for me.  I launched the
baloon just wanting to see what others have to say ;-).
