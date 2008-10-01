From: Jeff King <peff@peff.net>
Subject: Re: Git config not expanding user home directories
Date: Tue, 30 Sep 2008 23:22:46 -0400
Message-ID: <20081001032246.GB24513@coredump.intra.peff.net>
References: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au> <48E2043A.4000501@op5.se> <m33ajhsw24.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Tom Lanyon <tom@netspot.com.au>,
	Karl Chen <quarl@quarl.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 05:24:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KksJl-0001j3-Hx
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 05:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbYJADWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 23:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYJADWt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 23:22:49 -0400
Received: from peff.net ([208.65.91.99]:3932 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbYJADWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 23:22:48 -0400
Received: (qmail 14050 invoked by uid 111); 1 Oct 2008 03:22:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 23:22:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 23:22:46 -0400
Content-Disposition: inline
In-Reply-To: <m33ajhsw24.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97187>

On Tue, Sep 30, 2008 at 04:38:46AM -0700, Jakub Narebski wrote:

> There was a patch send to git mailing list adding basic '~' support
> (I think via $ENV{HOME}), and IIRC even ~user support. I don't know
> what happened to those patches (check mailing list archive), but
> most probably it was not accepted because it didn't provide a way
> for scripts to use this functionality, for example via --path option.

There were several rounds, and I thought it was shaping up, but then
no more rounds came. I assume that Karl lost interest (or perhaps we
nitpicked him to death), but I thought at the end of the thread Junio
laid out a plan for the next revision. I guess nobody cared enough about
the feature to implement it after that (though I think I found the final
version acceptable with a minor documentation tweak, I think Junio laid
out a cleaner approach).

The last patch is here, with one of the replies from Junio giving the
aforementioned plan:

  http://mid.gmane.org/quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu

-Peff
