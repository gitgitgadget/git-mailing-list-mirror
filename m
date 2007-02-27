From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 15:34:00 -0800
Message-ID: <7vk5y3b2fr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702280019340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBpg-0001rt-Na
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbXB0XeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbXB0XeF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:34:05 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43192 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbXB0XeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:34:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227233402.ZVSR2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:34:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Una01W00p1kojtg0000000; Tue, 27 Feb 2007 18:34:01 -0500
In-Reply-To: <Pine.LNX.4.63.0702280019340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 28 Feb 2007 00:20:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40845>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I personally am not very happy that "reflog show @{now}" gives relative 
>> date and not the full datestamp.
>
> $ git log -g @{now} 

I said "reflog show" because I wanted to have oneline and
abbrev.
