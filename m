From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sat, 20 Jan 2007 02:11:15 -0800
Message-ID: <7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 11:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8DC1-0000zB-Me
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 11:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbXATKLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 05:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbXATKLR
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 05:11:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43612 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965234AbXATKLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 05:11:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120101116.ETXJ20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 05:11:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DNBZ1W00Z1kojtg0000000; Sat, 20 Jan 2007 05:11:34 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 10:49:15 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37265>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Embarassing thinko.

Aha, progress ;-).  But it still seems to pick up entry that is
less than specified number of hours if I do:

	$ git log --walk-reflogs -4 master@{1.hour} | head -2
        commit 33dd19c2a9c0b114436f53d86fc1c2c5e00c26bb
        Reflog: master@{Sat, 20 Jan 2007 00:01:35 -0800} (Junio C Ham

It is Jan 20th 02:10 now and the master was not pointing at that
commit 1 hour ago.

Anyway, I am done for the night -- I haven't finished testing
the updated 'master' and 'next', so I'll push out the tip of
'pu' (which contains all of the tentitive 'master' and 'next'
changes I haven't verified yet) and call it a day.
