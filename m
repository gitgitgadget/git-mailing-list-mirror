From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Tue, 11 Dec 2007 20:45:40 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712112045040.555@xanadu.home>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
 <alpine.LFD.0.99999.0712111703380.555@xanadu.home>
 <20071212013828.GC19857@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 02:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Gfk-0004r4-Ov
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 02:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXLLBpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 20:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXLLBpn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 20:45:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25541 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbXLLBpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 20:45:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW002UYY85WE30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 20:45:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071212013828.GC19857@steel.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67982>

On Wed, 12 Dec 2007, Alex Riesen wrote:

> Nicolas Pitre, Tue, Dec 11, 2007 23:06:42 +0100:
> > 
> > Well, ignore the above.  It seems that most of stdio doesn't set errno 
> > so the above is crap.
> > 
> 
> Well, it had no reason to in this case. It's not an error.
> It does not even have to do a syscall.

Which is why I later agreed with your patch.


Nicolas
