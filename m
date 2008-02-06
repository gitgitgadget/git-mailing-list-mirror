From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write
 failures
Date: Wed, 06 Feb 2008 15:16:22 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802061511440.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
 <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
 <alpine.LFD.1.00.0802061420510.2732@xanadu.home>
 <e1dab3980802061202i39c42432k4dd9f95560a7ea62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Steven Tweed <d.s.tweed@reading.ac.uk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqhe-0005Zc-OU
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYBFUQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbYBFUQY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:16:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48917 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbYBFUQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:16:23 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVU001FL2ZACM30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 15:16:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980802061202i39c42432k4dd9f95560a7ea62@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72842>

On Wed, 6 Feb 2008, David Tweed wrote:
> On Feb 6, 2008 7:31 PM, Nicolas Pitre <nico@cam.org> wrote:
> > This is uncommon to have a prune occurring at the same time as a fetch,
> > but the --expire argument is there if for example you do a prune from a
> > cron job but still want to be safe by giving a grace period to garbage
> > files which might not be so after all.
> 
> Ah, I hadn't realised this was an intended usage of --expire. Since as
> you note there's no way to tell an abandoned tmp pack from one that's
> in the process of being written, following expire is probably
> necessary for safety. I'll look at adding support for that.

Did you miss Johannes ' patch?  He posted it yesterday and you were even 
CC'd. It did exactly that on top of yours already.


Nicolas
