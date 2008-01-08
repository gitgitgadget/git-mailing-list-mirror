From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 11:54:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801081152360.10101@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman>
 <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se> <20080108110757.GB18087@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 12:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCD3M-0001Ew-OP
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYAHLzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 06:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYAHLzF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:55:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:50648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751176AbYAHLzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:55:02 -0500
Received: (qmail invoked by alias); 08 Jan 2008 11:55:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 08 Jan 2008 12:55:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ILV49OLGIUTTc9gjRDV+IxrgrFcuqqiv5U2mvHn
	c/py2a4H+I0akf
X-X-Sender: gene099@racer.site
In-Reply-To: <20080108110757.GB18087@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69868>

Hi,

On Tue, 8 Jan 2008, Jeff King wrote:

> On Tue, Jan 08, 2008 at 11:56:00AM +0100, Peter Karlsson wrote:
> 
> > If I occasionally need to do a
> > 
> >  git add -kb binary.txt
> > 
> > to flag a file explicitely, that's a small price to pay for everything 
> > else to work out of the box.
> 
> For you, perhaps, since you apparently infrequently commit binary files 
> and derive some benefit from CRLF conversion. But please bear in mind 
> that there are people on the other end of the spectrum who want the 
> opposite (i.e., who could care less about CRLF, but _do_ have binary 
> files).

Do not forget the people who say that git is a content tracker (as opposed 
to a content munger).  Git was really intended as a tracker of octet 
strings which are organised in tree structures, and where you can have 
revisions over those tree structures.

That is the beauty of git: it keeps simple things simple.  Now, for some, 
this is a curse ;-)

Ciao,
Dscho
