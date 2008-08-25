From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is '-c'
Date: Tue, 26 Aug 2008 00:03:45 +0300
Message-ID: <20080825210345.GE14930@eagain.net>
References: <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080824222534.GC14930@eagain.net> <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48B29B2A.6000802@gnu.org> <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com> <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjF8-0004MU-U8
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbYHYVDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYHYVDu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:03:50 -0400
Received: from eagain.net ([208.78.102.120]:36328 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbYHYVDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:03:49 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id 344071EC45F;
	Mon, 25 Aug 2008 21:03:48 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 0FB00870003; Tue, 26 Aug 2008 00:03:45 +0300 (EEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93676>

On Mon, Aug 25, 2008 at 10:52:46PM +0200, Johannes Schindelin wrote:
> When a program is called via ssh's '-c' option, the login shell is called 
> on the remote computer, with the given arguments.  In the case that Git 
> was specified as login shell in /etc/passwd, Git used to complain that it 
> does not know the '-c' option and die.
> 
> This commit assumes that '-c' indicates that Git was specified as
> a login shell, and hands off to git-shell.
> 
> Noticed by Tommi Virtanen.

My imagination is insufficient in coming up with an uglier kludge, and
I sincerely hope my name isn't associated with this in any way.

-- 
:(){ :|:&};:
