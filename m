From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 18:17:35 -0400
Message-ID: <20091015221735.GA26775@coredump.intra.peff.net>
References: <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <20091015221657.GC13180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyYgS-0000Dx-Fl
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762984AbZJOWSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762982AbZJOWSN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:18:13 -0400
Received: from peff.net ([208.65.91.99]:38563 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762978AbZJOWSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:18:13 -0400
Received: (qmail 10551 invoked by uid 107); 15 Oct 2009 22:21:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Oct 2009 18:21:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 18:17:35 -0400
Content-Disposition: inline
In-Reply-To: <20091015221657.GC13180@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130429>

On Thu, Oct 15, 2009 at 06:16:57PM -0400, Jeff King wrote:

> So I will buy that this is somewhat of a new idea. I am still confused
> about what happens with this, though:
> 
>   $ git checkout origin/next
>   $ git fetch ;# updates origin/next
> 
> Do we refuse the fetch? Does the user now have a working tree and index
> that doesn't match their HEAD?

OK, nevermind about this, we just crossed emails.

-Peff
