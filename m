From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Sat, 10 May 2008 01:25:49 -0400
Message-ID: <20080510052548.GA11556@sigill.intra.peff.net>
References: <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home> <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com> <20080510002014.GH29038@spearce.org> <7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Sat May 10 07:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juhbm-0007it-VD
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 07:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYEJFZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 01:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYEJFZr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 01:25:47 -0400
Received: from peff.net ([208.65.91.99]:2222 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbYEJFZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 01:25:46 -0400
Received: (qmail 23327 invoked by uid 111); 10 May 2008 05:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 May 2008 01:25:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2008 01:25:49 -0400
Content-Disposition: inline
In-Reply-To: <87y76jx6y4.fsf@jeremyms.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81650>

On Fri, May 09, 2008 at 09:51:15PM -0400, Jeremy Maitin-Shepard wrote:

> When you create a new working directory, you would also create in the
> original repository a symlink named
> e.g. orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> that
> points to the .git directory of the newly created working directory.

That assumes you _can_ write to the original repository. That may or may
not be the case, depending on your setup.

-Peff
