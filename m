From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sun, 8 Jun 2008 16:01:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806081600220.1783@racer>
References: <20080607070637.79B17C7C0E@rwavmlap> <m37id1y4zj.fsf@localhost.localdomain> <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com> <20080608043543.GB11194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Anderson <rwa000@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:04:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5MRi-0004Ec-SE
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYFHPDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 11:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYFHPDP
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:03:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753964AbYFHPDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:03:14 -0400
Received: (qmail invoked by alias); 08 Jun 2008 15:03:12 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 08 Jun 2008 17:03:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZVk5QT2hZBtayzDi+isbJnjhtn/1Am+xNvrI/UX
	ta4Sk06b9vWnJo
X-X-Sender: gene099@racer
In-Reply-To: <20080608043543.GB11194@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84276>

Hi,

On Sun, 8 Jun 2008, Jeff King wrote:

> On Sat, Jun 07, 2008 at 09:06:19AM -0700, Robert Anderson wrote:
> 
> > > FYI this line is not necessary, and should be removed from
> > > git-format-patch output when pasting it to your MUA.
> > 
> > Err, then shouldn't it be removed from format-patch, rather than
> > deleted manually every time format-patch is used?
> 
> As others have pointed out, the usual way for using format-patch is to
> create an mbox that you then pull into your MUA (e.g., I do "git
> format-patch --stdout origin >mbox; mutt -f mbox").
> 
> However, sometimes it is desirable to cut and paste, either because it
> is inconvenient to bring the message into your MUA this way, or if you
> are just putting a commit into an email you have already started
> writing.
> 
> I was going to suggest a "--paste" option for format-patch which would
> produce a nicer output for cutting and pasting,

You still have to move the subject line where it belongs, so I think the 
value of --paste is limited.  You do have to pay attention anyway (for 
example when imitating how other people do it), so I think the current 
state should be fine.

Ciao,
Dscho
