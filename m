From: Nicolas Pitre <nico@cam.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:47:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701151143470.2577@xanadu.home>
References: <200701151301.l0FD1vPg007623@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVb-0000Gq-59
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:35 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAw-0003eK-Pl
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbXAOQrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 11:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXAOQrs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 11:47:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22053 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXAOQrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 11:47:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBX006805BMGRV0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Jan 2007 11:47:46 -0500 (EST)
In-reply-to: <200701151301.l0FD1vPg007623@laptop13.inf.utfsm.cl>
X-X-Sender: nico@xanadu.home
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36847>

On Mon, 15 Jan 2007, Horst H. von Brand wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
> 
> > Again true.  What has that to do with Git though?  Why shouldn't Git have 
> > features that let people with different methods of development from you use 
> > it?
> 
> As long as nobody else ends up paying the cost...
> 
> >     It is certainly true that signed commits /is/ a feature.  And it's a 
> > feature that some people might want.  If there isn't a technical argument 
> > against it, what does it matter?
> 
> It needs to be accomodated in the commit object format, so it means
> an(other) incompatible change there.

Not really.  Nothing prevents from having a signature block at the 
bottom of the commit message, just like signed tags.

> Need to add checking for properly
> signed commits all the way when slurping in a stream of changes. Need to
> set the whole up so it can bail out as if nothing ever happened in case one
> commit doesn't check out (this is probably easy).

... and if you don't care about the signature you may ignore it 
entirely.


Nicolas
