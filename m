From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-gui: Implement a 'clone' subcommand
Date: Fri, 3 Oct 2008 12:17:29 +0200
Message-ID: <20081003101729.GZ10360@machine.or.cz>
References: <1222793501-17997-1-git-send-email-pasky@suse.cz> <20080930195330.GA4413@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <petr.baudis@novartis.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 12:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlhkA-0004YN-0I
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 12:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYJCKRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYJCKRc
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:17:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56721 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbYJCKRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:17:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7D121393A2E4; Fri,  3 Oct 2008 12:17:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080930195330.GA4413@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97408>

On Tue, Sep 30, 2008 at 12:53:30PM -0700, Shawn O. Pearce wrote:
> Petr Baudis <pasky@suse.cz> wrote:
> >  Documentation/git-gui.txt         |    5 +++++
> >  git-gui/git-gui.sh                |   21 ++++++++++++++++++---
> >  git-gui/lib/choose_repository.tcl |   11 ++++++++++-
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> This looks fine, except for the diffstat.  You can't patch
> the docs and the code in the same patch as they are in two
> different repositories...  :-|

Oh, I forgot again, sorry. :-( But I think this shows rather bad design
of the layout, doesn't it? Shouldn't this documentation be kept in
git-gui/Documentation/{git-gui,config}.txt and included from git's
Documentation/?

> Also, I don't know if you've noticed but I think tg is
> sending duplicate "To" headers in the messages:

Thanks - I have noticed already but I didn't have time yet to fix it and
it seems generally pretty harmless. I will try to do something with that
later.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
