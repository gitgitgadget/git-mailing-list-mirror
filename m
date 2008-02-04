From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 04 Feb 2008 12:47:23 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802041245170.2732@xanadu.home>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
 <alpine.LSU.1.00.0802041512140.7372@racer.site>
 <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
 <alpine.LSU.1.00.0802041714560.7372@racer.site>
 <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gi mailing list <git@vger.kernel.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5QH-00061o-7O
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbYBDRr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbYBDRr0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:47:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62685 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbYBDRr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:47:26 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVQ00MMK6QZEDE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 04 Feb 2008 12:47:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72535>

On Mon, 4 Feb 2008, David Tweed wrote:

> However, I'm not familiar with what things like git-svn, cvs, etc, do.
> Given that I've seen patches adding "git gc" periodically during
> various imports, I wanted to someone who knows that area to confirm
> the patch isn't violating any assumptions.

If they're prunning old objects already, they can prune old temporary 
pack files assuming the same level of (non) risk.


Nicolas
