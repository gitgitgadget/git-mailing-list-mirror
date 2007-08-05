From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 16:38:47 -0700
Message-ID: <7vr6mheem0.fsf@assigned-by-dhcp.cox.net>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
	<85bqdndqgr.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
	<85bqdmctcl.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
	<85bqdlj1lh.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 01:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHpgU-0002m7-5k
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 01:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbXHEXit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756181AbXHEXit
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 19:38:49 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42641 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792AbXHEXis (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 19:38:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805233847.UKIT7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 5 Aug 2007 19:38:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YPem1X00J1kojtg0000000; Sun, 05 Aug 2007 19:38:47 -0400
In-Reply-To: <85bqdlj1lh.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	05 Aug 2007 20:08:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55084>

David Kastrup <dak@gnu.org> writes:

>> So stop this *insane* insistence of emacs. You should learn to just
>> assume that people don't even have it installed!
>
> We were discussing Texinfo, not Emacs.  Please focus.

I would welcome if the set of our documentation output formats
included *.info pages.

However, as the input format, texinfo _is_ painful.  AsciiDoc is
100x easier.  I've written documentaiton in texinfo format in
the past, and one thing I found quite painful was maintaining
the node header with prev/next links --- tedious, error prone
and boring.  There is no good editor to help you maintain them
other than Emacs texinfo mode as far as I know.
