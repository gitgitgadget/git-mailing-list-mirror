From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 17:02:43 -0700
Message-ID: <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
	<46250175.4020300@dawes.za.net>
	<Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
	<20070417235649.GE31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 02:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdxdI-0001it-EE
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 02:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031338AbXDRACp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 20:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031339AbXDRACp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 20:02:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56773 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031338AbXDRACo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 20:02:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418000244.MMLH1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 20:02:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oQ2i1W00w1kojtg0000000; Tue, 17 Apr 2007 20:02:43 -0400
In-Reply-To: <20070417235649.GE31488@curie-int.orbis-terrarum.net> (Robin
	H. Johnson's message of "Tue, 17 Apr 2007 16:56:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44843>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> As for a usage case:
> - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
>   same output)
> - Copies some file outside of the tree (the user is NOT smart enough,
>   and resists all reasonable attempts at edumacation)
> - Modifies said file outside of tree.
> - Contacts maintainer with entire changed file.
> - User vanishes off the internet.
>
> The entire file he sent if it's CVS, contains a $Header$ that uniquely
> identifies the file (path and revision), and the maintainer can simply
> drop the file in, and 'cvs diff -r$OLDREV $FILE'.
> If it's git, the maintainer drops the file in, and does 'git diff
> $OLDSHA1 $FILE'.

I personally hope that the maintainer drops such a non-patch
that originates from a PEBKAC.  At least I hope the tools that I
personally use are not maintained by such a maintainer ;-)
