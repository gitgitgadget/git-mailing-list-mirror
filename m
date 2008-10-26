From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sun, 26 Oct 2008 00:38:03 -0400
Message-ID: <20081026043802.GA14530@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net> <20081025005256.GD23903@coredump.intra.peff.net> <7vhc71b5ai.fsf@gitster.siamese.dyndns.org> <20081025071912.GA24287@coredump.intra.peff.net> <7v3aika5l7.fsf@gitster.siamese.dyndns.org> <20081025193554.GA27457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:39:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxPO-0003vT-RG
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbYJZEiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbYJZEiG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:38:06 -0400
Received: from peff.net ([208.65.91.99]:3792 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbYJZEiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:38:05 -0400
Received: (qmail 4829 invoked by uid 111); 26 Oct 2008 04:38:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:38:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:38:03 -0400
Content-Disposition: inline
In-Reply-To: <20081025193554.GA27457@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99140>

On Sat, Oct 25, 2008 at 03:35:54PM -0400, Jeff King wrote:

> I will re-roll my latest series according to your recommendation
> (unless you are set on reverting the first part; if so, please tell me
> asap so I can work under that assumption).

And here it is. 8 patches this time, and I tried to reorder with
"obviously correct" at the beginning and "I'm not so sure" at the end.

     1/8: diff: add missing static declaration
     2/8: document the diff driver textconv feature
     3/8: add userdiff textconv tests
     4/8: refactor userdiff textconv code
     5/8: userdiff: require explicitly allowing textconv
     6/8: only textconv regular files
     7/8: wt-status: load diff ui config
     8/8: enable textconv for diff in verbose status/commit

-Peff
