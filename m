From: Jeff King <peff@peff.net>
Subject: Re: git cloning fails
Date: Tue, 8 Apr 2008 16:15:19 -0400
Message-ID: <20080408201518.GA2584@sigill.intra.peff.net>
References: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com> <20080408131347.GB22623@sigill.intra.peff.net> <cb8016980804081240l4c7f42eeyd51a4a33248dabd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 22:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKEg-0007Yc-NZ
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYDHUPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbYDHUPV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:15:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2484 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbYDHUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 16:15:20 -0400
Received: (qmail 16826 invoked by uid 111); 8 Apr 2008 20:15:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Apr 2008 16:15:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Apr 2008 16:15:19 -0400
Content-Disposition: inline
In-Reply-To: <cb8016980804081240l4c7f42eeyd51a4a33248dabd2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79023>

On Tue, Apr 08, 2008 at 02:40:14PM -0500, Abraham Arce wrote:

> > > error: Couldn't get
> > > http://www.kernel.org/pub/scm/git/git.git/refs/tags/gitgui-0.6.0 for
> > > tags/gitgui-0.6.0
> > > The requested URL returned error: 404
> > > error: Could not interpret tags/gitgui-0.6.0 as something to pull
> [...]
> I've tried 3 times, the git version I am using is 1.5.0.6.

Ah, I was able to reproduce with that version. It looks like 1.5.0.6
doesn't properly fetch packed refs over http. IIRC, it _should_ work
with that version (RelNotes-1.5.0 mentions packed refs), but there may
be a bug.

That version is over a year old now, and any bug has long since been
fixed; can you upgrade to a more modern git?

-Peff
