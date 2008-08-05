From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
	Alpha
Date: Mon, 4 Aug 2008 18:20:07 -0700
Message-ID: <20080805012007.GB32543@spearce.org>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org> <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080805011051.GC32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Linder <james.h.linder@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBEg-0005H5-Ej
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbYHEBUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754358AbYHEBUK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:20:10 -0400
Received: from george.spearce.org ([209.20.77.23]:36503 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYHEBUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:20:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 87AA538419; Tue,  5 Aug 2008 01:20:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080805011051.GC32184@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91398>

Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Aug 05, 2008 at 01:36:15AM +0200, Johannes Schindelin wrote:
> > And I absolutely share the puzzlement of Shawn why anybody would try to do 
> > their own thing in Java, instead of contributing to jgit.
> > 
> > Especially the fact that "JavaGit" seems to repeat the all-to-obvious 
> > error of Eclipse: to make a platform-independent library that depends on 
> > platform dependent components.
> 
> [Totally naive question coming with no knowledge of actual size of
> current JGit's feature set:]
> 
> Wouldn't it make sense to have an ability to fall back on Git calls for
> functionality that is not implemented natively yet? If you then don't
> have Git available, you just don't get the functionality. What's the
> catch?

Someone else asked to do this in JGit before (it was privately
off-list to Robin and myself).  Both of our responses were that we
were not that interested in having such dependencies in the main
JGit tree at this time, but that JGit is BSD and nothing would stop
them from forking our tree and trying it out.  If there really was
value there we would have to consider merging it back.

Nothing came of it as far as I know.

Someone recently ported git-blame into JGit, and it looks like they
did a good job, but it was a straight C->Java port.  Since JGit
is licensed under the BSD and builtin-blame.c is under the GPL we
couldn't accept it as-is.  That side project produced a lot more
results than anything else of late, but the GPL virual clause kicked
in and prevented direct inclusion.

-- 
Shawn.
