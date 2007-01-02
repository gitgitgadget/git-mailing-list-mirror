From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 02 Jan 2007 12:30:16 -0800
Message-ID: <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net>
References: <459AA31E.5070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 21:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qHM-00028c-FV
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbXABUad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 2 Jan 2007 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbXABUad
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:30:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38319 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbXABUad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jan 2007 15:30:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102203032.OMPF19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 15:30:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6LVl1W0031kojtg0000000; Tue, 02 Jan 2007 15:29:45 -0500
To: Steve =?iso-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
In-Reply-To: <459AA31E.5070705@gmail.com> (Steve =?iso-8859-1?Q?Fr=E9cinau?=
 =?iso-8859-1?Q?x's?= message of "Tue,
	02 Jan 2007 19:23:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35814>

Steve Fr=E9cinaux <nudrema@gmail.com> writes:

> When using git-svn to access a SVN repo, the commit policy may
> vary. While git makes you commit small patches often, svn users tend
> to prefer bigger patches that implement a functionnality at once.
>
> So at the end you have a SVN commit which corresponds to several git =
ones.

I personally think this is solving a wrong problem.  Commit
granularity is a property of the project, the way in which
people involved in the project prefer working.  It is not about
"svn users" vs "git users", and it shouldn't be, especially if
the end result is still a single project.

Is git "making you commit small patches often"?  I honestly hope
we are not forcing you to do so, although we took pains to make
it easier because it tends to be easier to look at the history
later when commit boundaries match the logical steps of
evolution.

So my suggestion would be to educate people who tend to make too
large commits better separate their commits, and at the same
time coallesce the commits you create on the git side into a
presentable size, if you acquired a bad habit of making too
small commits, so that everybody follows the same commit
granularity guideline set by the project.
