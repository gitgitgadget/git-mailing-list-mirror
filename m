From: Nicolas Pitre <nico@cam.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 16:27:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511171622450.14287@localhost.localdomain>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 22:32:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrI0-0001GK-Ho
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVKQV1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKQV1Z
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:27:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58859 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751254AbVKQV1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:27:25 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IQ4000ZKBLNIJS0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Nov 2005 16:27:24 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12153>

On Thu, 17 Nov 2005, Linus Torvalds wrote:

> NOTE! The parsing is strictly sequential, so if you do
> 
> 	"one day before last thursday"
> 
> it will _not_ do what you think it does. It will take the current time, 
> subtract one day, and then go back to the thursday before that.

Maybe if you applied the different time units in decreasing size that 
would do the trick?  e.g. months have precedence over weeks, weeks over 
weekdays, weekdays over days, etc.


Nicolas
