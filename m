From: Junio C Hamano <junkio@cox.net>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 17:28:08 -0700
Message-ID: <7vveewp7tz.fsf@assigned-by-dhcp.cox.net>
References: <20070512205529.GS14859@MichaelsNB>
	<7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
	<20070513000151.GT14859@MichaelsNB>
	<200705131318.39723.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Niedermayer <michaelni@gmx.at>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 02:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOQD-0000zL-5J
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXENA2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758301AbXENA2L
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:28:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43471 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbXENA2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:28:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514002809.ZGJ2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 20:28:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yoU81W00J1kojtg0000000; Sun, 13 May 2007 20:28:09 -0400
In-Reply-To: <200705131318.39723.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 13 May 2007 13:18:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47203>

Jakub Narebski <jnareb@gmail.com> writes:

> Adding some gitweb-help.html page, linked somewhere from within gitweb
> pages (I think it shouldn't be embedded in gitweb, like help for search
> options is), certainly is possible. And perhaps we should do that, now
> that gitweb is more widely deployed, and used by "accidental" users
> (developers) with no knowledge of git, and perhaps even without
> knowledge of SCM [terms].

Yeah, that is definitely an improvement.

> It should be fairly easy to add "diff to prev" link, but is it really
> needed? It would be yet another link. Diff to previous version of blob
> is contained in "commitdiff" and is easy to find and go to... well,
> unless you are used to make large commits...

It would not be "yet another".  It feels kind of odd to get the
whole commitdiff from that page to begin with, when the user
already expressed that his attention is focused on that
particular path --- that is why he is in the History page to
begin with.
