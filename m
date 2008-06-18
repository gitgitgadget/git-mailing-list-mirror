From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Guided merge with override
Date: Wed, 18 Jun 2008 16:28:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806181627260.6439@racer>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org> <48563D6C.8060704@viscovery.net> <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com> <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181618070.6439@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8zcy-0006sx-K7
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 17:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYFRPaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYFRPaV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 11:30:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:41594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbYFRPaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 11:30:20 -0400
Received: (qmail invoked by alias); 18 Jun 2008 15:30:18 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp011) with SMTP; 18 Jun 2008 17:30:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QMyho8TjQz8PPWAHC6fpKOEkoNeSXg4bU/JKAUX
	b8v4D8Z6iO/v9K
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806181618070.6439@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85386>

Hi,

On Wed, 18 Jun 2008, Johannes Schindelin wrote:

> On Tue, 17 Jun 2008, Junio C Hamano wrote:
> 
> > No, neither --theirs nor --ours option exists in your version of git. 
> > But here is a patch to add it to git-merge-file.
> 
> Looks good, thanks!  Just to be safe, this should be accompanied by tet 
> cases.  But I did not see anything wrong with the patch.

Thinking about this again, there could be a problem: in case of complex 
merges, it is possible that the sides are switched around for an 
intermediate merge.  IOW you'd expect it to take "theirs", but it really 
takes "ours".

Hrm.

Ciao,
Dscho
