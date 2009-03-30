From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more
	robust
Date: Mon, 30 Mar 2009 07:14:17 -0700
Message-ID: <20090330141417.GV23521@spearce.org>
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302> <200903300851.43164.markus.heidelberg@web.de> <alpine.DEB.1.00.0903301001090.7534@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIHI-0001wy-5T
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbZC3OOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZC3OOU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:14:20 -0400
Received: from george.spearce.org ([209.20.77.23]:48370 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZC3OOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:14:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F3DE138211; Mon, 30 Mar 2009 14:14:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903301001090.7534@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115154>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 30 Mar 2009, Markus Heidelberg wrote:
> > Johannes Schindelin, 30.03.2009:
> > > And with bare repositories?
> > 
> > Git-gui doesn't seem to work with bare repositories, I get
> > "Cannot use funny .git directory: ."
> > when started on the command line.
> 
> Oh?  I thought there was some discussion recently that was explicitely 
> about git gui with bare repositories.  But I have to time-share my brain 
> these days, so my memory might well show some bit flips.

At best, you can get blame to run on a bare repository, but that's
it.  Most of the git-gui UI is designed for viewing the status of
the working tree, or manipulating the index and/or files in that
working tree.  There are fairly good reasons why it doesn't work
on a bare repository.

Of course, fetch/push would be fine a bare repository, but I consider
that use case to be not worth the cost it would be in code to make
it possible.  We'd have to if out huge blocks of git-gui code,
maybe 80%+ of git-gui.sh, and that script is already hairy enough
(3477 lines).

-- 
Shawn.
