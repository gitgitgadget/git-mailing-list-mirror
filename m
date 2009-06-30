From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Tue, 30 Jun 2009 01:33:05 -0400
Message-ID: <20090630053304.GB29643@sigio.peff.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628185218.GB8634@sigio.peff.net> <20090628210117.GA7821@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Jun 30 07:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLVwv-0006LB-1z
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 07:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbZF3FbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbZF3FbM
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 01:31:12 -0400
Received: from peff.net ([208.65.91.99]:57121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbZF3FbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 01:31:11 -0400
Received: (qmail 29662 invoked by uid 1000); 30 Jun 2009 05:33:05 -0000
Content-Disposition: inline
In-Reply-To: <20090628210117.GA7821@old.homeip.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122486>

On Sun, Jun 28, 2009 at 11:01:17PM +0200, Martin Renold wrote:

> As a former svn user I also miss -q.  I like to keep untracked non-ignored
> files lying around as a short-term TODO list.
> 
> I think the point is not SVN compatibility.  The point is that SVN just got
> the commandline interface right here ;-) because -q easier to discover and
> remember (many programs have --quiet/-q).  And when you use it you will use
> it several times in a row.  For this -uno is already too much to bother
> typing (assuming you have an alias 'git st').

If it is convenience you want, perhaps you would be even happier with:

  git config status.showUntrackedFiles no

As far as "SVN got it right": that may well be the case, but we have to
deal with the fact that "git status" is really a dry-run version of "git
commit", which already has a "-q" option, which does something totally
different. So I am a little hesitant to endorse its use in "git status"
for something unrelated (and I am hesitant to have redundant command
line options, as well).

-Peff
