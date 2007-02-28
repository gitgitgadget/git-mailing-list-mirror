From: Nicolas Pitre <nico@cam.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 20:48:44 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272040050.29426@xanadu.home>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org>
 <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
 <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702271643080.12485@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702272004370.29426@xanadu.home>
 <Pine.LNX.4.64.0702271719300.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMDw1-0000o9-5s
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXB1Bsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXB1Bsq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:48:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63110 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXB1Bsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:48:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE500GOSH18AJH3@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 20:48:44 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702271719300.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40872>

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 27 Feb 2007, Nicolas Pitre wrote:
> > 
> > /me wonders why Linux wasn't written in C++ with overloaded operators...
> 
> Actually, there was a short while that we tried it.

I know.  Amusing piece of history.

> Overloading of operators wouldn't be very useful, though: it really only 
> pays in either real math (where having "+" etc do the right thing for 
> complex numbers/vectors/matrices/whatever is totally unambiguous and just 
> makes code a lot more readable) or with really trivial stuff (ie "+" for 
> string concatenation).

Well...   We could have >> and << to replace memcpy(), copy_to_user(), 
copy_from_user(), and select the appropriate method depending on whether 
one is a user space pointer.

Or spin_lock++ and spin_lock--.

Or written_data >> file >> filesystem, replacing all fops methods with 
operators as well.

;-)

> Outside of math and really trivial stuff, it's just a horribly bad idea, 
> because it just makes for subtle and hard to understand code.

Indeed.  Well it can make the intent of the code clearer but certainly 
not its implementation.


Nicolas
