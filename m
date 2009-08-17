From: Nicolas Pitre <nico@cam.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 10:20:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908171008070.6044@xanadu.home>
References: <20090817072315.4314.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: bdonlan@gmail.com, johnflux@gmail.com, P@draigBrady.com,
	art.08.09@gmail.com, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md34m-000663-Mv
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbZHQOU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 10:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZHQOU2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:20:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11426 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbZHQOU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 10:20:27 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOI003OUYHYVEF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 10:20:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090817072315.4314.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126184>

On Mon, 17 Aug 2009, George Spelvin wrote:

> If it helps anyone resolve license issues, here's a from-FIPS-180-2
> implementation that's placed in the public domain.  That should be
> compatible with any license.
> 
> It uses Linus's and Artur's performance ideas, and some of Linus' macro
> ideas (in the rotate implementation), but tries to be textually different.
> Is there anything recognizable that anyone cares to clam copyright to?
> 
> It's not quite 100% finished, as I haven't benchmarked it against Linus's
> code yet, but it's functionally correct.
> 
> It's also clean with -W -Wall -Wextra.
> 
> TODO: Check if an initial copy to w[] is faster on i386 (less register
> pressure).
> 
> /*
>  * Secure Hash Algorith SHA-1, as published in FIPS PUB 180-2.
>  *
>  * This implementation is in the public domain.  Copyright abandoned.
>  * You may do anything you like with it, including evil things.
>  *
>  * This is a rewrite from scratch, based on Linus Torvalds' "block-sha1"
>  * from the git mailing list (August, 2009).  Additional optimization
>  * ideas cribbed from
>  * - Artur Skawina (x86, particularly P4, and much benchmarking)
>  * - Nicilas Pitre (ARM)

Please be careful to spell my name correctly.


Nicolas
