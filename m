From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 18:54:28 -0800
Message-ID: <7vabolzyjf.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<7v63za4yic.fsf@gitster.siamese.dyndns.org>
	<7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
	<20071207213414.GA11688@coredump.intra.peff.net>
	<20071207213541.GA11723@coredump.intra.peff.net>
	<7vtzmuyyc3.fsf@gitster.siamese.dyndns.org>
	<20071207215514.GA11784@coredump.intra.peff.net>
	<7vprxiyxfj.fsf@gitster.siamese.dyndns.org>
	<20071207220738.GA23535@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 03:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0pqK-0000eT-5N
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbXLHCyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXLHCyn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:54:43 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:51195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbXLHCyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:54:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68FE94AB4;
	Fri,  7 Dec 2007 21:54:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B444AB3;
	Fri,  7 Dec 2007 21:54:31 -0500 (EST)
In-Reply-To: <20071207220738.GA23535@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Dec 2007 17:07:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67500>

Jeff King <peff@peff.net> writes:

> Right, which leads to my (perhaps subtle) point that the builtin alias
> hack is just what you said elsewhere: a cute hack. IOW, I am slightly
> NAKing inclusion of it in master (OTOH, I really don't see what it could
> _hurt_, so maybe somebody could find a use for it that we didn't think
> of).

Heh, since when one can NAK one's own change? ;-)

Yeah, I am inclined to let it rot in 'next' until 1.5.4 ships and then
decide.  Either people will forget about it (in which case we can
revert) or enough people would want it and give some magic smarts to
it.
