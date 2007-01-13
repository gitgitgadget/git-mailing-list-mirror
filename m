From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 16:48:09 -0800
Message-ID: <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	<7virfct737.fsf@assigned-by-dhcp.cox.net>
	<slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
	<7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
	<20070112210403.GB6262@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 01:48:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5X4G-0007hR-8T
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 01:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbXAMAsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 19:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbXAMAsN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 19:48:13 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39973 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161156AbXAMAsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 19:48:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113004810.BRNC20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 19:48:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AQnJ1W00P1kojtg0000000; Fri, 12 Jan 2007 19:47:18 -0500
To: Peter Baumann <waste.manager@gmx.de>
In-Reply-To: <20070112210403.GB6262@xp.machine.xx> (Peter Baumann's message of
	"Fri, 12 Jan 2007 22:04:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36733>

Peter Baumann <waste.manager@gmx.de> writes:

> Yes. I fully second Linus opinion. But I think there should be
> a difference in adding completly new content to the index
> (number of entries in the index grows) or replacing content in
> the index.

Huh?

> ? So take five minutes to really think about that. Take an hour. Take a 
> ? week. Ponder it.

I'd second this ;-).

> ? What does it mean to "add" something to a project? It has _nothing_ to do 
> ? with "filenames". Yeah, the filename obviously exists, but it's not 
> ? something that exists on its own. You add the ONLY thing that git tracks. 
> ? 
> ? You add CONTENT.
> ? 
> ? When you do "git add file.c" you aren't adding a filename to the list of 
> ? files that git knows about. Not even CLOSE. No. You are really adding 
> ? _content_ to the project you are tracking.

Read this again, please.  Ponder it if you may.

> ? So even without an index, "git add" should work the way it works, once you 
> ? can just let go of the broken model that is CVS.
> ? 
> ? Please. Join me, Luke. The power of the git side is stronger. I am your 
> ? father. 
> ? 
> ?			Linus

And probably I am your uncle ;-).
