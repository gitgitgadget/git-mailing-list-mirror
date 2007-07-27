From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] work-trees are allowed inside a git-dir
Date: Fri, 27 Jul 2007 13:51:47 -0700
Message-ID: <7vejity3h8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271957250.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWnO-0001qh-Lv
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764276AbXG0Uvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764041AbXG0Uvw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:51:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45410 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764039AbXG0Uvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:51:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727205148.GGJC1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 16:51:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ukrn1X00C1kojtg0000000; Fri, 27 Jul 2007 16:51:47 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53967>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is allowed to call
>
> 	$ git --git-dir=../ --work-tree=. bla
>
> when you really want to.  In this case, you are both in the git directory
> and in the working tree.
>
> The earlier handling of this situation was seriously bogus.  For regular
> working tree operations, it checked if inside git dir.  That makes no
> sense, of course, since the check should be for a work tree, and nothing
> else.
>
> Fix that.

I do not doubt this patch makes the above command line to work
better, but I have to wonder how that layout is useful.  Care to
give a use case or two in the commit log message?
