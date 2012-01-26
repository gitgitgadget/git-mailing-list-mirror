From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: minor grammar fixes for v1.7.9 release notes
Date: Thu, 26 Jan 2012 14:27:21 -0500
Message-ID: <20120126192721.GA10699@sigill.intra.peff.net>
References: <20120125222002.GA6309@sigill.intra.peff.net>
 <7vwr8e2s3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 20:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqUyp-0007iU-9b
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 20:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab2AZT10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 14:27:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45919
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2AZT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 14:27:25 -0500
Received: (qmail 28867 invoked by uid 107); 26 Jan 2012 19:34:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 14:34:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 14:27:21 -0500
Content-Disposition: inline
In-Reply-To: <7vwr8e2s3n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189161>

On Thu, Jan 26, 2012 at 11:15:08AM -0800, Junio C Hamano wrote:

> > ... (I notice you mostly include features and not bug-fixes, which I
> > assume is to keep the list to a readable length).
> 
> Actually my intention regarding fixes are:
> 
>  - never mention follow-up fixes to new topics merged since v1.7.8 at all;
> 
>  - omit mentioning trivial fixes that not many people would be bitten by
>    and actually be hurt in real life (i.e. typo in an error message); and
> 
>  - make sure as many fixes are covered in "Fixes since v1.7.8" section.
> 
> So "keep the list short" is only one-third of the motivation.

That makes sense.

I was specifically thinking of 02f7914 (remote-curl: don't pass back
fake refs), because "git push --mirror" failing is an often-reported bug
for github (and the solution is to upgrade your git client). But looking
again, I see that the fix was actually in v1.7.8.2, so it is included by
the "...and all of the fixes in the maintenance releases" text.

In general, it seems like most of our fixes go onto the maintenance
track, so the "fixes" section of a major release ends up being empty.
Which I think is a good thing.

-Peff
