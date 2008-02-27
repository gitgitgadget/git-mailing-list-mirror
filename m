From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 22:04:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802272203270.22527@racer.site>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>  <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>  <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com>
 <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-91033209-1204149877=:22527"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Gabriel_Salda=F1a?= <gsaldana@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:05:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUPK-0001eA-56
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079AbYB0WFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbYB0WFK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:05:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:37181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752731AbYB0WFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:05:08 -0500
Received: (qmail invoked by alias); 27 Feb 2008 22:05:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 27 Feb 2008 23:05:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nMsF/Gb2nYhrLJEVllpXEwn8La6+wCzOHeJiXdi
	6zh5KjNB3W0pbl
X-X-Sender: gene099@racer.site
In-Reply-To: <47C5AEFA.5020004@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75306>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-91033209-1204149877=:22527
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 27 Feb 2008, Gabriel Saldaña wrote:

> Here it is:
> 
> $ msgfmt --tcl; echo $?
> msgfmt: unrecognized option `--tcl'
> Try `msgfmt --help' for more information.
> 1

Darn.  I think that's the same exit code as for any other invocation 
without filename.

So it seems that there is no easy way to tell a --tcl aware msgfmt from 
the other.

Ciao,
Dscho
---1463811741-91033209-1204149877=:22527--
