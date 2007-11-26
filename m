From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 16:39:23 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261635570.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <858x4l2apc.fsf@lola.goethe.zz>
 <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
 <Pine.LNX.4.64.0711262124411.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwlg7-0001sf-Ht
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbXKZVjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbXKZVjZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:39:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55157 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbXKZVjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:39:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400ANYUTNRZD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 16:39:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711262124411.27959@racer.site>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66132>

On Mon, 26 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 26 Nov 2007, Nicolas Pitre wrote:
> 
> > On Mon, 26 Nov 2007, David Kastrup wrote:
> > 
> > > Get rid of plumbing at the command line level.
> > 
> > We can't get rid of plumbing.  It is part of Git probably forever and is 
> > really really convenient for scripting in any language you want.
> 
> I agree, but that's not even the complete truth.  Git would be not even 
> half as useful as it is without its scriptability.

Sure, but this is missing the point.

The issue at hand is about the fact that way too many Git commands are 
to be found in the default command path.  Diverging on whether or not 
plumbing is useful is the wrong question.


Nicolas
