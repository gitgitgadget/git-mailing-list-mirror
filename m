From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 19:23:39 -0700
Message-ID: <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
	<20050524202846.GC25606@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
	<20050524213102.GB19180@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 25 04:22:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DalX0-0004yo-IF
	for gcvg-git@gmane.org; Wed, 25 May 2005 04:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVEYCXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 22:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVEYCXo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 22:23:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19188 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262239AbVEYCXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 22:23:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525022339.SBUL550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 22:23:39 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050524213102.GB19180@vrfy.org> (Kay Sievers's message of
 "Tue, 24 May 2005 23:31:02 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was browsing www.kernel.org/git and noticed that it shows
only files that exist at the tip.  How do I get history of a
file that does not exist anymore at the tip?

For example, diff-helper.c history is (quite correctly)
truncated somewhere close to where diff-tree-helper.c was
renamed to it.  From the commit log, humans can easily tell that
it used to be called diff-tree-helper.c.  I could not find an
easy way to see the history of diff-tree-helper.c file.

On probably a bit different topic (but I do not know who is
updating the copy on www.kernel.org, sorry).  Could somebody
update http://www.kernel.org/pub/software/scm/git/docs/ to
rename git-diff-tree-helper to git-diff-helper please?
git.git/Documentation/git.txt has been corrected quite some
time ago [*1*] and I do not know how the updates are propagated
to the web version of the documentation; is it a manual process?

[Footnotes]

*1* The following command tells me it was done about 10 days ago.

    git-rev-list 0 |
    git-diff-tree -S'diff-tree-helper' --stdin -v -p Documentation/git.txt

