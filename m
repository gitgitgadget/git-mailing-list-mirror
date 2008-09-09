From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 17:09:17 -0400
Message-ID: <20080909210917.GA3715@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vfxo958tj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdATh-0001f5-C1
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbYIIVJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYIIVJU
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:09:20 -0400
Received: from peff.net ([208.65.91.99]:1827 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbYIIVJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:09:19 -0400
Received: (qmail 20884 invoked by uid 111); 9 Sep 2008 21:09:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 17:09:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 17:09:17 -0400
Content-Disposition: inline
In-Reply-To: <7vfxo958tj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95432>

On Tue, Sep 09, 2008 at 02:05:28PM -0700, Junio C Hamano wrote:

> To be consistent, when you are at HEAD and are merging side branch B,
> because that merge is to incorporate what happened on the side branch
> while you are looking the other way, we should say "by the way, the
> difference between state $(git merge-base HEAD B) and state B was used to
> make this commit." in the resulting merge commit, shouldn't we?

I suppose you could, though in that case you can obviously calculate the
merge base yourself from the parents of the merge. The difference with
cherry-picking (or rebasing) is that you might not otherwise know about
the "by the way" commits.

-Peff
