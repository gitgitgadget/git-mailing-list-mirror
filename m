From: Jeff King <peff@peff.net>
Subject: Re: * [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 13:03:56 -0500
Message-ID: <20071205180356.GA5181@coredump.intra.peff.net>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com> <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 19:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izybe-0001XW-Aq
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 19:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbXLESEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 13:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXLESEA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 13:04:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3305 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbXLESD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 13:03:59 -0500
Received: (qmail 23882 invoked by uid 111); 5 Dec 2007 18:03:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Dec 2007 13:03:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2007 13:03:56 -0500
Content-Disposition: inline
In-Reply-To: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67171>

On Tue, Dec 04, 2007 at 11:55:41PM -0800, Junio C Hamano wrote:

> Yuck.  People actually use git-clean?

I use it all the time (though never with arguments, or I probably would
have noticed this bug). I think it is coupled with the "use git status
to see what is going on" workflow that, IIRC, you don't use.

Also, nit: don't you mean "git clean"? :)

-Peff
