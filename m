From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 12:04:24 -0400
Message-ID: <20070311160424.GA629@fieldses.org>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQWN-0000H4-Dz
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933794AbXCKQDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933798AbXCKQDk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:03:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50492 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933794AbXCKQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:03:40 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HQQX2-0002IE-HR; Sun, 11 Mar 2007 12:04:24 -0400
Content-Disposition: inline
In-Reply-To: <200703111505.l2BF54Kq006625@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41937>

On Sun, Mar 11, 2007 at 04:05:04PM +0100, Xavier Maillard wrote:
> Hi,
> 
> I have setup several 'topic branches' for a project I am
> maintaining.
> 
> For several ones, I want to merge them into master.
> 
> Here is what I am trying to use:
> 
> git checkout master
> git merge -m "Message" topic-branch
> 
> The merge is correct but there is not merge message when I do a
> git log.
> 
> I have tried either with and without -m, I even tried with git
> merge "merge message" topic-branch but then it failed.
> 
> What is the correct way to have merge message ?

Have you done any work on the master branch since you branched the topic
branch off from it?  If not, the merge is just a "fast forward"--no
merge commit is created, and instead the head of the master branch is
just updated to point at the same commit as the head of the topic
branch.

(Maybe git-merge could warn in the case of -m provided with a
fast-forward?)

--b.
