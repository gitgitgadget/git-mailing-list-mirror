From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 17:44:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701311742370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
 <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C0C4DF.C0EB4495@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIZM-00023s-Fm
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbXAaQoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXAaQoV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:44:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:56346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030264AbXAaQoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:44:20 -0500
Received: (qmail invoked by alias); 31 Jan 2007 16:44:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 31 Jan 2007 17:44:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C0C4DF.C0EB4495@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38276>


Hi,
On Wed, 31 Jan 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > I also verified that with my Tcl/Tk installation on MacOSX, a patch like
> > this was needed. IIRC Paulus argued that I should get a native TclTk,
> > which is supposed to work (though not with the paths on Cygwin, oh well).
> > 
> > Oh, and it is also needed for MinGW. But I guess it will remain unfixed.
> 
> You patch does not improve gitk under MinGW. The layout becomes less
> useful because the lower part becomes too high, so that the Search bar
> and some part of the patch + file list windows is not visible. :(

Ah yes, I don't use gitk all that often, and I did not realize that there 
was a search bar. Still, I think Mike's patch is too verbose, i.e. it is 
not minimal enough ;-)

Ciao,
Dscho
