From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] git-gui: Allow users to set commit.signoff from options.
Date: Mon, 9 Jul 2007 07:43:14 +0000
Message-ID: <20070709074314.18158.qmail@dd40bf21a4abfd.315fe32.mid.smarden.org>
References: <20070706144654.12095.qmail@c8e1b1dc78de94.315fe32.mid.smarden.org> <20070708214832.GC4436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 09:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ntb-0001SO-J7
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXGIHm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 03:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXGIHm4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:42:56 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:53044 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751171AbXGIHm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 03:42:56 -0400
Received: (qmail 18159 invoked by uid 1000); 9 Jul 2007 07:43:14 -0000
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070708214832.GC4436@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51968>

On Sun, Jul 08, 2007 at 05:48:32PM -0400, Shawn O. Pearce wrote:
> Gerrit Pape <pape@smarden.org> wrote:
> > Users may want to automatically sign-off any commit for a specific
> > repository.  If they are mostly a git-gui user they should be able to
> > view/set this option from within the git-gui environment, rather than
> > needing to edit a raw text file on their local filesystem.
> 
> Sure.  But your patch to git-gui actually just lets the user set
> the flag, but doesn't make git-gui honor it.  So the user can set
> "Automatically Sign-Off" through git-gui but it will have no effect
> within git-gui (git-gui doesn't use git-commit.sh, it has its own
> pure-Tcl implementation).

Ups, sorry.

> I'm not applying this to git-gui, for the very same reason that
> Junio already gave as to why he won't apply the git-commit.sh patch.
> 
> Within git-gui adding a signoff is either one mouse click (the
> button on the toolbar), a single keystroke (Ctrl-S) or a menu action
> (Commit->Signoff).  Three easy ways to insert the signoff line.
> But it still needs to be a choice from the user, every time they
> make a commit.

Yes, thanks, Gerrit.
