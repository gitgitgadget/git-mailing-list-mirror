From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: choose appropriate view for file type if a= parameter missing.
Date: Wed, 09 May 2007 19:04:01 -0700
Message-ID: <7vvef1o2ni.fsf@assigned-by-dhcp.cox.net>
References: <20070509221928.17244.qmail@f9729cdcdf57d1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu May 10 04:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hly0s-0001ep-K4
	for gcvg-git@gmane.org; Thu, 10 May 2007 04:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbXEJCEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 22:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbXEJCEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 22:04:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36900 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbXEJCEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 22:04:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510020406.JSOL13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 22:04:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xE421W0061kojtg0000000; Wed, 09 May 2007 22:04:05 -0400
In-Reply-To: <20070509221928.17244.qmail@f9729cdcdf57d1.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 9 May 2007 22:19:28 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46821>

Gerrit Pape <pape@smarden.org> writes:

> See http://bugs.debian.org/410465
>
> gitweb URLs use the a= parameter for the view to use on the given path, such
> as "blob" or "tree".  Currently, if a gitweb URL omits the a= parameter,
> gitweb just shows the top-level repository summary, regardless of the path
> given.  gitweb could instead choose an appropriate view based on the file
> type: blob for blobs (files), tree for trees (directories), and summary if no
> path given (the URL included no f= parameter, or an empty f= parameter).
>
> Apart from making gitweb more robust and supporting URL editing more easily,
> this change would aid the creation of shortcuts to git repositories using
> simple substitution, such as:
> http://example.org/git/?p=path/to/repo.git;hb=HEAD;f=%s
>
> - Josh Triplett
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>

I am not sure if this is a "good" feature or just "because we
can" feature, but I am slightly in favor.  I do not know about
others.

I'd however request a few changes to the proposed commit log
message:

 * "See http://..." is not the primary information, but "see
   ... for further details"; please have it at the end, not at
   the beginning.

 * Was the patch authored by you, or Josh?  If the former,
   what's his name doing here?  Perhaps you wanted to say
   "Reported by Josh Triplett"?
