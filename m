From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 05 Feb 2008 20:22:57 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802052021250.2732@xanadu.home>
References: <20080202122135.GA5783@code-monkey.de>
 <20080203030054.GA18654@coredump.intra.peff.net>
 <20080203043310.GA5984@coredump.intra.peff.net>
 <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
 <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
 <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
 <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802052228280.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMZ17-0005AM-HA
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbYBFBXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755765AbYBFBXT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:23:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39430 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbYBFBXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:23:18 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVS00DR0MI9NQB1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Feb 2008 20:22:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802052228280.8543@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72743>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> In our case, this would mean that the revision walker should realise that 
> a child whose date is not older than its parent commit must be wrong.  And 
> just take the parent's date instead (but maybe only for the purpose of 
> limiting).

Only for the committer's date of course.  Author's date might be 
completely random.


Nicolas
