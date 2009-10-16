From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 20:34:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910152032050.20122@xanadu.home>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
 <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 02:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myas9-0007Ex-SY
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 02:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763338AbZJPAfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 20:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762705AbZJPAfV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 20:35:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28094 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849AbZJPAfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 20:35:20 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRL00B0S09P1WQ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 20:34:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <885649360910151647v27a15334x63fe3b6f5035dbd2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130442>

On Thu, 15 Oct 2009, James Pickens wrote:

> BTW I'm not convinced this is any better than the current UI... just
> thinking out loud.

I concur with that.

> And I find it more than a little depressing that most
> of these ideas have already been discussed almost 3 years ago (thanks Jeff
> for the pointer).

Rehashing them from time to time is not necessarily a bad idea.  Maybe 
something better might (or not) turn up this time.


Nicolas
