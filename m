From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 08:18:16 +0100
Message-ID: <474FB938.3040209@op5.se>
References: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 08:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy093-0007Oz-8d
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 08:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850AbXK3HSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 02:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbXK3HSW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 02:18:22 -0500
Received: from mail.op5.se ([193.201.96.20]:41205 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXK3HSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 02:18:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0B6D31F0807F;
	Fri, 30 Nov 2007 08:18:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tggKIrwoFkxB; Fri, 30 Nov 2007 08:18:19 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C1BA51F0805B;
	Fri, 30 Nov 2007 08:18:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071130011748.GC11683@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66621>

Jeff King wrote:
> On Thu, Nov 29, 2007 at 08:13:04PM -0500, Nicolas Pitre wrote:
> 
>>> My point is that (2) is already implemented for every program (shell or
>>> no) which understands filename completion, and there is a proposal for
>>> taking it away. I would consider that, except I haven't see any claimed
>>> advantages except that the hardlinks are awful under Windows.
>> Weren't enough complaints about Git having waaaaaaaaaaay too many 
>> commands?  Didn't those complaints come about often enough already?
>>
>> 	$ git-[tab]
>> 	Display all 135 possibilities? (y or n)
> 
> Go back and read the thread to which you are responding. I am _not_
> arguing against moving those commands to $(libexecdir) where no sane
> user will ever see them. That change addresses the issue you are talking
> about.
> 
> I _am_ arguing against removing them entirely, for those of us who want
> to go to the trouble of enabling this (by putting a non-standard entry
> into our PATH). Because the issue you are talking about will already
> have been dealt with, it is no longer a compelling reason to remove the
> hardlinks entirely.
> 
> The only reason I have heard to remove them entirely is that Windows
> doesn't properly support hardlinks, which I addressed in my other mails
> (and to which I have seen no rebuttal).
> 

It would provide a ui inconsistency between platforms. Several people
pointed that out. It's decidedly a Bad Thing.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
