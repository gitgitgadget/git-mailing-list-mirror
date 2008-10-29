From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff
 --cached'.
Date: Wed, 29 Oct 2008 16:08:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1530966495-1225292940=:22125"
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:03:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCZW-0002nh-J7
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYJ2PBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbYJ2PBq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:01:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:60710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753682AbYJ2PBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:01:45 -0400
Received: (qmail invoked by alias); 29 Oct 2008 15:01:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 29 Oct 2008 16:01:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zJzF14uUz/2McIqyO4WdJtQTZysEPJf7BEeufwq
	NLpbRWwc15MmKY
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99368>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1530966495-1225292940=:22125
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 29 Oct 2008, Wincent Colaiuta wrote:

> El 29/10/2008, a las 1:44, David Symonds escribió:
> 
> > +SCRIPT_SH += git-staged.sh
> 
> Isn't this exactly what aliases are for?
>   git config --global alias.staged "diff --cached"
> (Rather than adding yet another command...)

The difference being, of course, that we do not ship default aliases (and 
neither do we plan to...).

So saying "this is what aliases are for" you ask for _newbies_ to add it 
for themselves.  We are talking the same newbies who should be helped by 
that command, and typically do not know that there are Git aliases yet.

Even worse, just sum the times it takes everybody to make that alias, and 
then compare with the time it would take to include something like David 
posted in git.git.  It should be obvious that the time balance is 
absolutely horrible.

Ciao,
Dscho

--8323328-1530966495-1225292940=:22125--
