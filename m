From: Junio C Hamano <junkio@cox.net>
Subject: Re: What commands can and can not be used with bare repositories?
Date: Sat, 30 Dec 2006 21:52:53 -0800
Message-ID: <7v3b6wk3wq.fsf@assigned-by-dhcp.cox.net>
References: <E1H0poE-0000qd-Ee@candygram.thunk.org>
	<20061231015732.GB5082@spearce.org> <20061231021248.GA26067@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:52:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tcw-0001Z0-RM
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbWLaFw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWLaFwz
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:52:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52415 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932989AbWLaFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:52:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231055254.BDMU2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:52:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Hs81W0091kojtg0000000; Sun, 31 Dec 2006 00:52:09 -0500
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20061231021248.GA26067@thunk.org> (Theodore Tso's message of
	"Sat, 30 Dec 2006 21:12:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35675>

Theodore Tso <tytso@mit.edu> writes:

> That makes sense, although the hueristic for determining whether or
> not "." is a Git repository might be a little interesting.  Say, if
> there is no containing directory which has a .git directory, and the
> directories "objects", "info", and "refs" are present?

We have something called is_bare_git_dir() that does much
simpler and hacky check.

See my other message to Shawn regarding tradeoffs between
possible improvements and backward compatibility.
