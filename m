From: Junio C Hamano <gitster@pobox.com>
Subject: Re: syntax for checking out specific tag on a remote
Date: Sat, 11 Aug 2007 18:41:30 -0700
Message-ID: <7v1we9leb9.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2SV-0002Ru-T1
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbXHLBld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbXHLBld
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:41:33 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63169 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHLBlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:41:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812014131.UBYJ24055.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 21:41:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aphX1X00C1kojtg0000000; Sat, 11 Aug 2007 21:41:31 -0400
In-Reply-To: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
	(Jon Smirl's message of "Sat, 11 Aug 2007 21:33:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55657>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> What's the syntax for checking out a specific tag on a remote?

This depends on where you stored the tags you obtained from the
remote.  By default, "git fetch --tags" would store the tags in
a flat namespace; there is no "remote tag" namespace.

Hence you would say:

	git checkout v2.6.19

to get a detached HEAD at v2.6.19, or if you want to start a
branch from there,

	git checkout -b my19 v2.6.19
