From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 02:17:32 -0800
Message-ID: <7v8xfm87cz.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<20070129061807.GA4634@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 11:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBTZy-0000H5-6z
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 11:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbXA2KRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXA2KRf
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 05:17:35 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52922 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbXA2KRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 05:17:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070129101733.OPM16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Mon, 29 Jan 2007 05:17:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GyGa1W00A1kojtg0000000; Mon, 29 Jan 2007 05:16:35 -0500
In-Reply-To: <20070129061807.GA4634@spearce.org> (Shawn O. Pearce's message of
	"Mon, 29 Jan 2007 01:18:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38072>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If you are curious its been pushed to repo.or.cz:
>
>   git://repo.or.cz/git-gui.git
>
>   Repository->Browse Current Branch
>   Double click on the file you want to see.

Cool.

I think it is not a big deal for git-gui which is for active
developers and not primarily for archaeologists, but it does not
seem to like to be invoked inside a bare repository.

Also it becomes very tempting to somehow have this "file
browser" selection UI as "tree browser" that can wander around
to view an arbitrary tree in the commit history.  The boundary
between git-gui and gitk would start to blurrrrrr.....
