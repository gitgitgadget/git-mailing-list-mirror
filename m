From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 20:56:52 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702232055060.29426@xanadu.home>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240229540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5y81g4t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:57:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKm9w-0004C8-J0
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbXBXB5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933330AbXBXB5J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:57:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32238 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329AbXBXB5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:57:06 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDY00EGK2QSNLA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Feb 2007 20:56:52 -0500 (EST)
In-reply-to: <7vk5y81g4t.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40490>

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> By the way, where do you start digging from?  From all refs?
> >
> > Yes, all refs. In order of the date.
> 
> Then, another possibly useful extension is "start from this ref"
> (you can give multiple and if no such refs are given keep the
> current "from all refs" behaviour).

Can we generalize the syntax a bit more instead?

What about HEAD:/blah ?


Nicolas
