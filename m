From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sun, 04 Feb 2007 12:08:40 -0800
Message-ID: <7vlkjdr8hj.fsf@assigned-by-dhcp.cox.net>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
	<200702041716.39999.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 21:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDnfI-0002F6-OS
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 21:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbXBDUIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbXBDUIm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 15:08:42 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:59209 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752530AbXBDUIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 15:08:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204200842.XWKD1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 15:08:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KY8h1W0051kojtg0000000; Sun, 04 Feb 2007 15:08:41 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38705>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Mention git-revert as an alternative to git-reset to revert changes.

Thanks; that makes sense.  Applied.

It is not a biggie but for future reference you might want to
check your KMail configuration to avoid the wrapped line below:

> diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
> index 5fc5be5..129c5c5 100644
> --- a/Documentation/tutorial.txt
> +++ b/Documentation/tutorial.txt
> @@ -461,6 +461,8 @@ this branch.  If this branch is the only branch containing 
> those
>  commits, they will be lost.  Also, don't use "git reset" on a
