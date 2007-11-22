From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path
	to patch
Date: Thu, 22 Nov 2007 04:57:48 -0500
Message-ID: <20071122095747.GF7153@sigill.intra.peff.net>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8oy-0007JX-8c
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXKVJ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXKVJ5v
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:57:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2223 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXKVJ5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:57:50 -0500
Received: (qmail 21454 invoked by uid 111); 22 Nov 2007 09:57:48 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 04:57:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 04:57:48 -0500
Content-Disposition: inline
In-Reply-To: <7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65767>

On Thu, Nov 22, 2007 at 01:50:31AM -0800, Junio C Hamano wrote:

> I am moderately negative about "paths imply jump to patch
> subcommand".  An option to git-add--interactive that tells which
> subcommand to initially choose is probably acceptable, though.

I agree that an option is nicer; it's just that it may be awkward since
'-i' is itself already an option.

> Would the patch I just sent out (you need to assemble the parts)
> make things easier?

Perhaps. This feature doesn't come up all that often for me, but I will
try running with your patch for a while to see if I like it.

-Peff
