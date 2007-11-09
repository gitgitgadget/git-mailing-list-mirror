From: Jeff King <peff@peff.net>
Subject: Re: git rebase --skip
Date: Fri, 9 Nov 2007 12:20:15 -0500
Message-ID: <20071109172014.GA12523@sigill.intra.peff.net>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net> <7vir4cz45z.fsf@gitster.siamese.dyndns.org> <20071109032227.GA31760@sigill.intra.peff.net> <Pine.LNX.4.64.0711091056530.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXX6-0003v6-FU
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXKIRUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXKIRUU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:20:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2116 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbXKIRUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:20:18 -0500
Received: (qmail 16713 invoked by uid 111); 9 Nov 2007 17:20:17 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 Nov 2007 12:20:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2007 12:20:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711091056530.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64223>

On Fri, Nov 09, 2007 at 10:59:57AM +0000, Johannes Schindelin wrote:

> Isn't having to say "--skip" instead of "--continue" enough?  Some people 
> might complain that it's too easy to get your fingers wired to type 
> --skip.

They already have.

> Besides, after my patch to rebase on a detached HEAD, it is very easy to 
> go back to the original state and try again.

But you are losing any work you did in resolving merges.


But I don't personally have this problem, so I will stop defending those
who claim to, and let them speak for themselves (hopefully with
patches!).

-Peff
