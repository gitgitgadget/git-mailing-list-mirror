From: Nicolas Pitre <nico@cam.org>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 09:45:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705170941590.24220@xanadu.home>
References: <11793556363795-git-send-email-junkio@cox.net>
 <11793556371774-git-send-email-junkio@cox.net>
 <200705170539.11402.andyparkins@gmail.com>
 <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 15:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HogIx-00022J-TJ
	for gcvg-git@gmane.org; Thu, 17 May 2007 15:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbXEQNp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbXEQNp2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 09:45:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18752 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXEQNp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 09:45:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI600LECU7ODID0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 09:45:24 -0400 (EDT)
In-reply-to: <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47520>

On Wed, 16 May 2007, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > Our in-tree .gitmodules will have the same problem.  I recognise that 
> > you've mitigated that with some "confirm with the user, store in the 
> > config" hand waving; but that is just hiding the problem: the submodule 
> > URL is not something that should be version controlled; it is an 
> > all-of-history property; when it changes for revision N it changes for 
> > revision N-1, N-2, N-3, etc.  Storing it in .gitmodules implies that 
> > it's value in the past has meaning - it doesn't.
> 
> I think that depends _WHY_ the URL recorded .gitmodules are
> updated.  It would perfectly be reasonable for release #1 of an
> appliance project to bind linux 2.4 tree at kernel/ subdirectory
> while release #2 source to have 2.6 one; they come from two
> different repository URLs.  When you seek the superproject back
> to release #1, you would still want to fetch from 2.4 upstream
> if you are updating.

I don't know if the above example should make sense.  In practice that 
would mean you'll have to _replace_ the repo within the submodule 
directory which is quite different from merely checking out a different 
version of the same repository.


Nicolas
