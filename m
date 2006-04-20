From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 14:24:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
References: <20060420133640.GA31198@spearce.org>
 <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 20:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWdpP-0005Oo-Jn
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 20:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWDTSY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDTSY3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 14:24:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36643 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751003AbWDTSY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 14:24:28 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY100A189SRC0I0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 14:24:27 -0400 (EDT)
In-reply-to: <20060420175554.GH31738@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18988>

On Thu, 20 Apr 2006, Shawn Pearce wrote:

> The more that I think about it the more it seems possible that the
> pathname hashing is what may be causing the problem.  Not only did
> bisect point to 1d6b38cc76c348e2477506ca9759fc241e3d0d46 but the
> directory which contains the bulk of the space has many files with
> the same name located in different directories:
[...]

But the bad commit according to your bisection talks about "thin" packs 
which are not involved in your case.  So something looks fishy with that 
commit which should not have touched path hashing in the non-thin pack 
case...  I think...


Nicolas
