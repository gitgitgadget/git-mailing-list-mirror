From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] rehabilitate some t5302 tests on 32-bit off_t machines
Date: Thu, 15 Nov 2007 20:39:23 +0100
Message-ID: <200711152039.23978.johannes.sixt@telecom.at>
References: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home> <alpine.LFD.0.9999.0711151349480.21255@xanadu.home> <7vsl3749hp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IskYx-0004Ix-FV
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 20:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760220AbXKOTj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 14:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759300AbXKOTj0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 14:39:26 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:53610 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbXKOTj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 14:39:26 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 9AF6F13B7DA;
	Thu, 15 Nov 2007 20:39:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3633D59DCF;
	Thu, 15 Nov 2007 20:39:24 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsl3749hp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65153>

On Thursday 15 November 2007 20:03, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > On Thu, 15 Nov 2007, Johannes Sixt wrote:
> >> Since you changed this test, I assume that the remaining
> >> tests that you put back failed only because this one did
> >> something wrong. If so, please mention that in the commit
> >> message.
> >
> > It did nothing wrong.  It was simply relying on the product of
> > a previous test that might still be disabled.
>
> Thanks for a fix-up and clarification.   Hannes, otherwise this
> passed in your environment?

Yes, it passes. Ack.

-- Hannes
