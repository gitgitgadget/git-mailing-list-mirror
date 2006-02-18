From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvs-import retries
Date: Sat, 18 Feb 2006 10:42:44 -0800
Message-ID: <7vvevco6e3.fsf@assigned-by-dhcp.cox.net>
References: <mj+md-20060217.193146.10308.albireo@ucw.cz>
	<7v1wy1t9cb.fsf@assigned-by-dhcp.cox.net>
	<mj+md-20060218.130645.5680.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 19:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAX2f-0007Mv-Kh
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 19:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBRSmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 13:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWBRSmq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 13:42:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45024 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932109AbWBRSmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 13:42:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218183927.RCTY17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 13:39:27 -0500
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <mj+md-20060218.130645.5680.albireo@ucw.cz> (Martin Mares's
	message of "Sat, 18 Feb 2006 14:14:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16419>

Martin Mares <mj@ucw.cz> writes:

> But it did and I finally understand why: _line() can exit not only
> by return, but also by falling over when readline() returns undef.

Ah, you are right and I feel stupid.  It's been a while since I
wrote real Perl code the last time, and forgot that "the last
evaluation" rule when I was reading the code.

It did not help that one of the languages I use in my day-job
(which I am too ashamed to even name) uses "if fell off at the
end return undef" rule X-<.
