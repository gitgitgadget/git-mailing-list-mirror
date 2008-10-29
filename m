From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 29 Oct 2008 13:11:22 -0400
Message-ID: <20081029171122.GA12167@sigill.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:12:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEb2-0001Xh-B5
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 18:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYJ2RL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYJ2RL0
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 13:11:26 -0400
Received: from peff.net ([208.65.91.99]:4268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbYJ2RL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 13:11:26 -0400
Received: (qmail 29574 invoked by uid 111); 29 Oct 2008 17:11:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 13:11:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 13:11:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99384>

On Wed, Oct 29, 2008 at 06:06:09PM +0100, Johannes Schindelin wrote:

> However, note that we have to hash out what to do about the convention 
> that --cached traditionally means that only the staging area (formerly 
> known as "the index") is affected, while --index means that the command 
> touches the working directory, too.

If we assume that we have only the word "stage" and variations
available, then there aren't too many options.

  only the staging area:
    --stage-only, --staged-only

  both:
    --staged (as opposed to --staged-only) --stage-and-worktree (too
    long), --both (not descriptive enough), --stage-too (yuck)

-Peff
