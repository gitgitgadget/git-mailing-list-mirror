From: Junio C Hamano <junkio@cox.net>
Subject: Re: blameview and file contents
Date: Tue, 30 Jan 2007 00:30:25 -0800
Message-ID: <7vveio5332.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com>
	<20070130065417.GA32640@spearce.org>
	<cc723f590701292322q7365f99bg3b7c76834f6fbad8@mail.gmail.com>
	<20070130072910.GB32640@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 09:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBoNr-0000hD-C1
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965447AbXA3Ia2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965450AbXA3Ia2
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:30:28 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38372 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965447AbXA3Ia1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:30:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130083026.IZBS3989.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 03:30:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HLWl1W00P1kojtg0000000; Tue, 30 Jan 2007 03:30:46 -0500
In-Reply-To: <20070130072910.GB32640@spearce.org> (Shawn O. Pearce's message
	of "Tue, 30 Jan 2007 02:29:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38136>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
>> See i said that there should be a simple way. Can we get this
>> documented in git-cat-file man page
>
> Well, this isn't the git-cat-file man page, but we do suggest people
> use `git show HEAD:foo.c` to get foo.c from HEAD in an interactive
> setting.  The git-show manpage refers people to git-rev-parse,
> which has the following:
>
> 	* A suffix ':' followed by a path; this names the blob or tree
> 	  at the given path in the tree-ish object named by the part
> 	  before the colon.
> ...
> But if you submit a documentation update to git-cat-file's manpage
> that points off to the same section of git-rev-parse, folks may
> appreciate it.  :-)

My feeling is that adding "See SPECIFYING REVISIONS section" to
Porcelain documentation is a very good idea, but unwanted
baggage for plumbing descriptions if added everywhere.  The
target audience of the latter is supposed to know what "object
name" is, so:

 <object>::
-	The sha1 identifier of the object.
+	The name of the object to show.

should be sufficient.
