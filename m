From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 03:23:04 -0500
Message-ID: <20081220082304.GA5693@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de> <20081220065337.GA2581@coredump.intra.peff.net> <200812200855.14915.robin.rosenberg.lists@dewire.com> <20081220080546.GA4580@coredump.intra.peff.net> <7vk59vz2dx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 09:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDx8M-0003Pl-AE
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 09:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbYLTIXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 03:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYLTIXH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 03:23:07 -0500
Received: from peff.net ([208.65.91.99]:1242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbYLTIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 03:23:06 -0500
Received: (qmail 22782 invoked by uid 111); 20 Dec 2008 08:23:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Dec 2008 03:23:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Dec 2008 03:23:04 -0500
Content-Disposition: inline
In-Reply-To: <7vk59vz2dx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103634>

On Sat, Dec 20, 2008 at 12:17:46AM -0800, Junio C Hamano wrote:

> >   1. git am /the/patch
> >   2. patch -p1 <.git/rebase-apply/patch
> >   3. manually inspect the results for sanity, and fix up the cache.h
> >      bit that failed totally
> >   4. git add -u && git add notes.[ch]
> >   5. git am --resolved
> 
> I usually skip 2-4 and edit .git/rebase-apply/patch in place instead, and
> run "git am" instead of step 5.

How do you track down the source of the conflict to do the patch fixup?
In this case, it was a context line in the patch that had been deleted
in my version. Do you just find the appropriate chunk in what you have
already and visually compare?

-Peff
