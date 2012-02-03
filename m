From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Fri, 3 Feb 2012 16:29:06 -0500
Message-ID: <20120203212906.GB1890@sigill.intra.peff.net>
References: <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
 <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
 <20120203120215.GA31441@sigill.intra.peff.net>
 <7v8vkjstq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQh0-0001W9-Ic
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab2BCV3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:29:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56012
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2BCV3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:29:08 -0500
Received: (qmail 2198 invoked by uid 107); 3 Feb 2012 21:36:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 16:36:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 16:29:06 -0500
Content-Disposition: inline
In-Reply-To: <7v8vkjstq2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189804>

On Fri, Feb 03, 2012 at 09:38:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, with the ordering change, there is a technically a regression
> > in one case: a random file "foo" next to a repo "foo.git". Saying "git
> > ls-remote foo" used to prefer "foo.git", and will now select the file
> > "foo" only to fail.
> 
> Yeah, very true X-<.
> 
> > Thanks for noticing. I saw this issue when I was writing the original
> > version of the patch, and meant to revisit it and at least document it
> > in the commit message, but I ended up forgetting.
> 
> No, thanks for working on this.

What do you want to do with it, then? Take my patch and ignore the
gitfile issue, or have me refactor it more heavily? I could go either
way.

-Peff
