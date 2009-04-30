From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: detecting cycles in Git's commit graph
Date: Thu, 30 Apr 2009 12:27:14 -0700
Message-ID: <20090430192714.GT23604@spearce.org>
References: <20090430191857.GA55192@ginosko.grantstreet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzbul-0008C4-8i
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZD3T1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 15:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZD3T1O
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:27:14 -0400
Received: from george.spearce.org ([209.20.77.23]:37963 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZD3T1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 15:27:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 683BB3806F; Thu, 30 Apr 2009 19:27:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090430191857.GA55192@ginosko.grantstreet.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118040>

Michael Hendricks <michael@ndrix.org> wrote:
> Are there any tools for detecting cycles in the commit graph which
> have been caused by grafts?  I thought 'git fsck' might do it, but it
> doesn't seem to.

Nope.  Cycles don't happen in a DAG.  So nobody has created tools
for it.  :-)

Yes, grafts are impure and can be used to cause a cycle, which is
one reason among many we don't encourage them being used.
 
-- 
Shawn.
