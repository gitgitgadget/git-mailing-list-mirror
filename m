From: Jeff King <peff@peff.net>
Subject: Re: Q about the date format in "git commit --date=..." and such
Date: Mon, 7 Mar 2011 20:16:46 -0500
Message-ID: <20110308011646.GA21278@sigill.intra.peff.net>
References: <4D73B158.5040409@dirk.my1.cc>
 <20110307165448.GD11934@sigill.intra.peff.net>
 <7vzkp6zclw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwlXy-0004Ds-3C
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 02:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab1CHBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 20:16:54 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab1CHBQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 20:16:54 -0500
Received: (qmail 10297 invoked by uid 111); 8 Mar 2011 01:16:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 08 Mar 2011 01:16:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 20:16:46 -0500
Content-Disposition: inline
In-Reply-To: <7vzkp6zclw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168627>

On Mon, Mar 07, 2011 at 04:20:59PM -0800, Junio C Hamano wrote:

> > That being said, with --reset-author I have never needed --date, so I
> > don't personally care if it gets done or not.
> 
> In short, should I take that the resolution of this issue is "I didn't
> know about --reset-author and asking for --date=loose was an X-Y problem"?
> 
> I agree with you that we would not want to loosen the specification side
> (i.e. "commit --date=" as opposed to the selector side "log --since=")
> unless we absolutely have to.

It is up to Dirk to say whether it solves his particular problem or not.
But thinking on it more, --date=now does encourage a bit of a wrong
workflow. Why would you be resetting the date but _not_ taking
ownership? Maybe a reasonable situation for that exists, but I couldn't
think of one.

-Peff
