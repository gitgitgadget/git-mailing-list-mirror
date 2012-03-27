From: Ivan Todoroski <grnch@gmx.net>
Subject: Re: [PATCH/RFC v2 2/4] remote-curl: send the refs to fetch-pack on
 stdin
Date: Wed, 28 Mar 2012 01:20:28 +0200
Message-ID: <4F724B3C.2070702@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net> <4F715D91.5070901@gmx.net> <7v8vimj73n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:20:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfgJ-0002Ac-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2C0XT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:19:59 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:34522 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755884Ab2C0XT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:19:58 -0400
Received: (qmail invoked by alias); 27 Mar 2012 23:19:57 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.58]
  by mail.gmx.net (mp069) with SMTP; 28 Mar 2012 01:19:57 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX18lG7U/YI8l77fNCk8FJjC0KGg3aLF2zlrCL7g7ip
	tNRtsXlfDfGeiF
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7v8vimj73n.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194095>

On 27.03.2012 19:18, Junio C Hamano wrote:
> Ivan Todoroski <grnch@gmx.net> writes:
> 
>> +	strbuf_init(&preamble, 4);
> 
> Curious.
> 
> If "4" does not really matter, I would drop this and use STRBUF_INIT at
> the beginning instead.

I only put 4 because I know the strbuf will always have at least 4 
bytes, because it always includes a flush packet. It doesn't matter at 
all otherwise, I will do as you suggest.
