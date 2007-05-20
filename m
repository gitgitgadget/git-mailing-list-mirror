From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] rev-list: '--indent' oneline output
Date: Sun, 20 May 2007 18:12:10 +0200
Message-ID: <FAA26696-F444-4057-AED4-02B413B8A36D@zib.de>
References: <20070518215603.GS15393@fieldses.org> <1179676829751-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 20 18:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpo26-0006De-Cy
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbXETQNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbXETQNQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:13:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:42290 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757684AbXETQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:13:15 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4KGC4HD021731;
	Sun, 20 May 2007 18:12:04 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bb27.pool.einsundeins.de [77.177.187.39])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4KGC2Ab020333
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 May 2007 18:12:03 +0200 (MEST)
In-Reply-To: <1179676829751-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47852>


On May 20, 2007, at 6:00 PM, Steffen Prohaska wrote:

> As a result, the output of
>     git-rev-list --pretty=oneline --topo-order --indent
> is formatted in a way that resembles merge summaries. All commits that
> were pulled from a branch are indented with one additional space below
> the summary of the merge commit.

I created the patch to illustrate how the history could be formatted to
replace summaries.

For example
     git-rev-list --pretty=oneline --topo-order --indent 404fdef2 |  
cut -d ' ' -f 2-
outputs

Merge branch 'maint'
  Documentation: Reformatted SYNOPSIS for several commands
  Documentation: Added [verse] to SYNOPSIS where necessary
  Documentation/git.txt: Update links to older documentation pages.
gitweb: Fix "Use of uninitialized value" warning in git_feed
Merge branch 'sp/cvsexport'
  Optimized cvsexportcommit: calling 'cvs status' once instead of  
once per touched file.
Add link to 1.5.1.5 release notes.
Merge 1.5.1.5 in
  GIT v1.5.1.5
  Merge branch 'maint' of git://linux-nfs.org/~bfields/git into maint
   user-manual: reorganize public git repo discussion
   user-manual: listing commits reachable from some refs not others
   user-manual: introduce git
   user-manual: add a "counting commits" example
   user-manual: move howto/using-topic-branches into manual
   user-manual: move howto/make-dist.txt into user manual
   Documentation: remove howto's now incorporated into manual
   user-manual: move quick-start to an appendix
   glossary: expand and clarify some definitions, prune cross-references
   user-manual: revise birdseye-view chapter
   Add a birdview-on-the-source-code section to the user manual
  Documentation: git-rev-list's "patterns"
gitweb: Remove redundant $searchtype setup
[...]

- Steffen
