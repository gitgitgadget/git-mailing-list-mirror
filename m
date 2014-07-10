From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 15:34:04 -0400
Message-ID: <20140710193404.GA15615@sigill.intra.peff.net>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
 <20140710040731.GD28401@sigill.intra.peff.net>
 <xmqqa98h8587.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5K6e-0000MA-LF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 21:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbaGJTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 15:34:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59540 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751717AbaGJTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 15:34:07 -0400
Received: (qmail 9262 invoked by uid 102); 10 Jul 2014 19:34:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 14:34:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 15:34:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa98h8587.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253200>

On Thu, Jul 10, 2014 at 10:59:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I know this is existing code you are moving, but I noticed it looks ripe
> > for using skip_prefix. Perhaps while we are in the area we should do the
> > following on top of your patch (I'd also be happy for it be squashed
> > in, but that may be too much in one patch).
> 
> I am tempted to suggest going the other way around, i.e. queue (an
> equivalent of) this on jk/skip-prefix and merge it to 'next' and
> then 'master' quickly.
> 
> I can go either way, but I tend to prefer building new things on top
> of obviously correct clean-up, not the other way around.

Me too. I just didn't want to make more work for Jacob (in having to
rebase on top of mine) or for you (in having to do a non-obvious merge a
few days from now).

-Peff
