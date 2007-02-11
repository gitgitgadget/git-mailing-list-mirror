From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 13:44:25 -0800
Message-ID: <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net>
References: <20070209014852.GA13207@thunk.org>
	<1171123504783-git-send-email-tytso@mit.edu>
	<11711235041527-git-send-email-tytso@mit.edu>
	<11711235042388-git-send-email-tytso@mit.edu>
	<20070210181357.GE25607@thunk.org>
	<Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070211001346.GA19656@thunk.org>
	<Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070211162136.GA26461@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 11 22:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGMUo-0006m4-9P
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 22:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXBKVo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 16:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXBKVo1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 16:44:27 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60230 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXBKVo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 16:44:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211214426.YFKE21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 16:44:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NMkR1W00k1kojtg0000000; Sun, 11 Feb 2007 16:44:26 -0500
In-Reply-To: <20070211162136.GA26461@thunk.org> (Theodore Tso's message of
	"Sun, 11 Feb 2007 11:21:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39307>

Theodore Tso <tytso@mit.edu> writes:

> ..., I think we're
> still safe, since aliases can't override commands.  

I feel a bit uneasy to hear safety argument based on that
current restriction, since we might want to loosen it later.
