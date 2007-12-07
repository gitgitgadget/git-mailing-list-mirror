From: Jeff King <peff@peff.net>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 16:55:14 -0500
Message-ID: <20071207215514.GA11784@coredump.intra.peff.net>
References: <20071207093439.GA21896@elte.hu> <7v63za4yic.fsf@gitster.siamese.dyndns.org> <7vwsrq3iox.fsf@gitster.siamese.dyndns.org> <20071207213414.GA11688@coredump.intra.peff.net> <20071207213541.GA11723@coredump.intra.peff.net> <7vtzmuyyc3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lAb-0000tM-DE
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbXLGVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbXLGVzT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:55:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3946 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbXLGVzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:55:18 -0500
Received: (qmail 13599 invoked by uid 111); 7 Dec 2007 21:55:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 16:55:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 16:55:14 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmuyyc3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67476>

On Fri, Dec 07, 2007 at 01:44:12PM -0800, Junio C Hamano wrote:

> Well, I think "git view" should not be just "predefined alias that the
> user can override wholesale", which is what you currently have.  I think
> it can just be an example in "git config" manpage (i.e. "If you want to,
> you can alias 'view' to 'gitk' or 'gitview'") and I do not think we need
> core-side support for that.

Sure, but regular aliases already do that. The point of making it a
"builtin" alias is that we can depend on it being there. But who is
depending?

-Peff
