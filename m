From: Junio C Hamano <junkio@cox.net>
Subject: Re: Losing branches (whee, data loss)
Date: Tue, 15 May 2007 23:12:17 -0700
Message-ID: <7vtzudfgam.fsf@assigned-by-dhcp.cox.net>
References: <464A940C.3080906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed May 16 08:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoCkO-0006QH-A4
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760972AbXEPGMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760949AbXEPGMU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:12:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61809 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760815AbXEPGMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:12:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516061218.IUGH14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 16 May 2007 02:12:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ziCH1W00T1kojtg0000000; Wed, 16 May 2007 02:12:18 -0400
In-Reply-To: <464A940C.3080906@garzik.org> (Jeff Garzik's message of "Wed, 16
	May 2007 01:18:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47414>

Jeff Garzik <jeff@garzik.org> writes:

> Grumble!
>
> When all this started, the branch 'upstream-fixes' exists, and branch
> 'tmp' does not exist.  This is my local clone of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> [jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
> error: Could not open config file!
> fatal: Branch rename failed

Sorry to hear that.

We used to have a problem with "branch -m" when you did not have
a .git/config file (or it was unwritable).  I think 1.5.0.X
series and 1.5.1 release had this bug; 1.5.1.1 and later should
have the appropriate fix.

Was this really a "whee, data loss", I wonder...?
