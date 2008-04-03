From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug in make install
Date: Thu, 3 Apr 2008 18:53:43 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804031852550.4008@racer.site>
References: <JYPQSO$FF146173479D39756CA6CA952130001D@poste.it> <alpine.LSU.1.00.0804022116080.4008@racer.site> <7vd4p75ycu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Maggi <marco.maggi-ipsu@poste.it>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 19:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhTds-00047h-N3
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 19:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbYDCRxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbYDCRxg
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 13:53:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:54941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753476AbYDCRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 13:53:35 -0400
Received: (qmail invoked by alias); 03 Apr 2008 17:53:33 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp044) with SMTP; 03 Apr 2008 19:53:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hm3BZ4I/Hh10xIfzduDe/B+AHw/kxWad6Egp7lU
	c6+610BouDEeH8
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4p75ycu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78765>

Hi,

On Wed, 2 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 2 Apr 2008, Marco Maggi wrote:
> >
> >> Do not bother me asking why I put "." in CDPATH.
> >
> > We will probably not bother.  But we mention that exporting CDPATH 
> > makes absolutely zero sense.
> 
> Often people who make this mistake do not know the difference between 
> setting it as a shell variable and exporting it to the environment, so a 
> comment to hint that there is a difference may be a helpful and friendly 
> thing to do.

Funny.  I did not even know about CDPATH until I joined the mailing list.  
So I assumed -- maybe mistakenly -- that everybody who wants to set 
CDPATH, especially to ".", knows what they are talking about.

Ciao,
Dscho
