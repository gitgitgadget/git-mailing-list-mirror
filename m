From: Nicolas Pitre <nico@cam.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 13:54:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701131340040.2577@xanadu.home>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <7virfct737.fsf@assigned-by-dhcp.cox.net>
 <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
 <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
 <20070112210403.GB6262@xp.machine.xx>
 <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <87y7o6x60w.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 19:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5o1c-0007Cb-QG
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 19:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbXAMSyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbXAMSyW
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 13:54:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61374 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422750AbXAMSyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 13:54:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBT00021LUKLDE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Jan 2007 13:54:20 -0500 (EST)
In-reply-to: <87y7o6x60w.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36765>

On Sat, 13 Jan 2007, Carl Worth wrote:

> Anyway, did I succeed in pointing out why some of us think that the
> "add a new path (with content) to the index" and the "update content
> for existing path" really shouldn't be mixed up in the same "add"
> command?

Not really.

The fact is that there is no strong reason why they shouldn't.  But 
there are good reasons why they should.  The most important one being 
that the user doesn't need to bother deciding which one of the two 
commands should be used in any given situation.  And because a single 
command can cover two _technically_ different cases transparently is a 
pretty good reason for not imposing this technical issue to the user.

But remember that git-update-index is still and will always be available 
to you for fancier and more fine grained control if/when you have a 
special need for it.  This is not the case for the vast majority of 
users though and the primary user interface should reflect that.


Nicolas
