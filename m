From: Petr Baudis <pasky@suse.cz>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
	Alpha
Date: Tue, 5 Aug 2008 03:10:51 +0200
Message-ID: <20080805011051.GC32184@machine.or.cz>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com> <20080804175403.GG27666@spearce.org> <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	James Linder <james.h.linder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBC3-0004bJ-My
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbYHEBR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757990AbYHEBR3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:17:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50619 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569AbYHEBR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:17:28 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CCB29393B8E7; Tue,  5 Aug 2008 03:10:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808050127510.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91397>

On Tue, Aug 05, 2008 at 01:36:15AM +0200, Johannes Schindelin wrote:
> And I absolutely share the puzzlement of Shawn why anybody would try to do 
> their own thing in Java, instead of contributing to jgit.
> 
> Especially the fact that "JavaGit" seems to repeat the all-to-obvious 
> error of Eclipse: to make a platform-independent library that depends on 
> platform dependent components.

[Totally naive question coming with no knowledge of actual size of
current JGit's feature set:]

Wouldn't it make sense to have an ability to fall back on Git calls for
functionality that is not implemented natively yet? If you then don't
have Git available, you just don't get the functionality. What's the
catch?


It seems to me that JavaGit's goal is "features, quick!" where JGit's
goal is "functionality, thoroughly". Both goals seem legitimate to me,
but I'm also not sure why didn't JavaGit just extend JGit's missing bits
with native Git calls and instead opted for reimplementation from the
ground up.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
