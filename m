From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 03:12:39 -0700
Message-ID: <7vy7gyjj3c.fsf@assigned-by-dhcp.cox.net>
References: <86bqduutz4.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 12:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSF2-000779-S3
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbXG3KMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbXG3KMl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:12:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53320 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbXG3KMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:12:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730101240.RLVP1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Jul 2007 06:12:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VmCf1X00F1kojtg0000000; Mon, 30 Jul 2007 06:12:40 -0400
In-Reply-To: <86bqduutz4.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Mon, 30 Jul 2007 11:22:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54220>

David Kastrup <dak@gnu.org> writes:

> One has to use git-stash rather than "git stash".  Oversight?

Does any of the other shell-scripts work without dashes?
E.g. commit, merge, am, checkout?

If they do, then probably you are invoking older versions of
these scripts than what you think you are.  "git" itself looks
at GIT_EXEC_PATH and then the $(gitexecdir) from the Makefile
when it was built for its subcommands.

Perhaps this is your "symlinked install" gone awry?  I dunno.
