From: Jeff King <peff@peff.net>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 11:20:02 -0500
Message-ID: <20071128162002.GB20308@coredump.intra.peff.net>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com> <3AAC5548-A9AC-4236-B1F7-5CFDE11B52C4@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPeH-0006cd-2W
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148AbXK1QUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXK1QUH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:20:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbXK1QUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:20:05 -0500
Received: (qmail 11767 invoked by uid 111); 28 Nov 2007 16:20:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 11:20:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 11:20:02 -0500
Content-Disposition: inline
In-Reply-To: <3AAC5548-A9AC-4236-B1F7-5CFDE11B52C4@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66366>

On Tue, Nov 27, 2007 at 11:07:29PM -0500, Geert Bosch wrote:

> I have always wondered why refs and tags are not
> in the regular object store. In a way, there
> should be just one root pointer (SHA1) pointing
> to a tree with refs, etc.

Assuming that they also retain the "having an object implies having all
of the objects it points to" property, then it makes it hard to talk
about subsets or single refs. If I fetch from you and you communicate
your repo state as some hash, then I am stuck getting _all_ of your
refs to complete this property.

-Peff
