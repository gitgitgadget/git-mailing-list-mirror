From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 13:24:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807221323440.3391@eeepc-johanness>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <7vljzur5wd.fsf@gitster.siamese.dyndns.org> <20080722044359.GB20787@sigill.intra.peff.net>
 <20080722045223.GC20787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLFz6-0005Fo-Ls
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 13:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYGVLXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYGVLXi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 07:23:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:41609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751503AbYGVLXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 07:23:37 -0400
Received: (qmail invoked by alias); 22 Jul 2008 11:23:35 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp025) with SMTP; 22 Jul 2008 13:23:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O2pNfwpHO+sQel6A2K06OKWwFTuGLIB1pO9cicG
	SXDNduhDtfoSrd
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080722045223.GC20787@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89486>

Hi,

On Tue, 22 Jul 2008, Jeff King wrote:

> On Tue, Jul 22, 2008 at 12:44:00AM -0400, Jeff King wrote:
> 
> > We could also swap the parent/child relationship, and have the pager 
> > as child. But I assume that it is done the way we have it because 
> > otherwise the shell gets confused about when the command ends (i.e., 
> > we want it to run until pager completion). I didn't test, though.
> 
> Hmm, it looks like the MINGW32 codepath already _does_ spawn in that 
> order, but has a "wait_for_child" atexit handler. I wonder if there is a 
> reason all platforms can't use that trick (though the mingw approach 
> uses run_command, which makes it harder to do the "wait for input before 
> starting less" trick).

I recently suggested exactly that already, to catch SIGSEGVs in the paged 
process, amongst other things.

Ciao,
Dscho
