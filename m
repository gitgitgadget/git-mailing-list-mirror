From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 13:41:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604201337220.2215@localhost.localdomain>
References: <20060420133640.GA31198@spearce.org>
 <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 19:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWdA6-0005OD-Nn
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWDTRls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDTRls
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:41:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29025 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751066AbWDTRlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:41:47 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY100JBH7TMB6G0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 13:41:46 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18984>

On Thu, 20 Apr 2006, Linus Torvalds wrote:

> That means that it probably _is_ the delta changes themselves (probably 
> commit c13c6bf7 "diff-delta: bound hash list length to avoid O(m*n) 
> behavior". You can try
> 
> 	git revert c13c6bf7
> 
> to see if that's it. Although Nico already showed interest, and if you 
> make the archive available to him, he's sure to figure it out.

It is not that.  With that code disabled there is still a 2x pack size.

Substituting diff-delta.c from the version in 1.2.3 doesn't solve the 
issue either.


Nicolas
