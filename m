From: Nicolas Pitre <nico@cam.org>
Subject: Re: fsck missing dangling commits that are candidate heads?
Date: Tue, 03 Apr 2007 15:53:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031551090.28181@xanadu.home>
References: <loom.20070403T213135-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYp4E-0006aO-Ah
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXDCTxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbXDCTxT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:53:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13835 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422665AbXDCTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:53:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX002WWTWQ1KI1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 15:53:14 -0400 (EDT)
In-reply-to: <loom.20070403T213135-68@post.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43647>

On Tue, 3 Apr 2007, Sergio Callegari wrote:

> Hi,
> 
> on git 1.5.0.6, I have done the following:
> 
> work work
> 
> git commit -a
> 
> git reset HEAD^         (assume a mistake)
> 
> git fsck
> 
> the last fsck shows nothing...
> Is this correct?

Yes.

> Shouldn't the latest commit (the one made unreachable by the
> reset) be reported as dangling and as a candidate branch head?
> 
> Also git lost-found misses the commit...
> But it is there... I can find it manually in the object database and tag it.

It is not lost.  Try git log -g and you'll probably find it there... at 
least until the reflog entry corresponding to it gets expired.


Nicolas
