From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 22:45:31 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182238470.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iihrt-0003Nt-3H
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963AbXJSCpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758673AbXJSCpe
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:45:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12220 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687AbXJSCpd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:45:33 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ5006EN0ZVT161@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 22:45:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019021255.GD3290@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61614>

On Thu, 18 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 08:45:27PM -0400, Shawn O. Pearce wrote:
> 
> > Recently I was referred to the Grammar Police as the git-pack-objects
> > progress message 'Deltifying %u objects' is considered to be not
> > proper English to at least some small but vocal segment of the
> > English speaking population.  Techncially we are applying delta
> > compression to these objects at this stage, so the new term is
> > slightly more acceptable to the Grammar Police but is also just
> > as correct.
> 
> Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
> but that's how languages change: saying "delta compressing" all the time
> will get awkward, so people invent a new word using existing rules to
> explain a common phenomenon.

Yet that progress display isn't solely about "delta compressing".  It 
also includes the search for best object match in order to keep the 
smallest delta possible.

I'd like to add my own boo, but since I'm not a native speaker I won't 
argue too much.


Nicolas
