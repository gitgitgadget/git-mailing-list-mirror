From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Sat, 4 Feb 2012 01:27:12 -0500
Message-ID: <20120204062712.GA20076@sigill.intra.peff.net>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
 <20120203120657.GB31441@sigill.intra.peff.net>
 <7v7h03odyo.fsf@alter.siamese.dyndns.org>
 <20120203212604.GA1890@sigill.intra.peff.net>
 <7vr4ybmvrq.fsf@alter.siamese.dyndns.org>
 <20120203215507.GB3472@sigill.intra.peff.net>
 <7vipjnmt8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZ5x-00037u-9b
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab2BDG1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:27:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57301
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2BDG1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:27:15 -0500
Received: (qmail 6289 invoked by uid 107); 4 Feb 2012 06:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 01:34:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 01:27:12 -0500
Content-Disposition: inline
In-Reply-To: <7vipjnmt8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189849>

On Fri, Feb 03, 2012 at 02:45:25PM -0800, Junio C Hamano wrote:

> > Nice. I was going to suggest a wrapper like "write_sh_script" so you
> > didn't have to spell out $SHELL_PATH, but I think the auto-detection
> > makes sense (and falling back to shell makes even more sense, as that
> > covers 99% of the cases anyway).
> 
> Let's not over-engineer this and stick to the simple-stupid-sufficient.
> 
> Something like this?

Here it is as patches with commit messages.  I don't think it's worth
doing a mechanical conversion of the whole test suite to write_script.

  [1/2]: tests: add write_script helper function
  [2/2]: t0300: use write_script helper

-Peff
