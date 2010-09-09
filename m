From: Jeff King <peff@peff.net>
Subject: Re: Tags only shown on log with --decorate?
Date: Thu, 9 Sep 2010 15:48:24 -0400
Message-ID: <20100909194823.GB1146@sigill.intra.peff.net>
References: <AANLkTikgxMFoiQm31FXgqBth=enVxxgxDJv8_97C30HF@mail.gmail.com>
 <AANLkTimOEQY9xJvindxuVPZotmWXZ=Ya9088ghL--Xuf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlos Eduardo da Fonseca <eduardongu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otn6m-0006KQ-6m
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab0IITsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:48:14 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569Ab0IITsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:48:12 -0400
Received: (qmail 21306 invoked by uid 111); 9 Sep 2010 19:48:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:48:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:48:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimOEQY9xJvindxuVPZotmWXZ=Ya9088ghL--Xuf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155897>

On Thu, Sep 09, 2010 at 02:25:30PM -0300, Carlos Eduardo da Fonseca wrote:

> I was wondering, why tags are only shown on log with --decorate, even
> signed tags?
> I have no problem in writing "--decorate", but tags, which are marks
> for something important, should be decorations?

There are two reasons I can think of not to want to see them:

  1. They take extra time to lookup (though really for most repos, I
     doubt it is even measurable).

  2. We did not historically show them, so some people find them
     distracting, and the default has never been switched to "on".

You can turn them on all the time with:

  git config --global log.decorate true

-Peff
