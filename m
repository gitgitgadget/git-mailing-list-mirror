From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
	branch-name
Date: Mon, 13 Apr 2009 07:09:47 -0400
Message-ID: <20090413110947.GA15647@coredump.intra.peff.net>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <200904092119.10520.mlevedahl@gmail.com> <7vbpr519jq.fsf@gitster.siamese.dyndns.org> <200904111301.31250.mlevedahl@gmail.com> <20090412072056.GA25837@coredump.intra.peff.net> <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org> <20090413085622.GC9846@coredump.intra.peff.net> <7vws9ohoa4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtK4Q-00078I-KT
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZDMLJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbZDMLJt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:09:49 -0400
Received: from peff.net ([208.65.91.99]:43848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZDMLJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:09:49 -0400
Received: (qmail 31680 invoked by uid 107); 13 Apr 2009 11:09:51 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:09:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:09:47 -0400
Content-Disposition: inline
In-Reply-To: <7vws9ohoa4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116426>

On Mon, Apr 13, 2009 at 02:54:27AM -0700, Junio C Hamano wrote:

> > I think it would be better in the synopsis to split this into two use
> > cases:
> >
> >   git checkout [<branch>]
> >   git checkout -b <new_branch> [<start_point>]
> >
> > And then explain them as separate definitions.
> 
> I'd agree it would make it much nicer.

A 5-patch series follows which does this and a few other fixups. I think
the result is better.

  1/5 doc: clarify --no-track option
  2/5 doc: refer to tracking configuration as "upstream"
  3/5 doc/checkout: refer to git-branch(1) as appropriate
  4/5 doc/checkout: split checkout and branch creation in synopsis
  5/5 docs/checkout: clarify what "non-branch" means

-Peff
