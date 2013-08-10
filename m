From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 06:28:35 -0400
Message-ID: <20130810102834.GA6237@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 10 12:28:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V86Pd-0003HA-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 12:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968560Ab3HJK2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 06:28:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:55637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968558Ab3HJK2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 06:28:40 -0400
Received: (qmail 5809 invoked by uid 102); 10 Aug 2013 10:28:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 05:28:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 06:28:35 -0400
Content-Disposition: inline
In-Reply-To: <52060EF9.2040504@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232089>

On Sat, Aug 10, 2013 at 11:59:21AM +0200, Michael Haggerty wrote:

> On 08/10/2013 08:47 AM, Jeff King wrote:
> > But I think MX records and deliverability is beside the point. Even in a
> > case where we come up with a valid, deliverable address, is that what
> > the user wants to have in their commit history for all time?
> 
> I intentionally don't set user.email in my ~/.gitconfig because I use
> different identities (on the same machine) depending on what project I
> am committing to (open-source vs. work).  After I clone a repo, I *rely*
> on Git reminding me to set user.email on my first commit, because I
> invariably forget to set it myself.  And for me, *any* universal,
> heuristically-determined email address would be wrong for me for at
> least some repos.

So if I understand your use case, then you would be even happier if
rather than giving a warning, git simply barfed and said "please set
your identity before committing"?

-Peff
