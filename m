From: Nicolas Pitre <nico@cam.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 20:04:29 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272001440.29426@xanadu.home>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org>
 <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMDFL-0007vQ-De
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXB1BEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXB1BEb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:04:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbXB1BEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:04:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE5002GOEZHF0P3@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 20:04:30 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40867>

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> We should complain, and say that you can only do "no_walk" with positive 
> refs. Negative object refs really don't make any sense unless you walk 
> the obejct list (or you're "git diff" and know about ranges explicitly).
> 
> Something like this (although I don't know if my message is necessarily 
> the best possible one).

It could be improved a little.

What about "a single object specification only must be provided" 
instead?


Nicolas
