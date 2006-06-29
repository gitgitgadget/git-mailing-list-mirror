From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 12:35:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291233120.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 18:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvzUT-0005k8-Il
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 18:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWF2Qfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 12:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWF2Qfi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 12:35:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14433 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750798AbWF2Qfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 12:35:38 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M00AIIRFCGDH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 12:35:37 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22872>

On Thu, 29 Jun 2006, Nicolas Pitre wrote:

> And this can be pushed even further by just including the sha1 of the 
> victim object inside the list of objects therefore computing a hash of 
> all objects (the victim and the window) for which no delta results. The 
> cache is therefore a list of hash values corresponding to bad 
> victim+window combinations.
> 
> So given my GIT repository such a cache would be 7610 * 40 = 304400 
> bytes if we stick to the full 40 bytes of sha1 to hash bad combinations.

Correction: the 40 bytes figure is for _ascii_ representation of sha1 
values.  The cache doesn't need ascii and therefore this number can be 
reduced by half.


Nicolas
