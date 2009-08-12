From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT 5/5] Treat gitlink tree entries similar to symlink
	tree entries
Date: Wed, 12 Aug 2009 08:32:10 -0700
Message-ID: <20090812153210.GF1033@spearce.org>
References: <1250089629-22547-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFoM-0007IS-0A
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbZHLPcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbZHLPcJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:32:09 -0400
Received: from george.spearce.org ([209.20.77.23]:59396 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbZHLPcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:32:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8FEAA381FF; Wed, 12 Aug 2009 15:32:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250089629-22547-1-git-send-email-fonseca@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125711>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Adds minimal support for gitlinks, based on the existing code for
> handling symlinks. The goal is to avoid exceptions when reading trees
> with gitlinks.

Applied, but who calls GitlinkTreeEntry ?
 
>  .../jgit/errors/GitlinksNotSupportedException.java |   58 +++++++++++++
>  .../src/org/spearce/jgit/lib/ForceModified.java    |    4 +
>  .../src/org/spearce/jgit/lib/GitlinkTreeEntry.java |   85 ++++++++++++++++++++
>  .../src/org/spearce/jgit/lib/TreeVisitor.java      |    8 ++
>  .../src/org/spearce/jgit/lib/WriteTree.java        |    7 ++
>  5 files changed, 162 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/GitlinksNotSupportedException.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java

-- 
Shawn.
