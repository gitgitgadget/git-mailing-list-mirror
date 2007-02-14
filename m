From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 18:45:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141843190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-773641533-1171475138=:22628"
Cc: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:45:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOCO-0002nN-MI
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbXBNRpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXBNRpl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:45:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:54789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbXBNRpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:45:40 -0500
Received: (qmail invoked by alias); 14 Feb 2007 17:45:39 -0000
X-Provags-ID: V01U2FsdGVkX1+GlQ8ZvjeGMQ8mfAChCFV4MB2YbbZ7RzouiUafVE
	BvHw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39702>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-773641533-1171475138=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The settings in /etc/gitconfig can be overridden in ~/.gitconfig,
> > which in turn can be overridden in .git/config.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > ...
> > 	Voilà.
> 
> I knew this can be done, and you are capable of doing this, but I was 
> wondering if it is a good thing to do in the first place.
> 
> Site-wide configuration for options that are potentially 
> compatibility-breaking is a bad idea on a multi-user machines, and it 
> was certainly the case back when our machines hosted many diverse set of 
> people.

That is why /etc is only writable by the administrator. And contrary to 
the Microsoft-infected world, Unix and Linux administrators are expected 
to have real know how. If they don't care about breaking things or not, 
they'll find other ways to screw you.

> But these days many machines are practically single-user and many more 
> are owned by a single group/project that share the same policy.  So in 
> such a setting, /etc/gitconfig might not be too bad.

Well, I don't use it myself (other than testing that the patch does what 
it says). Let the list decide?

Ciao,
Dscho

---1148973799-773641533-1171475138=:22628--
