From: Jeff King <peff@peff.net>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 16:48:46 -0400
Message-ID: <20101012204845.GA12790@sigill.intra.peff.net>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
 <20101012193204.GA8620@sigill.intra.peff.net>
 <20101012193830.GB8620@sigill.intra.peff.net>
 <AANLkTim_pjJ76J0ctSQO=eYsVtkZAgq2nhm0fskjjo+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 23:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5mi4-0003y5-EQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 23:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab0JLVsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 17:48:31 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41158 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab0JLVsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 17:48:30 -0400
Received: (qmail 26273 invoked by uid 111); 12 Oct 2010 20:48:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 12 Oct 2010 20:48:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Oct 2010 16:48:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim_pjJ76J0ctSQO=eYsVtkZAgq2nhm0fskjjo+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158882>

On Tue, Oct 12, 2010 at 02:37:50PM -0600, Chase Brammer wrote:

> Wow, I am amazed at how quick you churned that out.  I haven't
> participated in the git patch and release cycle, so forgive my
> ignorance.  Do you think that this will be released in the next
> release (1.7.3.2) ? If so, any expectations on release date?

Well, at 5 minutes it was really only 1 line of code per minute. ;)

I'm hoping that somebody else on the list who has worked in the
transport code recently can comment on whether this is the right fix.
Did you test it? Does it fix your issue?

If it seems OK, then somebody needs to submit a cleaned-up version with
commit message to Junio, who will probably cook it in "next" for at
least a few weeks, and then hopefully it would be in v1.7.3.2. He does
maintenance releases as-needed, which seems to generally be every few
weeks.

-Peff
