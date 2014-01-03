From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Thu, 2 Jan 2014 20:04:44 -0500
Message-ID: <20140103010444.GA13018@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228222129.GE5544@google.com>
 <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
 <20131230185125.GI20443@google.com>
 <20131231103323.GA14823@sigill.intra.peff.net>
 <20140102222833.GR20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 02:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VytBy-0000vR-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 02:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaACBEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 20:04:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:54204 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751864AbaACBEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 20:04:46 -0500
Received: (qmail 21909 invoked by uid 102); 3 Jan 2014 01:04:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jan 2014 19:04:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jan 2014 20:04:44 -0500
Content-Disposition: inline
In-Reply-To: <20140102222833.GR20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239900>

On Thu, Jan 02, 2014 at 02:28:33PM -0800, Jonathan Nieder wrote:

> > This is not exactly true. The TEST_OUTPUT_DIRECTORY setting does not
> > leak. t0000 sets $TEST_DIRECTORY (which it must, so the sub-scripts can
> > find test-lib.sh and friends), and then TEST_OUTPUT_DIRECTORY uses that
> > as a default if it is not explicitly set.
> 
> So I should have said something like the following instead:
> [...]

Yes, looks good to me.

-Peff
