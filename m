From: Jeff King <peff@peff.net>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 13:34:40 -0400
Message-ID: <20090415173440.GA25480@coredump.intra.peff.net>
References: <49E61067.6060802@hartwork.org> <20090415165420.GB24528@coredump.intra.peff.net> <49E611A5.8090602@hartwork.org> <20090415170444.GA24717@coredump.intra.peff.net> <7vprfdvnrj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu92c-00019i-PL
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbZDORer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZDOReq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:34:46 -0400
Received: from peff.net ([208.65.91.99]:41834 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbZDOReq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:34:46 -0400
Received: (qmail 27820 invoked by uid 107); 15 Apr 2009 17:34:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 13:34:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 13:34:40 -0400
Content-Disposition: inline
In-Reply-To: <7vprfdvnrj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116637>

On Wed, Apr 15, 2009 at 10:18:40AM -0700, Junio C Hamano wrote:

> > I think curly makes the most sense for grouping, though I still think it
> > is a bit ugly. Patch is below.
> 
> Thanks.  Doesn't this remind us of $gmane/72243, by the way?

Ah, yes. I felt like we had dealt with this before, but I couldn't
remember for what.

That message indicates that {} is preferred to (). Interestingly,
though, the stash usage and documentation still uses ().

-Peff
