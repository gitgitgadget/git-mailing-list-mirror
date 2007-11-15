From: Nicolas Pitre <nico@cam.org>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 17:12:23 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711151708470.21255@xanadu.home>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
 <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismx2-0004CK-HL
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737AbXKOWM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933739AbXKOWM0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:12:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32378 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933734AbXKOWMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 17:12:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRK00J5FJ0OFYD0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Nov 2007 17:12:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65171>

On Thu, 15 Nov 2007, Linus Torvalds wrote:

> 
> 
> On Thu, 15 Nov 2007, Jason Sewall wrote:
> >
> > find . -type f -exec dos2unix {} +
> 
> Oops.
> 
> You just ran "dos2unix" on all the *git* files!

Does "dos2unix" override file access bits?  Because the object store is 
always made read-only.


Nicolas
