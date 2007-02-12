From: Nicolas Pitre <nico@cam.org>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 22:55:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702112251580.1757@xanadu.home>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
 <20070211225326.GC31488@spearce.org>
 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
 <9e4733910702111815g5a42989fr8042e84b291ab576@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 04:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSIf-0004Hq-4i
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 04:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbXBLDz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 22:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbXBLDz4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 22:55:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42336 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963AbXBLDzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 22:55:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDC00DZU0968ZE0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Feb 2007 22:55:55 -0500 (EST)
In-reply-to: <9e4733910702111815g5a42989fr8042e84b291ab576@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39355>

On Sun, 11 Feb 2007, Jon Smirl wrote:

> Maybe there is something wrong with the wireless-dev tree.
> It looks like someone is working on it:
> 
> jonsmirl@jonsmirl:/extra$ git clone
> git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
> Initialized empty Git repository in /extra/wireless-dev/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from
> 'git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git'
> failed.

Try with git2.kernel.org then.  It seems that git.kernel.org too often 
resolves to git1.kernel.org not sharing the load with git2.kernel.org 
appropriately.


Nicolas
