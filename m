From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 14:01:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608211358390.3851@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
 <20060821070609.GC24054@spearce.org>
 <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
 <9e4733910608210914s1157f47eta821584928ce4dd5@mail.gmail.com>
 <Pine.LNX.4.64.0608211309270.3851@localhost.localdomain>
 <Pine.LNX.4.64.0608211350430.3851@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 20:02:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFE6D-00017B-LB
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWHUSB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 14:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWHUSB4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 14:01:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8442 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422674AbWHUSB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 14:01:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4D000XQ0R7BQ10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Aug 2006 14:01:55 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0608211350430.3851@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25808>

On Mon, 21 Aug 2006, Nicolas Pitre wrote:

> On Mon, 21 Aug 2006, Nicolas Pitre wrote:
> 
> > If for example each object has 2 delta childs, and each of those deltas 
> > also have 2 delta childs, you could have up to 39366 delta objects 
> > attached to a _single_ undeltified base object.
> 
> Sorry I've got the math wrong.  That is 3582 deltas, given a 
> conservative number of delta childs = 2.

OK I just can't count.  That is 2046.

But since I made a fool of myself already, why not try with 3 delta 
childs for a delta depth of 10 just for fun, now that I should have it 
right.  The answer is 88572.

Anyway I hope you've got my point now.  ;-)


Nicolas
