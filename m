From: Jeff King <peff@peff.net>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 17:07:39 -0500
Message-ID: <20071207220738.GA23535@coredump.intra.peff.net>
References: <20071207093439.GA21896@elte.hu> <7v63za4yic.fsf@gitster.siamese.dyndns.org> <7vwsrq3iox.fsf@gitster.siamese.dyndns.org> <20071207213414.GA11688@coredump.intra.peff.net> <20071207213541.GA11723@coredump.intra.peff.net> <7vtzmuyyc3.fsf@gitster.siamese.dyndns.org> <20071207215514.GA11784@coredump.intra.peff.net> <7vprxiyxfj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lMb-0006Ws-Ug
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbXLGWHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXLGWHm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:07:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3272 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbXLGWHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:07:41 -0500
Received: (qmail 13707 invoked by uid 111); 7 Dec 2007 22:07:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 17:07:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 17:07:39 -0500
Content-Disposition: inline
In-Reply-To: <7vprxiyxfj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67480>

On Fri, Dec 07, 2007 at 02:03:44PM -0800, Junio C Hamano wrote:

> > Sure, but regular aliases already do that. The point of making it a
> > "builtin" alias is that we can depend on it being there. But who is
> > depending?
> 
> Nobody is depending.
> 
> And I think the reason nobody depends on it is because there is no
> compelling reason to.  Perhaps the behaviour is not useful enough.  It
> surely is the case for "bisect view".

Right, which leads to my (perhaps subtle) point that the builtin alias
hack is just what you said elsewhere: a cute hack. IOW, I am slightly
NAKing inclusion of it in master (OTOH, I really don't see what it could
_hurt_, so maybe somebody could find a use for it that we didn't think
of).

-Peff
