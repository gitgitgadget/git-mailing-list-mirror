From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Thu, 9 Oct 2008 07:32:28 -0400
Message-ID: <20081009113228.GA17523@sigill.intra.peff.net>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv> <20081008015352.GA29313@coredump.intra.peff.net> <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com> <20081009014146.GA14204@coredump.intra.peff.net> <7viqs2ovte.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kntm8-00064j-MJ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbYJILcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYJILcd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:32:33 -0400
Received: from peff.net ([208.65.91.99]:3070 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbYJILcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:32:32 -0400
Received: (qmail 28338 invoked by uid 111); 9 Oct 2008 11:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 09 Oct 2008 07:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2008 07:32:29 -0400
Content-Disposition: inline
In-Reply-To: <7viqs2ovte.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97843>

On Thu, Oct 09, 2008 at 04:24:29AM -0700, Junio C Hamano wrote:

> > This makes a lot of sense to me as a best-practice. I wonder if we
> > wouldn't do better to add a core.symlink-templates option?
> 
> AFAIR, "git init" copies symlinks in templates as symlinks, so I do not
> see why you would even want to have such an option.

Ah, I didn't realize that. In that case, yes, setting up a template
directory of symlinks makes the most sense. I think a core.template
option is still worthwhile, though.

-Peff
