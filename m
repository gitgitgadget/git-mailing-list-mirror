From: Peter Kleiweg <pkleiweg@xs4all.nl>
Subject: Re: old but persistent problem: bad line length character
Date: Wed, 8 Jun 2011 20:33:51 +0200
Organization: -= de Laatste Huismus =-
Message-ID: <alpine.DEB.1.10.1106082024250.4195@localhost>
References: <alpine.DEB.1.10.1106071832470.4175@localhost> <20110607180624.GA23752@sigill.intra.peff.net> <alpine.DEB.1.10.1106072337500.11389@localhost> <7vpqmo2wy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:37:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNd9-0001zC-IY
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab1FHShW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:37:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:37136 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875Ab1FHShV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:37:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QUNd0-0001vz-G6
	for git@vger.kernel.org; Wed, 08 Jun 2011 20:37:18 +0200
Received: from pebbe.xs4all.nl ([80.101.76.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 20:37:18 +0200
Received: from pkleiweg by pebbe.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 20:37:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pebbe.xs4all.nl
X-X-Sender: peter@localhost
In-Reply-To: <7vpqmo2wy7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Accept-Language: nl,af,da,de,en,ia,nds,no,sv,fr,it
X-Face: "K~X:~!ydgSdjNy;]_+BCb\OM^pqyg_q*Le84$l46M\-mL=.^,L4B}bDK>`o#r4_>O*
X-Mailer: Alpine 1.10 (DEB 962 2008-03-14), Linux 2.6.18-6-686, i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175420>

Junio C Hamano schreef op de 8e dag van de zomermaand van het jaar 2011:

> Peter Kleiweg <pkleiweg@xs4all.nl> writes:
> 
> > I made it read some more than 4 bytes. And this is what I get:
> >
> > {27}]0;github git-receive-pack 'pebbe/Gabmap.git'{7}
> >
> > Ah, I see! I have a wrapper set-up around ssh that sets the 
> > window title of the shell to the ssh command argument. That is 
> > what messes things up!
> >
> > OK. Fixed now.
> 
> That does not explain why you earlier said 1.4.4.4 works and more recent
> versions do not, though.

I downloaded the sources of 1.4.4.4 and compiled it. I get the 
same problem. I guess the pre-compiled version that comes from 
Debian uses /usr/bin/ssh, and when I compile it myself it 
uses the version of ssh it finds in PATH.



-- 
Peter Kleiweg
http://pkleiweg.home.xs4all.nl/
