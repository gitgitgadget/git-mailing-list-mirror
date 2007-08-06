From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 01:45:58 -0700
Message-ID: <7vwsw9capl.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 10:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHyDz-0005ug-6V
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 10:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759839AbXHFIqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 04:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759733AbXHFIp7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 04:45:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41135 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759405AbXHFIp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 04:45:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806084558.XWNG14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 04:45:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YYly1X0031kojtg0000000; Mon, 06 Aug 2007 04:45:58 -0400
In-Reply-To: <20070805041320.GH9527@spearce.org> (Shawn O. Pearce's message of
	"Sun, 5 Aug 2007 00:13:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55126>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We recently talked about this on the mailing list and decided that
> git-add shouldn't remove files that have disappeared, as doing so
> might break most user's expections of what git-add does.
> ...
> "git commit -a" will remove disappeared files.  It has for quite
> some time.

It obviously is not the time to do this as I have already said
that I won't look at anything but fixes and documentation
updates until 1.5.3, but I am not opposed to have "git add -a $paths"
which would do something like "git add $paths && git add -u $paths".
We also might want to add "git add --refresh $paths" while at
it, which were brought up recently in a separate thread.
