From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with git cvsimport
Date: Tue, 27 Feb 2007 04:24:27 -0800
Message-ID: <7vvehng550.fsf@assigned-by-dhcp.cox.net>
References: <001f01c75a60$53443e10$0b0aa8c0@abf.local>
	<Pine.LNX.4.63.0702271318070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raimund Bauer <ray007@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1Nq-0004Zp-Dd
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068AbXB0MYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933079AbXB0MYa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:24:30 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60064 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068AbXB0MY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:24:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227122429.BUES2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 07:24:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UcQT1W00Y1kojtg0000000; Tue, 27 Feb 2007 07:24:28 -0500
In-Reply-To: <Pine.LNX.4.63.0702271318070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Feb 2007 13:19:07 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40717>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 27 Feb 2007, Raimund Bauer wrote:
>
>> When trying to cvsimport a project into git, I get an error from cvsps:
>> 
>> bad usage: invalid argument -A
>
> What was your command line?

Very good question.  Earlier I was doing grep, and as far as I
can tell, git-cvsimport in Perl _always_ has passed -A to cvsps.
