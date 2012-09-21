From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 17:13:06 -0400
Message-ID: <20120921211306.GB24134@sigill.intra.peff.net>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <m2obkz9j8t.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAXU-0004Yu-9f
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240Ab2IUVNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:13:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53734 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758078Ab2IUVNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:13:08 -0400
Received: (qmail 7525 invoked by uid 107); 21 Sep 2012 21:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 17:13:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 17:13:06 -0400
Content-Disposition: inline
In-Reply-To: <m2obkz9j8t.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206170>

On Fri, Sep 21, 2012 at 11:08:34PM +0200, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > A bigger question is: why are you setting SHELL=zsh in the first place?
> 
> SHELL is set to the login shell by default.

Yeah, sorry, I was thinking this was coming from our $SHELL_PATH
Makefile variable, and that he was setting that. The real solution is to
properly use $SHELL_PATH instead of $SHELL.

-Peff
