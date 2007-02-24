From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 09:27:57 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702240922250.29426@xanadu.home>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
 <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232123110.29426@xanadu.home>
 <Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232141040.29426@xanadu.home>
 <7vbqjk17a8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LRH.0.82.0702240005270.29426@xanadu.home>
 <7v7iu80y6i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 15:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKxsg-0001UR-Ip
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 15:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbXBXO17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 09:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbXBXO17
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 09:27:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29331 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894AbXBXO16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 09:27:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDZ000PH1ILUIE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Feb 2007 09:27:57 -0500 (EST)
In-reply-to: <7v7iu80y6i.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40517>

On Sat, 24 Feb 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > How does that solve the issue with servers (currently all of them) that 
> > don't know about the new sideband?
> 
> I actually happen to consider that a non problem.
> 
> It is true that you can only prepare the client and server side
> by 1.5.1, and new clients talking to 1.5.0 or older servers
> would not be able to squelch the noise.  But that is _not_ a new
> problem anyway, and given time the server side will eventually
> be updated to 1.5.1 or later.  If anything else, it would give
> incentive to people to upgrade their servers to 1.5.1 ;-)

Well... for such a special case feature I doubt this might be such a 
great insentive.  And since locally filtering on '\r' is so simple I 
wonder what the complexity of the alternative solution really buys us.


Nicolas



> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
