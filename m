From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 17:37:20 -0500
Message-ID: <20071128223720.GA13298@coredump.intra.peff.net>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org> <20071128194159.GA25977@midwinter.com> <20071128194919.GC11396@coredump.intra.peff.net> <7vprxu3urt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVXM-0002YV-4U
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXK1WhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXK1WhY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:37:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2062 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbXK1WhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:37:23 -0500
Received: (qmail 14746 invoked by uid 111); 28 Nov 2007 22:37:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 17:37:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 17:37:20 -0500
Content-Disposition: inline
In-Reply-To: <7vprxu3urt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66444>

On Wed, Nov 28, 2007 at 01:49:42PM -0800, Junio C Hamano wrote:

> > Hrm, this is going to have nasty conflicts with 'next', which already
> > does the remote ref matching. I think the best way to implement this
> > would probably be on top of the jk/send-pack topic in next, and add a
> > new REF_STATUS_REMOTE_CHANGED status type.
> 
> I think Jeff is referring to sp/refspec-match (605b4978).

No, I was actually referring to the jk/send-pack topic. I had thought it
graduated to master, but since Steven's work was based on a much older
version (e.g., with send-pack.c rather than builtin-send-pack.c), I
assumed it had not graduated and didn't confirm.

So let me amend my comment to "base this on a more recent master...".

-Peff
