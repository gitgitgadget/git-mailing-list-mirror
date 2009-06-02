From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git and multiple cores
Date: Tue, 2 Jun 2009 16:02:05 -0700
Message-ID: <20090602230205.GL30527@spearce.org>
References: <4A25AA4C.9070600@nortel.com> <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Friesen <cfriesen@nortel.com>, git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBczm-0000Ib-OV
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbZFBXCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbZFBXCF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:02:05 -0400
Received: from george.spearce.org ([209.20.77.23]:47201 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbZFBXCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 19:02:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC129381D1; Tue,  2 Jun 2009 23:02:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120559>

Peter Harris <git@peter.is-a-geek.org> wrote:
> On Tue, Jun 2, 2009 at 6:40 PM, Chris Friesen wrote:
> >
> > I'm using git 1.6.1.3 and it seems to be limited to a single core.
> > Given that I've seen cases where the cpu has been basically pinned for
> > minutes on end (initial clone of a repository, for instance) has there
> > been any discussion of taking advantage of multiple cores?
> 
> Sounds like you're mostly concerned about packing.
> 
> The good news is, your version of git already has a threaded packer.
> You just need to enable it. See "pack.threads" in "git help config".
> 
> 1.6.2 and newer use multiple threads by default.

True, but he was talking about initial clone, which on the client
side is git-index-pack.  Which is not threaded.
 
-- 
Shawn.
