From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase
	(but cvsps sees them all right)
Date: Mon, 3 Nov 2008 11:08:53 -0800
Message-ID: <20081103190853.GM15463@spearce.org>
References: <200811022203.41092.fg@one2team.net> <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com> <200811022331.14048.fg@one2team.net> <490F1021.1090002@alum.mit.edu> <490F4B1E.2080707@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:10:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4oS-00038k-9k
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYKCTIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbYKCTIy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:08:54 -0500
Received: from george.spearce.org ([209.20.77.23]:53554 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYKCTIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 14:08:53 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D1603835F; Mon,  3 Nov 2008 19:08:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490F4B1E.2080707@datacom.ind.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99981>

Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br> wrote:
> Michael Haggerty wrote:
> > Francis Galiegue wrote:
> >> The plan would be to convert all modules in one go, with no one committing in 
> >> the meantime, so that's not a problem.
> > 
> > Then you should definitely try cvs2svn/cvs2git [1].  cvsps-based
> > conversion tools all have known and unavoidable problems due to the
> > limitations of cvsps.
> 
> Does cvs2git plans to support incremental importing?

No, it doesn't, and likely never will.  Computing the
change sets from CVS is ugly and more-or-less requires
that you do it all in one pass.

-- 
Shawn.
