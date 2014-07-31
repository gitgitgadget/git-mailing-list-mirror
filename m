From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 3/2] stash: show combined diff with "stash show"
Date: Wed, 30 Jul 2014 20:17:46 -0400
Message-ID: <20140731001746.GC22297@peff.net>
References: <20140729115334.GA8976@peff.net>
 <20140729120732.GA9302@peff.net>
 <xmqq1tt43uem.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCe4J-00085J-G3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 02:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaGaAR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 20:17:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:43374 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752928AbaGaAR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 20:17:58 -0400
Received: (qmail 28306 invoked by uid 102); 31 Jul 2014 00:17:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jul 2014 19:17:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2014 20:17:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tt43uem.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254533>

On Tue, Jul 29, 2014 at 11:13:37AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... People might be doing things like "git stash show | git
> > apply", and would want to ignore the index content ...
> 
> FWIW, that is exactly how I use "git stash show -p" most of the time.

Like I said, I'm iffy on this part of the series for that reason. But
I'm curious: what do you think should happen in such a use case when
there are staged contents in the index? Right now we completely ignore
them.

-Peff
