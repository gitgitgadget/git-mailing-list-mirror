From: Nicolas Pitre <nico@cam.org>
Subject: Re: ok for git to delete temporary packs on write error?
Date: Wed, 28 Nov 2007 10:01:42 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711281000590.9605@xanadu.home>
References: <e1dab3980711272342x7afad721m113fe21f6879a886@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxOQT-0005bM-Hs
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701AbXK1PBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbXK1PBn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:01:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27640 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXK1PBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:01:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS800FDL1QU3MB0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 10:01:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980711272342x7afad721m113fe21f6879a886@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66352>

On Wed, 28 Nov 2007, David Tweed wrote:

> Hi, I'd like to check if there's any reason in the overall design of
> git which would make deleting tmp_pack's that have suffered
> write errors a bad idea? (Before I look further into this I may be missing
> a good reason why they shouldn't be auto-deleted.)
> 
> My encounter with this comes from using an almost full
> usbstick which I discovered when I was poking around
> for other reasons several partial packs from occasions
> (separated by weeks) where gc failed. On each failure
> I'd removed stuff from the drive to clear space and done
> a successful gc but hadn't thought to
> check below .git for removable stuff so they'd just accumulated.

I'd suggest they get removed a part of the prune command.


Nicolas
