From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase --skip
Date: Fri, 9 Nov 2007 10:59:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091056530.4362@racer.site>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net>
 <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se>
 <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net>
 <7vir4cz45z.fsf@gitster.siamese.dyndns.org> <20071109032227.GA31760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRbP-0005c6-C3
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXKILAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXKILAL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:00:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:40615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751874AbXKILAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:00:09 -0500
Received: (qmail invoked by alias); 09 Nov 2007 11:00:05 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 09 Nov 2007 12:00:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lyZ8w2LSl/fB6RO5auZveYQwWXspftiYjme75f0
	044lyCPdzAQrbI
X-X-Sender: gene099@racer.site
In-Reply-To: <20071109032227.GA31760@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64153>

Hi,

On Thu, 8 Nov 2007, Jeff King wrote:

> So I am fine with the original patch (unconditional reset --hard), but 
> it would be nice to see the people who care submit concrete proposals 
> for such a safety valve.

Isn't having to say "--skip" instead of "--continue" enough?  Some people 
might complain that it's too easy to get your fingers wired to type 
--skip.

In that case, I might beg to differ for two reasons: --skip is definitely 
not the default operation, so the fingers do not get any chance to do 
that, and even if, they would get wired to --force --skip just as easily.

Besides, after my patch to rebase on a detached HEAD, it is very easy to 
go back to the original state and try again.

Ciao,
Dscho
