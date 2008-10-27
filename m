From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 7/8] wt-status: load diff ui config
Date: Mon, 27 Oct 2008 04:23:55 -0400
Message-ID: <20081027082355.GB4085@sigill.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net> <20081026044935.GG21047@coredump.intra.peff.net> <7vmygqiozb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:25:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuNPY-0004L8-4B
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 09:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYJ0IYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbYJ0IYA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 04:24:00 -0400
Received: from peff.net ([208.65.91.99]:2740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbYJ0IYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 04:24:00 -0400
Received: (qmail 11938 invoked by uid 111); 27 Oct 2008 08:23:58 -0000
Received: from c-98-207-159-21.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (98.207.159.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 27 Oct 2008 04:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Oct 2008 04:23:55 -0400
Content-Disposition: inline
In-Reply-To: <7vmygqiozb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99215>

On Sun, Oct 26, 2008 at 10:30:48PM -0700, Junio C Hamano wrote:

> > But it makes me a little nervous. On one hand, I think it is definitely
> > the right thing for "status -v" to respect user options. But we do
> > several _other_ diffs in addition, and those are more "plumbing" diffs.
> > I think they should probably at least have diff_basic_config (e.g., for
> > rename limits). But we are applying the diff_ui_config options to all
> > diffs. Looking over the available options, I _think_ there are no nasty
> > surprises. But you never know.
> 
> Up to 6/8 are indisputably good changes.  The next one means well, and
> this one is a requisite step for it, but I agree that this feels somewhat
> risky.

I have to wonder that nobody ever complained about the lack of diff
config here before. If I ever used "git status -v", I would certainly
have been turned off by the lack of color. But maybe everybody is using
"git commit -v" and their editor is colorizing it. Or maybe they just
aren't using color (the only other noticeable thing would be rename
options).

-Peff
