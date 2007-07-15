From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Exporting a tree from a repository
Date: Sat, 14 Jul 2007 23:12:12 -0700
Message-ID: <7vy7hidwlf.fsf@assigned-by-dhcp.cox.net>
References: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
	<Pine.LNX.4.64.0707142237190.13310@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 15 08:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9xLK-0006gL-7v
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 08:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbXGOGMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 02:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbXGOGMP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 02:12:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43345 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbXGOGMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 02:12:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715061213.IWOD1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 02:12:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PiCC1X00Q1kojtg0000000; Sun, 15 Jul 2007 02:12:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52528>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> You should also be able to use this to get an "export" - simply create
> the new workdir and then remove the .git (being careful not to
> accidentally do this in your actual repository).  However I expect
> there is a better way to do this ...

You meant "git-archive" perhaps.
