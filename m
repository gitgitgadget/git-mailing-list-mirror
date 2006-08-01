From: Junio C Hamano <junkio@cox.net>
Subject: A few more fixups to gitweb
Date: Mon, 31 Jul 2006 21:24:52 -0700
Message-ID: <7vzmep2icr.fsf_-_@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200608010259.13721.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 01 06:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7loQ-0004EK-Ho
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 06:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWHAEYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 00:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWHAEYz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 00:24:55 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32695 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161004AbWHAEYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 00:24:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801042453.YIHQ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 00:24:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608010259.13721.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 Aug 2006 02:59:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24571>

I've applied most of the recent gitweb changes from the list
(except the one that processes gitweb.perl into gitweb.cgi, not
because I am opposed to it, but because merging it early would
make things a bit more inconvenient while many patches are in
flight on the list) and fixed up a few things I noticed.  I'll
be pushing out the results on "next" branch shortly, so if
people want to hack on gitweb further please base your changes
on this version (I am CC'ing this message to people who recently
worked on, or expressed interest in working on gitweb).

One thing to note.  Please make sure that you do not see
anything in Apache error log after you make your changes.  I do
not remember the details but kernel.org folks were very unhappy
earlier when gitweb spewed stuff into the error log, and if I
recall correctly things that output to the error stream were not
friendly to the http-server cache for some reason.
