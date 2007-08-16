From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 16:40:29 +0100
Message-ID: <20070816154029.GN21089@ftp.linux.org.uk>
References: <1187110824.32555.76.camel@localhost> <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org> <20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com> <alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in> <46C30220.6060007@gmail.com> <68B09015-4411-470A-BA88-732969469AA2@mac.com> <46C42DCB.1060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Satyam Sharma <satyam@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhTK-0004us-Fe
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 17:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbXHPPlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXHPPlH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 11:41:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44532 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbXHPPks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 11:40:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1ILhSX-0005ns-HO; Thu, 16 Aug 2007 16:40:29 +0100
Content-Disposition: inline
In-Reply-To: <46C42DCB.1060502@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56020>

On Thu, Aug 16, 2007 at 12:58:19PM +0200, Rene Herman wrote:
 
> Googling around, I see subversion already has this and calls the meta-data 
> "properties" (svn propset/get and friends). It uses a few properties 
> itself, such as the svn:executable property (which I saw is also the only 
> permission bit git keeps) and svn:ignore, which serves the same role as the 
> .gitignore files for git. Both those would fit into this scheme nicely for 
> git as well, if git were to do something similar and reserve for example 
> the "git.*" namespace for internal use.

"svn does it" is usually an indication of a bad idea, but anyway - it's
fundamentally wrong in this case, simply because "$FOO is interested
in $BAR" is a property of $FOO, not of $BAR.

> The git-blame thing as sketched before by Linus would never be able to 
> point out mailing lists, or general lists of "interested parties" for 
> example, but these properties can do anything...

No, they can not.  "I'm interested in drivers/foo/bar.c fixes" is not
an earth-shattering event and it sure as hell does not create a new revision
of the tree.
