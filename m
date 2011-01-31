From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 18:22:31 -0500
Message-ID: <20110131232231.GE14419@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 00:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk351-0004fm-07
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 00:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab1AaXWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 18:22:38 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab1AaXWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 18:22:38 -0500
Received: (qmail 14935 invoked by uid 111); 31 Jan 2011 23:22:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 23:22:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 18:22:31 -0500
Content-Disposition: inline
In-Reply-To: <201101312244.10047.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165775>

On Mon, Jan 31, 2011 at 10:44:09PM +0100, Thomas Rast wrote:

> Running "git fetch origin master" only updates FETCH_HEAD, not
> origin/master, which turns out to be quite confusing for newcomers
> especially after running 'git pull origin master'.
> 
> Since the remote branches in some sense reflect the "last known state"
> of the remote, it would make sense to also update them to whatever a
> two-argument fetch got.

I like this one. FYI, I posted a patch in Aug 2009, and there was some
discussion about the impacts (it spills over into the sibling
subthreads):

  http://article.gmane.org/gmane.comp.version-control.git/127215

I'm actually still carrying the patch in my repository (and using it
every day!). I guess I should get on polishing it up...

-Peff
