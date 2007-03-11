From: Junio C Hamano <junkio@cox.net>
Subject: Re: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 13:15:30 -0700
Message-ID: <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUS7-0000lh-2H
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXCKUPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXCKUPc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:15:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62154 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbXCKUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:15:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311201530.MCCC28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 16:15:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYFW1W00P1kojtg0000000; Sun, 11 Mar 2007 16:15:31 -0400
In-Reply-To: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com>
	(Jon Smirl's message of "Sun, 11 Mar 2007 10:06:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41970>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Reading the other thread on tracking temporary changes made me think
> of using inotify with git. The basic idea would be to a daemon running
> that uses inotify to listen for changes in the working tree. As these
> changes happen they get committed to a tracking tree.

I think it is an interesting idea, but can be used with any SCM
not just git ;-).
