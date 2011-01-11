From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter
 identity
Date: Tue, 11 Jan 2011 00:34:51 -0500
Message-ID: <20110111053451.GA10094@sigill.intra.peff.net>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjx45w7g.fsf@alter.siamese.dyndns.org>
 <vpq1v4nirzz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 11 06:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcWsp-0005Ij-39
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 06:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab1AKFe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 00:34:57 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37302 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab1AKFe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 00:34:56 -0500
Received: (qmail 11317 invoked by uid 111); 11 Jan 2011 05:34:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 05:34:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 00:34:51 -0500
Content-Disposition: inline
In-Reply-To: <vpq1v4nirzz.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164908>

On Sat, Jan 08, 2011 at 11:56:00AM +0100, Matthieu Moy wrote:

> > Wouldn't it work better to just get rid of the longer form and say
> > something like:
> >
> >     ... here is how to tell your name to git (existing message) ...
> >
> >     After doing the above, run
> >
> >     	git commit --amend --reset-author
> >
> >     to fix the identity used for this commit.
> 
> I'm fine with that proposal too. I'll resend with that if no one
> objects. Probalby rewording it to

Hmm.  When I originally wrote that message, I specifically avoided using
--reset-author because I figured people would want to most immediately
fix the broken commit, and then maybe would not be too lazy to fix
things for the future. But that was just a hunch, and I don't feel
strongly about it.

I was also afraid of people blindly running the fixup command without
doing the configuration specified in the commands above. However, I
think as long as the text makes it clear that one depends on the other,
it should be OK. So something like:

> After doing this, you can fix the identity used for this commit with:
> 
>   git commit --amend --reset-author

looks fine to me.

-Peff
