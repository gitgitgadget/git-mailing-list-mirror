From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 09 Apr 2009 13:51:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904091349150.6741@xanadu.home>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
 <20090409081443.GB17221@coredump.intra.peff.net>
 <7v3aci43g2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryQt-0002Vn-Bx
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935928AbZDIRvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935923AbZDIRvP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:51:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28077 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935917AbZDIRvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:51:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHU00B9FHL2FRU0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Apr 2009 13:51:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3aci43g2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116191>

On Thu, 9 Apr 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I disagree that it's unintrusive (and I understand that you don't think
> > it is, and that there may be others like you, but I am pointing out
> > there are others who think the opposite). But given that it's optional,
> > and it's not very much code, I don't have a strong objection. My
> > original comment was that I was dubious whether it would work: however,
> > I was thinking you would set it to a few seconds. Setting it to 60
> > seconds, I can imagine it would have an impact.
> 
> Heh, then why not make the option specify the number of _minutes_ not
> seconds to delay?  That would help clarifying what this option is meant to
> do.

Maybe only a few seconds is all that is needed in some circumstances.
For the issue I just posted, I wouldn't use it at all if the minimum 
delay was one minute.


Nicolas
