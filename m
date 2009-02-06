From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 6 Feb 2009 09:06:37 -0500
Message-ID: <20090206140637.GB18364@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com> <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de> <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com> <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de> <20090131095622.6117@nanako3.lavabit.com> <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org> <20090202124148.GB8325@sigio.peff.net> <7vvdrsdtvr.fsf@gitster.siamese.dyndns.org> <7vd4dzbei5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRNH-00057N-Am
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbZBFOGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbZBFOGk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:06:40 -0500
Received: from peff.net ([208.65.91.99]:56974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbZBFOGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:06:40 -0500
Received: (qmail 21977 invoked by uid 107); 6 Feb 2009 14:06:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 09:06:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 09:06:37 -0500
Content-Disposition: inline
In-Reply-To: <7vd4dzbei5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108709>

On Tue, Feb 03, 2009 at 09:45:54AM -0800, Junio C Hamano wrote:

> And this is meant for 1.7.0, and is queued at the tip of 'pu' just for the
> heck of it.

Looks sane to me for 1.7.0, but it will probably require tweaking of
which tests are fixed at that time (and actually, I think some can just
be cleaned up to use bare repositories instead of adding the config --
but let's deal with that when the patch is ready to be applied).

> This makes git-push to refuse pushing-push into a non-bare repository to

As opposed to non-pushing push?

-Peff
