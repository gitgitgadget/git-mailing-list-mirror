From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv1 0/6] Fix bug in large transactions
Date: Wed, 21 Jan 2015 18:47:00 -0500
Message-ID: <20150121234659.GE11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:47:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4zQ-0007gG-0H
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbbAUXrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:47:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:37124 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753124AbbAUXrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:47:01 -0500
Received: (qmail 2732 invoked by uid 102); 21 Jan 2015 23:47:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:47:01 -0600
Received: (qmail 2027 invoked by uid 107); 21 Jan 2015 23:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:47:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:47:00 -0500
Content-Disposition: inline
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262788>

On Wed, Jan 21, 2015 at 03:23:39PM -0800, Stefan Beller wrote:

> (reported as: git update-ref --stdin : too many open files, 2014-12-20)
> 
> First a test case is introduced to demonstrate the failure,
> the patches 2-6 are little refactoring and the last patch 
> fixes the bug and also marks the bugs as resolved in the
> test suite.
> 
> Unfortunately this applies on top of origin/next.

Saying "applies on next" is not very useful to Junio. He is not going to
branch a topic straight from "next", as merging it to master would pull
in all of the topics cooking in "next" (not to mention a bunch of merge
commits which are generally never part of "master").

Instead, figure out which topic in next you actually _need_ to build on,
and then it can be branched from there. And if there is no such topic,
then you should not be building on next, of course. :) But I think you
know that part already.

-Peff
