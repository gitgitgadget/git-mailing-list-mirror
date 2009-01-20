From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Mon, 19 Jan 2009 23:06:17 -0500
Message-ID: <20090120040617.GB30714@sigill.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net> <7vljt6q4cf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7uA-0005i6-Sn
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbZATEGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 23:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbZATEGX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:06:23 -0500
Received: from peff.net ([208.65.91.99]:51816 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbZATEGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:06:22 -0500
Received: (qmail 31284 invoked by uid 107); 20 Jan 2009 04:06:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:06:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:06:17 -0500
Content-Disposition: inline
In-Reply-To: <7vljt6q4cf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106434>

On Mon, Jan 19, 2009 at 03:10:56PM -0800, Junio C Hamano wrote:

> > Hrm. OK, it doesn't actually work always. It does for git-log, but not
> > for rev-list, which leaves diff_use_color_default as -1. I don't know if
> > there are any other ways you can get to this code path without having
> > set diff_use_color_default.
> 
> Yuck, no matter what you do please don't contaminate plumbing with the UI
> color options.

Of course. But the problem is that rev-list is _already_ contaminated by
--pretty=format:%Cred. Or do you mean, you really want rev-list to
unconditionally output color in such a case?

-Peff
