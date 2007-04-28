From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: Added 'find-rev' command
Date: Fri, 27 Apr 2007 23:13:46 -0700
Message-ID: <7vbqh9kov9.fsf@assigned-by-dhcp.cox.net>
References: <117770027350-git-send-email-aroben@apple.com>
	<20070427193004.GC12375@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 08:13:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhgBr-0001qY-Fc
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 08:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbXD1GNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 02:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbXD1GNs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 02:13:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48029 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbXD1GNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 02:13:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428061346.BZRR13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 02:13:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sWDm1W00A1kojtg0000000; Sat, 28 Apr 2007 02:13:47 -0400
In-Reply-To: <20070427193004.GC12375@untitled> (Eric Wong's message of "Fri,
	27 Apr 2007 12:30:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45769>

Eric Wong <normalperson@yhbt.net> writes:

> Adam Roben <aroben@apple.com> wrote:
>> This patch adds a new 'find-rev' command to git-svn that lets you easily
>> translate between SVN revision numbers and git tree-ish.
>
> Looks useful.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>

But looks quite wasteful.  Why not run "rev-list -v" or
something instead of running cat-file on revision one-by-one?
