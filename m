From: Derek Mahar <derek.mahar@gmail.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 03:53:43 +0000 (UTC)
Message-ID: <loom.20080210T033717-237@post.gmane.org>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com> <47AA0FD8.1050801@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 05:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3Ww-0001NQ-H2
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbYBJEKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755887AbYBJEKb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:10:31 -0500
Received: from main.gmane.org ([80.91.229.2]:48798 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941AbYBJEKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:10:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JO3Vy-0007pt-Id
	for git@vger.kernel.org; Sun, 10 Feb 2008 04:10:03 +0000
Received: from 63.243.173.117 ([63.243.173.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 04:10:02 +0000
Received: from derek.mahar by 63.243.173.117 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 04:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.243.173.117 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73307>

Martin Langhoff <martin <at> catalyst.net.nz> writes:
> I just don't worry about the timestamps 
> 
> I normally track the Moodle CVS tree, and do all my "new feature" and
> "client customization" branches in git. The feature branches I rebase
> aggressively, until they are ready to be "landed" in CVS. It is in that
> "landing in cvs" that I use cvsexportcommit, usually with a long list of
> commits!

How do you get git-cvsimport to avoid the "duplicate" commit that it creates
when it imports a commit that you "landed" in CVS with git-cvsexportcommit?  I
call this commit a duplicate because though it has a different SHA1 identifier,
commit timestamp, and even committer email address, it refers to the same tree
identifier as the landed commit.  However, because it has the same textual
difference as the landed commit, the duplicate commit introduces no new textual
difference.  It is essentially an "empty" commit.  Do you just accept and ignore
this empty commit?

Derek
