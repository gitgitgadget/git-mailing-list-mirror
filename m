From: Jeff King <peff@peff.net>
Subject: Re: Separate default push/pull?
Date: Sat, 13 Feb 2010 06:58:34 -0500
Message-ID: <20100213115834.GA7385@coredump.intra.peff.net>
References: <m2zl3fg26j.fsf@boostpro.com>
 <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
 <20100212001417.GC21930@coredump.intra.peff.net>
 <7veikrl1m1.fsf@alter.siamese.dyndns.org>
 <20100212010549.GA23303@coredump.intra.peff.net>
 <7vvde3dmhp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGdy-0006Xr-3t
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab0BML6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 06:58:33 -0500
Received: from peff.net ([208.65.91.99]:60376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab0BML6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 06:58:32 -0500
Received: (qmail 13858 invoked by uid 107); 13 Feb 2010 11:58:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 13 Feb 2010 06:58:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2010 06:58:34 -0500
Content-Disposition: inline
In-Reply-To: <7vvde3dmhp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139790>

On Thu, Feb 11, 2010 at 09:57:54PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In a distributed setup, I don't think it is that uncommon to not want to
> > push to the place you pull from. You are generally pulling and building
> > on somebody else's work, so if there is no central repo, you will be
> > pushing to somewhere that is not where you pulled it.
> 
> You are probably right.
> 
> It still feels funny to see "git pull" and "git push" goes to different
> places, but as long as that is what the user explicitly configures, that's
> fine.

By the way, I am a little iffy on the configuration I suggested. Even
though it matches David's workflow, it seems unintuitive to me that a
"push.defaultremote" variable would override what's in "branch.*.remote".

-Peff
