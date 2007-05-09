From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 12:18:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705091210570.18541@iabervon.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 18:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlosW-00082o-Cl
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXEIQSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbXEIQSz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:18:55 -0400
Received: from iabervon.org ([66.92.72.58]:3961 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbXEIQSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:18:54 -0400
Received: (qmail 25633 invoked by uid 1000); 9 May 2007 16:18:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 16:18:53 -0000
In-Reply-To: <Pine.LNX.4.64.0705091447110.4167@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46737>

On Wed, 9 May 2007, Johannes Schindelin wrote:

> > To be honest, I wouldn't even be *thinking* about the endianity of SHA-1
> > octet representation (you don't usually really deal with the hash as
> > with a number, so expecting to have it in native endianity is not very
> > natural; you just deal with it as with a data blob) and the
> > "(big-endian)" would only confuse me and get me thinking about "huh, do
> > they swap the bytes, or wait, they don't, ...?!".
> > 
> > But that's maybe just me.
> 
> But then, maybe it is just me? I got it completely wrong the first time, 
> fully expecting the calculations to be carried out in host endianness for 
> performance reasons.

I think the Mozilla implementation carries out calculations in host 
endianness, and transfers data from the input to the internal state and 
from the internal state to the final hash with shifts and masks.

Which calculations are you seeing that involve byte order?

	-Daniel
*This .sig left intentionally blank*
