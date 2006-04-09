From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 09 Apr 2006 13:40:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604091333140.2215@localhost.localdomain>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk>
 <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 19:40:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSdtc-0003vi-Cb
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 19:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWDIRkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 13:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDIRkQ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 13:40:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35741 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750823AbWDIRkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 13:40:15 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXG00F91UF2WXG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Apr 2006 13:40:14 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Peter Eriksen <s022018@student.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18553>

On Sun, 9 Apr 2006, Nicolas Pitre wrote:

> On Sun, 9 Apr 2006, Peter Eriksen wrote:
> 
> > Greetings Gitlings,
> > 
> > I've been trying to implement an alternative algorithm
> > for diff_delta().  I'm getting close to something that
> > works, but now I'm stuck!
> 
> Nothing outside diff-delta.c and patch-delta.c is aware of the delta 
> data format.  So if your version is meant to be a transparent 
> replacement then it should pass all tests.  If it doesn't then it is 
> broken.
> 
> To help you play around you could try the test-delta utility (make 
> test-delta to build it).
> 
> So:
> 
> 	test-delta -d file1 file2 delta_file
> 	test-delta -p file1 delta_file file3
> 	cmp file2 file3
> 
> You should always have file3 identical to file2.

Out of curiosity I just tried your diff-delta version with test-delta 
and it produced a segmentation fault on the first attempt.

It also has lots of compilation warnings.


Nicolas
