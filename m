From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 21:38:56 -0400
Message-ID: <20071031013856.GA23274@coredump.intra.peff.net>
References: <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2Y9-0007E7-9r
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXJaBjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbXJaBjA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:39:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3120 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbXJaBi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:38:59 -0400
Received: (qmail 6441 invoked by uid 111); 31 Oct 2007 01:38:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 21:38:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 21:38:56 -0400
Content-Disposition: inline
In-Reply-To: <fg8h9l$b4n$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62773>

On Wed, Oct 31, 2007 at 01:12:37AM +0100, Jakub Narebski wrote:

> > that they are machine parseable. If you wanted to write a tool to pick
> > the URLs out of this email and clone them as git repos, then how do you
> > find the end of:
> > 
> >   http://host/git repo with spaces in the path
> You use
> 
>   'http://host/git repo with spaces in the path'

...which is a quoting mechanism, and it's not even one commonly used in
emails (i.e., people have written "parse a URL from this text" scripts
for RFC-encoded URLs, but _not_ for shell quoting).

-Peff
