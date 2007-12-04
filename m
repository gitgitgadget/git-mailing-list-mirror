From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-add--interactive works only in top level
Date: Tue, 4 Dec 2007 11:48:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041148310.27959@racer.site>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
 <7vwsrv9fos.fsf@gitster.siamese.dyndns.org> <4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU>
 <7vmysr9dxg.fsf@gitster.siamese.dyndns.org> <9AADB5DF-15FA-4A5F-BF4B-509135E486B6@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Reid Barton <rwbarton@MIT.EDU>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 12:49:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzWHb-0006pa-Vd
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 12:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbXLDLt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 06:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXLDLt2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 06:49:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:41763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753357AbXLDLt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 06:49:27 -0500
Received: (qmail invoked by alias); 04 Dec 2007 11:49:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 04 Dec 2007 12:49:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X6dtjvruX1b2URVQetcANw1zpQUut7fEqLrKBxy
	jeVwYjrsO/YOIf
X-X-Sender: gene099@racer.site
In-Reply-To: <9AADB5DF-15FA-4A5F-BF4B-509135E486B6@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67037>

Hi,

On Tue, 4 Dec 2007, Wincent Colaiuta wrote:

> El 4/12/2007, a las 7:22, Junio C Hamano escribi?:
> 
> > Reid Barton <rwbarton@MIT.EDU> writes:
> > 
> > > I understand that programs such as git-add--interactive will be 
> > > moved out of the executable path not too long from now, which will 
> > > also ameliorate the situation.
> > 
> > Honestly, there is nothing to ameliorate.  We do not even document 
> > git-add--interactive on purpose.
> > 
> > Once I saw somebody who somehow got a root account on a shared UNIX 
> > box and tryed running everything he found under /sbin one after 
> > another without understanding what he was doing.  Needless to say, the 
> > box did not last too long.  Somehow that "tab completion" comment 
> > reminds of him.
> 
> Here he have two options: blame the user for his/her stupidity, or look 
> at this a UI problem and try to make the UI "idiot proof".
> 
> In this particular case I see no impediment to favouring the second 
> option, because we're not talking about making changes that would make 
> Git less powerful or useful for "non-idiots", "power users" or "real 
> men" (whatever you want to call them). In other words, we are not 
> talking about "dumbing down" Git for the sake of the ignorant. This is 
> an opportunity to polish the UI in the same way that we polish the 
> internal pack format.

You know, without patches you will not convince me ;-)

Ciao,
Dscho
