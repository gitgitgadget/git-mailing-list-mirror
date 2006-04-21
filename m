From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 23:07:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604202256510.2215@localhost.localdomain>
References: <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org>
 <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
 <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
 <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060421012029.GB819@spearce.org>
 <Pine.LNX.4.64.0604202213470.2215@localhost.localdomain>
 <20060421024012.GA1213@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 05:07:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWlzR-0000wV-Gi
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 05:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDUDHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 23:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDUDHW
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 23:07:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65079 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932216AbWDUDHV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 23:07:21 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY100FJWY060621@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 23:07:18 -0400 (EDT)
In-reply-to: <20060421024012.GA1213@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19017>

On Thu, 20 Apr 2006, Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > With the patch above the Linux kernel pack is 0.3% smaller with 1% more 
> > CPU usage.  But like for the diff-delta hash list limiting code this 
> > small overhead is certainly a good compromize to avoid big degradations 
> > in some other cases.
> 
> Hmm.  See the email I just sent. I was seeing a good 10% increase
> in my own tests on a Linux kernel repository.  But I guess I can
> hope that my test was flawed somehow and it really is closer to a 1%
> increase in running time, making it more likely that the above fix
> makes it into GIT.

Well, I repeated the kernel run and this time it took 2.5% more CPU with 
the patch.

But the thing is that I get a +/- 1% difference between successive runs.  
So while the patch does add a certain overhead, it appears to be in the 
same range as noise here.


Nicolas
