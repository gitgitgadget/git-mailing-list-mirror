From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] prune: heed --expire for stale packs, add a test
Date: Tue, 05 Feb 2008 15:13:27 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802051512370.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
 <alpine.LSU.1.00.0802052005200.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Steven Tweed <d.s.tweed@reading.ac.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUB7-0002MY-60
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167AbYBEUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759306AbYBEUN3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:13:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47786 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759167AbYBEUN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:13:28 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVS00MVV867IID0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Feb 2008 15:13:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802052005200.8543@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72688>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> 
> Follow the same logic as for loose objects when removing stale packs: they
> might be in use (for example when fetching, or repacking in a cron job),
> so give the user a chance to say (via --expire) what is considered too
> young an age to die for stale packs.
> 
> Also add a simple test to verify that the stale packs are actually
> expired.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Nicolas Pitre <nico@cam.org>


Nicolas
