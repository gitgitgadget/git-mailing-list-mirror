From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Mon, 31 Aug 2009 01:05:54 -0400
Message-ID: <20090831050554.GA17197@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
 <20090830095509.GB30922@coredump.intra.peff.net>
 <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
 <20090831042724.GA16646@coredump.intra.peff.net>
 <7vljl0lgms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 07:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhz5h-00025e-5O
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 07:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbZHaFFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 01:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbZHaFFz
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 01:05:55 -0400
Received: from peff.net ([208.65.91.99]:41488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269AbZHaFFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 01:05:55 -0400
Received: (qmail 20903 invoked by uid 107); 31 Aug 2009 05:06:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 01:06:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 01:05:54 -0400
Content-Disposition: inline
In-Reply-To: <7vljl0lgms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127460>

On Sun, Aug 30, 2009 at 10:03:07PM -0700, Junio C Hamano wrote:

> >   - "-f" is kind of vague. Would people expect it to force aspects of
> >     the stash? Should it be "--intent-as-empty"?
> 
> I am not sure if asking for positive confirmation with "-f" is even worth
> it.  As you pointed out in your earlier message, which prompted me to
> respond with a patch, when this codepath is exercised, the user is in a
> rush, and I do not see what else the user would want to do other than
> including it in the stash by rerunning with -f.

I guess it was just to mitigate my fear that we are somehow creating a
stash that will confuse people when they apply it. But really that fear
is probably unjustified.

-Peff
