From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Tue, 30 Jun 2009 11:33:48 -0400
Message-ID: <20090630153347.GA3547@sigio.peff.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628185218.GB8634@sigio.peff.net> <20090628210117.GA7821@old.homeip.net> <20090630053304.GB29643@sigio.peff.net> <20090630151442.GA20688@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLfJV-0001fL-O9
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 17:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbZF3Pbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbZF3Pbz
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 11:31:55 -0400
Received: from peff.net ([208.65.91.99]:46500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbZF3Pby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 11:31:54 -0400
Received: (qmail 3557 invoked by uid 1000); 30 Jun 2009 15:33:48 -0000
Content-Disposition: inline
In-Reply-To: <20090630151442.GA20688@old.homeip.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122520>

On Tue, Jun 30, 2009 at 05:14:42PM +0200, Martin Renold wrote:

> > [...] but we have to deal with the fact that "git status" is really a
> > dry-run version of "git commit", which already has a "-q" option
> 
> Good point. However I think those commands are similar only from an
> implementation point of view.  As an user I think of them as being quite
> different.  I would not be surprised about different meaning of options -
> certainly less than about "git commit -a" vs "git add -u".

The main difference that trips people, I think, is that they expect "git
status <file>" to restrict status to a subset of the tree. But it is
about "what would happen if I did 'git commit <file>'", which is quite
different.

There has been much discussion about an alternate command that would be
more like "svn status", and even some partial implementations. But it
needs somebody who really cares about the feature to step up and
complete it.

-Peff
