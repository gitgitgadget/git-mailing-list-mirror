From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Sat, 5 Sep 2009 05:08:08 -0400
Message-ID: <20090905090808.GB13221@coredump.intra.peff.net>
References: <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <7vljkxdiil.fsf@alter.siamese.dyndns.org>
 <20090902100730.GA18226@gmail.com>
 <20090902175908.GA5998@coredump.intra.peff.net>
 <20090903011234.GA7415@gmail.com>
 <20090905062846.GD29863@coredump.intra.peff.net>
 <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 11:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjrFr-0005Pi-8v
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 11:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbZIEJIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 05:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbZIEJIJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 05:08:09 -0400
Received: from peff.net ([208.65.91.99]:40776 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549AbZIEJIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 05:08:09 -0400
Received: (qmail 26246 invoked by uid 107); 5 Sep 2009 09:08:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 05:08:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 05:08:08 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127807>

On Sat, Sep 05, 2009 at 04:48:09AM -0400, Jeff King wrote:

> On Sat, Sep 05, 2009 at 02:28:46AM -0400, Jeff King wrote:
> 
> > I see. I still think you may want to improve "commit --dry-run" with a
> > plumbing format, though, instead of "git status". Then it would
> > automagically support "--amend", as well as other dry-run things (e.g.,
> > "git commit --dry-run --porcelain --amend foo.c"). And not having looked
> > at the code, I would guess it is a one-liner patch to switch the "output
> > format" flag that commit passes to the wt-status.c code.
> 
> OK, it was a bit more complex than that. But here is a series which does
> a few things. It is still missing a few bits, so is RFC.

BTW, in case it was not obvious from the context, these are built on top
of jc/1.7.0-status.

-Peff
