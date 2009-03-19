From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Gnome chose Git
Date: Fri, 20 Mar 2009 00:17:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200017340.10279@pacific.mpi-cbg.de>
References: <877i2lbvt7.fsf@iki.fi>  <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>  <49C24D9B.1060301@drmicha.warpmail.net>  <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>  <20090319151610.GO23521@spearce.org> 
 <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>  <20090319201405.GD17028@coredump.intra.peff.net>  <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com>  <20090319214317.GU23521@spearce.org>  <20090319214432.GV23521@spearce.org>
 <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1246335393-1237504681=:10279"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRUZ-0002Dy-3T
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbZCSXQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZCSXQI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:16:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:42656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753043AbZCSXQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:16:06 -0400
Received: (qmail invoked by alias); 19 Mar 2009 23:16:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 20 Mar 2009 00:16:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18H8xUn7jkHA0EjlBuAsBhoXooHakVmSdHkBijFaL
	py1DBC/WCB6eAb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113858>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1246335393-1237504681=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 19 Mar 2009, demerphq wrote:

> 2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> >> demerphq <demerphq@gmail.com> wrote:
> >> > Outside of parsing the reflog directly, (which feels wrong and dirty
> >> > to me), how does one find out the times that a reflog entry was
> >> > created?
> >> >
> >> > The closest thing i could find was git log -g, but that shows the time
> >>
> >>   git reflog -g branch@{now}
> >
> > Arrgh, I of course actually meant
> >
> >    git log -g branch@{now}
> >
> >> the @{now} suffix is the magic to make it show the time.
> 
> Ah! Much nicer! Thanks.
> 
> Is there by any chance any way to set the date format it uses to
> something more suitable for machine processing?

git log --date=$FORMAT -g branch

Hth,
Dscho

--8323328-1246335393-1237504681=:10279--
