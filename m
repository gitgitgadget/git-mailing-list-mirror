From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Implement a 'clone' subcommand
Date: Tue, 30 Sep 2008 12:58:39 -0700
Message-ID: <20080930195839.GK21310@spearce.org>
References: <1222793501-17997-1-git-send-email-pasky@suse.cz> <20080930195330.GA4413@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <petr.baudis@novartis.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:59:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KklNx-0002l1-TY
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYI3T6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbYI3T6k
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:58:40 -0400
Received: from george.spearce.org ([209.20.77.23]:59791 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYI3T6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:58:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 36FBD3835F; Tue, 30 Sep 2008 19:58:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930195330.GA4413@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97153>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Petr Baudis <pasky@suse.cz> wrote:
> > This enables git-gui to be started with the clone dialog opened right
> > away, possibly with the URL prefilled when it is passed as another
> > argument. git-gui can then be e.g. registered as the git:// protocol
> > handler.
> > 
> > This is just a simple implementation - we construct the front actions
> > page, then throw it away immediately; I wanted to avoid unnecessary
> > refactoring and complication of the code, though.
> > 
> > Signed-off-by: Petr Baudis <petr.baudis@novartis.com>
> > 
> > ---
> >  Documentation/git-gui.txt         |    5 +++++
> >  git-gui/git-gui.sh                |   21 ++++++++++++++++++---
> >  git-gui/lib/choose_repository.tcl |   11 ++++++++++-
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> This looks fine [...]

I take that back.  "git gui clone git://repo.or.cz/alt-git.git"
didn't show the URL in the clone dialog for me.  This is on top
of your previous series, including the "locator" feature, and
with two locators configured in my .git/config.

-- 
Shawn.
