From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 13:06:25 -0400
Message-ID: <20160419170624.GA3999@sigill.intra.peff.net>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com>
 <20160419050342.GA19439@sigill.intra.peff.net>
 <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:06:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZ6f-0002RV-2k
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbcDSRG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:06:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932125AbcDSRG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:06:28 -0400
Received: (qmail 6138 invoked by uid 102); 19 Apr 2016 17:06:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 13:06:27 -0400
Received: (qmail 17215 invoked by uid 107); 19 Apr 2016 17:06:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 13:06:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 13:06:25 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291883>

On Tue, Apr 19, 2016 at 08:17:38AM -0700, Stefan Beller wrote:

> On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:
> 
> > I guess this will invalidate old patch-ids, but there's not much to be
> > done about that.
> 
> What do you mean by that? (What consequences do you imagine?)
> I think diffs with any kind of heuristic can still be applied, no?

I mean that if you save any old patch-ids from "git patch-id", they
won't match up when compared with new versions of git. We can probably
ignore it, though. This isn't the first time that patch-ids might have
changed, and I think the advice is already that one should not count on
them to be stable in the long term.

-Peff
