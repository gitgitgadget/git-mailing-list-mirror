From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: removing content from git history
Date: Wed, 10 Oct 2007 15:41:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101535560.4174@racer.site>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org>
 <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
 <20070221210045.GB26525@spearce.org> <Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
 <20070221212129.GD26525@spearce.org> <18187.60305.613904.547916@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 16:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifckx-0000q6-Uk
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbXJJOlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbXJJOlm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:41:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:42777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752939AbXJJOlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 10:41:42 -0400
Received: (qmail invoked by alias); 10 Oct 2007 14:41:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 10 Oct 2007 16:41:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e4/UP0z8e/8ygbWjXp9+64e8pK5846PEI9cDzAh
	4ZsHhc/KwaILHZ
X-X-Sender: gene099@racer.site
In-Reply-To: <18187.60305.613904.547916@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60505>

Hi,

On Tue, 9 Oct 2007, Bill Lear wrote:

> Our company has content in our central git repository that we need to 
> remove per a contractual obligation.  I believe the content in question 
> is limited to one sub-directory, that has existed since (or near to) the 
> beginning of the repo, if that matters.  We obviously would just like to 
> issue a "git nuke" operation and be done with it, if that is available.  
> Barring that, we could probably follow reasonably simple steps to purge 
> the content and rebuild the repo.
> 
> So, what options do we have at present?

git filter-branch.  I suggest using the index filter.  There is even a 
nice example in the man page of git filter-branch.

Which reminds me that I have some TODOs left in filter-branch...

Ciao,
Dscho
