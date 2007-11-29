From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Thu, 29 Nov 2007 09:14:53 -0500
Message-ID: <20071129141452.GA32670@coredump.intra.peff.net>
References: <20071121171235.GA32233@sigill.intra.peff.net> <7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxkAd-0005rX-42
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbXK2OO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbXK2OO4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:14:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684AbXK2OOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:14:55 -0500
Received: (qmail 19403 invoked by uid 111); 29 Nov 2007 14:14:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 09:14:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 09:14:53 -0500
Content-Disposition: inline
In-Reply-To: <7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66534>

On Wed, Nov 28, 2007 at 04:02:49PM -0800, Junio C Hamano wrote:

> I do not think this is a risky change; it won't add too many rename
> sources we did not consider traditionally (typechanges are usually rare
> event anyway).

OK. What next? Did the patch I sent make sense? Do you want a cleaned up
version with a commit message and signoff, or does it need work?

> You are copying the source to elsewhere and then completely rewriting it
> (even making it into a different type), so I do not think 'copied' is so
> unreasonable.  An alternative would be to say you renamed it and then
> created something totally different, which would also be reasonable.

I am inclined to leave it as 'copied' for now because it makes some
sense and is the least invasive change (and is independent of adding the
rename source, so we can always change it later).

-Peff
