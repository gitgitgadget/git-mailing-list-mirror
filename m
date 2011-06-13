From: Peter Kleiweg <pkleiweg@xs4all.nl>
Subject: Re: file mode
Date: Mon, 13 Jun 2011 16:25:41 +0200
Organization: -= de Laatste Huismus =-
Message-ID: <alpine.DEB.1.10.1106131624120.4221@localhost>
References: <alpine.DEB.1.10.1106122055210.6124@localhost> <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com> <20110613053814.GA2680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 16:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW87f-0007oj-Hf
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 16:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab1FMO2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 10:28:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:54249 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab1FMO2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 10:28:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QW87U-0007iq-GV
	for git@vger.kernel.org; Mon, 13 Jun 2011 16:28:00 +0200
Received: from pebbe.xs4all.nl ([80.101.76.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 16:28:00 +0200
Received: from pkleiweg by pebbe.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 16:28:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pebbe.xs4all.nl
X-X-Sender: peter@localhost
In-Reply-To: <20110613053814.GA2680@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Accept-Language: nl,af,da,de,en,ia,nds,no,sv,fr,it
X-Face: "K~X:~!ydgSdjNy;]_+BCb\OM^pqyg_q*Le84$l46M\-mL=.^,L4B}bDK>`o#r4_>O*
X-Mailer: Alpine 1.10 (DEB 962 2008-03-14), Linux 2.6.18-6-686, i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175708>

Jeff King schreef op de 13e dag van de zomermaand van het jaar 2011:

> On Sun, Jun 12, 2011 at 07:12:42PM +0000, Michael Witten wrote:
> 
> > On Sun, Jun 12, 2011 at 18:57, Peter Kleiweg <pkleiweg@xs4all.nl> wrote:
> > > I added a file that has file mode 600. When I do a check-out,
> > > the file comes with mode 644. Is this supposed to happen? Then
> > > how do I control what permissions files have?

> We could add in a config option to respect file modes, but it has
> generally been seen as not worthwhile. It solves only a part of the
> general metadata problem, as it omits owner and group names or ids, as
> well as extended metadata like ACLs.

I see your point. 


 
> If modes are important to you, the suggested fixes are one of:

Thanks. This is really helpfull.



-- 
Peter Kleiweg
http://pkleiweg.home.xs4all.nl/
