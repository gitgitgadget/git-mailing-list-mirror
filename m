From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 17:57:49 -0500
Message-ID: <20080129225748.GD4586@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net> <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> <7v7ihsmeg7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzPd-00078r-IK
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbYA2W5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbYA2W5w
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:57:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3262 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbYA2W5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:57:52 -0500
Received: (qmail 11725 invoked by uid 111); 29 Jan 2008 22:57:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 29 Jan 2008 17:57:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2008 17:57:49 -0500
Content-Disposition: inline
In-Reply-To: <7v7ihsmeg7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72014>

On Tue, Jan 29, 2008 at 02:53:12PM -0800, Junio C Hamano wrote:

> If your int is 64-bit, struct diff_score which is 4-int is
> 16-byte long.  32m * 16 = 501,801,600.  That seems to match your
> 450MB observation well.

Yes, except for s/64-bit/32-bit/.

-Peff
