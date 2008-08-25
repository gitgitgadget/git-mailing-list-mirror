From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is '-c'
Date: Tue, 26 Aug 2008 01:20:02 +0300
Message-ID: <20080825222002.GF14930@eagain.net>
References: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48B29B2A.6000802@gnu.org> <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com> <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080825210345.GE14930@eagain.net> <alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXkQw-000696-SF
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 00:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYHYWUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 18:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYHYWUG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 18:20:06 -0400
Received: from eagain.net ([208.78.102.120]:36668 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243AbYHYWUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 18:20:05 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id 525161EC623;
	Mon, 25 Aug 2008 22:20:04 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 77180870003; Tue, 26 Aug 2008 01:20:02 +0300 (EEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93692>

On Tue, Aug 26, 2008 at 12:05:21AM +0200, Johannes Schindelin wrote:
> I do disagree with you that it is a kludge though.  I think it makes 
> complete sense to add this to Documentation/git.txt in addition to other 
> documentation that is lacking from my patch, though:
> 
> -- snip --
> -c <command>::
> 	execute <command> in git-shell.
> -- snap --

All I'm going to say is that that's not the way you build trustable
software. You take a minimal interface and restrict untrusted users to
that, you don't add a feature to the widest possible interface..

-- 
:(){ :|:&};:
