From: Junio C Hamano <junkio@cox.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 18:45:25 -0800
Message-ID: <7v649pr60q.fsf@assigned-by-dhcp.cox.net>
References: <45E1E47C.5090908@verizon.net>
	<7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
	<45E1F6B5.8030907@verizon.net> <20070226020657.GA1884@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 03:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLVrs-0006iH-4n
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 03:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXBZCp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 21:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933699AbXBZCp1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 21:45:27 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48720 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbXBZCp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 21:45:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226024527.XXRL233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 21:45:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U2lR1W00J1kojtg0000000; Sun, 25 Feb 2007 21:45:26 -0500
In-Reply-To: <20070226020657.GA1884@spearce.org> (Shawn O. Pearce's message of
	"Sun, 25 Feb 2007 21:06:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40605>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Hmm.  Probably not.  In pg I used to compare HEAD^{tree} to the
> tree output by git-write-tree and refuse to make the commit if
> they had the same value.  git-gui just blindly assumes that if a
> file is staged for committing then it won't make an empty commit;
> this is also the behavior in git-commit.sh.
>
> Yet in the case of a merge you may want the same tree and not even
> realize it...

git-commit has been raised with all of these logic during its
evolution.  Is it a possibility to reuse it somehow?
