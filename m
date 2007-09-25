From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Missing strptime
Date: Tue, 25 Sep 2007 02:03:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709250202130.28395@racer.site>
References: <OF8EBEA0A7.5425E9EA-ON88257360.00812AEA-88257360.00819919@beckman.com>
 <Pine.LNX.4.64.0709250127170.28395@racer.site>
 <alpine.LFD.0.999.0709241750510.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mkraai@beckman.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 03:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZyqe-0004hv-OW
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 03:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbXIYBET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 21:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbXIYBET
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 21:04:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:55514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752462AbXIYBES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 21:04:18 -0400
Received: (qmail invoked by alias); 25 Sep 2007 01:04:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 25 Sep 2007 03:04:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19g9g5/r8NgZoGZMw6+PlBgpHgBGddSJAOMDL7Vn7
	z95mX3ilKKDQkF
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0709241750510.3579@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59084>

Hi,

On Mon, 24 Sep 2007, Linus Torvalds wrote:

> On Tue, 25 Sep 2007, Johannes Schindelin wrote:
> > 
> > The only user for strptime is convert-objects, a program that should 
> > probably move to contrib/ anyway.  It was used once, a long time ago, 
> > to convert from the old format, which hashed the compressed contents, 
> > to the current format, which hashes the contents _before_ compression.
> 
> Actually, it also changes the date format, I think.

Yes, right, that was actually why strptime() was needed.

Ciao,
Dscho
