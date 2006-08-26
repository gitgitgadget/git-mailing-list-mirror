From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Fri, 25 Aug 2006 19:05:56 -0700
Message-ID: <7vveog45ff.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252135.27894.jnareb@gmail.com>
	<e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 04:05:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGnYP-0005eb-6E
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 04:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWHZCFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 22:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbWHZCFm
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 22:05:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60830 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422955AbWHZCFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 22:05:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826020541.EVQB18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 Aug 2006 22:05:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id ES5h1V00F4Noztg0000000
	Fri, 25 Aug 2006 22:05:41 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26025>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> You can view new gitweb in work at
>>   http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
>
> Very nice job!
>
> Just a couple of suggestion regarding blame.
>
> - Instead of commit sha perhaps is more useful to show author name
> (linked to commit) and progressive number of revision.

Remember git history is not linear so progressive number does
not make much sense here.  I agree author and commit date would
be nice if they were readily available without cluttering.
A pop-up when hovered, perhaps?

> - Original code lines, ie. imported at the beginning and never
> modified, perhaps it is better to view without commit number, this
> could obfuscate the view and in any case is not an accurate info
> because the line was not modified during initial patch.

That holds only true for very young projects, or ones that were
perfect from the beginning and did not see much action ;-).
