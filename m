From: Nicolas Pitre <nico@cam.org>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 11:19:37 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803141117040.2947@xanadu.home>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
 <m3lk4ly3vy.fsf@localhost.localdomain> <20080314134205.GA19674@pe.Belkin>
 <b77c1dce0803140753w21515021u4541796d6e6934b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, geoffrey.russell@gmail.com,
	git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBiU-0000GW-VV
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYCNPT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYCNPT6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:19:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35535 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYCNPT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:19:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXQ0067C7WPF510@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Mar 2008 11:19:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <b77c1dce0803140753w21515021u4541796d6e6934b@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77236>

On Fri, 14 Mar 2008, Rafael Garcia-Suarez wrote:

> On 14/03/2008, Chris Shoemaker wrote:
> >   This way you would get exactly:
> >
> >     1---2---3---4---5---3'   <--- master <--- HEAD
> >
> >
> >  While the 3' commit has the same contents as 3, it is a new, distinct
> >   commit with its own history.  Its commit message should explain why
> >   you want to go from 5 back to the contents of 3.
> 
> Just a small question -- does that mean that 3 and 3' share the same
> tree object ?

Yes.  However, they don't share the same parent in the commit object, so 
even if the commit text was the same and the time stamps were forced to 
be the same, the commit 3' won't have the same SHA1.


Nicolas
