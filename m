From: Nicolas Pitre <nico@cam.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 10:48:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608281045590.3683@localhost.localdomain>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org>
 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
 <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 16:49:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHiQ6-0004Sw-6V
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 16:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWH1Osy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 10:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWH1Osy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 10:48:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33459 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751042AbWH1Osx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 10:48:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4P00CLNQHGC480@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Aug 2006 10:48:52 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26160>

On Sun, 27 Aug 2006, Linus Torvalds wrote:

> 
> 
> On Mon, 28 Aug 2006, Nicolas Pitre wrote:
> > 
> > Good job indeed.  Oh and you probably should not bother trying to 
> > deltify commit objects at all since that would be a waste of time.
> 
> It might not necessarily always be a waste of time.
[...]
> It's probably not worth doing for the fast importer unless it just 
> happens to fall out of the code very easily.

... which is what my comment was all about.


Nicolas
