From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update git-am documentation
Date: Sun, 15 Apr 2007 23:56:20 -0700
Message-ID: <7vabx8x0x7.fsf@assigned-by-dhcp.cox.net>
References: <20070416053525.GA18821@localdomain>
	<20070416062016.GA19759@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdL8T-0003ei-4w
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbXDPG4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbXDPG4W
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:56:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36312 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbXDPG4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:56:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416065621.RPBP1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 02:56:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id niwL1W00D1kojtg0000000; Mon, 16 Apr 2007 02:56:21 -0400
In-Reply-To: <20070416062016.GA19759@localdomain> (Andrew Ruder's message of
	"Mon, 16 Apr 2007 01:20:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44597>

Andrew Ruder <andy@aeruder.net> writes:

> Documentation/git-am.txt missing several short versions

Short ones were semi deliberately left out, but I do not think
adding them would hurt.

> ...  Added documentation for --resolvemsg=<msg>
> command-line option.

On the other hand, this was purely meant as an internal
communication tool for the commands that invoke am, so I do not
think it is wise to document it without saying that, as I think
anybody reading your new documentation would end up asking "Huh?
what use is that?".
