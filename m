From: Jeff King <peff@peff.net>
Subject: Re: Resend: [PATCH] Do not log unless all connect() attempts fail
Date: Tue, 12 Jul 2011 01:55:53 -0400
Message-ID: <20110712055553.GD11644@sigill.intra.peff.net>
References: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:56:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVwu-0007eB-6F
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab1GLFzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:55:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44703
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab1GLFzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:55:54 -0400
Received: (qmail 9088 invoked by uid 107); 12 Jul 2011 05:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 01:56:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 01:55:53 -0400
Content-Disposition: inline
In-Reply-To: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176917>

On Mon, Jul 11, 2011 at 11:06:15AM -0700, Dave Zarzycki wrote:

> IPv6 hosts are often unreachable on the primarily IPv4 Internet and
> therefore we shouldn't print an error if there are still other hosts we
> can try to connect() to. This helps "git fetch --quiet" stay quiet.

Thanks for the resend; I think this got lost in the shuffle between
releases. This version addresses my complaints about the original; I
don't see any reason it shouldn't be applied.

-Peff
