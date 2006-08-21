From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 13:55:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608211350430.3851@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
 <20060821070609.GC24054@spearce.org>
 <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
 <9e4733910608210914s1157f47eta821584928ce4dd5@mail.gmail.com>
 <Pine.LNX.4.64.0608211309270.3851@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 19:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFDzS-0007wA-4W
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 19:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWHURzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWHURzG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 13:55:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45274 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422805AbWHURzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 13:55:05 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4D0004I0FS0RP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Aug 2006 13:55:04 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0608211309270.3851@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25807>

On Mon, 21 Aug 2006, Nicolas Pitre wrote:

> If for example each object has 2 delta childs, and each of those deltas 
> also have 2 delta childs, you could have up to 39366 delta objects 
> attached to a _single_ undeltified base object.

Sorry I've got the math wrong.  That is 3582 deltas, given a 
conservative number of delta childs = 2.


Nicolas
