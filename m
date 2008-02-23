From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 10:10:13 +0100
Message-ID: <20080223091013.GB12161@uranus.ravnborg.org>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 10:10:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSqP5-000743-Ox
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 10:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbYBWJKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 04:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756636AbYBWJKG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 04:10:06 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:48679 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445AbYBWJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 04:10:03 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 614A2E30838;
	Sat, 23 Feb 2008 10:10:00 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id 13D94580D8; Sat, 23 Feb 2008 10:10:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74808>

On Fri, Feb 22, 2008 at 06:37:14PM -0600, Chase Venters wrote:
> I've been making myself more familiar with git lately and I'm curious what 
> habits others have adopted. (I know there are a few documents in circulation 
> that deal with using git to work on the kernel but I don't think this has 
> been specifically covered).
> 
> My question is: If you're working on multiple things at once, do you tend to 
> clone the entire repository repeatedly into a series of separate working 
> directories and do your work there, then pull that work (possibly comprising 
> a series of "temporary" commits) back into a separate local master 
> respository with --squash, either into "master" or into a branch containing 
> the new feature?

The simple (for me) workflow I use is to create a clone of the
kernel for each 'topic' I work on.
So at the same time I may have one or maybe up to five clones of the
kernel.

When I want to combine thing I use git format-patch and git am.
Often there is some amount of editing done before combining stuff
especially for larger changes where the first in the serie is often
preparational work that were identified in random order when I did
the inital work.

	Sam
