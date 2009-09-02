From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 14:00:50 -0400
Message-ID: <20090902180050.GB5998@coredump.intra.peff.net>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <20090902124832.GC4012@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 20:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu8k-0008Re-O4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 20:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZIBSAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZIBSAv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 14:00:51 -0400
Received: from peff.net ([208.65.91.99]:43291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbZIBSAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 14:00:51 -0400
Received: (qmail 7967 invoked by uid 107); 2 Sep 2009 18:01:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 14:01:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 14:00:50 -0400
Content-Disposition: inline
In-Reply-To: <20090902124832.GC4012@sirena.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127622>

On Wed, Sep 02, 2009 at 01:48:32PM +0100, Mark Brown wrote:

> It would be nice to be able to explicitly ask to suppress some of the
> output for cases where there's a lot of it and only a small part is
> interesting (like when resolving a large merge as mentioned earlier) - I
> often end up doing this by hand in those situations.  I do agree that
> doing this by default would be surprising.

Yeah, we already have --untracked-files=<no|normal|all> and a matching
config variable. If there are cases people find useful, I don't see a
reason why we can't make other sections configurable, too. I think it
just somebody to write a patch for the behavior they think makes sense
(or at the very least a concrete proposal).

-Peff
