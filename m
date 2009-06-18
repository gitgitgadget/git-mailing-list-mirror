From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:44:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181042270.4848@intel-tinevez-2-302>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <vpqbpomey8c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDGF-00045L-8n
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbZFRIol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756812AbZFRIoj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:44:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:34983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756647AbZFRIoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:44:38 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:44:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 18 Jun 2009 10:44:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199paJwtzJ9+fkhHB5FGJLG9Lx31n8YYEY56BXZx+
	W1GITFYpNSGbnn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <vpqbpomey8c.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121820>

Hi,

On Thu, 18 Jun 2009, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I'd really rather stay with "fixup".
> 
> I like fixup. I'd say "fixup: <message>" so that the thing actually
> looks like a program directive rather than natural language.

Umm...  The thing would be used like this:

original edit list:

	pick b1ab1ab First commit
	pick deafbee Second commit
	pick 0123456 This is a fixup for the first commit

edited edit list:

	pick b1ab1ab First commit
	fixup 0123456 This is a fixup for the first commit
	pick deafbee Second commit

It would squash the first two commits, forget about the second commit 
message and continue with the last commit.  No user interaction unless 
there are merge conflicts.

Ciao,
Dscho
