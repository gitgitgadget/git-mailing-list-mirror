From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the
 tracked branch
Date: Thu, 10 Sep 2009 07:11:56 -0400
Message-ID: <20090910111156.GA2910@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <4AA8CA88.9060802@drmicha.warpmail.net>
 <200909101218.06789.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 13:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlhZR-0004sC-NV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 13:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbZIJLL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZIJLL7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 07:11:59 -0400
Received: from peff.net ([208.65.91.99]:53537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbZIJLL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 07:11:59 -0400
Received: (qmail 747 invoked by uid 107); 10 Sep 2009 11:12:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Sep 2009 07:12:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Sep 2009 07:11:56 -0400
Content-Disposition: inline
In-Reply-To: <200909101218.06789.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128108>

On Thu, Sep 10, 2009 at 12:18:06PM +0200, Johan Herland wrote:

> > > A special shortcut '@{tracked}' refers to the branch tracked by the
> > > current branch.
> >
> > Sorry, I didn't know the name of the long form was up for discussion.
> > But it should certainly coincide with the key which for-each-ref
> > uses, shouldn't it? I don't care whether tracked or upstream, but
> > for-each-ref's "upstream" has set the precedent.
> 
> ...and 'git branch --track' set an even earlier precedent...

FWIW, that came about from this discussion:

  http://article.gmane.org/gmane.comp.version-control.git/115765

-Peff
