From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 17:48:14 -0800
Message-ID: <7vy7mwnsm9.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhctkp8gk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180226480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIbA3-0004pf-2Q
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993032AbXBRBsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993057AbXBRBsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:48:16 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37010 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993032AbXBRBsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:48:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218014815.NZMZ1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 20:48:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QpoE1W0061kojtg0000000; Sat, 17 Feb 2007 20:48:15 -0500
In-Reply-To: <Pine.LNX.4.63.0702180226480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 02:29:17 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40051>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I strongly disagree from my recent day-job experience. [Explains a 
>> convincing use case in favour of cd-up.]
>
> Hmm. I have to think about that. But a consequence of what you suggest 
> would be to disallow git-apply outside of a repository, because then you 
> would introduce _another_ inconsistency (git-apply without --index would 
> behave differently when inside a repo than when outside of one).

Why?  git-apply outside is like 'patch' isn't it?
