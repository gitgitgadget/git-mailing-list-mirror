From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 18:21:32 +0200
Message-ID: <20081013162132.GB20371@leksak.fem-net>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQC7-00017u-Rh
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbYJMQVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYJMQVn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:21:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753941AbYJMQVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:21:42 -0400
Received: (qmail invoked by alias); 13 Oct 2008 16:21:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp012) with SMTP; 13 Oct 2008 18:21:40 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/CakAfg/nCbnLyA+2YGipOVI0yw7YpqAAuEkPtit
	Myj3BIhfIl2X3f
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KpQAm-0006rV-UH; Mon, 13 Oct 2008 18:21:32 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98120>

Hi,

Johannes Schindelin wrote:
> and I would have expected others to need a lot less arguments 
> to see it that way, too.

Despite the fact that I've never used hardlinks in a git repository, I
would have expected git to keep them.  So I'm one of the "others" who
thinks this config option is just sane (and should perhaps even be
enabled by default, if it does not break stuff on file systems that do
not have a hardlink feature... but ok)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
