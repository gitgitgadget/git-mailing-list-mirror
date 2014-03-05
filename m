From: Jeff King <peff@peff.net>
Subject: Re: Negation in refspecs
Date: Wed, 5 Mar 2014 14:11:28 -0500
Message-ID: <20140305191128.GC31252@sigill.intra.peff.net>
References: <CACAUoX6Y5eC_9PxihkecfgWeCetj4K30sVm7wHosTqqh=_0unA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mickey Killianey <mickey@killianey.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHE7-0002y4-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbaCETLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:11:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:33588 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753025AbaCETLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:11:30 -0500
Received: (qmail 18525 invoked by uid 102); 5 Mar 2014 19:11:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:11:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:11:28 -0500
Content-Disposition: inline
In-Reply-To: <CACAUoX6Y5eC_9PxihkecfgWeCetj4K30sVm7wHosTqqh=_0unA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243468>

On Wed, Mar 05, 2014 at 10:06:26AM -0800, Mickey Killianey wrote:

> Is there any syntax to support partial negations of refspecs, such as:
> 
> +refs/heads/*:refs/remotes/origin/*
> !refs/heads/dont-pull:
> !:refs/remotes/origin/dont-push
> 
> If not now, is negation something that might be possible/reasonable in
> a future version of Git, or is it difficult/unlikely to change?

No, it doesn't exist now. It's something that people have asked for
occasionally, but I don't think anybody is actively working on it.

I posted a rough patch here:

  http://thread.gmane.org/gmane.comp.version-control.git/240997/focus=241057

about a month ago, but I do not have any immediate plans to take it
further (that email details some of the issues). If you're interested in
working on it, I think people are receptive to the idea; it just needs a
clean implementation.

-Peff
