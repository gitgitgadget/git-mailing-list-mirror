From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 15:19:47 +0100
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <20070303141947.GN16509@flower.upol.cz>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <7vabyweypw.fsf@assigned-by-dhcp.cox.net> <E1HNATn-0005Y6-HW@flower> <200703030357.18822.jnareb@gmail.com> <alpine.LRH.0.82.0703022223060.29426@xanadu.home> <7v3b4mbglp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 15:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNUwi-0005Y0-VC
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 15:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXCCOKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 09:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbXCCOKe
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 09:10:34 -0500
Received: from raven.upol.cz ([158.194.120.4]:37901 "EHLO raven.upol.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030224AbXCCOKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 09:10:34 -0500
Received: from smtpgate (antivir1.upol.cz [158.194.108.127])
	by raven.upol.cz (AIX4.3/8.9.3/8.9.3) with SMTP id PAA104456;
	Sat, 3 Mar 2007 15:18:53 +0100
Received: from flower (flower.upol.cz [158.194.64.22])
 by smtpgate ([158.194.108.127]:25) (F-Secure Anti-Virus for Internet Mail 6.50.60 Release)
 with SMTP; Sat, 3 Mar 2007 14:09:55 -0000
 (envelope-from <olecom@flower.upol.cz>)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1HNV5P-0006PX-BC; Sat, 03 Mar 2007 15:19:47 +0100
Content-Disposition: inline
In-Reply-To: <7v3b4mbglp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41297>

On Sat, Mar 03, 2007 at 05:29:22AM -0800, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sat, 3 Mar 2007, Jakub Narebski wrote:
> >
> >> By "conservatively" it means that it uses 'application/xhtml+xml' only when
> >> client explicitly claims that it accepts its, and it is not due to for
> >> example */* accept globbing.
> >> 
> >> So if lynx isn't working, it is its damn fault...
> >
> > I absolutely don't care.
> >
> > I use lynx, and lynx worked perfectly fine before.  So it is not lynx 
> > that broke it.  Please fix gitweb.
> 
> I think the real question is if gitweb output need to be XHTML.
> If everybody's browser is happier with text/html and we do not
> have to use things only in xhtml, sending text/html out (both as
> content-type and the actual contents) feels like the right thing
> to do from compatibility point of view.
> 

Right XML (XHTML) isn't a tags soup as HTML is, so it's better. But
"application/xml+xml+xml" is very silly, unless site's content uses
dynamics, DOM, etc. As far as i can see, gitweb is not going to have
javascript and such yet (because of compatibility/usability).

Thus, fixing of http content negotiation is needed, or whatever is used
in Perl for this.
____
