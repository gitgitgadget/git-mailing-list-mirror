From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 17:07:44 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805121706260.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 23:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfG8-0002XB-97
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbYELVHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbYELVHr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:07:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16728 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYELVHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:07:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0R00M3ZXCDZ4F0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 May 2008 17:07:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080512202414.GA8620@mithlond.arda.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81951>

On Mon, 12 May 2008, Teemu Likonen wrote:

> I'll send you the .git/logs directory but I'm afraid it doesn't tell
> much. There are just three files:
> 
>   .git/logs/HEAD
>   .git/logs/refs/heads/master
>   .git/logs/refs/remotes/origin/master
> 
> They containt one line for the initial clone and one line for
> the fast-forward pull.

That's what I want.  This way I should be able to reproduce your exact 
case.


Nicolas
