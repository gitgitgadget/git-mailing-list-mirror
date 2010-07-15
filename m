From: carbonated beverage <ramune@net-ronin.org>
Subject: git-svn question
Date: Thu, 15 Jul 2010 10:18:49 -0700
Message-ID: <20100715171849.GA31823@heretic.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 15 20:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSmm-0000mh-9p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933968Ab0GOSDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 14:03:41 -0400
Received: from heretic.net-ronin.org ([168.75.111.50]:41737 "EHLO
	heretic.net-ronin.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933965Ab0GOSDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 14:03:40 -0400
X-Greylist: delayed 2691 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2010 14:03:40 EDT
Received: from ramune by heretic.net-ronin.org with local (Exim 4.69)
	(envelope-from <ramune@heretic.net-ronin.org>)
	id 1OZS5B-0008I1-Bo
	for git@vger.kernel.org; Thu, 15 Jul 2010 10:18:49 -0700
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151102>

Hi all,

I'm trying to figure out how to import a rather large SVN tree that has been
around for a while, initially converted from CVS.

The layout is a bit odd.  Instead of standard branch/tags/trunk, it has those
directories multiply nested, e.g.:

A/
A/branches
A/branches/B
A/branches/B/branches
A/branches/B/tags
A/branches/B/trunk
A/tags/tag-1/branches
A/tags/tag-1/tags/B/branches
A/tags/tag-1/tags/B/tags
A/tags/tag-1/tags/B/trunk
A/tags/tag-1/trunk
A/trunk

etc.

Given multiple projects that are nested as such, is there a way to get git-svn
to import the tree and be able to derive the tags and branches?  Also, this
tree is a little over 1TiB in size, though a large chunk of that is due to
the duplicates made by SVN's branches/tags.

Thanks,

-- DN
Daniel N.
