From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 01:53:38 -0500
Message-ID: <20081220065337.GA2581@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 20 07:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvjn-0003Tv-6C
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 07:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYLTGxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 01:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYLTGxl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 01:53:41 -0500
Received: from peff.net ([208.65.91.99]:1631 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbYLTGxk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 01:53:40 -0500
Received: (qmail 22246 invoked by uid 111); 20 Dec 2008 06:53:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Dec 2008 01:53:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Dec 2008 01:53:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103627>

On Sat, Dec 20, 2008 at 12:35:06AM +0100, Johannes Schindelin wrote:

> Commit notes are blobs which are shown together with the commit
> message.  These blobs are taken from the notes ref, which you can
> configure by the config variable core.notesRef, which in turn can
> be overridden by the environment variable GIT_NOTES_REF.

Hmm. I wanted to try some performance comparisons based on this
implementation, but I can't get your 1/4 to apply. Conflicts in
config.txt and cache.h when applying to master, and "sha1 information is
lacking or useless" for a 3-way merge. What did you base this on?

-Peff
