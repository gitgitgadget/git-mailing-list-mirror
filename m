From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 12:26:39 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271225330.29426@xanadu.home>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org>
 <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
 <alpine.LRH.0.82.0702270856360.29426@xanadu.home>
 <Pine.LNX.4.64.0702270816350.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 18:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM669-0001Cm-3e
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 18:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbXB0R0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 12:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbXB0R0l
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 12:26:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27844 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXB0R0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 12:26:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE4002BITSFEIN2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 12:26:39 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702270816350.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40763>

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> So to be portable, and to be safe, you really should make the error values 
> part of the enum, ie you should add a
> 
> 	OBJ_ERROR = -1,
> 
> if you want to make sure that the enum really can hold a negative number!

Fair enough.  That's what I suggested in another email, i.e. to redefine 
OBJ_BAD = -1.


Nicolas
