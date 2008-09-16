From: Jeff King <peff@peff.net>
Subject: Re: Diff-tree does not work for initial commit
Date: Tue, 16 Sep 2008 02:21:05 -0400
Message-ID: <20080916062105.GA12708@coredump.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Anatol Pomozov <anatol.pomozov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Sep 16 08:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfTx5-0001Gs-Bc
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 08:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYIPGVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 02:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbYIPGVI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 02:21:08 -0400
Received: from peff.net ([208.65.91.99]:2014 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbYIPGVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 02:21:07 -0400
Received: (qmail 20318 invoked by uid 111); 16 Sep 2008 06:21:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Sep 2008 02:21:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 02:21:05 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95977>

On Tue, Sep 16, 2008 at 08:19:37AM +0200, Sverre Rabbelier wrote:

> I like it, although I think that if we add broader support for it, we
> should probably be consequent and add it everywhere where appropriate?
> (That is ofcourse, assuming that does not take too long to implement
> etc.)

Right, that was what I meant by "incomplete". I think there are several
other cases where giving "--root" would have expected behavior but is
currently ignored. I'll take a closer look, but I probably won't have
time for a few days.

-Peff
