From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 16:31:16 -0400
Message-ID: <20070618203116.GK2334@fieldses.org>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jun 18 22:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Nsg-0001mu-ID
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 22:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763225AbXFRUbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 16:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763180AbXFRUbU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 16:31:20 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38673 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763572AbXFRUbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 16:31:20 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1I0Nsa-0005Gr-RS; Mon, 18 Jun 2007 16:31:16 -0400
Content-Disposition: inline
In-Reply-To: <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50407>

On Mon, Jun 18, 2007 at 09:29:18PM +0100, Oliver Kullmann wrote:
> On Mon, Jun 18, 2007 at 09:49:07PM +0200, Alex Riesen wrote:
> > Git does not keep "renaming history". It does not have to, as it keeps
> > how your project looked at each commit (point in history).
> 
> For my purposes, that is a bad thing, since I want to get rid off some parts
> of the history (specifically I want to eliminate some files from history),
> as explained in that last paragraph in my e-mail (with the motivation):

Oh, so even if somebody checks out a previous version of the project,
you don't want them to see that file at the old name any more?

The git history is totally immutable, by design--the SHA1 name of a
commit is taken over the commit, the contents of the entire tree at that
point, and any commit(s) that precede this commit--hence it recursively
summarizes the entire history of the project.

So if you want to erase all memory of a path from the git history, then
you have to rebuild it all.  Which is possible--it'd just mean creating
a new project and writing a script to import every version into the new
project....

--b.
