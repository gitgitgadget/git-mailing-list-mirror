From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] gitweb: use blame --porcelain
Date: Thu, 05 Oct 2006 14:18:36 -0700
Message-ID: <7vlknubgwj.fsf@assigned-by-dhcp.cox.net>
References: <7vwt7ebhe9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:19:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVac5-0003JK-Ru
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWJEVSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWJEVSi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:18:38 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33005 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbWJEVSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:18:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005211836.NMCD22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:18:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WlJf1V0041kojtg0000000
	Thu, 05 Oct 2006 17:18:39 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwt7ebhe9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 05 Oct 2006 14:07:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28372>

Side note.

This change does not give any more information (other than the
link to the corresponding line in the original version) than the
current gitweb in "next", but "blame --porcelain" returns richer
information than it used to be available, most notably the
summary line.  It might be interesting to enhance the title pop-up
mechanism to show them on mouse-over, but I was too lazy ;-).

I've considered making the commit-8 link to link not to the
commit page for the originating commit but to the corresponding
line in the blame page for it, but opted to take over the line
number link, which was serving far less useful purpose.  Your
keyboard has PgUp and PgDn to let you navigate within the same
blame output.

As I noted in the log message for [3/6], I suspect that the
curent implementation to show the original line number is
unnecessarily inefficient.  Improvement is much encouraged.
Again, I am too lazy to look into it right now.
